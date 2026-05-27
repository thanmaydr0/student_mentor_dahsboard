import { useLocation, Link } from 'react-router-dom'
import { motion, AnimatePresence } from 'framer-motion'
import {
  LayoutDashboard,
  Calendar,
  Bell,
  UserCircle,
  Users,
  ClipboardCheck,
  ClipboardList,
  GraduationCap,
  LogOut,
  X,
  FileText,
  Library,
  Trophy,
  CalendarDays,
  MessageSquare,
  Briefcase,
  PenTool,
  Video,
  TrendingUp,
  Target,
  CreditCard,
  Receipt,
  ScanSearch,
  Compass
} from 'lucide-react'
import { useAuth } from '../../hooks/useAuth'
import { useUnreadCount } from '../../hooks/student/useNotifications'
import { cn } from '../../lib/utils'
import { useTheme } from '../../context/ThemeContext'

interface SidebarProps {
  role: 'student' | 'mentor' | 'parent'
  isOpen: boolean
  onClose: () => void
}

interface NavItem {
  label: string
  path: string
  icon: typeof LayoutDashboard
  badge?: boolean
}

const studentNav: NavItem[] = [
  { label: 'Dashboard', path: '/student/dashboard', icon: LayoutDashboard },
  { label: 'Leaderboard', path: '/student/leaderboard', icon: Trophy },
  { label: 'Career Assistance', path: '/student/career', icon: Briefcase },
  { label: 'Unstop Matches', path: '/student/unstop-matches', icon: Compass },
  { label: 'Calendar AI', path: '/student/calendar', icon: CalendarDays },
  { label: 'Timetable', path: '/student/timetable', icon: Calendar },
  { label: 'Fee Payments', path: '/student/fees', icon: CreditCard },
  { label: 'Resource Library', path: '/student/library', icon: Library },
  { label: 'Notifications', path: '/student/notifications', icon: Bell, badge: true },
  { label: 'Profile', path: '/profile', icon: UserCircle },
]

const mentorNav: NavItem[] = [
  { label: 'Dashboard', path: '/mentor/dashboard', icon: LayoutDashboard },
  { label: 'Community', path: '/mentor/community', icon: Users },
  { label: 'Parent Comms', path: '/mentor/parents', icon: MessageSquare },
  { label: 'Attendance Log', path: '/mentor/attendance', icon: ClipboardCheck },
  { label: 'IAT Marks', path: '/mentor/iat-marks', icon: ClipboardList },
  { label: 'Result Fetch', path: '/mentor/results', icon: FileText },
  { label: 'Fee Receipts', path: '/mentor/fees', icon: Receipt },
  { label: 'ERP Deep Scraper', path: '/mentor/erp-scraper', icon: ScanSearch },
  { label: 'TYL Tracker', path: '/mentor/tyl-tracker', icon: TrendingUp },
  { label: 'Resource Library', path: '/mentor/library', icon: Library },
  { label: 'Timetable', path: '/mentor/timetable', icon: Calendar },
  { label: 'Profile', path: '/profile', icon: UserCircle },
]

const parentNav: NavItem[] = [
  { label: 'Dashboard', path: '/parent/dashboard', icon: LayoutDashboard },
  { label: 'Academic GPS', path: '/parent/predictor', icon: TrendingUp },
  { label: 'Career Radar', path: '/parent/career-radar', icon: Target },
  { label: 'Mentor Connect', path: '/parent/mentor-connect', icon: MessageSquare },
  { label: 'Deadlines', path: '/parent/deadlines', icon: CalendarDays },
  { label: 'Profile', path: '/profile', icon: UserCircle },
]

