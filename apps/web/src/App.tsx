import { lazy, Suspense } from 'react'
import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom'
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import { Toaster } from 'react-hot-toast'
import { AuthProvider } from './context/AuthContext'
import { ThemeProvider } from './context/ThemeContext'
import ProtectedRoute from './components/layout/ProtectedRoute'

// Lazy-loaded pages
const LoginPage = lazy(() => import('./pages/auth/LoginPage'))
const SignUpPage = lazy(() => import('./pages/auth/SignUpPage'))
const StudentDashboard = lazy(() => import('./pages/StudentDashboard'))
const TimetablePage = lazy(() => import('./pages/student/TimetablePage'))
const AttendancePage = lazy(() => import('./pages/student/AttendancePage'))
const NotificationsPage = lazy(() => import('./pages/shared/NotificationsPage'))
const MentorDashboard = lazy(() => import('./pages/mentor/MentorDashboard'))
const StudentDetailPage = lazy(() => import('./pages/mentor/StudentDetailPage'))
const TYLTrackerPage = lazy(() => import('./pages/mentor/TYLTrackerPage'))
const BulkAttendancePage = lazy(() => import('./pages/mentor/BulkAttendancePage'))
const TimetableManagePage = lazy(() => import('./pages/mentor/TimetableManagePage'))
const IATMarksPage = lazy(() => import('./pages/mentor/IATMarksPage'))
const ResultFetchPage = lazy(() => import('./pages/mentor/ResultFetchPage'))
const CommunityPage = lazy(() => import('./pages/mentor/CommunityPage'))
const ParentCommsPage = lazy(() => import('./pages/mentor/ParentCommsPage'))
const FeeManagementPage = lazy(() => import('./pages/mentor/FeeManagementPage'))
const ERPScraperPage = lazy(() => import('./pages/mentor/ERPScraperPage'))
const ResourceLibraryPage = lazy(() => import('./pages/student/ResourceLibraryPage'))
const LeaderboardPage = lazy(() => import('./pages/student/LeaderboardPage'))
const CalendarParserPage = lazy(() => import('./pages/student/CalendarParserPage'))
const CareerAssistancePage = lazy(() => import('./pages/student/career/CareerAssistancePage'))
const ResumeBuilderPage = lazy(() => import('./pages/student/career/ResumeBuilderPage'))
const UnstopMatchesPage = lazy(() => import('./pages/student/career/UnstopMatchesPage'))
const AchievementVaultPage = lazy(() => import('./pages/student/AchievementVaultPage'))
const FeePaymentPage = lazy(() => import('./pages/student/FeePaymentPage'))
const ProfilePage = lazy(() => import('./pages/ProfilePage'))
const ParentDashboard = lazy(() => import('./pages/parent/ParentDashboard'))
const AcademicGPSPage = lazy(() => import('./pages/parent/AcademicGPSPage'))
const CareerRadarPage = lazy(() => import('./pages/parent/CareerRadarPage'))
const MentorConnectPage = lazy(() => import('./pages/parent/MentorConnectPage'))
const SmartDeadlinesPage = lazy(() => import('./pages/parent/SmartDeadlinesPage'))
const ResourceRequestsPage = lazy(() => import('./pages/ResourceRequestsPage'))
const RewardsHubPage = lazy(() => import('./pages/student/RewardsHubPage'))
const NotFoundPage = lazy(() => import('./pages/NotFoundPage'))

const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      staleTime: 1000 * 60 * 5, // 5 minutes
      retry: 1,
      refetchOnWindowFocus: false,
    },
  },
})

function PageFallback() {
  return (
    <div className="flex min-h-screen items-center justify-center bg-surface-50">
      <div className="h-8 w-8 animate-spin rounded-full border-2 border-brand-300 border-t-brand-800" />
    </div>
  )
}

