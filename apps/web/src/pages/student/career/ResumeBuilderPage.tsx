import { useState, useRef, useEffect } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { FileText, Save, Download, Mic, Plus, Trash2, ShieldCheck, ChevronDown, Briefcase, GraduationCap, LayoutPanelLeft, Upload, Sparkles, FolderGit2, X, Phone, Mail, Wand2, Link as LinkIcon, Settings2, GripVertical, CheckCircle2 } from 'lucide-react'
import toast from 'react-hot-toast'
import { supabase } from '../../../lib/supabase'
import * as pdfjsLib from 'pdfjs-dist'
import pdfWorkerUrl from 'pdfjs-dist/build/pdf.worker.min.mjs?url'

// Set up PDF.js worker
pdfjsLib.GlobalWorkerOptions.workerSrc = pdfWorkerUrl

type Theme = 'executive' | 'modern' | 'creative'

interface ResumeData {
  name: string
  email: string
  phone: string
  linkedin: string
  github: string
  summary: string
  experience: { id: string, company: string, role: string, description: string, startDate: string, endDate: string }[]
  education: { id: string, school: string, degree: string, year: string, gpa: string }[]
  projects: { id: string, name: string, tech: string, description: string, link: string }[]
  skills: string[]
}

const generateId = () => Math.random().toString(36).substring(2, 9)

const emptyExp = () => ({ id: generateId(), company: '', role: '', description: '', startDate: '', endDate: '' })
const emptyEdu = () => ({ id: generateId(), school: '', degree: '', year: '', gpa: '' })
const emptyProj = () => ({ id: generateId(), name: '', tech: '', description: '', link: '' })

