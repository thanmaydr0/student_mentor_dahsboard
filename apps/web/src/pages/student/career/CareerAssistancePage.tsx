import { useState } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { Briefcase, PenTool, Video, Sparkles } from 'lucide-react'
import ResumeBuilderPage from './ResumeBuilderPage'
import JobTrackerPage from './JobTrackerPage'
import InterviewPrepPage from './InterviewPrepPage'
import LightRays from '../../../components/ui/LightRays'
import ThemeToggle from '../../../components/ui/ThemeToggle'

const TABS = [
  { id: 'resume', label: 'Resume', icon: PenTool },
  { id: 'jobs', label: 'Jobs', icon: Briefcase },
  { id: 'interview', label: 'Interviews', icon: Video },
]

export default function CareerAssistancePage() {
  const [activeTab, setActiveTab] = useState<'resume' | 'jobs' | 'interview'>('resume')

  return (
    <div className="relative min-h-[calc(100vh-100px)] w-full overflow-hidden flex flex-col -mx-4 -mt-6 sm:mx-0 sm:mt-0 p-4 sm:p-0">
      
      {/* Background Atmosphere */}
      <div className="absolute inset-0 z-0 pointer-events-none overflow-hidden rounded-3xl">
         <LightRays />
         <div className="absolute inset-0 bg-gradient-to-b from-slate-50/50 to-white dark:from-[#0a0a0a]/50 dark:to-[#0a0a0a] backdrop-blur-[2px]" />
      </div>

      <div className="relative z-10 flex flex-col h-full flex-1">
        
        {/* Floating Header & Navigation Dock */}
        <div className="flex flex-col md:flex-row items-center justify-between gap-6 mb-8 mt-2 print:hidden">
          <div className="flex items-center gap-3">
             <div className="w-12 h-12 rounded-2xl bg-gradient-to-br from-brand-500 to-indigo-600 flex items-center justify-center shadow-lg shadow-brand-500/30">
               <Sparkles className="text-white" size={24} />
             </div>
             <div>
               <h1 className="text-2xl sm:text-3xl font-black tracking-tight text-slate-900 dark:text-white">Career Hub</h1>
               <p className="text-sm font-medium text-slate-500 dark:text-slate-400">Your ultimate placement arsenal.</p>
             </div>
          </div>

          <div className="flex items-center gap-4">
            {/* The Dock */}
            <nav className="flex p-1.5 bg-white/70 dark:bg-[#1a1d24]/70 backdrop-blur-xl rounded-2xl shadow-sm border border-slate-200/50 dark:border-white/10">
              {TABS.map((tab) => {
                 const isActive = activeTab === tab.id
                 const Icon = tab.icon
                 return (
                   <button
                     key={tab.id}
                     onClick={() => setActiveTab(tab.id as any)}
                     className={`relative flex items-center gap-2 px-5 py-2.5 rounded-xl text-sm font-bold transition-all duration-300 z-10 ${
                       isActive 
                         ? 'text-white' 
                         : 'text-slate-500 hover:text-slate-800 dark:text-slate-400 dark:hover:text-slate-200'
                     }`}
                   >
                     {isActive && (
                       <motion.div
                         layoutId="career-dock-indicator"
                         className="absolute inset-0 bg-slate-900 dark:bg-white rounded-xl shadow-md"
                         initial={false}
                         transition={{ type: 'spring', stiffness: 500, damping: 35 }}
                       />
                     )}
                     <span className="relative z-10 flex items-center gap-2">
                       <Icon size={18} className={isActive ? 'text-white dark:text-black' : ''} /> 
                       <span className="hidden sm:inline">{tab.label}</span>
                     </span>
                   </button>
                 )
              })}
            </nav>

            {/* Explicit Theme Toggle for the Hub */}
            <div className="bg-white/70 dark:bg-[#1a1d24]/70 backdrop-blur-xl p-2 rounded-2xl shadow-sm border border-slate-200/50 dark:border-white/10 hidden sm:block">
              <ThemeToggle />
            </div>
          </div>
        </div>

        {/* Content Area with Staggered Slide Animations */}
        <div className="flex-1 w-full relative">
          <AnimatePresence mode="wait">
            {activeTab === 'resume' && (
              <motion.div key="resume" initial={{ opacity: 0, y: 20, scale: 0.98 }} animate={{ opacity: 1, y: 0, scale: 1 }} exit={{ opacity: 0, y: -20, scale: 0.98 }} transition={{ duration: 0.4, ease: [0.22, 1, 0.36, 1] }} className="h-full">
                <ResumeBuilderPage />
              </motion.div>
            )}
            {activeTab === 'jobs' && (
              <motion.div key="jobs" initial={{ opacity: 0, y: 20, scale: 0.98 }} animate={{ opacity: 1, y: 0, scale: 1 }} exit={{ opacity: 0, y: -20, scale: 0.98 }} transition={{ duration: 0.4, ease: [0.22, 1, 0.36, 1] }} className="h-full">
                <JobTrackerPage />
              </motion.div>
            )}
            {activeTab === 'interview' && (
              <motion.div key="interview" initial={{ opacity: 0, y: 20, scale: 0.98 }} animate={{ opacity: 1, y: 0, scale: 1 }} exit={{ opacity: 0, y: -20, scale: 0.98 }} transition={{ duration: 0.4, ease: [0.22, 1, 0.36, 1] }} className="h-full">
                <InterviewPrepPage />
              </motion.div>
            )}
          </AnimatePresence>
        </div>

      </div>
    </div>
  )
}
