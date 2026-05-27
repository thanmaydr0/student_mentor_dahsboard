import React, { useState, useEffect } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { TrendingUp, Search, Award, BookOpen, BrainCircuit, Code, MessageSquare, Loader2, X, AlertCircle } from 'lucide-react'
import AppShell from '../../components/layout/AppShell'
import Card from '../../components/ui/Card'
import * as xlsx from 'xlsx'
import toast from 'react-hot-toast'

interface TYLData {
  usn: string
  name: string
  email: string
  branch: string
  lx: string
  ax: string
  cx: string
  px: string
  sx: string
}

export default function TYLTrackerPage() {
  const [data, setData] = useState<TYLData[]>([])
  const [isLoading, setIsLoading] = useState(true)
  const [searchQuery, setSearchQuery] = useState('')
  const [selectedStudent, setSelectedStudent] = useState<TYLData | null>(null)

  useEffect(() => {
    loadExcelData()
  }, [])

  const loadExcelData = async () => {
    try {
      // Fetch the excel file from public directory
      const response = await fetch('/trev.xlsx')
      if (!response.ok) throw new Error("Could not find master data file.")
      
      const arrayBuffer = await response.arrayBuffer()
      const wb = xlsx.read(arrayBuffer, { type: 'array' })
      
      const sheet = wb.Sheets['Consolidated']
      if (!sheet) throw new Error("Consolidated sheet not found in master data.")

      const rows: any[][] = xlsx.utils.sheet_to_json(sheet, { header: 1 })
      
      // Find the header row (the one containing 'Email' and 'Full Name')
      let headerRowIndex = -1
      for (let i = 0; i < 10; i++) {
        if (rows[i] && rows[i].includes('Email') && rows[i].includes('Full Name')) {
          headerRowIndex = i
          break
        }
      }

      if (headerRowIndex === -1) throw new Error("Could not find header row in Consolidated sheet.")

      const headers = rows[headerRowIndex]
      
      // Find exact indices for robustness, prioritizing the latter columns for Lx, Ax etc. as per master data structure
      const getIndex = (name: string, reverse = false) => {
        if (reverse) {
          for (let i = headers.length - 1; i >= 0; i--) {
            if (headers[i] === name) return i
          }
        }
        return headers.findIndex(h => typeof h === 'string' && h.includes(name))
      }

      const emailIdx = getIndex('Email')
      const nameIdx = getIndex('Full Name')
      const usnIdx = headers.findIndex(h => typeof h === 'string' && h.includes('USN'))
      const branchIdx = getIndex('BRANCH')
      
      const lxIdx = getIndex('Lx', true)
      const axIdx = getIndex('Ax', true)
      const cxIdx = getIndex('Cx', true)
      const pxIdx = getIndex('Px', true)
      const sxIdx = getIndex('Sx', true)

      const parsedData: TYLData[] = []
      
      for (let i = headerRowIndex + 1; i < rows.length; i++) {
        const row = rows[i]
        if (!row || !row[usnIdx]) continue // Skip empty rows or rows without USN
        
        parsedData.push({
          usn: (row[usnIdx] || '').toString().trim(),
          name: (row[nameIdx] || '').toString().trim(),
          email: (row[emailIdx] || '').toString().trim(),
          branch: (row[branchIdx] || '').toString().trim(),
          lx: (row[lxIdx] || '').toString().trim(),
          ax: (row[axIdx] || '').toString().trim(),
          cx: (row[cxIdx] || '').toString().trim(),
          px: (row[pxIdx] || '').toString().trim(),
          sx: (row[sxIdx] || '').toString().trim(),
        })
      }

      setData(parsedData)
      setIsLoading(false)
    } catch (err: any) {
      console.error(err)
      toast.error(err.message || "Failed to parse TYL Master Data.")
      setIsLoading(false)
    }
  }

  // Filter logic
  const searchResults = data.filter(s => {
    if (!searchQuery) return false
    const q = searchQuery.toLowerCase()
    return s.usn.toLowerCase().includes(q) || s.name.toLowerCase().includes(q)
  }).slice(0, 5) // limit to 5 results for dropdown

  const handleSelect = (student: TYLData) => {
    setSelectedStudent(student)
    setSearchQuery('')
  }

  return (
    <AppShell role="mentor">
      <div className="max-w-6xl mx-auto space-y-8">
        
        {/* Header */}
        <div className="flex flex-col gap-2">
          <h1 className="text-3xl font-black text-slate-900 dark:text-white flex items-center gap-3">
            <TrendingUp className="text-brand-500 dark:text-cyan-400" size={32} />
            TYL Tracker
          </h1>
          <p className="text-slate-600 dark:text-slate-400 font-medium">
            Search for any student to view their 'Tie Your Laces' training levels instantly from the master data.
          </p>
        </div>

        {isLoading ? (
          <div className="flex flex-col items-center justify-center py-20 px-4">
            <Loader2 className="animate-spin text-brand-500 mb-4" size={40} />
            <p className="text-slate-500 font-bold">Loading Master Data...</p>
          </div>
        ) : (
          <div className="grid grid-cols-1 lg:grid-cols-12 gap-8">
            
            {/* Search Section */}
            <div className="lg:col-span-4 flex flex-col gap-4">
              <div className="relative z-20">
                <div className="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                  <Search size={20} className="text-slate-400" />
                </div>
                <input
                  type="text"
                  placeholder="Search USN or Name..."
                  value={searchQuery}
                  onChange={(e) => setSearchQuery(e.target.value)}
                  className="w-full pl-12 pr-4 py-4 rounded-2xl bg-white dark:bg-[#12141a] border border-slate-200 dark:border-white/5 text-slate-900 dark:text-white focus:border-brand-500 outline-none transition-all shadow-sm font-bold text-lg"
                />
                
                {/* Search Dropdown */}
                <AnimatePresence>
                  {searchQuery && (
                    <motion.div
                      initial={{ opacity: 0, y: -10 }}
                      animate={{ opacity: 1, y: 0 }}
                      exit={{ opacity: 0, y: -10 }}
                      className="absolute top-full mt-2 w-full bg-white dark:bg-[#12141a] border border-slate-200 dark:border-white/5 rounded-2xl shadow-xl overflow-hidden"
                    >
                      {searchResults.length > 0 ? (
                        searchResults.map(s => (
                          <button
                            key={s.usn}
                            onClick={() => handleSelect(s)}
                            className="w-full text-left px-5 py-4 hover:bg-slate-50 dark:hover:bg-white/5 transition-colors border-b border-slate-100 dark:border-white/5 last:border-0"
                          >
                            <p className="font-bold text-slate-900 dark:text-white text-lg">{s.name}</p>
                            <p className="text-sm font-semibold text-brand-600 dark:text-cyan-500">{s.usn}</p>
                          </button>
                        ))
                      ) : (
                        <div className="px-5 py-6 text-center text-slate-500 font-medium flex flex-col items-center gap-2">
                          <AlertCircle size={24} className="text-slate-400" />
                          No students found matching "{searchQuery}"
                        </div>
                      )}
                    </motion.div>
                  )}
                </AnimatePresence>
              </div>

              {/* Instructions Box */}
              <Card className="p-6 bg-brand-50 dark:bg-cyan-900/10 border-brand-200 dark:border-cyan-500/20 shadow-none">
                <h3 className="font-bold text-brand-800 dark:text-cyan-400 mb-2 flex items-center gap-2">
                  <Award size={18} /> How to use
                </h3>
                <p className="text-sm text-brand-700/80 dark:text-cyan-400/80 leading-relaxed font-medium">
                  Type a USN (e.g. 1CR23...) or student name in the search bar. The data is pulled directly from the Consolidated master sheet without any latency.
                </p>
              </Card>
            </div>

            {/* Dashboard Section */}
            <div className="lg:col-span-8 relative z-10">
              <AnimatePresence mode="wait">
                {selectedStudent ? (
                  <motion.div
                    key={selectedStudent.usn}
                    initial={{ opacity: 0, scale: 0.95 }}
                    animate={{ opacity: 1, scale: 1 }}
                    exit={{ opacity: 0, scale: 0.95 }}
                    className="flex flex-col gap-6"
                  >
                    {/* Student Profile Header */}
                    <Card className="p-8 border-t-4 border-t-brand-500 dark:border-t-cyan-500 flex flex-col sm:flex-row items-start sm:items-center justify-between gap-6 overflow-hidden relative">
                      <div className="absolute top-0 right-0 -mr-16 -mt-16 text-brand-500/5 dark:text-cyan-500/5 rotate-12 pointer-events-none">
                        <TrendingUp size={200} />
                      </div>
                      <div>
                        <h2 className="text-3xl font-black text-slate-900 dark:text-white mb-2">{selectedStudent.name}</h2>
                        <div className="flex flex-wrap items-center gap-3 text-sm font-bold text-slate-500">
                          <span className="bg-slate-100 dark:bg-white/5 px-3 py-1 rounded-lg text-slate-700 dark:text-slate-300">{selectedStudent.usn}</span>
                          {selectedStudent.branch && <span className="bg-brand-50 dark:bg-cyan-900/30 px-3 py-1 rounded-lg text-brand-700 dark:text-cyan-400">{selectedStudent.branch}</span>}
                          {selectedStudent.email && <span>{selectedStudent.email}</span>}
                        </div>
                      </div>
                      <button onClick={() => setSelectedStudent(null)} className="shrink-0 p-2 text-slate-400 hover:text-slate-900 dark:hover:text-white transition-colors bg-slate-100 dark:bg-white/5 rounded-full">
                        <X size={20} />
                      </button>
                    </Card>

                    {/* Levels Grid */}
                    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                      <LevelCard title="Aptitude (Ax)" level={selectedStudent.ax} icon={<BrainCircuit size={24} />} color="blue" />
                      <LevelCard title="Programming (Px)" level={selectedStudent.px} icon={<Code size={24} />} color="emerald" />
                      <LevelCard title="Soft Skills (Sx)" level={selectedStudent.sx} icon={<MessageSquare size={24} />} color="amber" />
                      <LevelCard title="Language (Lx)" level={selectedStudent.lx} icon={<BookOpen size={24} />} color="indigo" />
                      <LevelCard title="Core (Cx)" level={selectedStudent.cx} icon={<Award size={24} />} color="rose" />
                    </div>
                  </motion.div>
                ) : (
                  <motion.div
                    key="empty"
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    exit={{ opacity: 0 }}
                    className="h-full min-h-[400px] flex flex-col items-center justify-center border-2 border-dashed border-slate-200 dark:border-white/5 rounded-3xl"
                  >
                    <Search size={48} className="text-slate-300 dark:text-slate-600 mb-4" />
                    <h3 className="text-xl font-bold text-slate-400 dark:text-slate-500">Search for a student</h3>
                    <p className="text-sm font-medium text-slate-400 mt-2">Their TYL tracking dashboard will appear here</p>
                  </motion.div>
                )}
              </AnimatePresence>
            </div>

          </div>
        )}
      </div>
    </AppShell>
  )
}

