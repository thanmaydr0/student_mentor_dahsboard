import React, { useState, useEffect } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { Award, UploadCloud, Calendar, Clock, Trophy, MapPin, CheckCircle2, Circle, Loader2, X, Plus } from 'lucide-react'
import AppShell from '../../components/layout/AppShell'
import Card from '../../components/ui/Card'
import Button from '../../components/ui/Button'
import Input from '../../components/ui/Input'
import { supabase } from '../../lib/supabase'
import toast from 'react-hot-toast'

interface Achievement {
  id: string
  student_id: string
  title: string
  category: string
  event_date: string | null
  event_time: string | null
  cert_url: string | null
  attendance_claimed: boolean
  notes: string | null
  created_at: string
}

export default function AchievementVaultPage() {
  const [achievements, setAchievements] = useState<Achievement[]>([])
  const [isLoading, setIsLoading] = useState(true)
  const [isUploading, setIsUploading] = useState(false)
  const [filterCategory, setFilterCategory] = useState<string>('all')
  const [showUploadModal, setShowUploadModal] = useState(false)
  const [uploadFile, setUploadFile] = useState<File | null>(null)
  
  // AI Extracted/Manual form state
  const [formTitle, setFormTitle] = useState('')
  const [formCategory, setFormCategory] = useState('hackathon')
  const [formDate, setFormDate] = useState('')
  const [formTime, setFormTime] = useState('')
  const [certUrl, setCertUrl] = useState('')

  useEffect(() => {
    fetchAchievements()
  }, [])

  const fetchAchievements = async () => {
    try {
      const { data: { user } } = await supabase.auth.getUser()
      if (!user) return

      const { data, error } = await supabase
        .from('achievements')
        .select('*')
        .eq('student_id', user.id)
        .order('event_date', { ascending: false })

      if (error) throw error
      setAchievements(data || [])
    } catch (err: any) {
      toast.error('Failed to load achievements')
    } finally {
      setIsLoading(false)
    }
  }

  const handleFileUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    if (!e.target.files || e.target.files.length === 0) return
    const file = e.target.files[0]
    setUploadFile(file)
    setIsUploading(true)

    try {
      const { data: { user } } = await supabase.auth.getUser()
      if (!user) throw new Error("Not authenticated")

      const fileExt = file.name.split('.').pop()
      const fileName = `${user.id}/${Date.now()}.${fileExt}`

      // Upload to Storage
      const { error: uploadError } = await supabase.storage
        .from('certificates')
        .upload(fileName, file)

      if (uploadError) throw uploadError

      const { data: { publicUrl } } = supabase.storage
        .from('certificates')
        .getPublicUrl(fileName)

      setCertUrl(publicUrl)
      
      // Call AI Edge Function to extract date/time/title
      toast.loading("Analyzing certificate with AI...", { id: "ai-extract" })
      const { data, error: fnError } = await supabase.functions.invoke('extract-cert-date', {
        body: { cert_url: publicUrl }
      })

      if (fnError || !data?.success) {
        toast.dismiss("ai-extract")
        toast.error("Could not auto-extract details. Please fill manually.")
      } else {
        toast.success("Details extracted successfully!", { id: "ai-extract" })
        if (data.data.title) setFormTitle(data.data.title)
        if (data.data.event_date) setFormDate(data.data.event_date)
        if (data.data.event_time) setFormTime(data.data.event_time)
      }

    } catch (err: any) {
      console.error(err)
      toast.error('Failed to upload file')
    } finally {
      setIsUploading(false)
    }
  }

  const handleSaveAchievement = async () => {
    if (!formTitle) return toast.error("Event Name is required")
    if (!certUrl) return toast.error("Please wait for the certificate to finish uploading")

    try {
      const { data: { user } } = await supabase.auth.getUser()
      if (!user) return

      const { error } = await supabase
        .from('achievements')
        .insert({
          student_id: user.id,
          title: formTitle,
          category: formCategory,
          event_date: formDate || null,
          event_time: formTime || null,
          cert_url: certUrl
        })

      if (error) throw error
      
      toast.success("Achievement added to Vault!")
      setShowUploadModal(false)
      resetForm()
      fetchAchievements()
    } catch (err: any) {
      toast.error("Failed to save achievement")
    }
  }

  const toggleAttendanceClaimed = async (id: string, currentStatus: boolean) => {
    try {
      setAchievements(prev => prev.map(a => a.id === id ? { ...a, attendance_claimed: !currentStatus } : a))
      
      const { error } = await supabase
        .from('achievements')
        .update({ attendance_claimed: !currentStatus })
        .eq('id', id)

      if (error) throw error
    } catch (err: any) {
      toast.error("Failed to update status")
      fetchAchievements() // revert
    }
  }

  const resetForm = () => {
    setUploadFile(null)
    setFormTitle('')
    setFormDate('')
    setFormTime('')
    setCertUrl('')
    setFormCategory('hackathon')
  }

  const filteredAchievements = filterCategory === 'all' 
    ? achievements 
    : achievements.filter(a => a.category === filterCategory)

  return (
    <AppShell role="student">
      <div className="max-w-7xl mx-auto space-y-8 animate-in fade-in duration-500">
        
        {/* Header */}
        <div className="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
          <div>
            <h1 className="text-3xl font-black text-slate-900 dark:text-white flex items-center gap-3">
              <Trophy className="text-amber-500" size={32} />
              Achievement Vault
            </h1>
            <p className="text-slate-500 dark:text-slate-400 mt-1 font-medium">
              Store your certificates and track your attendance claims for external events.
            </p>
          </div>
          <Button 
            onClick={() => setShowUploadModal(true)}
            className="bg-amber-500 hover:bg-amber-600 text-white shadow-lg shadow-amber-500/20"
          >
            <Plus size={18} className="mr-2" />
            Add Achievement
          </Button>
        </div>

        {/* Filters */}
        <div className="flex items-center gap-2 overflow-x-auto pb-2 scrollbar-hide">
          {['all', 'hackathon', 'club_event', 'workshop', 'competition', 'other'].map(cat => (
            <button
              key={cat}
              onClick={() => setFilterCategory(cat)}
              className={`px-4 py-2 rounded-xl text-sm font-bold whitespace-nowrap transition-colors ${
                filterCategory === cat 
                ? 'bg-amber-100 text-amber-700 dark:bg-amber-500/20 dark:text-amber-400'
                : 'bg-slate-100 text-slate-500 hover:bg-slate-200 dark:bg-white/5 dark:text-slate-400 dark:hover:bg-white/10'
              }`}
            >
              {cat === 'all' ? 'All Events' : cat.replace('_', ' ').replace(/\b\w/g, l => l.toUpperCase())}
            </button>
          ))}
        </div>

        {/* Grid */}
        {isLoading ? (
          <div className="flex justify-center py-20">
            <Loader2 className="animate-spin text-amber-500" size={40} />
          </div>
        ) : filteredAchievements.length === 0 ? (
          <div className="text-center py-20 bg-slate-50 dark:bg-white/5 rounded-3xl border-2 border-dashed border-slate-200 dark:border-white/10">
            <Trophy size={48} className="mx-auto text-slate-300 dark:text-slate-600 mb-4" />
            <h3 className="text-xl font-bold text-slate-400 dark:text-slate-500">No achievements yet</h3>
            <p className="text-sm font-medium text-slate-400 mt-2">Upload a certificate to start building your vault.</p>
          </div>
        ) : (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <AnimatePresence>
              {filteredAchievements.map(achievement => (
                <motion.div
                  key={achievement.id}
                  layout
                  initial={{ opacity: 0, scale: 0.9 }}
                  animate={{ opacity: 1, scale: 1 }}
                  exit={{ opacity: 0, scale: 0.9 }}
                >
                  <Card className="h-full flex flex-col overflow-hidden group">
                    <div className="relative h-48 bg-slate-100 dark:bg-[#12141a] border-b border-slate-200 dark:border-white/5 overflow-hidden">
                      {achievement.cert_url ? (
                        <img 
                          src={achievement.cert_url} 
                          alt={achievement.title} 
                          className="w-full h-full object-cover opacity-80 group-hover:opacity-100 transition-opacity"
                        />
                      ) : (
                        <div className="w-full h-full flex items-center justify-center">
                          <Award size={48} className="text-slate-300 dark:text-slate-700" />
                        </div>
                      )}
                      <div className="absolute top-3 left-3 px-3 py-1 bg-black/50 backdrop-blur-md text-white text-xs font-bold rounded-lg uppercase tracking-wider">
                        {achievement.category.replace('_', ' ')}
                      </div>
                    </div>
                    
                    <div className="p-6 flex-1 flex flex-col">
                      <h3 className="text-xl font-bold text-slate-900 dark:text-white mb-4 line-clamp-2">
                        {achievement.title}
                      </h3>
                      
                      <div className="space-y-2 mb-6">
                        <div className="flex items-center gap-2 text-sm text-slate-600 dark:text-slate-400 font-medium">
                          <Calendar size={16} className="text-amber-500" />
                          {achievement.event_date ? new Date(achievement.event_date).toLocaleDateString(undefined, { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' }) : 'Unknown Date'}
                        </div>
                        {achievement.event_time && (
                          <div className="flex items-center gap-2 text-sm text-slate-600 dark:text-slate-400 font-medium">
                            <Clock size={16} className="text-amber-500" />
                            {achievement.event_time}
                          </div>
                        )}
                      </div>

                      <div className="mt-auto pt-4 border-t border-slate-100 dark:border-white/5 flex items-center justify-between">
                        <span className="text-sm font-bold text-slate-500 dark:text-slate-400">Attendance Claim</span>
                        <button
                          onClick={() => toggleAttendanceClaimed(achievement.id, achievement.attendance_claimed)}
                          className={`flex items-center gap-2 px-3 py-1.5 rounded-lg text-sm font-bold transition-colors ${
                            achievement.attendance_claimed 
                            ? 'bg-emerald-100 text-emerald-700 dark:bg-emerald-500/20 dark:text-emerald-400' 
                            : 'bg-slate-100 text-slate-500 hover:bg-slate-200 dark:bg-white/5 dark:text-slate-400 dark:hover:bg-white/10'
                          }`}
                        >
                          {achievement.attendance_claimed ? <CheckCircle2 size={16} /> : <Circle size={16} />}
                          {achievement.attendance_claimed ? 'Claimed' : 'Pending'}
                        </button>
                      </div>
                    </div>
                  </Card>
                </motion.div>
              ))}
            </AnimatePresence>
          </div>
        )}

      </div>

      {/* Upload Modal */}
      <AnimatePresence>
        {showUploadModal && (
          <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-900/50 backdrop-blur-sm">
            <motion.div
              initial={{ opacity: 0, scale: 0.95 }}
              animate={{ opacity: 1, scale: 1 }}
              exit={{ opacity: 0, scale: 0.95 }}
              className="bg-white dark:bg-[#1a1d24] w-full max-w-xl rounded-3xl shadow-2xl overflow-hidden"
            >
              <div className="p-6 border-b border-slate-100 dark:border-white/5 flex justify-between items-center">
                <h2 className="text-2xl font-black text-slate-900 dark:text-white flex items-center gap-2">
                  <UploadCloud className="text-amber-500" /> Upload Certificate
                </h2>
                <button onClick={() => { setShowUploadModal(false); resetForm(); }} className="p-2 text-slate-400 hover:text-slate-900 dark:hover:text-white bg-slate-100 dark:bg-white/5 rounded-full transition-colors">
                  <X size={20} />
                </button>
              </div>

              <div className="p-6 space-y-6">
                
                {/* File Upload Zone */}
                {!certUrl ? (
                  <div className="relative border-2 border-dashed border-slate-200 dark:border-white/10 rounded-2xl p-8 text-center hover:bg-slate-50 dark:hover:bg-white/5 transition-colors cursor-pointer group">
                    <input 
                      type="file" 
                      accept="image/*,application/pdf"
                      onChange={handleFileUpload}
                      disabled={isUploading}
                      className="absolute inset-0 w-full h-full opacity-0 cursor-pointer disabled:cursor-not-allowed"
                    />
                    <div className="flex flex-col items-center gap-3">
                      {isUploading ? (
                        <>
                          <Loader2 size={40} className="text-amber-500 animate-spin" />
                          <p className="font-bold text-slate-600 dark:text-slate-300">Uploading & Analyzing...</p>
                        </>
                      ) : (
                        <>
                          <div className="w-16 h-16 bg-amber-100 dark:bg-amber-500/20 text-amber-500 rounded-full flex items-center justify-center group-hover:scale-110 transition-transform">
                            <UploadCloud size={24} />
                          </div>
                          <div>
                            <p className="font-bold text-slate-900 dark:text-white">Click or drag certificate</p>
                            <p className="text-sm font-medium text-slate-500">Image or PDF up to 5MB</p>
                          </div>
                        </>
                      )}
                    </div>
                  </div>
                ) : (
                  <div className="relative h-40 rounded-2xl overflow-hidden border border-slate-200 dark:border-white/10">
                    <img src={certUrl} alt="Certificate preview" className="w-full h-full object-cover" />
                    <div className="absolute inset-0 bg-gradient-to-t from-black/50 to-transparent flex items-end p-4">
                      <span className="text-white font-bold flex items-center gap-2"><CheckCircle2 size={16} className="text-emerald-400"/> Uploaded</span>
                    </div>
                  </div>
                )}

                {/* Form Fields (Auto-filled by AI) */}
                <div className="space-y-4">
                  <Input 
                    label="Event Name" 
                    placeholder="e.g. HackCMRIT 2025" 
                    value={formTitle}
                    onChange={e => setFormTitle(e.target.value)}
                  />
                  
                  <div className="space-y-1.5">
                    <label className="text-sm font-bold text-slate-700 dark:text-slate-300">Category</label>
                    <select 
                      value={formCategory}
                      onChange={e => setFormCategory(e.target.value)}
                      className="w-full px-4 py-3 rounded-xl bg-slate-50 dark:bg-[#12141a] border border-slate-200 dark:border-white/10 focus:border-amber-500 outline-none transition-all font-medium"
                    >
                      <option value="hackathon">Hackathon</option>
                      <option value="club_event">Club Event</option>
                      <option value="workshop">Workshop</option>
                      <option value="competition">Competition</option>
                      <option value="other">Other</option>
                    </select>
                  </div>

                  <div className="grid grid-cols-2 gap-4">
                    <Input 
                      label="Date" 
                      type="date"
                      value={formDate}
                      onChange={e => setFormDate(e.target.value)}
                    />
                    <Input 
                      label="Time" 
                      placeholder="e.g. 10:00 AM"
                      value={formTime}
                      onChange={e => setFormTime(e.target.value)}
                    />
                  </div>
                </div>

                <div className="pt-4 flex gap-3">
                  <Button variant="secondary" fullWidth onClick={() => { setShowUploadModal(false); resetForm(); }}>Cancel</Button>
                  <Button 
                    fullWidth 
                    onClick={handleSaveAchievement} 
                    disabled={!certUrl || isUploading}
                    className="bg-amber-500 hover:bg-amber-600 text-white"
                  >
                    Save Achievement
                  </Button>
                </div>
              </div>
            </motion.div>
          </div>
        )}
      </AnimatePresence>
    </AppShell>
  )
}
