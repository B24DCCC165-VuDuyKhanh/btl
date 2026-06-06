import React, { useEffect, useState } from 'react';
import { motion } from 'framer-motion';
import {
  UserOutlined, FileTextOutlined, MessageOutlined, TagOutlined,
  TeamOutlined, EyeOutlined, LikeOutlined, ArrowRightOutlined,
  FireFilled, ClockCircleOutlined, CheckCircleFilled, LockOutlined,
  RiseOutlined, TrophyFilled,
} from '@ant-design/icons';
import { adminStatsAPI, adminPostsAPI, adminUsersAPI } from '@/services/api';
import type { AdminStats, Post, User } from '@/types';
import { history } from '@umijs/max';
import { useAuthStore } from '@/stores/auth';
import dayjs from 'dayjs';

/* ─── Animation ─────────────────────────────────────────── */
const stagger = { hidden: {}, show: { transition: { staggerChildren: 0.07 } } };
const fadeUp  = { hidden: { opacity: 0, y: 18 }, show: { opacity: 1, y: 0, transition: { duration: 0.38 } } };

/* ─── Mini Bar Chart ─────────────────────────────────────── */
function MiniBar({ value, max, color }: { value: number; max: number; color: string }) {
  const pct = max > 0 ? Math.round((value / max) * 100) : 0;
  return (
    <div className="flex items-end gap-px h-8">
      {[...Array(7)].map((_, i) => (
        <motion.div
          key={i}
          className="flex-1 rounded-sm"
          style={{ background: color, opacity: 0.2 + (i / 6) * 0.8 }}
          initial={{ scaleY: 0 }}
          animate={{ scaleY: 1 }}
          transition={{ delay: i * 0.05, duration: 0.3, ease: 'easeOut' }}
          transformOrigin="bottom"
        />
      ))}
    </div>
  );
}

/* ─── Activity Bar ───────────────────────────────────────── */
function ActivityChart({ data }: { data: AdminStats['recentActivity'] }) {
  if (!data?.length) return null;
  const maxVal = Math.max(...data.map(d => d.posts + d.comments), 1);

  return (
    <div className="flex items-end gap-1.5 h-20">
      {data.map((d, i) => {
        const totalH = ((d.posts + d.comments) / maxVal) * 100;
        const postPct = (d.posts + d.comments) > 0 ? (d.posts / (d.posts + d.comments)) * 100 : 50;
        return (
          <div key={d.date} className="flex-1 flex flex-col items-center gap-0.5 group relative">
            {/* Tooltip */}
            <div className="absolute bottom-full mb-1 hidden group-hover:flex flex-col items-center z-10 pointer-events-none">
              <div className="bg-gray-900 text-white text-xs rounded-lg px-2 py-1 whitespace-nowrap shadow-xl">
                📝 {d.posts} bài · 💬 {d.comments} cmt
              </div>
              <div className="w-2 h-2 bg-gray-900 rotate-45 -mt-1" />
            </div>
            <div className="w-full rounded-t-sm overflow-hidden flex flex-col-reverse" style={{ height: `${totalH}%`, minHeight: 4 }}>
              <motion.div
                className="w-full"
                style={{ height: `${100 - postPct}%`, background: '#4DE2E2', minHeight: 2 }}
                initial={{ scaleY: 0 }}
                animate={{ scaleY: 1 }}
                transition={{ delay: i * 0.07, duration: 0.4 }}
              />
              <motion.div
                className="w-full"
                style={{ height: `${postPct}%`, background: '#4F8CFF', minHeight: 2 }}
                initial={{ scaleY: 0 }}
                animate={{ scaleY: 1 }}
                transition={{ delay: i * 0.07 + 0.1, duration: 0.4 }}
              />
            </div>
            <span className="text-xs" style={{ color: 'var(--text-muted)', fontSize: 9 }}>{d.label}</span>
          </div>
        );
      })}
    </div>
  );
}