export default function Sidebar({ role, isOpen, onClose }: SidebarProps) {
  const { pathname } = useLocation()
  const { user, profile, signOut } = useAuth()
  const { theme } = useTheme()

  const { data: unreadCount = 0 } = useUnreadCount(user?.id)
  const links = role === 'student' ? studentNav : role === 'parent' ? parentNav : mentorNav

  const sidebarContent = (
    <>
      {/* Top: Logo */}
      <div className="flex h-16 shrink-0 items-center justify-between border-b border-brand-50 dark:border-white/5 px-6">
        <Link to={`/${role}/dashboard`} className="flex items-center gap-2" onClick={onClose}>
          <div className="flex h-8 w-8 items-center justify-center rounded-lg bg-brand-800 dark:bg-amber-400 dark:text-black">
            <GraduationCap size={18} className="text-white dark:text-black" strokeWidth={2} />
          </div>
          <span className="text-lg font-semibold tracking-tight text-brand-900 dark:text-white">
            EduPredict
          </span>
        </Link>
        <button
          onClick={onClose}
          className="rounded-md p-1 text-brand-400 hover:text-brand-600 dark:text-slate-400 dark:hover:text-white md:hidden"
        >
          <X size={20} />
        </button>
      </div>

      {/* Middle: Navigation */}
      <nav className="flex-1 space-y-1 overflow-y-auto px-3 py-6">
        {links.map((link) => {
          const isActive = pathname === link.path || pathname.startsWith(link.path + '/')
          const Icon = link.icon

          return (
            <Link
              key={link.label}
              to={link.path}
              onClick={onClose}
              className={cn(
                'relative flex items-center gap-3 rounded-lg px-3 py-2.5 text-sm font-medium transition-colors duration-150',
                isActive
                  ? 'text-brand-900 dark:text-black font-semibold'
                  : 'text-brand-600 hover:bg-slate-100/80 hover:text-brand-900 dark:text-slate-400 dark:hover:bg-white/5 dark:hover:text-slate-100'
              )}
            >
              {isActive && (
                <motion.div
                  layoutId="sidebar-active-indicator"
                  className="absolute inset-0 rounded-lg border-l-2 border-brand-600 bg-brand-50 dark:border-amber-500 dark:bg-amber-400"
                  initial={false}
                  transition={{ type: 'spring', stiffness: 300, damping: 30 }}
                />
              )}

              <span className="relative z-10 flex w-full items-center justify-between">
                <span className="flex items-center gap-3">
                  <Icon
                    size={18}
                    className={cn('stroke-[2px]', isActive ? 'text-brand-700 dark:text-black' : 'text-brand-400 dark:text-slate-500')}
                  />
                  {link.label}
                </span>

                {link.badge && unreadCount > 0 && (
                  <span className={cn(
                    'flex h-5 items-center justify-center rounded-full px-2 text-xs font-semibold',
                    isActive 
                      ? 'bg-red-500 text-white' 
                      : 'bg-red-100 text-red-600 dark:bg-red-950/40 dark:text-red-400'
                  )}>
                    {unreadCount}
                  </span>
                )}
              </span>
            </Link>
          )
        })}
      </nav>

      {/* Bottom: User Profile */}
      <div className="shrink-0 border-t border-brand-50 dark:border-white/5 p-4">
        <div className="mb-2 flex items-center gap-3 px-2 py-2">
          <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-brand-100 text-brand-700 dark:bg-slate-800 dark:text-slate-200">
            {profile?.avatar_url ? (
              <img
                src={profile.avatar_url}
                alt="Profile"
                className="h-full w-full rounded-full object-cover"
              />
            ) : (
              <span className="font-semibold">
                {profile?.full_name?.charAt(0).toUpperCase() || 'U'}
              </span>
            )}
          </div>
          <div className="flex min-w-0 flex-col">
            <span className="truncate text-sm font-medium text-brand-900 dark:text-white">
              {profile?.full_name || 'User'}
            </span>
            <span className="truncate text-xs capitalize text-brand-500 dark:text-slate-400">
              {profile?.role || role}
            </span>
          </div>
        </div>

        <button
          onClick={() => {
            onClose()
            signOut()
          }}
          className="flex w-full items-center gap-2 rounded-lg px-3 py-2 text-sm font-medium text-red-600 transition-colors hover:bg-red-50 dark:hover:bg-red-950/20"
        >
          <LogOut size={16} />
          Sign Out
        </button>
      </div>
    </>
  )

  return (
    <>
      {/* ─── Desktop Sidebar (always visible, no animation) ─── */}
      <aside className="fixed inset-y-0 left-0 z-30 hidden w-[240px] flex-col border-r border-brand-100 bg-white dark:border-white/5 dark:bg-slate-900/60 dark:backdrop-blur-md md:flex">
        {sidebarContent}
      </aside>

      {/* ─── Mobile Sidebar (animated drawer) ─── */}
      <AnimatePresence>
        {isOpen && (
          <>
            {/* Backdrop */}
            <motion.div
              key="backdrop"
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              exit={{ opacity: 0 }}
              transition={{ duration: 0.2 }}
              className="fixed inset-0 z-40 bg-slate-900/30 backdrop-blur-sm md:hidden"
              onClick={onClose}
            />

            {/* Drawer */}
            <motion.aside
              key="mobile-sidebar"
              initial={{ x: -240 }}
              animate={{ x: 0 }}
              exit={{ x: -240 }}
              transition={{ duration: 0.3, ease: [0.22, 1, 0.36, 1] }}
              className="fixed inset-y-0 left-0 z-50 flex w-[240px] flex-col border-r border-brand-100 bg-white dark:border-white/5 dark:bg-[#0c0d10] shadow-xl md:hidden"
            >
              {sidebarContent}
            </motion.aside>
          </>
        )}
      </AnimatePresence>
    </>
  )
}
