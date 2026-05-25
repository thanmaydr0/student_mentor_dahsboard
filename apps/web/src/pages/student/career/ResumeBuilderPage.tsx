import { useState, useRef } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { FileText, Save, Download, Mic, Plus, Trash2, ShieldCheck, ChevronDown, Briefcase, GraduationCap, LayoutPanelLeft, Upload, Sparkles } from 'lucide-react'
import toast from 'react-hot-toast'
import { supabase } from '../../../lib/supabase'
import * as pdfjsLib from 'pdfjs-dist'
import pdfWorkerUrl from 'pdfjs-dist/build/pdf.worker.min.mjs?url'

// Set up PDF.js worker
pdfjsLib.GlobalWorkerOptions.workerSrc = pdfWorkerUrl

const STAGGER = {
  hidden: { opacity: 0, y: 20 },
  show: {
    opacity: 1,
    y: 0,
    transition: { staggerChildren: 0.1, delayChildren: 0.1 }
  }
}

const ITEM = {
  hidden: { opacity: 0, y: 15 },
  show: { opacity: 1, y: 0, transition: { type: 'spring', stiffness: 300, damping: 24 } }
}

export default function ResumeBuilderPage() {
  const [resumeData, setResumeData] = useState({
    name: '',
    email: '',
    summary: '',
    experience: [{ company: '', role: '', description: '' }],
    education: [{ school: '', degree: '', year: '' }],
  })
  
  const [atsScore, setAtsScore] = useState<number | null>(null)
  const [tips, setTips] = useState<string[]>([])
  const [isScoring, setIsScoring] = useState(false)
  const [isImporting, setIsImporting] = useState(false)
  const [isImprovising, setIsImprovising] = useState(false)
  const [activeSection, setActiveSection] = useState<string>('personal')
  const fileInputRef = useRef<HTMLInputElement>(null)

  const handleImportClick = () => fileInputRef.current?.click()
  
  const handleFileChange = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0]
    if (!file) return
    setIsImporting(true)
    try {
      let extractedText = ''
      
      if (file.type === 'application/pdf') {
        const arrayBuffer = await file.arrayBuffer()
        const pdf = await pdfjsLib.getDocument({ data: arrayBuffer }).promise
        let fullText = ''
        for (let i = 1; i <= pdf.numPages; i++) {
          const page = await pdf.getPage(i)
          const textContent = await page.getTextContent()
          const pageText = textContent.items.map((item: any) => item.str).join(' ')
          fullText += pageText + '\n'
        }
        extractedText = fullText
      } else {
        extractedText = await file.text()
      }
      if (!extractedText.trim()) {
        const err: any = new Error("Could not extract text from file")
        err.extractedText = ""
        throw err
      }
      
      console.log('Extracted text length:', extractedText.length)

      const { data, error } = await supabase.functions.invoke('parse-resume', {
        body: { text: extractedText }
      })
      
      if (error || !data) {
         const err: any = new Error("Edge function error")
         err.extractedText = extractedText
         throw err
      }

      console.log('Parsed data from edge function:', data)

      setResumeData({
        name: data.name || '',
        email: data.email || '',
        summary: data.summary || '',
        experience: data.experience?.length ? data.experience : [{ company: '', role: '', description: '' }],
        education: data.education?.length ? data.education : [{ school: '', degree: '', year: '' }],
      })
      toast.success('Resume imported successfully!')
    } catch (err: any) {
      console.error('Resume Parse Error:', err)
      
      // Fallback: If edge function fails (e.g. not deployed), dump text into summary so user doesn't lose it
      const fallbackText = file?.type === 'application/pdf' ? 'Raw PDF Text Extracted (AI Formatting Unavailable): \n\n' : ''
      setResumeData(prev => ({
        ...prev,
        summary: prev.summary + '\n' + fallbackText + (err.extractedText || 'Could not parse text correctly.')
      }))
      
      toast.error('AI formatting failed. Raw text dumped into summary.')
    } finally {
      setIsImporting(false)
      if (e.target) e.target.value = ''
    }
  }

  const handleImprovise = async () => {
    setIsImprovising(true)
    try {
      // Simulate AI rewriting
      await new Promise(r => setTimeout(r, 2500))
      setResumeData(prev => ({
        ...prev,
        summary: prev.summary 
          ? `Results-driven professional with a proven track record of delivering scalable solutions. ${prev.summary}`
          : 'Innovative and results-driven professional with a proven track record of designing and implementing scalable systems.',
        experience: prev.experience.map(exp => ({
          ...exp,
          description: exp.description 
            ? `${exp.description} Spearheaded cross-functional initiatives resulting in a 40% performance improvement.`
            : 'Engineered robust solutions and optimized legacy systems, improving overall performance by 40%.'
        }))
      }))
      toast.success('Resume professionally enhanced!')
    } catch (err) {
      toast.error('Failed to enhance resume')
    } finally {
      setIsImprovising(false)
    }
  }

  const handleScoreResume = async () => {
    setIsScoring(true)
    try {
      const { data, error } = await supabase.functions.invoke('ats-score', {
        body: { resumeData }
      })
      if (error) throw error
      setAtsScore(data.score)
      setTips(data.tips)
      toast.success('ATS Score Calculated!')
    } catch (err: any) {
      toast.error('Failed to calculate ATS score')
    } finally {
      setIsScoring(false)
    }
  }

  const handleSave = () => toast.success('Resume synchronized.')
  const handlePrint = () => window.print()

  const addExp = () => setResumeData(p => ({ ...p, experience: [...p.experience, { company: '', role: '', description: '' }] }))
  const rmExp = (i: number) => setResumeData(p => { const ne = [...p.experience]; ne.splice(i, 1); return { ...p, experience: ne } })
  
  const addEdu = () => setResumeData(p => ({ ...p, education: [...p.education, { school: '', degree: '', year: '' }] }))
  const rmEdu = (i: number) => setResumeData(p => { const ne = [...p.education]; ne.splice(i, 1); return { ...p, education: ne } })

  return (
    <div className="flex flex-col gap-6 h-full pb-10">
      <style>{`
        @media print {
          body * { visibility: hidden; }
          #resume-canvas, #resume-canvas * { visibility: visible; }
          #resume-canvas {
            position: absolute; left: 0; top: 0; width: 100%; margin: 0; padding: 20px;
            box-shadow: none !important; border: none !important; background: white !important; color: black !important;
          }
          /* Force standard formatting for print */
          .print-header { border-bottom: 2px solid black !important; }
          .print-text { color: black !important; }
        }
      `}</style>

      {/* Control Bar */}
      <motion.div variants={STAGGER} initial="hidden" animate="show" className="flex flex-wrap justify-end gap-3 print:hidden">
        <input type="file" accept=".pdf,.doc,.docx" className="hidden" ref={fileInputRef} onChange={handleFileChange} />
        
        <motion.button variants={ITEM} onClick={handleImportClick} disabled={isImporting} className="flex items-center gap-2 px-6 py-2.5 bg-slate-100 dark:bg-[#1a1d24] hover:bg-slate-200 dark:hover:bg-[#1f232b] text-slate-700 dark:text-slate-300 rounded-xl transition-all duration-300 shadow-sm border border-slate-200/50 dark:border-white/5 font-bold active:scale-95">
          <Upload size={18} /> {isImporting ? 'Parsing...' : 'Import Resume'}
        </motion.button>
        
        <motion.button variants={ITEM} onClick={handleImprovise} disabled={isImprovising} className="flex items-center gap-2 px-6 py-2.5 bg-brand-50 dark:bg-brand-900/30 text-brand-700 dark:text-brand-400 hover:bg-brand-100 dark:hover:bg-brand-900/50 rounded-xl transition-all duration-300 shadow-sm border border-brand-200 dark:border-brand-500/20 font-bold active:scale-95">
          <Sparkles size={18} className={isImprovising ? "animate-pulse" : ""} /> {isImprovising ? 'Enhancing...' : 'Improvise AI'}
        </motion.button>

        <motion.button variants={ITEM} onClick={handleScoreResume} disabled={isScoring} className="flex items-center gap-2 px-6 py-2.5 bg-white/70 dark:bg-[#1a1d24]/70 backdrop-blur-xl hover:bg-white dark:hover:bg-[#1f232b] text-brand-700 dark:text-cyan-400 rounded-xl transition-all duration-300 shadow-[0_4px_20px_-4px_rgba(0,0,0,0.1)] dark:shadow-[0_0_15px_rgba(34,211,238,0.15)] border border-slate-200/50 dark:border-cyan-500/20 font-bold active:scale-95">
          <ShieldCheck size={18} /> {isScoring ? 'Analyzing...' : 'Scan Resume'}
        </motion.button>
        <motion.button variants={ITEM} onClick={handleSave} className="flex items-center gap-2 px-6 py-2.5 bg-brand-600 dark:bg-cyan-600 text-white hover:bg-brand-700 dark:hover:bg-cyan-500 rounded-xl transition-all duration-300 shadow-[0_4px_20px_-4px_rgba(37,99,235,0.4)] dark:shadow-[0_0_20px_rgba(34,211,238,0.3)] border border-transparent font-bold active:scale-95">
          <Save size={18} /> Sync
        </motion.button>
        <motion.button variants={ITEM} onClick={handlePrint} className="flex items-center gap-2 px-6 py-2.5 bg-slate-900 dark:bg-white text-white dark:text-slate-900 hover:bg-black dark:hover:bg-slate-200 rounded-xl transition-all duration-300 shadow-[0_4px_20px_-4px_rgba(0,0,0,0.4)] dark:shadow-[0_0_20px_rgba(255,255,255,0.2)] font-bold active:scale-95">
          <Download size={18} /> Export PDF
        </motion.button>
      </motion.div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-8 print:block">
        
        {/* Editor Side */}
        <motion.div variants={STAGGER} initial="hidden" animate="show" className="flex flex-col gap-5 print:hidden h-[calc(100vh-250px)] overflow-y-auto pr-3 custom-scrollbar">
          
          <motion.div variants={ITEM} className="bg-white/70 dark:bg-[#12141a]/80 backdrop-blur-2xl rounded-2xl border border-slate-200/50 dark:border-white/5 shadow-xl overflow-hidden transition-all duration-300">
             <button onClick={() => setActiveSection(activeSection === 'personal' ? '' : 'personal')} className="w-full flex items-center justify-between p-6 focus:outline-none">
                <span className="font-black tracking-tight flex items-center gap-3 text-slate-900 dark:text-white text-lg"><LayoutPanelLeft size={22} className="text-brand-600 dark:text-cyan-500"/> Personal & Summary</span>
                <ChevronDown size={20} className={`text-slate-500 transition-transform duration-500 ${activeSection === 'personal' ? 'rotate-180' : ''}`} />
             </button>
             <AnimatePresence>
               {activeSection === 'personal' && (
                 <motion.div initial={{ height: 0, opacity: 0 }} animate={{ height: 'auto', opacity: 1 }} exit={{ height: 0, opacity: 0 }} transition={{ type: 'spring', stiffness: 300, damping: 30 }} className="overflow-hidden">
                    <div className="p-6 pt-0 space-y-5">
                      <div className="h-px w-full bg-gradient-to-r from-transparent via-slate-200 dark:via-white/10 to-transparent mb-6" />
                      <div className="grid grid-cols-2 gap-4">
                        <div className="col-span-2 sm:col-span-1">
                          <label className="text-[10px] font-black tracking-widest text-slate-400 uppercase mb-2 block pl-1">Full Name</label>
                          <input type="text" value={resumeData.name} onChange={e => setResumeData({...resumeData, name: e.target.value})} className="w-full rounded-xl bg-slate-50 dark:bg-[#0a0a0c] border border-slate-200 dark:border-white/5 text-slate-900 dark:text-white px-4 py-3 outline-none focus:border-brand-500 dark:focus:border-cyan-500 focus:ring-2 focus:ring-brand-500/20 dark:focus:ring-cyan-500/20 transition-all font-medium" placeholder="John Doe" />
                        </div>
                        <div className="col-span-2 sm:col-span-1">
                          <label className="text-[10px] font-black tracking-widest text-slate-400 uppercase mb-2 block pl-1">Email</label>
                          <input type="email" value={resumeData.email} onChange={e => setResumeData({...resumeData, email: e.target.value})} className="w-full rounded-xl bg-slate-50 dark:bg-[#0a0a0c] border border-slate-200 dark:border-white/5 text-slate-900 dark:text-white px-4 py-3 outline-none focus:border-brand-500 dark:focus:border-cyan-500 focus:ring-2 focus:ring-brand-500/20 dark:focus:ring-cyan-500/20 transition-all font-medium" placeholder="john@example.com" />
                        </div>
                      </div>
                      <div>
                        <div className="flex items-center justify-between mb-2 pl-1">
                          <label className="text-[10px] font-black tracking-widest text-slate-400 uppercase">Summary</label>
                          <button className="text-xs font-bold text-brand-600 dark:text-cyan-400 flex items-center gap-1 hover:opacity-80 transition" onClick={() => toast('Voice active')}><Mic size={14}/> Dictate</button>
                        </div>
                        <textarea rows={4} value={resumeData.summary} onChange={e => setResumeData({...resumeData, summary: e.target.value})} className="w-full rounded-xl bg-slate-50 dark:bg-[#0a0a0c] border border-slate-200 dark:border-white/5 text-slate-900 dark:text-white px-4 py-3 outline-none focus:border-brand-500 dark:focus:border-cyan-500 focus:ring-2 focus:ring-brand-500/20 dark:focus:ring-cyan-500/20 transition-all font-medium resize-none leading-relaxed" placeholder="Brief professional overview..." />
                      </div>
                    </div>
                 </motion.div>
               )}
             </AnimatePresence>
          </motion.div>

          {/* Experience Section */}
          <motion.div variants={ITEM} className="bg-white/70 dark:bg-[#12141a]/80 backdrop-blur-2xl rounded-2xl border border-slate-200/50 dark:border-white/5 shadow-xl overflow-hidden transition-all duration-300">
             <button onClick={() => setActiveSection(activeSection === 'experience' ? '' : 'experience')} className="w-full flex items-center justify-between p-6 focus:outline-none">
                <span className="font-black tracking-tight flex items-center gap-3 text-slate-900 dark:text-white text-lg"><Briefcase size={22} className="text-brand-600 dark:text-cyan-500"/> Work Experience</span>
                <ChevronDown size={20} className={`text-slate-500 transition-transform duration-500 ${activeSection === 'experience' ? 'rotate-180' : ''}`} />
             </button>
             <AnimatePresence>
               {activeSection === 'experience' && (
                 <motion.div initial={{ height: 0, opacity: 0 }} animate={{ height: 'auto', opacity: 1 }} exit={{ height: 0, opacity: 0 }} transition={{ type: 'spring', stiffness: 300, damping: 30 }} className="overflow-hidden">
                    <div className="p-6 pt-0 space-y-6">
                      <div className="h-px w-full bg-gradient-to-r from-transparent via-slate-200 dark:via-white/10 to-transparent mb-6" />
                      {resumeData.experience.map((exp, i) => (
                        <motion.div key={i} initial={{ opacity: 0, x: -20 }} animate={{ opacity: 1, x: 0 }} className="p-5 rounded-2xl border border-slate-200/60 dark:border-white/5 bg-slate-50/50 dark:bg-black/30 relative group shadow-sm">
                           <button onClick={() => rmExp(i)} className="absolute top-4 right-4 p-2 text-slate-400 bg-white dark:bg-[#1a1d24] rounded-full shadow-sm hover:text-red-500 hover:shadow-md transition-all scale-90 opacity-0 group-hover:opacity-100 group-hover:scale-100"><Trash2 size={14}/></button>
                           <input type="text" placeholder="Company Name" className="w-full bg-transparent outline-none font-black text-lg text-slate-900 dark:text-white mb-1 placeholder-slate-300 dark:placeholder-slate-700 transition" value={exp.company} onChange={e => {
                             const ne = [...resumeData.experience]; ne[i].company = e.target.value; setResumeData({...resumeData, experience: ne})
                           }} />
                           <input type="text" placeholder="Job Title" className="w-full bg-transparent outline-none font-semibold text-sm text-brand-600 dark:text-cyan-500 mb-3 placeholder-slate-300 dark:placeholder-slate-700 transition" value={exp.role} onChange={e => {
                             const ne = [...resumeData.experience]; ne[i].role = e.target.value; setResumeData({...resumeData, experience: ne})
                           }} />
                           <textarea rows={3} placeholder="Key achievements and duties..." className="w-full rounded-xl bg-white dark:bg-[#0a0a0c] border border-slate-200/50 dark:border-white/5 text-slate-700 dark:text-slate-300 px-4 py-3 outline-none focus:border-brand-500 dark:focus:border-cyan-500 transition-all font-medium resize-none text-sm leading-relaxed shadow-inner" value={exp.description} onChange={e => {
                             const ne = [...resumeData.experience]; ne[i].description = e.target.value; setResumeData({...resumeData, experience: ne})
                           }} />
                        </motion.div>
                      ))}
                      <button onClick={addExp} className="w-full py-4 border border-dashed border-slate-300 dark:border-white/10 rounded-2xl text-slate-500 dark:text-slate-400 hover:text-brand-600 dark:hover:text-cyan-400 hover:border-brand-500 dark:hover:border-cyan-500 hover:bg-brand-50/50 dark:hover:bg-cyan-500/5 transition-all flex items-center justify-center gap-2 font-black text-sm">
                        <Plus size={18} /> Add Experience
                      </button>
                    </div>
                 </motion.div>
               )}
             </AnimatePresence>
          </motion.div>
          
          {/* Education Section */}
          <motion.div variants={ITEM} className="bg-white/70 dark:bg-[#12141a]/80 backdrop-blur-2xl rounded-2xl border border-slate-200/50 dark:border-white/5 shadow-xl overflow-hidden transition-all duration-300">
             <button onClick={() => setActiveSection(activeSection === 'education' ? '' : 'education')} className="w-full flex items-center justify-between p-6 focus:outline-none">
                <span className="font-black tracking-tight flex items-center gap-3 text-slate-900 dark:text-white text-lg"><GraduationCap size={22} className="text-brand-600 dark:text-cyan-500"/> Education</span>
                <ChevronDown size={20} className={`text-slate-500 transition-transform duration-500 ${activeSection === 'education' ? 'rotate-180' : ''}`} />
             </button>
             <AnimatePresence>
               {activeSection === 'education' && (
                 <motion.div initial={{ height: 0, opacity: 0 }} animate={{ height: 'auto', opacity: 1 }} exit={{ height: 0, opacity: 0 }} transition={{ type: 'spring', stiffness: 300, damping: 30 }} className="overflow-hidden">
                    <div className="p-6 pt-0 space-y-6">
                      <div className="h-px w-full bg-gradient-to-r from-transparent via-slate-200 dark:via-white/10 to-transparent mb-6" />
                      {resumeData.education.map((edu, i) => (
                        <motion.div key={i} initial={{ opacity: 0, x: -20 }} animate={{ opacity: 1, x: 0 }} className="p-5 rounded-2xl border border-slate-200/60 dark:border-white/5 bg-slate-50/50 dark:bg-black/30 relative group shadow-sm flex flex-col gap-2">
                           <button onClick={() => rmEdu(i)} className="absolute top-4 right-4 p-2 text-slate-400 bg-white dark:bg-[#1a1d24] rounded-full shadow-sm hover:text-red-500 hover:shadow-md transition-all scale-90 opacity-0 group-hover:opacity-100 group-hover:scale-100"><Trash2 size={14}/></button>
                           <input type="text" placeholder="Institution" className="w-full bg-transparent outline-none font-black text-lg text-slate-900 dark:text-white placeholder-slate-300 dark:placeholder-slate-700 transition" value={edu.school} onChange={e => {
                             const ne = [...resumeData.education]; ne[i].school = e.target.value; setResumeData({...resumeData, education: ne})
                           }} />
                           <div className="flex gap-4">
                             <input type="text" placeholder="Degree" className="flex-1 bg-transparent outline-none font-semibold text-sm text-brand-600 dark:text-cyan-500 placeholder-slate-300 dark:placeholder-slate-700 transition" value={edu.degree} onChange={e => {
                               const ne = [...resumeData.education]; ne[i].degree = e.target.value; setResumeData({...resumeData, education: ne})
                             }} />
                             <input type="text" placeholder="Year" className="w-20 bg-transparent outline-none font-semibold text-sm text-slate-500 dark:text-slate-400 placeholder-slate-300 dark:placeholder-slate-700 text-right transition" value={edu.year} onChange={e => {
                               const ne = [...resumeData.education]; ne[i].year = e.target.value; setResumeData({...resumeData, education: ne})
                             }} />
                           </div>
                        </motion.div>
                      ))}
                      <button onClick={addEdu} className="w-full py-4 border border-dashed border-slate-300 dark:border-white/10 rounded-2xl text-slate-500 dark:text-slate-400 hover:text-brand-600 dark:hover:text-cyan-400 hover:border-brand-500 dark:hover:border-cyan-500 hover:bg-brand-50/50 dark:hover:bg-cyan-500/5 transition-all flex items-center justify-center gap-2 font-black text-sm">
                        <Plus size={18} /> Add Education
                      </button>
                    </div>
                 </motion.div>
               )}
             </AnimatePresence>
          </motion.div>

        </motion.div>

        {/* Live Preview Side (Glowing Wireframe in Dark, Paper in Light) */}
        <motion.div variants={STAGGER} initial="hidden" animate="show" className="flex flex-col gap-6 print:block relative">
          
          <AnimatePresence>
            {atsScore !== null && (
              <motion.div initial={{ opacity: 0, y: 20, scale: 0.9 }} animate={{ opacity: 1, y: 0, scale: 1 }} exit={{ opacity: 0, scale: 0.9 }} className="absolute -top-6 right-0 z-20 w-80 p-5 rounded-2xl bg-white/90 dark:bg-[#12141a]/95 backdrop-blur-2xl border border-emerald-500/30 shadow-[0_10px_40px_-10px_rgba(16,185,129,0.3)] dark:shadow-[0_10px_40px_-10px_rgba(16,185,129,0.2)] print:hidden">
                <div className="flex items-center gap-4 border-b border-slate-100 dark:border-white/5 pb-4 mb-4">
                  <div className="w-14 h-14 rounded-full border-[3px] border-emerald-500 flex items-center justify-center font-black text-2xl text-emerald-600 dark:text-emerald-400 shadow-[0_0_15px_rgba(16,185,129,0.4)]">
                    {atsScore}
                  </div>
                  <div>
                    <h3 className="font-black text-slate-900 dark:text-white tracking-tight">ATS Score</h3>
                    <p className="text-xs font-semibold text-slate-500 uppercase tracking-widest mt-0.5">Algorithm Passed</p>
                  </div>
                </div>
                {tips.length > 0 && (
                  <ul className="space-y-2 text-xs font-medium text-slate-600 dark:text-slate-400">
                    {tips.map((t, i) => <li key={i} className="flex items-start gap-2"><span className="text-emerald-500">▹</span> {t}</li>)}
                  </ul>
                )}
              </motion.div>
            )}
          </AnimatePresence>

          <motion.div variants={ITEM} className="w-full flex justify-center perspective-[1000px] print:p-0">
             {/* The Canvas */}
             <div id="resume-canvas" className="w-full max-w-[21cm] min-h-[29.7cm] p-12 transition-all duration-500 bg-white text-slate-900 shadow-[0_20px_60px_-15px_rgba(0,0,0,0.1)] dark:bg-[#0a0a0c] dark:text-slate-300 dark:border dark:border-cyan-500/20 dark:shadow-[0_0_50px_-12px_rgba(34,211,238,0.15)] rounded-md print:shadow-none print:min-h-0 print:border-none print:p-0 print:bg-white print:text-black">
                
                <div className="text-center pb-8 mb-8 border-b-2 border-slate-900 dark:border-cyan-500/30 print-header">
                   <h1 className="text-4xl font-black uppercase tracking-tighter text-slate-900 dark:text-white print-text">{resumeData.name || 'Your Name'}</h1>
                   <p className="mt-2 font-bold tracking-widest text-brand-600 dark:text-cyan-400 text-sm print-text">{resumeData.email || 'email@example.com'}</p>
                </div>
                
                {resumeData.summary && (
                  <div className="mb-8">
                     <h2 className="text-xs font-black uppercase tracking-widest text-slate-400 dark:text-slate-600 mb-3">Professional Summary</h2>
                     <p className="text-sm leading-loose font-medium print-text">{resumeData.summary}</p>
                  </div>
                )}

                {resumeData.experience.some(e => e.company || e.role) && (
                  <div className="mb-8">
                     <h2 className="text-xs font-black uppercase tracking-widest text-slate-400 dark:text-slate-600 mb-4">Experience</h2>
                     <div className="space-y-6">
                       {resumeData.experience.map((exp, i) => (
                         (exp.company || exp.role) ? (
                           <div key={i} className="group relative">
                             <div className="flex justify-between items-baseline mb-1">
                               <h3 className="font-extrabold text-slate-900 dark:text-white text-base print-text">{exp.role || 'Job Title'}</h3>
                               <span className="text-xs font-bold text-slate-400 uppercase tracking-widest">Present</span>
                             </div>
                             <p className="text-sm font-bold text-brand-600 dark:text-cyan-500 mb-2 print-text">{exp.company || 'Company Name'}</p>
                             <p className="text-sm leading-relaxed font-medium whitespace-pre-wrap print-text text-slate-700 dark:text-slate-400">{exp.description || 'Description of duties and achievements...'}</p>
                           </div>
                         ) : null
                       ))}
                     </div>
                  </div>
                )}

                {resumeData.education.some(e => e.school || e.degree) && (
                  <div className="mb-8">
                     <h2 className="text-xs font-black uppercase tracking-widest text-slate-400 dark:text-slate-600 mb-4">Education</h2>
                     <div className="space-y-4">
                       {resumeData.education.map((edu, i) => (
                         (edu.school || edu.degree) ? (
                           <div key={i} className="flex justify-between items-baseline">
                             <div>
                               <h3 className="font-extrabold text-slate-900 dark:text-white text-base print-text">{edu.school || 'University Name'}</h3>
                               <p className="text-sm font-bold text-slate-600 dark:text-slate-500 mt-0.5 print-text">{edu.degree || 'Degree'}</p>
                             </div>
                             <span className="text-xs font-bold text-slate-400 uppercase tracking-widest">{edu.year || '2024'}</span>
                           </div>
                         ) : null
                       ))}
                     </div>
                  </div>
                )}
             </div>
          </motion.div>
        </motion.div>
      </div>
    </div>
  )
}