/* ─── Donut-like ring stat ───────────────────────────────── */
function RingStat({ label, value, total, color }: { label: string; value: number; total: number; color: string }) {
  const pct = total > 0 ? Math.min(100, Math.round((value / total) * 100)) : 0;
  const r = 26, circ = 2 * Math.PI * r;
  return (
    <div className="flex items-center gap-3">
      <svg width="64" height="64" viewBox="0 0 64 64" className="flex-shrink-0">
        <circle cx="32" cy="32" r={r} fill="none" stroke="var(--border)" strokeWidth="6" />
        <motion.circle
          cx="32" cy="32" r={r} fill="none"
          stroke={color} strokeWidth="6"
          strokeDasharray={circ}
          initial={{ strokeDashoffset: circ }}
          animate={{ strokeDashoffset: circ * (1 - pct / 100) }}
          transition={{ duration: 1, ease: 'easeOut' }}
          strokeLinecap="round"
          transform="rotate(-90 32 32)"
        />
        <text x="32" y="37" textAnchor="middle" fontSize="13" fontWeight="bold" fill={color}>{pct}%</text>
      </svg>
      <div>
        <p className="text-xl font-black" style={{ color: 'var(--text)' }}>{value.toLocaleString()}</p>
        <p className="text-xs" style={{ color: 'var(--text-muted)' }}>{label}</p>
      </div>
    </div>
  );
}

