// ============================================================
// Core Domain Types
// ============================================================

export type UserRole = 'student' | 'lecturer' | 'admin';
export type UserStatus = 'active' | 'locked';
export type VoteType = 'up' | 'down';
export type PostStatus = 'active' | 'hidden' | 'deleted';

export interface User {
  id: string;
  name: string;
  code?: string;
  email: string;
  role: UserRole;
  status: UserStatus;
  department?: string;
  faculty?: string;
  class?: string;
  avatar?: string;
  darkMode?: boolean;
  notifications?: boolean;
  bio?: string;
  createdAt: string;
  updatedAt: string;
}

export interface Tag {
  id: string;
  name: string;
  description?: string;
  color: string;
  usageCount: number;
  createdAt: string;
  updatedAt: string;
}

export interface Post {
  id: string;
  title: string;
  content: string;
  authorId: string;
  author?: User;
  status: PostStatus;
  votes: number;
  views: number;
  answersCount: number;
  category?: string;
  tags?: Tag[];
  userVote?: VoteType | null;
  isSaved?: boolean;
  createdAt: string;
  updatedAt: string;
}

export interface Comment {
  id: string;
  postId: string;
  authorId: string;
  author?: User;
  parentCommentId?: string | null;
  content: string;
  votes: number;
  userVote?: VoteType | null;
  replies?: Comment[];
  createdAt: string;
  updatedAt: string;
}

export interface Notification {
  id: string;
  recipientId: string;
  type: string;
  targetId?: string;
  message: string;
  read: boolean;
  createdAt: string;
  updatedAt: string;
}

// ============================================================
// API Response Types
// ============================================================

export interface ApiResponse<T = unknown> {
  success: boolean;
  message?: string;
  data?: T;
  error?: string;
}

export interface PaginationMeta {
  total: number;
  page: number;
  limit: number;
  totalPages: number;
}

export interface PaginatedResponse<T> {
  data: T[];
  pagination: PaginationMeta;
}

// ============================================================
// Admin Types
// ============================================================

export interface AdminStats {
  // Tổng quan
  totalPosts:      number;
  totalUsers:      number;
  totalComments:   number;
  totalTags:       number;
  totalVotes:      number;
  totalViews:      number;
  postsToday:      number;
  postsThisWeek:   number;
  commentsToday:   number;
  activeUsers:     number;

  // Phân tích người dùng
  usersByRole:   Record<string, number>;  // student | lecturer | admin
  usersByStatus: Record<string, number>;  // active | locked

  // Phân tích bài viết
  postsByStatus: Record<string, number>;  // active | hidden | deleted

  // Xu hướng 7 ngày
  recentActivity: Array<{ date: string; label: string; posts: number; comments: number }>;

  // Top nội dung
  popularTags: Array<{ id: string; name: string; color: string; count: number }>;
  topPosts:    Array<{
    id: string; title: string; votes: number; views: number;
    answersCount: number; createdAt: string;
    author?: { id: string; name: string; role: string };
  }>;
}


// ============================================================
// Form Types
// ============================================================

export interface LoginForm {
  email: string;
  password: string;
}

export interface RegisterForm {
  name: string;
  code?: string;
  email: string;
  password: string;
  role: 'student' | 'lecturer';
  faculty?: string;
  department?: string;
  class?: string;
}

export interface CreatePostForm {
  title: string;
  content: string;
  tags: string[];
  category?: string;
}

export interface CreateCommentForm {
  content: string;
}

export interface AdminUserForm {
  name: string;
  code?: string;
  email: string;
  password?: string;
  role: UserRole;
  faculty?: string;
  department?: string;
  class?: string;
  bio?: string;
}

export interface AdminTagForm {
  name: string;
  color: string;
  description?: string;
}

// ============================================================
// UI Types
// ============================================================

export type ToastType = 'success' | 'error' | 'info' | 'warning';

export interface Toast {
  id: string;
  type: ToastType;
  message: string;
  duration?: number;
}

export interface PostFilters {
  search?: string;
  tagId?: string;
  category?: string;
  sort?: 'newest' | 'hot' | 'unanswered';
  page?: number;
  limit?: number;
}