export default function ResumeBuilderPage() {
  const [theme, setTheme] = useState<Theme>('modern')
  const [resumeData, setResumeData] = useState<ResumeData>({
    name: '', email: '', phone: '', linkedin: '', github: '',
    summary: '',
    experience: [emptyExp()],
    education: [emptyEdu()],
    projects: [emptyProj()],
    skills: [],
  })
  
  const [newSkill, setNewSkill] = useState('')
  const [atsScore, setAtsScore] = useState<number | null>(null)
  const [tips, setTips] = useState<string[]>([])
  const [isScoring, setIsScoring] = useState(false)
  const [isImporting, setIsImporting] = useState(false)
  const [isEnhancingFull, setIsEnhancingFull] = useState(false)
  const [activeSection, setActiveSection] = useState<string>('personal')
  const [enhancingIndex, setEnhancingIndex] = useState<number | null>(null)
  
  const fileInputRef = useRef<HTMLInputElement>(null)

  // Load from local storage on mount (convenience feature)
  useEffect(() => {
    const saved = localStorage.getItem('edupredict_resume')
    if (saved) {
      try {
        setResumeData(JSON.parse(saved))
      } catch (e) {}
    }
  }, [])

  // Auto-save to local storage (convenience feature)
  useEffect(() => {
    localStorage.setItem('edupredict_resume', JSON.stringify(resumeData))
  }, [resumeData])

  // --- Handlers ---
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
        for (let i = 1; i <= pdf.numPages; i++) {
          const page = await pdf.getPage(i)
          const textContent = await page.getTextContent()
          extractedText += textContent.items.map((item: any) => item.str).join(' ') + '\n'
        }
      } else {
        extractedText = await file.text()
      }
      
      const { data, error } = await supabase.functions.invoke('parse-resume', { body: { text: extractedText } })
      if (error || !data) throw new Error("Edge function error")
      
      setResumeData(prev => ({
        ...prev,
        name: data.name || prev.name,
        email: data.email || prev.email,
        summary: data.summary || prev.summary,
        experience: data.experience?.length ? data.experience.map((e: any) => ({ ...e, id: generateId() })) : prev.experience,
        education: data.education?.length ? data.education.map((e: any) => ({ ...e, id: generateId() })) : prev.education,
      }))
      toast.success('Resume imported successfully!')
    } catch (err) {
      toast.error('AI formatting failed.')
    } finally {
      setIsImporting(false)
      if (e.target) e.target.value = ''
    }
  }

  const handleScoreResume = async () => {
    setIsScoring(true)
    try {
      const { data, error } = await supabase.functions.invoke('ats-score', { body: { resumeData } })
      if (error) throw error
      setAtsScore(data.score)
      setTips(data.tips)
      toast.success('ATS Score Calculated!')
    } catch (err) {
      toast.error('Failed to calculate ATS score')
    } finally {
      setIsScoring(false)
    }
  }

  const handleEnhanceFullResume = async () => {
    setIsEnhancingFull(true)
    const loadingToast = toast.loading('AI is rewriting your resume...')
    try {
      const { data, error } = await supabase.functions.invoke('enhance-full-resume', { body: { resumeData } })
      if (error) throw error
      if (data?.enhancedResume) {
        setResumeData(prev => ({ ...prev, ...data.enhancedResume }))
        toast.success('Resume enhanced successfully!', { id: loadingToast })
      } else {
        throw new Error('Invalid response from AI')
      }
    } catch (err) {
      toast.error('Failed to enhance resume', { id: loadingToast })
    } finally {
      setIsEnhancingFull(false)
    }
  }

  const handleEnhanceBullet = async (index: number) => {
    const exp = resumeData.experience[index]
    if (!exp.description) return toast.error("Write some draft text first!")
    
    setEnhancingIndex(index)
    try {
      const { data: { session } } = await supabase.auth.getSession()
      const res = await fetch(`${import.meta.env.VITE_SUPABASE_URL}/functions/v1/enhance-resume-bullet`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', 'Authorization': `Bearer ${session?.access_token}` },
        body: JSON.stringify({ text: exp.description, role: exp.role, company: exp.company })
      })
      const result = await res.json()
      if (!res.ok || result.error) throw new Error(result.error)
      
      const ne = [...resumeData.experience]
      ne[index].description = result.enhancedText
      setResumeData({ ...resumeData, experience: ne })
      toast.success("Bullet point enhanced!")
    } catch (err) {
      toast.error("Failed to enhance bullet point.")
    } finally {
      setEnhancingIndex(null)
    }
  }

  const handlePrint = () => {
    window.print()
  }

  // --- Array Modifiers ---
  const addExp = () => setResumeData(p => ({ ...p, experience: [...p.experience, emptyExp()] }))
  const rmExp = (i: number) => setResumeData(p => { const ne = [...p.experience]; ne.splice(i, 1); return { ...p, experience: ne } })
  const addEdu = () => setResumeData(p => ({ ...p, education: [...p.education, emptyEdu()] }))
  const rmEdu = (i: number) => setResumeData(p => { const ne = [...p.education]; ne.splice(i, 1); return { ...p, education: ne } })
  const addProj = () => setResumeData(p => ({ ...p, projects: [...p.projects, emptyProj()] }))
  const rmProj = (i: number) => setResumeData(p => { const ne = [...p.projects]; ne.splice(i, 1); return { ...p, projects: ne } })
  
  const addSkill = (e: React.KeyboardEvent) => {
    if (e.key === 'Enter' && newSkill.trim()) {
      e.preventDefault()
      if (!resumeData.skills.includes(newSkill.trim())) {
        setResumeData(p => ({ ...p, skills: [...p.skills, newSkill.trim()] }))
      }
      setNewSkill('')
    }
  }
  const rmSkill = (skill: string) => setResumeData(p => ({ ...p, skills: p.skills.filter(s => s !== skill) }))

  return (
    <div className="flex flex-col gap-6 h-full pb-10">
      <style>{`
        @media print {
          body * { visibility: hidden; }
          #resume-canvas, #resume-canvas * { visibility: visible; }
          #resume-canvas {
            position: absolute; left: 0; top: 0; width: 100%; margin: 0; padding: 0 !important;
            box-shadow: none !important; border: none !important; 
          }
          /* Ensure A4 size exactly on print */
          @page { size: A4 portrait; margin: 0; }
          
          .theme-executive { font-family: 'Times New Roman', Times, serif !important; }
          .theme-modern { font-family: 'Inter', sans-serif !important; }
          .theme-creative { font-family: 'Outfit', sans-serif !important; }
          
          .print-black { color: black !important; }
          .print-gray { color: #4b5563 !important; }
          .print-accent { color: ${theme === 'executive' ? 'black' : theme === 'modern' ? '#0ea5e9' : '#f59e0b'} !important; }
        }
      `}</style>

      {/* Modern Control Bar */}
      <div className="flex flex-col md:flex-row items-center justify-between gap-4 bg-white dark:bg-[#12141a] p-4 rounded-2xl border border-slate-200 dark:border-white/5 shadow-sm print:hidden">
        
        {/* Theme Selector - Elegant Pills */}
        <div className="flex items-center gap-2 p-1 bg-slate-100 dark:bg-black/40 rounded-xl overflow-hidden w-full md:w-auto">
          {(['executive', 'modern', 'creative'] as Theme[]).map(t => (
            <button
              key={t}
              onClick={() => setTheme(t)}
              className={`flex-1 md:flex-none px-6 py-2.5 text-sm font-bold capitalize rounded-lg transition-all duration-300 ${
                theme === t 
                  ? 'bg-white dark:bg-[#252830] text-brand-700 dark:text-cyan-400 shadow-sm border border-slate-200/50 dark:border-white/5' 
                  : 'text-slate-500 hover:text-slate-700 dark:hover:text-slate-300 hover:bg-slate-200/50 dark:hover:bg-white/5 border border-transparent'
              }`}
            >
              {t}
            </button>
          ))}
        </div>

        {/* Action Buttons */}
        <div className="flex items-center gap-3 w-full md:w-auto overflow-x-auto pb-1 md:pb-0 custom-scrollbar">
          <input type="file" accept=".pdf,.doc,.docx" className="hidden" ref={fileInputRef} onChange={handleFileChange} />
          
          <button onClick={handleImportClick} disabled={isImporting} className="flex items-center gap-2 px-5 py-2.5 bg-slate-50 dark:bg-white/5 hover:bg-slate-100 dark:hover:bg-white/10 text-slate-700 dark:text-slate-200 rounded-xl transition-all font-semibold text-sm whitespace-nowrap">
            <Upload size={16} /> {isImporting ? 'Parsing...' : 'Import'}
          </button>

          <button onClick={handleScoreResume} disabled={isScoring} className="flex items-center gap-2 px-5 py-2.5 bg-indigo-50 dark:bg-indigo-500/10 text-indigo-700 dark:text-indigo-400 hover:bg-indigo-100 dark:hover:bg-indigo-500/20 rounded-xl transition-all font-semibold text-sm whitespace-nowrap">
            <ShieldCheck size={16} /> {isScoring ? 'Scanning...' : 'ATS Scan'}
          </button>
          
          <button onClick={handleEnhanceFullResume} disabled={isEnhancingFull} className="flex items-center gap-2 px-5 py-2.5 bg-purple-50 dark:bg-purple-500/10 text-purple-700 dark:text-purple-400 hover:bg-purple-100 dark:hover:bg-purple-500/20 rounded-xl transition-all font-semibold text-sm whitespace-nowrap">
            <Wand2 size={16} /> {isEnhancingFull ? 'Enhancing...' : 'AI Enhance'}
          </button>

          <button onClick={handlePrint} className="flex items-center gap-2 px-6 py-2.5 bg-brand-600 dark:bg-cyan-600 text-white hover:bg-brand-700 dark:hover:bg-cyan-500 rounded-xl transition-all font-bold text-sm shadow-sm whitespace-nowrap ml-auto">
            <Download size={16} /> Download PDF
          </button>
        </div>
      </div>

      <div className="flex flex-col lg:flex-row gap-8 print:block">
        
        {/* Editor Side - Refined and robust */}
        <div className="w-full lg:w-[45%] flex flex-col gap-4 print:hidden h-[calc(100vh-200px)] overflow-y-auto pr-2 custom-scrollbar">
          
          <SectionAccordion title="Personal Details" icon={<LayoutPanelLeft size={18}/>} activeSection={activeSection} setActiveSection={setActiveSection} sectionId="personal">
            <div className="space-y-4">
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <Input label="Full Name" value={resumeData.name} onChange={v => setResumeData({...resumeData, name: v})} placeholder="John Doe" />
                <Input label="Email Address" type="email" value={resumeData.email} onChange={v => setResumeData({...resumeData, email: v})} placeholder="john@example.com" />
                <Input label="Phone Number" value={resumeData.phone} onChange={v => setResumeData({...resumeData, phone: v})} placeholder="+1 234 567 8900" />
                <Input label="LinkedIn (Username only)" value={resumeData.linkedin} onChange={v => setResumeData({...resumeData, linkedin: v})} placeholder="johndoe" />
                <Input label="GitHub (Username only)" value={resumeData.github} onChange={v => setResumeData({...resumeData, github: v})} placeholder="johndoe" />
              </div>
              <div>
                <label className="text-[11px] font-bold tracking-widest text-slate-500 uppercase mb-2 block">Professional Summary</label>
                <textarea rows={4} value={resumeData.summary} onChange={e => setResumeData({...resumeData, summary: e.target.value})} className="w-full rounded-xl bg-slate-50 dark:bg-[#0a0a0c] border border-slate-200 dark:border-white/10 text-slate-900 dark:text-white px-4 py-3 outline-none focus:border-brand-500 transition-all text-sm resize-none" placeholder="A brief, impactful overview of your career and goals..." />
              </div>
            </div>
          </SectionAccordion>

          <SectionAccordion title="Skills" icon={<Sparkles size={18}/>} activeSection={activeSection} setActiveSection={setActiveSection} sectionId="skills">
            <div className="space-y-4">
              <input type="text" value={newSkill} onChange={e => setNewSkill(e.target.value)} onKeyDown={addSkill} placeholder="Type a skill (e.g. React) and press Enter..." className="w-full rounded-xl bg-slate-50 dark:bg-[#0a0a0c] border border-slate-200 dark:border-white/10 text-slate-900 dark:text-white px-4 py-3 outline-none focus:border-brand-500 transition-all font-medium text-sm" />
              
              {resumeData.skills.length > 0 && (
                <div className="flex flex-wrap gap-2 p-4 bg-slate-50 dark:bg-black/20 border border-slate-200 dark:border-white/5 rounded-xl">
                  {resumeData.skills.map((skill) => (
                    <span key={skill} className="flex items-center gap-1.5 bg-white dark:bg-[#1a1d24] border border-slate-200 dark:border-white/10 text-slate-700 dark:text-slate-300 px-3 py-1.5 rounded-lg text-sm font-semibold shadow-sm">
                      {skill}
                      <button onClick={() => rmSkill(skill)} className="text-slate-400 hover:text-red-500 transition-colors"><X size={14}/></button>
                    </span>
                  ))}
                </div>
              )}
            </div>
          </SectionAccordion>

          <SectionAccordion title="Experience" icon={<Briefcase size={18}/>} activeSection={activeSection} setActiveSection={setActiveSection} sectionId="experience">
            <div className="space-y-6">
              {resumeData.experience.map((exp, i) => (
                <div key={exp.id} className="p-5 rounded-xl border border-slate-200 dark:border-white/10 bg-slate-50 dark:bg-black/20 relative group">
                  <div className="absolute top-5 right-5 flex gap-2">
                    <button onClick={() => rmExp(i)} className="p-2 text-slate-400 bg-white dark:bg-[#1a1d24] border border-slate-200 dark:border-white/10 rounded-lg hover:text-red-500 transition-colors"><Trash2 size={16}/></button>
                  </div>
                  
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4 pr-12">
                    <Input label="Company Name" value={exp.company} onChange={v => { const ne = [...resumeData.experience]; ne[i].company = v; setResumeData({...resumeData, experience: ne}) }} />
                    <Input label="Job Title" value={exp.role} onChange={v => { const ne = [...resumeData.experience]; ne[i].role = v; setResumeData({...resumeData, experience: ne}) }} />
                    <Input label="Start Date" placeholder="e.g. Jun 2021" value={exp.startDate} onChange={v => { const ne = [...resumeData.experience]; ne[i].startDate = v; setResumeData({...resumeData, experience: ne}) }} />
                    <Input label="End Date" placeholder="e.g. Present" value={exp.endDate} onChange={v => { const ne = [...resumeData.experience]; ne[i].endDate = v; setResumeData({...resumeData, experience: ne}) }} />
                  </div>
                  
                  <div className="relative mt-2">
                    <div className="flex justify-between items-end mb-2">
                      <label className="text-[11px] font-bold tracking-widest text-slate-500 uppercase block">Description / Achievements</label>
                      <button onClick={() => handleEnhanceBullet(i)} disabled={enhancingIndex === i || !exp.description} className="text-[11px] font-bold text-indigo-600 dark:text-indigo-400 bg-indigo-50 dark:bg-indigo-500/10 hover:bg-indigo-100 dark:hover:bg-indigo-500/20 px-3 py-1.5 rounded-lg flex items-center gap-1.5 transition-colors disabled:opacity-50">
                        <Wand2 size={12}/> {enhancingIndex === i ? 'Enhancing...' : 'Magic Rewrite'}
                      </button>
                    </div>
                    <textarea rows={4} placeholder="Describe achievements (1 per line). Start with action verbs..." value={exp.description} onChange={e => { const ne = [...resumeData.experience]; ne[i].description = e.target.value; setResumeData({...resumeData, experience: ne}) }} className="w-full rounded-xl bg-white dark:bg-[#0a0a0c] border border-slate-200 dark:border-white/10 px-4 py-3 outline-none focus:border-brand-500 transition-all text-sm resize-none" />
                  </div>
                </div>
              ))}
              <AddButton onClick={addExp} label="Add Experience" />
            </div>
          </SectionAccordion>

          <SectionAccordion title="Projects" icon={<FolderGit2 size={18}/>} activeSection={activeSection} setActiveSection={setActiveSection} sectionId="projects">
            <div className="space-y-6">
              {resumeData.projects.map((proj, i) => (
                <div key={proj.id} className="p-5 rounded-xl border border-slate-200 dark:border-white/10 bg-slate-50 dark:bg-black/20 relative group">
                  <button onClick={() => rmProj(i)} className="absolute top-5 right-5 p-2 text-slate-400 bg-white dark:bg-[#1a1d24] border border-slate-200 dark:border-white/10 rounded-lg hover:text-red-500 transition-colors"><Trash2 size={16}/></button>
                  
                  <div className="grid grid-cols-1 gap-4 mb-4 pr-12">
                    <Input label="Project Name" value={proj.name} onChange={v => { const ne = [...resumeData.projects]; ne[i].name = v; setResumeData({...resumeData, projects: ne}) }} />
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                      <Input label="Tech Stack" placeholder="e.g. React, Node.js" value={proj.tech} onChange={v => { const ne = [...resumeData.projects]; ne[i].tech = v; setResumeData({...resumeData, projects: ne}) }} />
                      <Input label="Link" placeholder="https://..." value={proj.link} onChange={v => { const ne = [...resumeData.projects]; ne[i].link = v; setResumeData({...resumeData, projects: ne}) }} />
                    </div>
                  </div>
                  
                  <label className="text-[11px] font-bold tracking-widest text-slate-500 uppercase mb-2 block">Project Description</label>
                  <textarea rows={2} placeholder="Brief description..." value={proj.description} onChange={e => { const ne = [...resumeData.projects]; ne[i].description = e.target.value; setResumeData({...resumeData, projects: ne}) }} className="w-full rounded-xl bg-white dark:bg-[#0a0a0c] border border-slate-200 dark:border-white/10 px-4 py-3 outline-none focus:border-brand-500 transition-all text-sm resize-none" />
                </div>
              ))}
              <AddButton onClick={addProj} label="Add Project" />
            </div>
          </SectionAccordion>

          <SectionAccordion title="Education" icon={<GraduationCap size={18}/>} activeSection={activeSection} setActiveSection={setActiveSection} sectionId="education">
            <div className="space-y-6">
              {resumeData.education.map((edu, i) => (
                <div key={edu.id} className="p-5 rounded-xl border border-slate-200 dark:border-white/10 bg-slate-50 dark:bg-black/20 relative group">
                  <button onClick={() => rmEdu(i)} className="absolute top-5 right-5 p-2 text-slate-400 bg-white dark:bg-[#1a1d24] border border-slate-200 dark:border-white/10 rounded-lg hover:text-red-500 transition-colors"><Trash2 size={16}/></button>
                  
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4 pr-12">
                    <div className="col-span-1 md:col-span-2"><Input label="School/University" value={edu.school} onChange={v => { const ne = [...resumeData.education]; ne[i].school = v; setResumeData({...resumeData, education: ne}) }} /></div>
                    <Input label="Degree/Major" value={edu.degree} onChange={v => { const ne = [...resumeData.education]; ne[i].degree = v; setResumeData({...resumeData, education: ne}) }} />
                    <Input label="Year/Range" placeholder="e.g. 2020 - 2024" value={edu.year} onChange={v => { const ne = [...resumeData.education]; ne[i].year = v; setResumeData({...resumeData, education: ne}) }} />
                    <div className="col-span-1 md:col-span-2"><Input label="GPA (Optional)" placeholder="e.g. 3.8/4.0" value={edu.gpa} onChange={v => { const ne = [...resumeData.education]; ne[i].gpa = v; setResumeData({...resumeData, education: ne}) }} /></div>
                  </div>
                </div>
              ))}
              <AddButton onClick={addEdu} label="Add Education" />
            </div>
          </SectionAccordion>
        </div>

        {/* Live Preview Side */}
        <div className="w-full lg:w-[55%] flex flex-col items-center print:block relative">
          
          <AnimatePresence>
            {atsScore !== null && (
              <motion.div initial={{ opacity: 0, y: -20 }} animate={{ opacity: 1, y: 0 }} exit={{ opacity: 0, y: -20 }} className="w-full max-w-[21cm] mb-4 p-4 rounded-xl bg-emerald-50 dark:bg-emerald-900/20 border border-emerald-200 dark:border-emerald-500/30 flex items-start gap-4 print:hidden">
                <div className="w-12 h-12 rounded-full bg-emerald-100 dark:bg-emerald-500/20 flex items-center justify-center font-black text-xl text-emerald-600 dark:text-emerald-400 shrink-0">
                  {atsScore}
                </div>
                <div className="flex-1">
                  <div className="flex items-center justify-between mb-1">
                    <h3 className="font-bold text-emerald-900 dark:text-emerald-400">ATS Score</h3>
                    <button onClick={() => setAtsScore(null)} className="text-emerald-600/50 hover:text-emerald-600"><X size={16}/></button>
                  </div>
                  {tips.length > 0 && (
                    <ul className="space-y-1 mt-2">
                      {tips.map((t, i) => <li key={i} className="text-xs font-medium text-emerald-800 dark:text-emerald-300 flex items-start gap-1.5"><CheckCircle2 size={14} className="shrink-0 mt-0.5 text-emerald-500"/> {t}</li>)}
                    </ul>
                  )}
                </div>
              </motion.div>
            )}
          </AnimatePresence>

          <div className="w-full flex justify-center print:p-0">
             {/* The Interactive Resume Canvas - A4 Scaled */}
             <div 
               id="resume-canvas" 
               className={`w-full max-w-[21cm] aspect-[1/1.4142] p-[1.5cm] bg-white shadow-2xl rounded-md transition-all duration-300 print:shadow-none print:w-[21cm] print:h-[29.7cm] print:p-[1cm] overflow-hidden
                 ${theme === 'executive' ? 'font-serif text-slate-900' : ''}
                 ${theme === 'modern' ? 'font-sans text-slate-800' : ''}
                 ${theme === 'creative' ? 'font-sans text-slate-900' : ''}
               `}
             >
                
                {theme === 'executive' && (
                  <div className="text-center mb-6 border-b-[3px] border-black pb-4">
                     <h1 className="text-[28px] font-bold uppercase tracking-widest text-black print-black mb-2 leading-none">{resumeData.name || 'FIRST LAST'}</h1>
                     <div className="flex flex-wrap items-center justify-center gap-x-3 gap-y-1 text-[12px] font-medium text-gray-700 print-gray">
                        {resumeData.email && <span>{resumeData.email}</span>}
                        {resumeData.phone && <span>• {resumeData.phone}</span>}
                        {resumeData.linkedin && <span>• linkedin.com/in/{resumeData.linkedin}</span>}
                        {resumeData.github && <span>• github.com/{resumeData.github}</span>}
                     </div>
                  </div>
                )}

                {theme === 'modern' && (
                  <div className="mb-6 border-b-2 border-sky-500/30 pb-4 flex justify-between items-end">
                    <div>
                      <h1 className="text-[32px] font-extrabold tracking-tight text-slate-900 print-black leading-none">{resumeData.name || 'Your Name'}</h1>
                      <div className="flex flex-col gap-0.5 mt-2 text-[12px] font-medium text-slate-500 print-gray">
                        {resumeData.email && <span className="flex items-center gap-1.5"><Mail size={12}/> {resumeData.email}</span>}
                        {resumeData.phone && <span className="flex items-center gap-1.5"><Phone size={12}/> {resumeData.phone}</span>}
                      </div>
                    </div>
                    <div className="text-right text-[12px] font-medium text-slate-500 flex flex-col gap-0.5 items-end print-gray">
                        {resumeData.linkedin && <span className="flex items-center gap-1.5">{resumeData.linkedin} <LinkIcon size={12}/></span>}
                        {resumeData.github && <span className="flex items-center gap-1.5">{resumeData.github} <LinkIcon size={12}/></span>}
                    </div>
                  </div>
                )}

                {theme === 'creative' && (
                  <div className="mb-6 flex">
                    <div className="w-1.5 h-[70px] bg-amber-500 mr-5 print-accent" />
                    <div className="py-1">
                      <h1 className="text-[36px] font-black tracking-tighter text-slate-900 print-black uppercase leading-none">{resumeData.name || 'NAME HERE'}</h1>
                      <div className="flex flex-wrap gap-4 mt-2 text-[12px] font-bold text-amber-600 print-accent">
                        {resumeData.email && <span>{resumeData.email}</span>}
                        {resumeData.phone && <span>{resumeData.phone}</span>}
                        {resumeData.linkedin && <span>in/{resumeData.linkedin}</span>}
                        {resumeData.github && <span>gh/{resumeData.github}</span>}
                      </div>
                    </div>
                  </div>
                )}
                
                {resumeData.summary && (
                  <div className="mb-5">
                     <SectionHeader title="Summary" theme={theme} />
                     <p className="text-[12px] leading-relaxed text-gray-800 print-black">{resumeData.summary}</p>
                  </div>
                )}

                {resumeData.experience.some(e => e.company || e.role) && (
                  <div className="mb-5">
                     <SectionHeader title="Experience" theme={theme} />
                     <div className="space-y-3.5">
                       {resumeData.experience.map((exp) => (
                         (exp.company || exp.role) ? (
                           <div key={exp.id}>
                             <div className="flex justify-between items-baseline mb-0.5">
                               <h3 className={`text-[13px] font-bold ${theme === 'executive' ? 'text-black print-black' : 'text-slate-900 print-black'}`}>{exp.role || 'Job Title'}</h3>
                               <span className={`text-[11px] font-semibold ${theme === 'executive' ? 'text-gray-600' : 'text-slate-500'} print-gray whitespace-nowrap`}>
                                 {exp.startDate} {exp.startDate && exp.endDate ? '–' : ''} {exp.endDate}
                               </span>
                             </div>
                             <p className={`text-[12px] font-semibold mb-1.5 ${theme === 'modern' ? 'text-sky-600 print-accent' : theme === 'creative' ? 'text-amber-600 print-accent' : 'text-gray-800 print-black italic'}`}>
                               {exp.company || 'Company Name'}
                             </p>
                             {exp.description && (
                               <ul className="list-disc list-outside ml-4 space-y-0.5">
                                 {exp.description.split('\n').map((bullet, idx) => bullet.trim() && (
                                   <li key={idx} className="text-[11px] leading-snug text-gray-700 print-black pl-1">{bullet.replace(/^[-•*]\s*/, '')}</li>
                                 ))}
                               </ul>
                             )}
                           </div>
                         ) : null
                       ))}
                     </div>
                  </div>
                )}

                {resumeData.projects.some(p => p.name) && (
                  <div className="mb-5">
                     <SectionHeader title="Projects" theme={theme} />
                     <div className="space-y-3.5">
                       {resumeData.projects.map((proj) => (
                         proj.name ? (
                           <div key={proj.id}>
                             <div className="flex items-baseline gap-2 mb-0.5">
                               <h3 className={`text-[13px] font-bold text-black print-black`}>{proj.name}</h3>
                               {proj.link && <span className="text-[10px] text-gray-500 font-medium truncate max-w-[200px]">| {proj.link}</span>}
                             </div>
                             {proj.tech && <p className="text-[11px] font-semibold text-gray-600 mb-1">Technologies: {proj.tech}</p>}
                             <p className="text-[11px] leading-snug text-gray-700 print-black">{proj.description}</p>
                           </div>
                         ) : null
                       ))}
                     </div>
                  </div>
                )}

                <div className={`grid ${theme === 'executive' ? 'grid-cols-1' : 'grid-cols-2 gap-8'}`}>
                  {resumeData.skills.length > 0 && (
                    <div className="mb-5">
                       <SectionHeader title="Skills" theme={theme} />
                       <div className="flex flex-wrap gap-1.5">
                         {resumeData.skills.map((skill, i) => (
                           <span key={i} className={`text-[11px] px-2 py-0.5 ${theme === 'executive' ? 'font-medium text-black' : 'bg-slate-100 rounded text-slate-700 font-semibold'} print-black`}>
                             {skill} {theme === 'executive' && i < resumeData.skills.length - 1 ? '•' : ''}
                           </span>
                         ))}
                       </div>
                    </div>
                  )}

                  {resumeData.education.some(e => e.school || e.degree) && (
                    <div className="mb-5">
                       <SectionHeader title="Education" theme={theme} />
                       <div className="space-y-3">
                         {resumeData.education.map((edu) => (
                           (edu.school || edu.degree) ? (
                             <div key={edu.id}>
                               <div className="flex justify-between items-baseline mb-0.5">
                                 <h3 className="text-[13px] font-bold text-black print-black">{edu.school || 'University'}</h3>
                                 <span className="text-[11px] font-semibold text-gray-600 print-gray">{edu.year}</span>
                               </div>
                               <div className="flex justify-between text-[12px]">
                                 <p className="text-gray-800 print-black italic">{edu.degree || 'Degree'}</p>
                                 {edu.gpa && <span className="font-medium text-gray-600 print-gray whitespace-nowrap ml-2">GPA: {edu.gpa}</span>}
                               </div>
                             </div>
                           ) : null
                         ))}
                       </div>
                    </div>
                  )}
                </div>

             </div>
          </div>
        </div>
      </div>
    </div>
  )
}

