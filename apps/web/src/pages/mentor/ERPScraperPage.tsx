import React, { useState } from 'react'
import { ScanSearch, UserSearch, AlertCircle, Loader2 } from 'lucide-react'
import AppShell from '../../components/layout/AppShell'
import Card from '../../components/ui/Card'
import { useAuth } from '../../hooks/useAuth'
import { useMentorStudents } from '../../hooks/mentor/useMentorStudents'
import { supabase } from '../../lib/supabase'
import ComprehensiveReport from '../../components/mentor/ComprehensiveReport'

export default function ERPScraperPage() {
  const { user } = useAuth()
  const { data: students, isLoading: isLoadingStudents } = useMentorStudents(user?.id)
  
  const [selectedStudentId, setSelectedStudentId] = useState('')
  const [isScraping, setIsScraping] = useState(false)
  const [error, setError] = useState<string | null>(null)
  
  const [reportData, setReportData] = useState<{ studentName: string, markdown: string } | null>(null)

  const handleScrape = async () => {
    if (!selectedStudentId) return
    
    setIsScraping(true)
    setError(null)
    setReportData(null)

    try {
      const { data: session } = await supabase.auth.getSession()
      
      const res = await fetch(
        `${import.meta.env.VITE_SUPABASE_URL}/functions/v1/erp-full-profile-sync`,
        {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${session.session?.access_token}`
          },
          body: JSON.stringify({ student_id: selectedStudentId })
        }
      )

      const result = await res.json()

      if (!res.ok || result.error) {
        throw new Error(result.error || 'Failed to scrape ERP')
      }

      setReportData({
        studentName: result.student_name,
        markdown: result.markdown
      })
    } catch (err: any) {
      setError(err.message)
    } finally {
      setIsScraping(false)
    }
  }

  return (
    <AppShell role="mentor">
      <div className="mx-auto max-w-6xl space-y-8">
        <div>
          <h1 className="text-2xl font-bold tracking-tight text-brand-900 dark:text-white sm:text-3xl">
            ERP Deep Scraper
          </h1>
          <p className="mt-2 text-sm text-brand-600 dark:text-slate-400 sm:text-base">
            Select a student to completely scrape their ERP dashboard and generate a comprehensive PDF report.
          </p>
        </div>

        {/* Selection Area */}
        <Card className="p-6">
          <div className="flex flex-col md:flex-row gap-4 items-end">
            <div className="flex-1 w-full space-y-2">
              <label className="text-sm font-medium text-brand-900 dark:text-white flex items-center gap-2">
                <UserSearch size={16} className="text-brand-500" />
                Select Student
              </label>
              <div className="relative">
                <select
                  value={selectedStudentId}
                  onChange={(e) => setSelectedStudentId(e.target.value)}
                  className="w-full appearance-none rounded-xl border border-brand-200 bg-white px-4 py-3 pr-10 text-sm font-medium text-brand-900 outline-none transition-all focus:border-brand-500 focus:ring-4 focus:ring-brand-500/10 dark:border-white/10 dark:bg-slate-900 dark:text-white dark:focus:border-amber-500 dark:focus:ring-amber-500/10"
                  disabled={isLoadingStudents || isScraping}
                >
                  <option value="">-- Choose a student from your cohort --</option>
                  {students?.map(s => (
                    <option key={s.id} value={s.id}>
                      {s.full_name} ({s.usn || 'No USN'})
                    </option>
                  ))}
                </select>
                <div className="pointer-events-none absolute inset-y-0 right-0 flex items-center px-4">
                  <svg className="h-4 w-4 text-brand-400 dark:text-slate-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                  </svg>
                </div>
              </div>
            </div>

            <button
              onClick={handleScrape}
              disabled={!selectedStudentId || isScraping}
              className="w-full md:w-auto flex items-center justify-center gap-2 rounded-xl bg-brand-600 px-8 py-3 text-sm font-semibold text-white shadow-sm transition-all hover:bg-brand-700 focus:outline-none focus:ring-4 focus:ring-brand-500/20 disabled:cursor-not-allowed disabled:opacity-50 dark:bg-amber-500 dark:text-slate-900 dark:hover:bg-amber-400"
            >
              {isScraping ? (
                <>
                  <Loader2 size={18} className="animate-spin" />
                  Scraping ERP...
                </>
              ) : (
                <>
                  <ScanSearch size={18} />
                  Run Deep Scrape
                </>
              )}
            </button>
          </div>
          
          {error && (
            <div className="mt-4 flex items-center gap-2 text-sm text-red-600 dark:text-red-400 bg-red-50 dark:bg-red-950/30 p-3 rounded-lg border border-red-100 dark:border-red-900/50">
              <AlertCircle size={16} />
              {error}
            </div>
          )}
        </Card>

        {/* Loading State Area */}
        {isScraping && (
          <div className="flex flex-col items-center justify-center py-20 space-y-6">
            <div className="relative h-24 w-24">
              <div className="absolute inset-0 rounded-full border-4 border-brand-100 dark:border-white/5"></div>
              <div className="absolute inset-0 rounded-full border-4 border-brand-600 dark:border-amber-500 border-t-transparent animate-spin"></div>
              <div className="absolute inset-0 flex items-center justify-center text-brand-600 dark:text-amber-500">
                <ScanSearch size={32} className="animate-pulse" />
              </div>
            </div>
            <div className="text-center space-y-2">
              <h3 className="text-xl font-bold text-brand-900 dark:text-white">Connecting to ERP</h3>
              <p className="text-brand-500 dark:text-slate-400">Authenticating and downloading full student profile...</p>
            </div>
          </div>
        )}

        {/* Report Display Area */}
        {reportData && !isScraping && (
          <div className="h-[800px] print:h-auto">
            <ComprehensiveReport 
              studentName={reportData.studentName} 
              markdownContent={reportData.markdown} 
            />
          </div>
        )}
      </div>
    </AppShell>
  )
}
