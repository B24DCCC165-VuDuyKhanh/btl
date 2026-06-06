const { User, Post, Comment, Tag, PostVote, sequelize } = require('../models');
const { Op } = require('sequelize');

async function getStats(req, res, next) {
  try {
    const now      = new Date();
    const today    = new Date(now.getFullYear(), now.getMonth(), now.getDate());
    const thisWeek = new Date(today); thisWeek.setDate(today.getDate() - 6);
    const last7    = Array.from({ length: 7 }, (_, i) => {
      const d = new Date(today);
      d.setDate(today.getDate() - (6 - i));
      return d;
    });

    // ── Tổng hợp cơ bản ─────────────────────────────────
    const [
      totalUsers,
      totalPosts,
      totalComments,
      totalTags,
    ] = await Promise.all([
      User.count(),
      Post.count({ where: { status: 'active' } }),
      Comment.count(),
      Tag.count(),
    ]);

    // ── Người dùng theo role & trạng thái ───────────────
    const usersByRole = await User.findAll({
      attributes: [
        'role',
        [sequelize.fn('COUNT', sequelize.col('id')), 'count'],
      ],
      group: ['role'],
      raw: true,
    });

    const usersByStatus = await User.findAll({
      attributes: [
        'status',
        [sequelize.fn('COUNT', sequelize.col('id')), 'count'],
      ],
      group: ['status'],
      raw: true,
    });

    // ── Bài viết theo trạng thái ────────────────────────
    const postsByStatus = await Post.findAll({
      attributes: [
        'status',
        [sequelize.fn('COUNT', sequelize.col('id')), 'count'],
      ],
      group: ['status'],
      raw: true,
    });

    // ── Bài viết hôm nay & tuần này ─────────────────────
    const [postsToday, postsThisWeek] = await Promise.all([
      Post.count({ where: { createdAt: { [Op.gte]: today } } }),
      Post.count({ where: { createdAt: { [Op.gte]: thisWeek } } }),
    ]);

    // ── Bình luận hôm nay ───────────────────────────────
    const commentsToday = await Comment.count({
      where: { createdAt: { [Op.gte]: today } },
    });

    // ── Tổng votes ──────────────────────────────────────
    const totalVotesRaw = await Post.findOne({
      attributes: [[sequelize.fn('SUM', sequelize.col('votes')), 'total']],
      raw: true,
    });
    const totalVotes = Number(totalVotesRaw?.total) || 0;

    // ── Tổng lượt xem ───────────────────────────────────
    const totalViewsRaw = await Post.findOne({
      attributes: [[sequelize.fn('SUM', sequelize.col('views')), 'total']],
      raw: true,
    });
    const totalViews = Number(totalViewsRaw?.total) || 0;

    // ── Active users (có bài viết/comment trong 7 ngày) ─
    const activeUsers = await User.count({
      where: { status: 'active' },
    });

    // ── Hoạt động 7 ngày gần đây (posts + comments) ─────
    const postsLast7 = await Post.findAll({
      attributes: [
        [sequelize.fn('DATE', sequelize.col('createdAt')), 'date'],
        [sequelize.fn('COUNT', sequelize.col('id')), 'count'],
      ],
      where: { createdAt: { [Op.gte]: thisWeek } },
      group: [sequelize.fn('DATE', sequelize.col('createdAt'))],
      raw: true,
    });

    const commentsLast7 = await Comment.findAll({
      attributes: [
        [sequelize.fn('DATE', sequelize.col('createdAt')), 'date'],
        [sequelize.fn('COUNT', sequelize.col('id')), 'count'],
      ],
      where: { createdAt: { [Op.gte]: thisWeek } },
      group: [sequelize.fn('DATE', sequelize.col('createdAt'))],
      raw: true,
    });

    // Map to array of 7 days
    const postsMap    = Object.fromEntries(postsLast7.map(r => [r.date, Number(r.count)]));
    const commentsMap = Object.fromEntries(commentsLast7.map(r => [r.date, Number(r.count)]));

    const recentActivity = last7.map(d => {
      const key = d.toISOString().slice(0, 10);
      return {
        date:     key,
        label:    `${d.getDate()}/${d.getMonth() + 1}`,
        posts:    postsMap[key]    || 0,
        comments: commentsMap[key] || 0,
      };
    });

    // ── Top 5 tags phổ biến ─────────────────────────────
    const popularTags = await Tag.findAll({
      attributes: [
        'id', 'name', 'color',
        [sequelize.fn('COUNT', sequelize.col('posts.id')), 'count'],
      ],
      include: [{ model: Post, as: 'posts', attributes: [] }],
      group: ['Tag.id'],
      order: [[sequelize.literal('count'), 'DESC']],
      limit: 5,
      subQuery: false,
    });

    // ── Top 5 bài viết nhiều vote nhất ──────────────────
    const topPosts = await Post.findAll({
      where: { status: 'active' },
      order: [['votes', 'DESC'], ['views', 'DESC']],
      limit: 5,
      attributes: ['id', 'title', 'votes', 'views', 'answersCount', 'createdAt'],
      include: [
        { model: require('../models').User, as: 'author', attributes: ['id', 'name', 'role'] },
      ],
    });

    res.json({
      // Tổng quan
      totalUsers,
      totalPosts,
      totalComments,
      totalTags,
      totalVotes,
      totalViews,
      postsToday,
      postsThisWeek,
      commentsToday,
      activeUsers,

      // Phân tích người dùng
      usersByRole: usersByRole.reduce((acc, r) => {
        acc[r.role] = Number(r.count);
        return acc;
      }, {}),
      usersByStatus: usersByStatus.reduce((acc, r) => {
        acc[r.status] = Number(r.count);
        return acc;
      }, {}),

      // Phân tích bài viết
      postsByStatus: postsByStatus.reduce((acc, r) => {
        acc[r.status] = Number(r.count);
        return acc;
      }, {}),

      // Xu hướng 7 ngày
      recentActivity,

      // Top nội dung
      popularTags: popularTags.map(tag => ({
        id:    tag.id,
        name:  tag.name,
        color: tag.color,
        count: Number(tag.get('count')),
      })),
      topPosts: topPosts.map(p => ({
        id:           p.id,
        title:        p.title,
        votes:        p.votes,
        views:        p.views,
        answersCount: p.answersCount,
        createdAt:    p.createdAt,
        author:       p.author,
      })),
    });
  } catch (error) {
    next(error);
  }
}

module.exports = { getStats };