/* ─── Main Component ─────────────────────────────────────── */
export default function AdminDashboard() {
  const { user }   = useAuthStore();
  const [stats, setStats] = useState<AdminStats | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    adminStatsAPI.getStats()
      .then(r => setStats((r.data as any) || null))
      .catch(() => {})
      .finally(() => setLoading(false));
  }, []);

  const hour = new Date().getHours();
  const greeting = hour < 12 ? '☀️ Chào buổi sáng' : hour < 18 ? '🌤️ Chào buổi chiều' : '🌙 Chào buổi tối';

  /* Skeleton row */
  const Sk = ({ w = 'w-full', h = 'h-4' }: { w?: string; h?: string }) => (
    <div className={`skeleton rounded ${w} ${h}`} />
  );

  const quickActions = [
    { label: 'Bài đăng',    icon: <FileTextOutlined />, path: '/admin/posts', color: '#4F8CFF' },
    { label: 'Người dùng',  icon: <TeamOutlined />,     path: '/admin/users', color: '#7B61FF' },
    { label: 'Tags',         icon: <TagOutlined />,      path: '/admin/tags',  color: '#FF6B35' },
  ];

  return (
    <motion.div className="space-y-5" variants={stagger} initial="hidden" animate="show">

      {/* ── Welcome ─────────────────────────────────────── */}
      <motion.div variants={fadeUp}
        className="relative rounded-3xl p-7 overflow-hidden"
        style={{ background: 'linear-gradient(135deg,#131929 0%,#0d1b35 60%,#131929 100%)', border: '1px solid rgba(79,140,255,0.2)' }}
      >
        <div className="absolute top-0 right-0 w-56 h-56 blur-3xl opacity-25 pointer-events-none"
          style={{ background: 'radial-gradient(#7B61FF,transparent 70%)', transform: 'translate(30%,-30%)' }} />
        <div className="absolute bottom-0 left-0 w-44 h-44 blur-3xl opacity-15 pointer-events-none"
          style={{ background: 'radial-gradient(#4F8CFF,transparent 70%)', transform: 'translate(-20%,20%)' }} />
        <div className="relative z-10 flex flex-wrap items-center justify-between gap-4">
          <div>
            <p className="text-sm mb-0.5" style={{ color: 'rgba(255,255,255,0.45)' }}>{greeting}</p>
            <h1 className="text-2xl font-black text-white">{user?.name || 'Admin'}</h1>
            <p className="text-sm mt-1" style={{ color: 'rgba(255,255,255,0.5)' }}>
              {dayjs().format('dddd, DD/MM/YYYY')}
            </p>
          </div>
          <div className="flex items-center gap-2 px-4 py-2 rounded-2xl"
            style={{ background: 'rgba(34,197,94,0.12)', border: '1px solid rgba(34,197,94,0.25)' }}>
            <div className="w-2 h-2 rounded-full bg-green-400 animate-pulse" />
            <span className="text-sm font-semibold text-green-300">Hệ thống online</span>
          </div>
        </div>
      </motion.div>

      {/* ── Stat Cards (8 thẻ) ──────────────────────────── */}
      <motion.div variants={fadeUp}>
        <h2 className="text-xs font-bold uppercase tracking-widest mb-3" style={{ color: 'var(--text-muted)' }}>
          Tổng quan hệ thống
        </h2>
        <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
          {[
            { label: 'Bài viết',     val: stats?.totalPosts,    icon: <FileTextOutlined />, color: '#4F8CFF', sub: `+${stats?.postsToday ?? 0} hôm nay` },
            { label: 'Người dùng',   val: stats?.totalUsers,    icon: <TeamOutlined />,     color: '#7B61FF', sub: `${stats?.activeUsers ?? 0} đang HĐ` },
            { label: 'Bình luận',    val: stats?.totalComments, icon: <MessageOutlined />,  color: '#4DE2E2', sub: `+${stats?.commentsToday ?? 0} hôm nay` },
            { label: 'Lượt xem',     val: stats?.totalViews,    icon: <EyeOutlined />,      color: '#22c55e', sub: 'Tổng lượt xem' },
            { label: 'Tags',         val: stats?.totalTags,     icon: <TagOutlined />,      color: '#FF6B35', sub: 'Chủ đề' },
            { label: 'Votes',        val: stats?.totalVotes,    icon: <LikeOutlined />,     color: '#f59e0b', sub: 'Tổng tương tác' },
            { label: 'Bài tuần này', val: stats?.postsThisWeek, icon: <RiseOutlined />,     color: '#a855f7', sub: '7 ngày gần đây' },
            { label: 'Đang HĐ',      val: stats?.activeUsers,   icon: <CheckCircleFilled />,color: '#10b981', sub: 'Tài khoản active' },
          ].map((c, i) => (
            <motion.div key={c.label}
              className="rounded-2xl p-4 border relative overflow-hidden"
              style={{ background: 'var(--surface)', borderColor: 'var(--border)' }}
              initial={{ opacity: 0, y: 16 }} animate={{ opacity: 1, y: 0 }}
              transition={{ delay: i * 0.06 }}
              whileHover={{ y: -3, boxShadow: `0 12px 36px ${c.color}20` }}
            >
              <div className="absolute top-0 left-0 right-0 h-0.5 rounded-t-2xl"
                style={{ background: `linear-gradient(90deg,${c.color},${c.color}66)` }} />
              <div className="flex items-center justify-between mb-2">
                <div className="w-9 h-9 rounded-xl flex items-center justify-center text-white"
                  style={{ background: `linear-gradient(135deg,${c.color},${c.color}99)` }}>
                  {c.icon}
                </div>
              </div>
              {loading
                ? <Sk h="h-7" w="w-16" />
                : <p className="text-2xl font-black" style={{ color: 'var(--text)' }}>
                    {(c.val ?? 0).toLocaleString()}
                  </p>
              }
              <p className="text-xs font-semibold mt-0.5" style={{ color: 'var(--text)' }}>{c.label}</p>
              <p className="text-xs" style={{ color: c.color }}>{c.sub}</p>
            </motion.div>
          ))}
        </div>
      </motion.div>

      {/* ── Row 2: Phân tích người dùng + Hoạt động 7 ngày ── */}
      <motion.div variants={fadeUp} className="grid grid-cols-1 lg:grid-cols-2 gap-5">

        {/* Phân tích người dùng */}
        <div className="rounded-2xl border p-5" style={{ background: 'var(--surface)', borderColor: 'var(--border)' }}>
          <h3 className="font-bold text-sm mb-4 flex items-center gap-2" style={{ color: 'var(--text)' }}>
            <TeamOutlined style={{ color: '#7B61FF' }} /> Phân tích người dùng
          </h3>

          {loading
            ? <div className="space-y-4"><Sk /><Sk w="w-3/4" /><Sk w="w-1/2" /></div>
            : <>
              <div className="grid grid-cols-3 gap-3 mb-5">
                {[
                  { key: 'student',  label: 'Sinh viên',  color: '#4F8CFF', icon: '🎓' },
                  { key: 'lecturer', label: 'Giảng viên', color: '#7B61FF', icon: '👨‍🏫' },
                  { key: 'admin',    label: 'Admin',      color: '#FF6B6B', icon: '🛡️' },
                ].map(r => (
                  <div key={r.key} className="rounded-xl p-3 text-center"
                    style={{ background: `${r.color}12`, border: `1px solid ${r.color}25` }}>
                    <p className="text-lg mb-0.5">{r.icon}</p>
                    <p className="text-xl font-black" style={{ color: r.color }}>
                      {(stats?.usersByRole?.[r.key] ?? 0).toLocaleString()}
                    </p>
                    <p className="text-xs" style={{ color: 'var(--text-muted)' }}>{r.label}</p>
                  </div>
                ))}
              </div>

              <div className="space-y-2.5">
                <p className="text-xs font-semibold uppercase tracking-wide mb-2" style={{ color: 'var(--text-muted)' }}>Trạng thái tài khoản</p>
                {[
                  { label: 'Hoạt động', key: 'active', color: '#22c55e' },
                  { label: 'Bị khóa',   key: 'locked', color: '#ef4444' },
                ].map(s => {
                  const val  = stats?.usersByStatus?.[s.key] ?? 0;
                  const pct  = stats?.totalUsers ? Math.round((val / stats.totalUsers) * 100) : 0;
                  return (
                    <div key={s.key}>
                      <div className="flex justify-between text-xs mb-1">
                        <span style={{ color: 'var(--text-muted)' }}>{s.label}</span>
                        <span style={{ color: s.color }} className="font-semibold">{val} ({pct}%)</span>
                      </div>
                      <div className="h-2 rounded-full overflow-hidden" style={{ background: 'var(--border)' }}>
                        <motion.div className="h-full rounded-full"
                          style={{ background: s.color }}
                          initial={{ width: 0 }}
                          animate={{ width: `${pct}%` }}
                          transition={{ duration: 0.9, ease: 'easeOut' }}
                        />
                      </div>
                    </div>
                  );
                })}
              </div>
            </>
          }
        </div>

        {/* Hoạt động 7 ngày */}
        <div className="rounded-2xl border p-5" style={{ background: 'var(--surface)', borderColor: 'var(--border)' }}>
          <h3 className="font-bold text-sm mb-1 flex items-center gap-2" style={{ color: 'var(--text)' }}>
            <RiseOutlined style={{ color: '#4F8CFF' }} /> Hoạt động 7 ngày gần đây
          </h3>
          <div className="flex items-center gap-4 mb-4">
            <span className="flex items-center gap-1.5 text-xs" style={{ color: 'var(--text-muted)' }}>
              <span className="w-3 h-2 rounded-sm inline-block" style={{ background: '#4F8CFF' }} /> Bài viết
            </span>
            <span className="flex items-center gap-1.5 text-xs" style={{ color: 'var(--text-muted)' }}>
              <span className="w-3 h-2 rounded-sm inline-block" style={{ background: '#4DE2E2' }} /> Bình luận
            </span>
          </div>
          {loading
            ? <div className="h-20 skeleton rounded-xl" />
            : <ActivityChart data={stats?.recentActivity ?? []} />
          }

          <div className="grid grid-cols-2 gap-3 mt-4 pt-4 border-t" style={{ borderColor: 'var(--border)' }}>
            <div className="text-center">
              <p className="text-xl font-black" style={{ color: '#4F8CFF' }}>
                {stats?.recentActivity?.reduce((s, d) => s + d.posts, 0) ?? 0}
              </p>
              <p className="text-xs" style={{ color: 'var(--text-muted)' }}>Bài viết / tuần</p>
            </div>
            <div className="text-center">
              <p className="text-xl font-black" style={{ color: '#4DE2E2' }}>
                {stats?.recentActivity?.reduce((s, d) => s + d.comments, 0) ?? 0}
              </p>
              <p className="text-xs" style={{ color: 'var(--text-muted)' }}>Bình luận / tuần</p>
            </div>
          </div>
        </div>
      </motion.div>

      {/* ── Row 3: Bài viết + Tags phổ biến ─────────────── */}
      <motion.div variants={fadeUp} className="grid grid-cols-1 lg:grid-cols-2 gap-5">

        {/* Bài viết theo trạng thái */}
        <div className="rounded-2xl border p-5" style={{ background: 'var(--surface)', borderColor: 'var(--border)' }}>
          <div className="flex items-center justify-between mb-4">
            <h3 className="font-bold text-sm flex items-center gap-2" style={{ color: 'var(--text)' }}>
              <FileTextOutlined style={{ color: '#4F8CFF' }} /> Bài viết theo trạng thái
            </h3>
            <motion.button onClick={() => history.push('/admin/posts')}
              className="flex items-center gap-1 text-xs font-semibold px-2.5 py-1.5 rounded-lg"
              style={{ color: '#4F8CFF', background: 'rgba(79,140,255,0.1)', border: '1px solid rgba(79,140,255,0.2)' }}
              whileHover={{ scale: 1.04 }}>
              Xem tất cả <ArrowRightOutlined />
            </motion.button>
          </div>
          {loading
            ? <div className="space-y-3"><Sk /><Sk w="w-2/3" /></div>
            : <div className="space-y-3">
                {[
                  { label: 'Đang hiển thị', key: 'active', color: '#22c55e', icon: '✅' },
                  { label: 'Đã ẩn',          key: 'hidden', color: '#f59e0b', icon: '🔒' },
                  { label: 'Đã xóa',         key: 'deleted',color: '#ef4444', icon: '🗑️' },
                ].map(s => {
                  const val = stats?.postsByStatus?.[s.key] ?? 0;
                  const total = (stats?.totalPosts ?? 0) + (stats?.postsByStatus?.hidden ?? 0) + (stats?.postsByStatus?.deleted ?? 0);
                  const pct = total > 0 ? Math.round((val / total) * 100) : 0;
                  return (
                    <div key={s.key}>
                      <div className="flex justify-between text-xs mb-1">
                        <span style={{ color: 'var(--text-muted)' }}>{s.icon} {s.label}</span>
                        <span className="font-semibold" style={{ color: s.color }}>{val} ({pct}%)</span>
                      </div>
                      <div className="h-2 rounded-full overflow-hidden" style={{ background: 'var(--border)' }}>
                        <motion.div className="h-full rounded-full"
                          style={{ background: s.color }}
                          initial={{ width: 0 }}
                          animate={{ width: `${pct}%` }}
                          transition={{ duration: 0.9, ease: 'easeOut' }}
                        />
                      </div>
                    </div>
                  );
                })}

                <div className="pt-3 mt-1 border-t grid grid-cols-2 gap-3" style={{ borderColor: 'var(--border)' }}>
                  <div className="rounded-xl p-3 text-center" style={{ background: 'rgba(79,140,255,0.06)' }}>
                    <p className="text-lg font-black" style={{ color: '#4F8CFF' }}>{(stats?.totalVotes ?? 0).toLocaleString()}</p>
                    <p className="text-xs" style={{ color: 'var(--text-muted)' }}>👍 Tổng votes</p>
                  </div>
                  <div className="rounded-xl p-3 text-center" style={{ background: 'rgba(34,197,94,0.06)' }}>
                    <p className="text-lg font-black" style={{ color: '#22c55e' }}>{(stats?.totalViews ?? 0).toLocaleString()}</p>
                    <p className="text-xs" style={{ color: 'var(--text-muted)' }}>👁️ Tổng views</p>
                  </div>
                </div>
              </div>
          }
        </div>

        {/* Tags phổ biến */}
        <div className="rounded-2xl border p-5" style={{ background: 'var(--surface)', borderColor: 'var(--border)' }}>
          <div className="flex items-center justify-between mb-4">
            <h3 className="font-bold text-sm flex items-center gap-2" style={{ color: 'var(--text)' }}>
              <TrophyFilled style={{ color: '#f59e0b' }} /> Tags phổ biến nhất
            </h3>
            <motion.button onClick={() => history.push('/admin/tags')}
              className="flex items-center gap-1 text-xs font-semibold px-2.5 py-1.5 rounded-lg"
              style={{ color: '#FF6B35', background: 'rgba(255,107,53,0.1)', border: '1px solid rgba(255,107,53,0.2)' }}
              whileHover={{ scale: 1.04 }}>
              Quản lý <ArrowRightOutlined />
            </motion.button>
          </div>
          {loading
            ? <div className="space-y-3">{Array.from({ length: 5 }).map((_, i) => <Sk key={i} />)}</div>
            : <div className="space-y-2.5">
                {(stats?.popularTags ?? []).map((tag, i) => {
                  const maxCount = stats?.popularTags?.[0]?.count ?? 1;
                  const pct = Math.round((tag.count / maxCount) * 100);
                  return (
                    <div key={tag.id} className="flex items-center gap-3">
                      <span className="text-sm font-black w-5 text-center" style={{ color: 'var(--text-muted)' }}>
                        {i === 0 ? '🥇' : i === 1 ? '🥈' : i === 2 ? '🥉' : `${i + 1}.`}
                      </span>
                      <div className="flex-1">
                        <div className="flex justify-between text-xs mb-1">
                          <span className="font-semibold" style={{ color: tag.color || 'var(--text)' }}>
                            #{tag.name}
                          </span>
                          <span style={{ color: 'var(--text-muted)' }}>{tag.count} bài</span>
                        </div>
                        <div className="h-1.5 rounded-full overflow-hidden" style={{ background: 'var(--border)' }}>
                          <motion.div className="h-full rounded-full"
                            style={{ background: tag.color || '#4F8CFF' }}
                            initial={{ width: 0 }}
                            animate={{ width: `${pct}%` }}
                            transition={{ duration: 0.8, delay: i * 0.1, ease: 'easeOut' }}
                          />
                        </div>
                      </div>
                    </div>
                  );
                })}
              </div>
          }
        </div>
      </motion.div>

      {/* ── Quick Actions ─────────────────────────────────── */}
      <motion.div variants={fadeUp}>
        <h2 className="text-xs font-bold uppercase tracking-widest mb-3" style={{ color: 'var(--text-muted)' }}>
          Truy cập nhanh
        </h2>
        <div className="grid grid-cols-3 gap-3">
          {quickActions.map(a => (
            <motion.button key={a.path}
              onClick={() => history.push(a.path)}
              className="flex items-center gap-3 p-4 rounded-2xl border text-left"
              style={{ background: `${a.color}0d`, borderColor: `${a.color}30` }}
              whileHover={{ scale: 1.02, y: -2 }} whileTap={{ scale: 0.98 }}
            >
              <div className="w-9 h-9 rounded-xl flex items-center justify-center text-white"
                style={{ background: a.color }}>{a.icon}</div>
              <span className="text-sm font-semibold flex-1" style={{ color: 'var(--text)' }}>{a.label}</span>
              <ArrowRightOutlined style={{ color: a.color, fontSize: 11 }} />
            </motion.button>
          ))}
        </div>
      </motion.div>

    </motion.div>
  );
}
