import React, { useState } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { Compass, Briefcase, GraduationCap, Search, ExternalLink, MapPin, DollarSign, Building2, Calendar, Loader2, Sparkles, ArrowRight, X } from 'lucide-react'
import AppShell from '../../../components/layout/AppShell'
import Card from '../../../components/ui/Card'
import { useAuth } from '../../../hooks/useAuth'
import { supabase } from '../../../lib/supabase'
import toast from 'react-hot-toast'

type OpportunityType = 'internship' | 'job' | ''

interface Opportunity {
  company: string
  role: string
  location?: string
  stipend?: string
  description?: string
  link: string
  deadline?: string
}

export default function UnstopMatchesPage() {
  const { user } = useAuth()
  
  // Form State
  const [step, setStep] = useState<1 | 2 | 3>(1)
  const [domain, setDomain] = useState('')
  const [skills, setSkills] = useState<string[]>([])
  const [newSkill, setNewSkill] = useState('')
  const [prefType, setPrefType] = useState<OpportunityType>('')

  // Loading & Results State
  const [isScraping, setIsScraping] = useState(false)
  const [results, setResults] = useState<Opportunity[]>([])
  const [hasSearched, setHasSearched] = useState(false)

  const handleAddSkill = (e: React.KeyboardEvent) => {
    if (e.key === 'Enter' && newSkill.trim()) {
      e.preventDefault()
      if (!skills.includes(newSkill.trim()) && skills.length < 5) {
        setSkills([...skills, newSkill.trim()])
      }
      setNewSkill('')
    }
  }
  const handleRemoveSkill = (s: string) => setSkills(skills.filter(skill => skill !== s))

  const handleSearch = async () => {
    if (!domain || skills.length === 0 || !prefType) {
      return toast.error("Please fill out all survey fields.")
    }
    
    setIsScraping(true)
    setHasSearched(true)
    
    try {
      const { data, error } = await supabase.functions.invoke('unstop-scraper', {
        body: { type: prefType, domain, skills }
      })
      
      if (error) throw error
      if (!data.success) throw new Error(data.error)
      
      setResults(data.opportunities || [])
      toast.success("Matches found!")
    } catch (err: any) {
      console.error(err)
      toast.error("Failed to scrape Unstop. Please try again.")
      setHasSearched(false)
    } finally {
      setIsScraping(false)
    }
  }

  const resetSearch = () => {
    setHasSearched(false)
    setResults([])
    setStep(1)
  }

  return (
    <AppShell role="student">
      <div className="max-w-6xl mx-auto space-y-6">
        
        {/* Header */}
        <div className="flex flex-col gap-2">
          <h1 className="text-3xl font-black text-slate-900 dark:text-white flex items-center gap-3">
            <Compass className="text-brand-500 dark:text-cyan-400" size={32} />
            Unstop Matches
          </h1>
          <p className="text-slate-600 dark:text-slate-400 font-medium">
            Take a quick survey and let our AI scrape Unstop.com to find the perfect opportunities for you.
          </p>
        </div>

        {!hasSearched ? (
          /* Survey Form */
          <Card className="max-w-2xl mx-auto p-8 border-t-4 border-t-brand-500 dark:border-t-cyan-500 shadow-xl bg-white/50 dark:bg-[#12141a]/50 backdrop-blur-xl">
            <AnimatePresence mode="wait">
              {step === 1 && (
                <motion.div key="step1" initial={{ opacity: 0, x: -20 }} animate={{ opacity: 1, x: 0 }} exit={{ opacity: 0, x: 20 }} className="space-y-6">
                  <div>
                    <h2 className="text-2xl font-bold text-slate-900 dark:text-white mb-2">What is your core domain?</h2>
                    <p className="text-sm text-slate-500 dark:text-slate-400 mb-6">e.g., Software Engineering, Data Science, Digital Marketing</p>
                    <input type="text" value={domain} onChange={e => setDomain(e.target.value)} placeholder="Enter your domain..." autoFocus className="w-full text-lg px-5 py-4 rounded-xl bg-slate-50 dark:bg-black/40 border border-slate-200 dark:border-white/10 text-slate-900 dark:text-white focus:border-brand-500 outline-none transition-all shadow-sm" />
                  </div>
                  <button onClick={() => setStep(2)} disabled={!domain.trim()} className="w-full py-4 rounded-xl bg-brand-600 dark:bg-cyan-600 text-white font-bold text-lg hover:bg-brand-700 dark:hover:bg-cyan-500 transition-colors disabled:opacity-50 flex items-center justify-center gap-2">
                    Next Step <ArrowRight size={20}/>
                  </button>
                </motion.div>
              )}
              
              {step === 2 && (
                <motion.div key="step2" initial={{ opacity: 0, x: -20 }} animate={{ opacity: 1, x: 0 }} exit={{ opacity: 0, x: 20 }} className="space-y-6">
                  <div>
                    <h2 className="text-2xl font-bold text-slate-900 dark:text-white mb-2">What are your top skills?</h2>
                    <p className="text-sm text-slate-500 dark:text-slate-400 mb-6">Type up to 5 skills and press Enter (e.g., React, Python, Figma)</p>
                    
                    <input type="text" value={newSkill} onChange={e => setNewSkill(e.target.value)} onKeyDown={handleAddSkill} placeholder="Type a skill..." autoFocus className="w-full text-lg px-5 py-4 rounded-xl bg-slate-50 dark:bg-black/40 border border-slate-200 dark:border-white/10 text-slate-900 dark:text-white focus:border-brand-500 outline-none transition-all shadow-sm mb-4" />
                    
                    <div className="flex flex-wrap gap-2">
                      {skills.map(skill => (
                        <span key={skill} className="px-4 py-2 bg-brand-50 dark:bg-cyan-900/30 text-brand-700 dark:text-cyan-300 font-bold rounded-lg flex items-center gap-2 border border-brand-200 dark:border-cyan-500/30 shadow-sm">
                          {skill} <button onClick={() => handleRemoveSkill(skill)} className="hover:text-red-500"><X size={16}/></button>
                        </span>
                      ))}
                    </div>
                  </div>
                  <div className="flex gap-4">
                    <button onClick={() => setStep(1)} className="px-6 py-4 rounded-xl bg-slate-100 dark:bg-white/5 text-slate-600 dark:text-slate-300 font-bold hover:bg-slate-200 dark:hover:bg-white/10 transition-colors">Back</button>
                    <button onClick={() => setStep(3)} disabled={skills.length === 0} className="flex-1 py-4 rounded-xl bg-brand-600 dark:bg-cyan-600 text-white font-bold text-lg hover:bg-brand-700 dark:hover:bg-cyan-500 transition-colors disabled:opacity-50 flex items-center justify-center gap-2">
                      Next Step <ArrowRight size={20}/>
                    </button>
                  </div>
                </motion.div>
              )}

              {step === 3 && (
                <motion.div key="step3" initial={{ opacity: 0, x: -20 }} animate={{ opacity: 1, x: 0 }} exit={{ opacity: 0, x: 20 }} className="space-y-6">
                  <div>
                    <h2 className="text-2xl font-bold text-slate-900 dark:text-white mb-2">What are you looking for?</h2>
                    <p className="text-sm text-slate-500 dark:text-slate-400 mb-6">Select the type of opportunity</p>
                    
                    <div className="grid grid-cols-2 gap-4">
                      <button onClick={() => setPrefType('internship')} className={`p-6 rounded-2xl border-2 flex flex-col items-center justify-center gap-3 transition-all ${prefType === 'internship' ? 'border-brand-500 bg-brand-50 dark:border-cyan-500 dark:bg-cyan-900/20 text-brand-700 dark:text-cyan-400' : 'border-slate-200 dark:border-white/10 bg-slate-50 dark:bg-black/20 text-slate-500 hover:border-brand-300'}`}>
                        <GraduationCap size={40} />
                        <span className="font-bold text-lg">Internships</span>
                      </button>
                      <button onClick={() => setPrefType('job')} className={`p-6 rounded-2xl border-2 flex flex-col items-center justify-center gap-3 transition-all ${prefType === 'job' ? 'border-brand-500 bg-brand-50 dark:border-cyan-500 dark:bg-cyan-900/20 text-brand-700 dark:text-cyan-400' : 'border-slate-200 dark:border-white/10 bg-slate-50 dark:bg-black/20 text-slate-500 hover:border-brand-300'}`}>
                        <Briefcase size={40} />
                        <span className="font-bold text-lg">Full-Time Jobs</span>
                      </button>
                    </div>
                  </div>
                  <div className="flex gap-4">
                    <button onClick={() => setStep(2)} className="px-6 py-4 rounded-xl bg-slate-100 dark:bg-white/5 text-slate-600 dark:text-slate-300 font-bold hover:bg-slate-200 dark:hover:bg-white/10 transition-colors">Back</button>
                    <button onClick={handleSearch} disabled={!prefType} className="flex-1 py-4 rounded-xl bg-gradient-to-r from-brand-600 to-indigo-600 dark:from-cyan-600 dark:to-blue-600 text-white font-black text-lg hover:opacity-90 transition-all disabled:opacity-50 flex items-center justify-center gap-2 shadow-lg shadow-brand-500/30">
                      <Sparkles size={20}/> Find Matches on Unstop
                    </button>
                  </div>
                </motion.div>
              )}
            </AnimatePresence>
          </Card>
        ) : isScraping ? (
          /* Loading State */
          <div className="flex flex-col items-center justify-center py-20 px-4">
            <div className="relative">
              <div className="absolute inset-0 rounded-full blur-xl bg-brand-500/30 animate-pulse"></div>
              <Compass className="text-brand-600 dark:text-cyan-400 animate-spin-slow relative z-10" size={80} />
            </div>
            <h2 className="text-2xl font-black text-slate-900 dark:text-white mt-8 mb-2">Scraping Unstop.com...</h2>
            <p className="text-slate-500 font-medium text-center max-w-md">
              Our AI is actively browsing opportunities based on your skills ({skills.join(', ')}). This usually takes 10-15 seconds.
            </p>
            <div className="mt-8 flex items-center gap-2 text-brand-600 dark:text-cyan-400 font-bold">
              <Loader2 className="animate-spin" size={20} /> Extracting data...
            </div>
          </div>
        ) : (
          /* Results State */
          <div className="space-y-6">
            <div className="flex items-center justify-between bg-white dark:bg-[#12141a] p-4 rounded-2xl border border-slate-200 dark:border-white/5 shadow-sm">
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 rounded-full bg-emerald-100 dark:bg-emerald-900/30 text-emerald-600 dark:text-emerald-400 flex items-center justify-center">
                  <Sparkles size={20}/>
                </div>
                <div>
                  <h3 className="font-black text-slate-900 dark:text-white">{results.length} Matches Found</h3>
                  <p className="text-xs font-semibold text-slate-500 uppercase tracking-widest">{domain} • {prefType}</p>
                </div>
              </div>
              <button onClick={resetSearch} className="px-5 py-2.5 rounded-xl bg-slate-100 dark:bg-white/5 text-slate-700 dark:text-slate-300 font-bold hover:bg-slate-200 dark:hover:bg-white/10 transition-colors text-sm">
                New Search
              </button>
            </div>

            {results.length === 0 ? (
              <div className="text-center py-20">
                <Compass className="mx-auto text-slate-300 dark:text-slate-600 mb-4" size={64}/>
                <h3 className="text-xl font-bold text-slate-900 dark:text-white">No exact matches found</h3>
                <p className="text-slate-500 mt-2">Try adjusting your skills or expanding your domain.</p>
              </div>
            ) : (
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                {results.map((opp, idx) => (
                  <Card key={idx} className="flex flex-col h-full bg-white dark:bg-[#12141a] border border-slate-200 dark:border-white/5 hover:border-brand-400 dark:hover:border-cyan-500/50 transition-colors overflow-hidden group">
                    <div className="p-6 flex-1 flex flex-col">
                      <div className="flex items-start justify-between gap-4 mb-4">
                        <div>
                          <h3 className="font-bold text-lg text-slate-900 dark:text-white leading-tight mb-1 group-hover:text-brand-600 dark:group-hover:text-cyan-400 transition-colors">{opp.role}</h3>
                          <p className="font-semibold text-brand-600 dark:text-cyan-500 flex items-center gap-1.5"><Building2 size={14}/> {opp.company}</p>
                        </div>
                      </div>
                      
                      <div className="space-y-2 mt-4 mb-6">
                        {opp.location && (
                          <div className="flex items-center gap-2 text-sm font-medium text-slate-600 dark:text-slate-400">
                            <MapPin size={16} className="text-slate-400"/> {opp.location}
                          </div>
                        )}
                        {opp.stipend && (
                          <div className="flex items-center gap-2 text-sm font-medium text-emerald-600 dark:text-emerald-400 bg-emerald-50 dark:bg-emerald-500/10 w-fit px-2 py-0.5 rounded">
                            <DollarSign size={14}/> {opp.stipend}
                          </div>
                        )}
                        {opp.deadline && (
                          <div className="flex items-center gap-2 text-sm font-medium text-orange-600 dark:text-orange-400 bg-orange-50 dark:bg-orange-500/10 w-fit px-2 py-0.5 rounded">
                            <Calendar size={14}/> Ends {opp.deadline}
                          </div>
                        )}
                      </div>

                      {opp.description && (
                        <p className="text-sm text-slate-500 dark:text-slate-400 line-clamp-3 mb-6 flex-1">
                          {opp.description}
                        </p>
                      )}

                      <a href={opp.link} target="_blank" rel="noreferrer" className="mt-auto w-full py-3 rounded-xl bg-slate-900 dark:bg-white text-white dark:text-slate-900 font-bold flex items-center justify-center gap-2 hover:bg-black dark:hover:bg-slate-200 transition-colors">
                        Apply on Unstop <ExternalLink size={16}/>
                      </a>
                    </div>
                  </Card>
                ))}
              </div>
            )}
          </div>
        )}
      </div>
    </AppShell>
  )
}