export default function App() {
  return (
    <BrowserRouter>
      <QueryClientProvider client={queryClient}>
        <ThemeProvider>
          <AuthProvider>
            <Suspense fallback={<PageFallback />}>
              <Routes>
                {/* Public routes */}
                <Route path="/" element={<Navigate to="/auth/login" replace />} />
                <Route path="/auth/login" element={<LoginPage />} />
                <Route path="/auth/signup" element={<SignUpPage />} />

                {/* Student routes */}
                <Route element={<ProtectedRoute role="student" />}>
                  <Route path="/student/dashboard" element={<StudentDashboard />} />
                  <Route path="/student/timetable" element={<TimetablePage />} />
                  <Route path="/student/career/resume" element={<ResumeBuilderPage />} />
                  <Route path="/student/career/unstop" element={<UnstopMatchesPage />} />
                  <Route path="/student/achievements" element={<AchievementVaultPage />} />
                  <Route path="/student/attendance" element={<AttendancePage />} />
                  <Route path="/student/notifications" element={<NotificationsPage />} />
                  <Route path="/student/library" element={<ResourceLibraryPage />} />
                  <Route path="/student/leaderboard" element={<LeaderboardPage />} />
                  <Route path="/student/calendar" element={<CalendarParserPage />} />
                  <Route path="/student/career" element={<CareerAssistancePage />} />
                  <Route path="/student/unstop-matches" element={<UnstopMatchesPage />} />
                  <Route path="/student/fees" element={<FeePaymentPage />} />
                  <Route path="/student/peer-resources" element={<ResourceRequestsPage />} />
                  <Route path="/student/rewards" element={<RewardsHubPage />} />
                </Route>

                {/* Mentor routes */}
                <Route element={<ProtectedRoute role="mentor" />}>
                  <Route path="/mentor/dashboard" element={<MentorDashboard />} />
                  <Route path="/mentor/student/:id" element={<StudentDetailPage />} />
                  <Route path="/mentor/attendance" element={<BulkAttendancePage />} />
                  <Route path="/mentor/timetable" element={<TimetableManagePage />} />
                  <Route path="/mentor/iat-marks" element={<IATMarksPage />} />
                  <Route path="/mentor/results" element={<ResultFetchPage />} />
                  <Route path="/mentor/community" element={<CommunityPage />} />
                  <Route path="/mentor/parents" element={<ParentCommsPage />} />
                  <Route path="/mentor/fees" element={<FeeManagementPage />} />
                  <Route path="/mentor/erp-scraper" element={<ERPScraperPage />} />
                  <Route path="/mentor/tyl-tracker" element={<TYLTrackerPage />} />
                  <Route path="/mentor/library" element={<ResourceLibraryPage />} />
                </Route>

                {/* Shared protected routes (any authenticated user) */}
                <Route element={<ProtectedRoute />}>
                  <Route path="/profile" element={<ProfilePage />} />
                </Route>

                {/* Parent routes */}
                <Route element={<ProtectedRoute role="parent" />}>
                  <Route path="/parent/dashboard" element={<ParentDashboard />} />
                  <Route path="/parent/predictor" element={<AcademicGPSPage />} />
                  <Route path="/parent/career-radar" element={<CareerRadarPage />} />
                  <Route path="/parent/mentor-connect" element={<MentorConnectPage />} />
                  <Route path="/parent/deadlines" element={<SmartDeadlinesPage />} />
                </Route>

                {/* 404 */}
                <Route path="*" element={<NotFoundPage />} />
              </Routes>
            </Suspense>

            <Toaster
              position="top-right"
              toastOptions={{
                duration: 4000,
                style: {
                  fontFamily: 'DM Sans, system-ui, sans-serif',
                  borderRadius: '12px',
                  padding: '12px 16px',
                  fontSize: '14px',
                },
              }}
            />
          </AuthProvider>
        </ThemeProvider>
      </QueryClientProvider>
    </BrowserRouter>
  )
}
