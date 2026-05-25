import { useState } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { Plus, GripHorizontal, FileSignature, X, Copy, Check, Briefcase, Sparkles } from 'lucide-react'
import toast from 'react-hot-toast'
import { supabase } from '../../../lib/supabase'

const KANBAN_COLUMNS = ['Applied', 'Interview', 'Offer', 'Rejected']

interface JobApp {
  id: string
  company_name: string
  job_title: string
  status: string
}

export default function JobTrackerPage() {
  const [apps, setApps] = useState<JobApp[]>([
    { id: '1', company_name: 'Google', job_title: 'Software Engineer', status: 'Interview' },
    { id: '2', company_name: 'Microsoft', job_title: 'Frontend Dev', status: 'Applied' },
    { id: '3', company_name: 'Meta', job_title: 'React Dev', status: 'Rejected' },
  ])
  
  const [isGenerating, setIsGenerating] = useState<string | null>(null)
  const [coverLetterResult, setCoverLetterResult] = useState<string | null>(null)
  const [isCopied, setIsCopied] = useState(false)
  const [isNewModalOpen, setIsNewModalOpen] = useState(false)
  const [newApp, setNewApp] = useState({ company_name: '', job_title: '', status: 'Applied' })

  // Native HTML5 Drag and Drop
  const handleDragStart = (e: React.DragEvent, appId: string) => {
    e.dataTransfer.setData('appId', appId)
    if (e.currentTarget instanceof HTMLElement) {
       e.currentTarget.style.opacity = '0.4'
    }
  }
  const handleDragEnd = (e: React.DragEvent) => {
    if (e.currentTarget instanceof HTMLElement) {
       e.currentTarget.style.opacity = '1'
    }
  }

  const handleDrop = (e: React.DragEvent, status: string) => {
    e.preventDefault()
    const appId = e.dataTransfer.getData('appId')
    if (appId) {
      setApps(prev => prev.map(a => a.id === appId ? { ...a, status } : a))
    }
  }

  const handleDragOver = (e: React.DragEvent) => e.preventDefault()

  const handleGenerateCoverLetter = async (appId: string) => {
    setIsGenerating(appId)
    try {
      const app = apps.find(a => a.id === appId)
      const { data, error } = await supabase.functions.invoke('generate-cover-letter', {
        body: { jobTitle: app?.job_title, companyName: app?.company_name, resumeData: { name: 'Student', skills: ['React', 'TypeScript'] } }
      })
      if (error) throw error
      setCoverLetterResult(data.coverLetter)
      toast.success('AI generation complete')
    } catch (e: any) {
      toast.error('Generation failed')
    } finally {
      setIsGenerating(null)
    }
  }

  const handleCopy = () => {
    if (coverLetterResult) {
      navigator.clipboard.writeText(coverLetterResult)
      setIsCopied(true)
      setTimeout(() => setIsCopied(false), 2000)
      toast.success('Copied')
    }
  }

  const handleAddNew = (e: React.FormEvent) => {
    e.preventDefault()
    if (!newApp.company_name || !newApp.job_title) return
    setApps([{ id: Date.now().toString(), ...newApp }, ...apps])
    setNewApp({ company_name: '', job_title: '', status: 'Applied' })
    setIsNewModalOpen(false)
    toast.success('Added to board')
  }

  const getColColor = (status: string) => {
    if (status === 'Applied') return 'from-blue-500/20 via-blue-500/5 to-transparent border-blue-500/30'
    if (status === 'Interview') return 'from-amber-500/20 via-amber-500/5 to-transparent border-amber-500/30'
    if (status === 'Offer') return 'from-emerald-500/20 via-emerald-500/5 to-transparent border-emerald-500/30'
    return 'from-red-500/20 via-red-500/5 to-transparent border-red-500/30'
  }

  return (
    <div className="flex flex-col gap-6 h-full pb-10">
      
      <motion.div initial={{ opacity: 0, y: -10 }} animate={{ opacity: 1, y: 0 }} className="flex justify-end mb-2">
        <button onClick={() => setIsNewModalOpen(true)} className="flex items-center justify-center gap-2 px-6 py-2.5 bg-white/70 dark:bg-white text-slate-900 hover:bg-white/90 dark:hover:bg-slate-200 rounded-xl transition-all duration-300 shadow-[0_0_20px_rgba(255,255,255,0.2)] font-black">
          <Plus size={18} /> Add Target
        </button>
      </motion.div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 items-start h-[calc(100vh-250px)] overflow-x-auto overflow-y-hidden custom-scrollbar">
        {KANBAN_COLUMNS.map((col, idx) => (
          <motion.div 
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: idx * 0.1 }}
            key={col} 
            onDrop={(e) => handleDrop(e, col)}
            onDragOver={handleDragOver}
            className={`rounded-3xl p-5 border-t bg-gradient-to-b dark:bg-[#0a0a0c]/80 backdrop-blur-2xl h-full max-h-full flex flex-col ${getColColor(col)}`}
          >
             <div className="flex items-center justify-between mb-6 px-1">
                <h3 className="font-black text-sm uppercase tracking-widest text-slate-800 dark:text-white flex items-center gap-2">
                   {col}
                </h3>
                <span className="px-2.5 py-1 bg-white/50 dark:bg-white/10 rounded-lg text-xs font-black text-slate-600 dark:text-slate-300">
                  {apps.filter(a => a.status === col).length}
                </span>
             </div>

             <div className="flex flex-col gap-4 flex-1 overflow-y-auto custom-scrollbar pr-2 pb-10">
                <AnimatePresence>
                  {apps.filter(a => a.status === col).map(app => (
                    <motion.div 
                      key={app.id} 
                      layoutId={app.id}
                      initial={{ opacity: 0, scale: 0.9 }}
                      animate={{ opacity: 1, scale: 1 }}
                      exit={{ opacity: 0, scale: 0.9 }}
                      whileHover={{ y: -4, scale: 1.02, transition: { type: 'spring', stiffness: 400 } }}
                      draggable
                      onDragStart={(e: any) => handleDragStart(e, app.id)}
                      onDragEnd={handleDragEnd}
                      className="group bg-white dark:bg-[#12141a] p-5 rounded-2xl border border-slate-200/50 dark:border-white/5 shadow-lg dark:shadow-[0_8px_30px_rgb(0,0,0,0.4)] cursor-grab active:cursor-grabbing relative overflow-hidden"
                    >
                       <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-transparent via-brand-500/50 to-transparent opacity-0 group-hover:opacity-100 transition-opacity" />
                       
                       <div className="flex items-start justify-between mb-4">
                          <h4 className="font-black text-slate-900 dark:text-white leading-tight pr-6">{app.job_title}</h4>
                          <GripHorizontal size={16} className="text-slate-300 dark:text-slate-600 opacity-0 group-hover:opacity-100 transition-opacity absolute right-4 top-5" />
                       </div>
                       
                       <p className="text-sm font-bold text-brand-600 dark:text-cyan-500 flex items-center gap-2">
                         <div className="w-5 h-5 rounded overflow-hidden bg-white flex items-center justify-center shrink-0 shadow-sm border border-slate-100 dark:border-white/10">
                           <img src={`https://logo.clearbit.com/${app.company_name.toLowerCase().replace(/\s+/g, '')}.com`} onError={(e) => (e.currentTarget.style.display = 'none')} className="w-full h-full object-contain" alt=""/>
                         </div>
                         {app.company_name}
                       </p>
                       
                       <div className="mt-5 pt-4 border-t border-slate-100 dark:border-white/5">
                          <button 
                             onClick={() => handleGenerateCoverLetter(app.id)}
                             disabled={isGenerating === app.id}
                             className="w-full justify-center text-[11px] uppercase tracking-widest font-black text-slate-500 dark:text-slate-400 hover:text-brand-600 dark:hover:text-cyan-400 flex items-center gap-2 bg-slate-50/50 dark:bg-white/5 hover:bg-brand-50 dark:hover:bg-cyan-500/10 px-4 py-3 rounded-xl transition-all"
                          >
                             {isGenerating === app.id ? (
                               <span className="flex items-center gap-2"><Sparkles size={14} className="animate-pulse text-cyan-500" /> Thinking...</span>
                             ) : (
                               <><FileSignature size={14} /> AI Cover Letter</>
                             )}
                          </button>
                       </div>
                    </motion.div>
                  ))}
                </AnimatePresence>
                
                {apps.filter(a => a.status === col).length === 0 && (
                  <motion.div initial={{ opacity: 0 }} animate={{ opacity: 1 }} className="flex-1 min-h-[120px] flex items-center justify-center text-slate-400 dark:text-slate-600 border-2 border-dashed border-slate-200/50 dark:border-white/5 rounded-2xl">
                    <p className="text-[10px] font-black uppercase tracking-widest">Drop Zone</p>
                  </motion.div>
                )}
             </div>
          </motion.div>
        ))}
      </div>

      {/* New Application Modal */}
      <AnimatePresence>
        {isNewModalOpen && (
          <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-white/20 dark:bg-black/60 backdrop-blur-xl">
            <motion.div initial={{ opacity: 0, scale: 0.9, y: 20 }} animate={{ opacity: 1, scale: 1, y: 0 }} exit={{ opacity: 0, scale: 0.9, y: 20 }} className="bg-white dark:bg-[#0a0a0c] rounded-[2rem] w-full max-w-md overflow-hidden shadow-2xl border border-slate-200/50 dark:border-white/10 relative">
               
               <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-brand-500 to-cyan-500" />
               
               <div className="flex items-center justify-between p-8 pb-4">
                 <h2 className="font-black text-2xl text-slate-900 dark:text-white tracking-tight">New Target</h2>
                 <button onClick={() => setIsNewModalOpen(false)} className="p-2 bg-slate-100 dark:bg-white/5 rounded-full text-slate-500 hover:text-slate-900 dark:hover:text-white transition"><X size={18}/></button>
               </div>

               <form onSubmit={handleAddNew} className="p-8 pt-4 space-y-6">
                 <div>
                   <label className="text-[10px] font-black tracking-widest text-slate-400 uppercase mb-2 block">Company</label>
                   <input required type="text" value={newApp.company_name} onChange={e => setNewApp({...newApp, company_name: e.target.value})} className="w-full px-5 py-4 bg-slate-50 dark:bg-[#12141a] border border-slate-200/50 dark:border-white/5 rounded-xl outline-none focus:border-brand-500 dark:focus:border-cyan-500 transition font-bold text-slate-900 dark:text-white" placeholder="Google" />
                 </div>
                 <div>
                   <label className="text-[10px] font-black tracking-widest text-slate-400 uppercase mb-2 block">Role</label>
                   <input required type="text" value={newApp.job_title} onChange={e => setNewApp({...newApp, job_title: e.target.value})} className="w-full px-5 py-4 bg-slate-50 dark:bg-[#12141a] border border-slate-200/50 dark:border-white/5 rounded-xl outline-none focus:border-brand-500 dark:focus:border-cyan-500 transition font-bold text-slate-900 dark:text-white" placeholder="Frontend Engineer" />
                 </div>
                 <div className="pt-4">
                   <button type="submit" className="w-full py-4 font-black text-white bg-slate-900 dark:bg-white dark:text-slate-900 hover:bg-black dark:hover:bg-slate-200 rounded-xl transition shadow-[0_0_20px_rgba(255,255,255,0.1)] active:scale-95">Add to Board</button>
                 </div>
               </form>
            </motion.div>
          </div>
        )}
      </AnimatePresence>

      {/* Cover Letter Modal */}
      <AnimatePresence>
        {coverLetterResult && (
          <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 sm:p-6 bg-white/20 dark:bg-black/60 backdrop-blur-xl">
            <motion.div initial={{ opacity: 0, scale: 0.95 }} animate={{ opacity: 1, scale: 1 }} exit={{ opacity: 0, scale: 0.95 }} className="bg-white dark:bg-[#0a0a0c] rounded-[2rem] w-full max-w-2xl overflow-hidden shadow-2xl border border-slate-200/50 dark:border-white/10 flex flex-col max-h-[85vh] relative">
               <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-brand-500 to-cyan-500" />
               
               <div className="flex items-center justify-between p-8 pb-4">
                 <h2 className="font-black text-2xl text-slate-900 dark:text-white tracking-tight flex items-center gap-3"><Sparkles size={24} className="text-cyan-500"/> AI Draft</h2>
                 <button onClick={() => setCoverLetterResult(null)} className="p-2 bg-slate-100 dark:bg-white/5 rounded-full text-slate-500 hover:text-slate-900 dark:hover:text-white transition"><X size={18}/></button>
               </div>
               
               <div className="px-8 pb-4">
                 <div className="p-8 overflow-y-auto whitespace-pre-wrap font-serif text-slate-800 dark:text-slate-300 leading-loose text-lg bg-slate-50/50 dark:bg-[#12141a] rounded-2xl max-h-[50vh] custom-scrollbar border border-slate-200/50 dark:border-white/5">
                   {coverLetterResult}
                 </div>
               </div>
               
               <div className="p-8 pt-4 flex justify-end">
                 <button onClick={handleCopy} className="flex items-center gap-2 px-8 py-4 bg-slate-900 dark:bg-white text-white dark:text-slate-900 rounded-xl hover:bg-black dark:hover:bg-slate-200 transition font-black active:scale-95">
                   {isCopied ? <Check size={18} /> : <Copy size={18} />}
                   {isCopied ? 'Copied' : 'Copy Text'}
                 </button>
               </div>
            </motion.div>
          </div>
        )}
      </AnimatePresence>

    </div>
  )
}