function LevelCard({ title, level, icon, color }: { title: string, level: string, icon: React.ReactNode, color: string }) {
  // Determine if passed based on string presence. E.g. "L1", "A2", etc.
  // If it's 0, empty, NA, or whitespace, assume not passed.
  const cleanLvl = (level || '').toString().trim().toUpperCase()
  const isCleared = cleanLvl !== '' && cleanLvl !== '0' && cleanLvl !== 'NA'

  // Dynamic colors
  const colors = {
    blue: 'bg-blue-50 text-blue-600 border-blue-200 dark:bg-blue-900/20 dark:text-blue-400 dark:border-blue-500/30',
    emerald: 'bg-emerald-50 text-emerald-600 border-emerald-200 dark:bg-emerald-900/20 dark:text-emerald-400 dark:border-emerald-500/30',
    amber: 'bg-amber-50 text-amber-600 border-amber-200 dark:bg-amber-900/20 dark:text-amber-400 dark:border-amber-500/30',
    indigo: 'bg-indigo-50 text-indigo-600 border-indigo-200 dark:bg-indigo-900/20 dark:text-indigo-400 dark:border-indigo-500/30',
    rose: 'bg-rose-50 text-rose-600 border-rose-200 dark:bg-rose-900/20 dark:text-rose-400 dark:border-rose-500/30',
  }[color] || colors.blue

  const emptyColors = 'bg-slate-50 text-slate-400 border-slate-200 dark:bg-[#12141a] dark:text-slate-600 dark:border-white/5'

  return (
    <Card className={`p-6 border-2 transition-all ${isCleared ? colors : emptyColors}`}>
      <div className="flex justify-between items-start mb-6">
        <div className={`p-3 rounded-xl ${isCleared ? 'bg-white dark:bg-black/20' : 'bg-slate-100 dark:bg-white/5'}`}>
          {icon}
        </div>
        {isCleared ? (
          <span className="px-3 py-1 bg-white dark:bg-black/20 rounded-full text-xs font-black uppercase tracking-wider shadow-sm">
            Cleared
          </span>
        ) : (
          <span className="px-3 py-1 bg-slate-200 dark:bg-white/5 rounded-full text-xs font-bold text-slate-500 uppercase tracking-wider">
            Not Cleared
          </span>
        )}
      </div>
      <div>
        <p className="text-[11px] font-black tracking-widest uppercase mb-1 opacity-70">{title}</p>
        <h3 className="text-3xl font-black">
          {isCleared ? cleanLvl : '—'}
        </h3>
      </div>
    </Card>
  )
}
