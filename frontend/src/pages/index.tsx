import React, { useEffect, useState, useCallback } from 'react';
import { history } from '@umijs/max';
import { motion } from 'framer-motion';
import { PlusOutlined } from '@ant-design/icons';
import { postsAPI } from '@/services/api';
import { useAuthStore } from '@/stores/auth';

export default function HomePage() {
  const { isAuthenticated } = useAuthStore();
  const [total, setTotal] = useState(0);

  const fetchPosts = useCallback(async () => {
    try {
      const res = await postsAPI.getPosts({ page: 1, limit: 1 });
      const d = res.data as any;
      setTotal(d.pagination?.total || 0);
    } catch {
      // ignore
    }
  }, []);

  useEffect(() => { fetchPosts(); }, [fetchPosts]);

  return (
    <div className="min-h-screen flex items-center justify-center" style={{ marginTop: '-64px' /* bù lại cho header nếu có */ }}>
      {/* Hero Section */}
      <section className="hero-bg py-16 px-4 w-full">
        <div className="max-w-4xl mx-auto text-center">
          <motion.div
            initial={{ opacity: 0, y: 30 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6 }}
          >
            <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full mb-6 text-sm font-semibold"
              style={{ background: 'rgba(79,140,255,0.12)', border: '1px solid rgba(79,140,255,0.25)', color: '#4F8CFF' }}>
              🎓 Cộng đồng học tập PTIT
            </div>

            <h1 className="text-4xl sm:text-5xl font-black mb-4 leading-tight" style={{ color: 'var(--text)' }}>
              Diễn Đàn{' '}
              <span className="text-gradient">Hỏi Đáp</span>
              <br />Sinh Viên
            </h1>

            <p className="text-lg mb-8 max-w-2xl mx-auto" style={{ color: 'var(--text-muted)' }}>
              Nơi sinh viên và giảng viên cùng đặt câu hỏi, chia sẻ kiến thức và học hỏi lẫn nhau.
            </p>

            <div className="flex flex-col sm:flex-row gap-3 justify-center">
              {isAuthenticated ? (
                <motion.button
                  onClick={() => history.push('/post/create')}
                  className="flex items-center justify-center gap-2 px-8 py-4 rounded-2xl text-white font-bold text-base btn-ripple"
                  style={{
                    background: 'linear-gradient(135deg, #4F8CFF, #7B61FF)',
                    boxShadow: '0 8px 32px rgba(79,140,255,0.4)',
                  }}
                  whileHover={{ scale: 1.03, y: -2 }}
                  whileTap={{ scale: 0.97 }}
                >
                  <PlusOutlined />
                  Đặt câu hỏi ngay
                </motion.button>
              ) : (
                <>
                  <motion.button
                    onClick={() => history.push('/auth/register')}
                    className="flex items-center justify-center gap-2 px-8 py-4 rounded-2xl text-white font-bold text-base"
                    style={{
                      background: 'linear-gradient(135deg, #4F8CFF, #7B61FF)',
                      boxShadow: '0 8px 32px rgba(79,140,255,0.4)',
                    }}
                    whileHover={{ scale: 1.03 }}
                  >
                    Tham gia ngay miễn phí
                  </motion.button>
                  <motion.button
                    onClick={() => history.push('/auth/login')}
                    className="flex items-center justify-center gap-2 px-8 py-4 rounded-2xl font-bold text-base border"
                    style={{ borderColor: 'var(--border)', color: 'var(--text)' }}
                    whileHover={{ scale: 1.02 }}
                  >
                    Đăng nhập
                  </motion.button>
                </>
              )}
            </div>

            {/* Stats bar */}
            <div className="flex justify-center gap-8 mt-10">
              {[
                { label: 'Câu hỏi', value: total.toString() || '0' },
                { label: 'Sinh viên', value: '100+' },
                { label: 'Giảng viên', value: '10+' },
              ].map((stat) => (
                <div key={stat.label} className="text-center">
                  <p className="text-2xl font-black text-gradient">{stat.value}</p>
                  <p className="text-sm" style={{ color: 'var(--text-muted)' }}>{stat.label}</p>
                </div>
              ))}
            </div>
          </motion.div>
        </div>
      </section>
    </div>
  );
}