function SectionHeader({ title, theme }: { title: string, theme: Theme }) {
  if (theme === 'executive') {
    return <h2 className="text-[13px] font-bold uppercase tracking-widest text-black border-b border-black pb-1 mb-2.5 print-black">{title}</h2>
  }
  if (theme === 'modern') {
    return <h2 className="text-[13px] font-bold uppercase tracking-wider text-sky-600 print-accent border-b border-slate-200 pb-1 mb-2.5">{title}</h2>
  }
  return <h2 className="text-[14px] font-black uppercase text-amber-600 print-accent mb-2.5">{title}</h2>
}

function SectionAccordion({ title, icon, activeSection, setActiveSection, sectionId, children }: any) {
  const isActive = activeSection === sectionId
  return (
    <div className="shrink-0 bg-white dark:bg-[#12141a] rounded-2xl border border-slate-200 dark:border-white/5 shadow-sm overflow-hidden">
      <button onClick={() => setActiveSection(isActive ? '' : sectionId)} className="w-full flex items-center justify-between p-5 focus:outline-none hover:bg-slate-50 dark:hover:bg-white/[0.02] transition-colors">
        <span className="font-bold tracking-tight flex items-center gap-3 text-slate-900 dark:text-white text-[15px]">
          <span className="text-brand-500 dark:text-cyan-500">{icon}</span> {title}
        </span>
        <ChevronDown size={18} className={`text-slate-400 transition-transform duration-300 ${isActive ? 'rotate-180' : ''}`} />
      </button>
      <AnimatePresence>
        {isActive && (
          <motion.div initial={{ height: 0, opacity: 0 }} animate={{ height: 'auto', opacity: 1 }} exit={{ height: 0, opacity: 0 }} className="overflow-hidden">
            <div className="p-5 pt-0 border-t border-slate-100 dark:border-white/5">
              <div className="mt-4">{children}</div>
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  )
}

function Input({ label, value, onChange, placeholder, type = 'text' }: any) {
  return (
    <div>
      <label className="text-[11px] font-bold tracking-widest text-slate-500 uppercase mb-2 block">{label}</label>
      <input type={type} value={value} onChange={e => onChange(e.target.value)} placeholder={placeholder} className="w-full rounded-xl bg-slate-50 dark:bg-[#0a0a0c] border border-slate-200 dark:border-white/10 text-slate-900 dark:text-white px-4 py-3 outline-none focus:border-brand-500 transition-all text-sm" />
    </div>
  )
}

function AddButton({ onClick, label }: { onClick: () => void, label: string }) {
  return (
    <button onClick={onClick} className="w-full py-4 border border-dashed border-slate-300 dark:border-white/10 rounded-xl text-slate-500 dark:text-slate-400 hover:text-brand-600 dark:hover:text-cyan-400 hover:border-brand-500 dark:hover:border-cyan-500 hover:bg-brand-50/50 dark:hover:bg-cyan-500/5 transition-all flex items-center justify-center gap-2 font-bold text-sm">
      <Plus size={18} /> {label}
    </button>
  )
}
