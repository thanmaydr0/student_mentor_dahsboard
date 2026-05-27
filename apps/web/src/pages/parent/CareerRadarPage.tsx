import React, { useState, useEffect } from 'react'
import { motion } from 'framer-motion'
import { Target, Compass, Briefcase, Award, CheckCircle2, ChevronRight, Lock } from 'lucide-react'
import { useQuery } from '@tanstack/react-query'
import AppShell from '../../components/layout/AppShell'
import Card from '../../components/ui/Card'
import { Radar, RadarChart, PolarGrid, PolarAngleAxis, PolarRadiusAxis, ResponsiveContainer } from 'recharts'
import { supabase } from '../../lib/supabase'
import { useAuth } from '../../hooks/useAuth'
import { cn } from '../../lib/utils'

export default function CareerRadarPage() {
  const { user } = useAuth()
  
  const { data: careerMetrics, isLoading } = useQuery({
    queryKey: ['career-metrics', user?.id],
    queryFn: async () => {
      // Find linked student
      const { data: linkData } = await supabase
        .from('parent_student_links')
        .select('student_id')
        .eq('parent_id', user?.id)
        .single()
        
      if (!linkData) return null

      const { data, error } = await supabase
        .from('career_metrics')
        .select('*')
        .eq('student_id', linkData.student_id)
        .single()
        
      if (error) throw error
      return data
    },
    enabled: !!user?.id
  })

  const radarData = careerMetrics ? [
    { subject: 'Problem Solving', A: careerMetrics.problem_solving, fullMark: 100 },
    { subject: 'Communication', A: careerMetrics.communication, fullMark: 100 },
    { subject: 'Technical Skills', A: careerMetrics.technical_skills, fullMark: 100 },
    { subject: 'Teamwork', A: careerMetrics.teamwork, fullMark: 100 },
    { subject: 'Leadership', A: careerMetrics.leadership, fullMark: 100 },
    { subject: 'Adaptability', A: careerMetrics.adaptability, fullMark: 100 },
  ] : []

  const recentMilestones = careerMetrics?.recent_milestones || []
  return (
    <AppShell role="parent">
      <div className="max-w-6xl mx-auto flex flex-col gap-8 pb-10">
        
        {/* Header */}
        <div className="flex flex-col sm:flex-row sm:items-end justify-between gap-4 border-b border-slate-200 dark:border-white/10 pb-6">
          <div className="flex flex-col gap-3">
            <h1 className="text-3xl font-bold text-slate-900 dark:text-white flex items-center gap-3">
              <div className="p-2.5 bg-gradient-to-br from-rose-500 to-orange-600 rounded-xl shadow-sm text-white">
                <Target size={24} />
              </div>
              Career & Skill Radar
            </h1>
            <p className="text-slate-500 dark:text-slate-400 max-w-2xl text-sm leading-relaxed">
              A high-level secure view of your child's placement readiness. We analyze their resume scores and job tracker activity to give you insights without invading their day-to-day privacy.
            </p>
          </div>
          <div className="flex items-center gap-2 text-xs font-semibold text-slate-500 bg-slate-100 dark:bg-white/5 px-3 py-1.5 rounded-full shrink-0">
            <Lock size={14} className="text-emerald-600"/> High-level Privacy Preserved
          </div>
        </div>

        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} className="grid grid-cols-1 lg:grid-cols-12 gap-8">
          
          {/* Left: Radar Chart */}
          <div className="lg:col-span-7 flex flex-col gap-6">
            <Card className="p-6 h-[450px] flex flex-col">
              <h3 className="text-lg font-bold text-slate-900 dark:text-white mb-2">Skill Readiness Radar</h3>
              <p className="text-sm text-slate-500 dark:text-slate-400 mb-6">Aggregated based on recent mock tests, resume parsing, and internal grades.</p>
              
              <div className="flex-1 w-full min-h-[300px]">
                {isLoading ? (
                  <div className="flex h-full items-center justify-center text-slate-500">Loading radar data...</div>
                ) : !careerMetrics ? (
                  <div className="flex h-full items-center justify-center text-slate-500">No career data available yet.</div>
                ) : (
                  <ResponsiveContainer width="100%" height="100%">
                    <RadarChart cx="50%" cy="50%" outerRadius="75%" data={radarData}>
                      <PolarGrid stroke="#e2e8f0" />
                      <PolarAngleAxis dataKey="subject" tick={{ fill: '#64748b', fontSize: 12, fontWeight: 600 }} />
                      <PolarRadiusAxis angle={30} domain={[0, 100]} tick={false} axisLine={false} />
                      <Radar
                        name="Student Profile"
                        dataKey="A"
                        stroke="#f43f5e"
                        strokeWidth={3}
                        fill="#f43f5e"
                        fillOpacity={0.2}
                      />
                    </RadarChart>
                  </ResponsiveContainer>
                )}
              </div>
            </Card>

            <div className="grid grid-cols-1 gap-6">
               <Card className="p-6 bg-gradient-to-br from-emerald-50 to-teal-50 dark:from-emerald-950/20 dark:to-teal-950/20 border-emerald-100 dark:border-emerald-900/30 flex items-center justify-between group">
                 <div>
                   <h4 className="font-bold text-emerald-900 dark:text-emerald-400 text-sm uppercase tracking-wider mb-2">Primary Strength</h4>
                   <p className="text-2xl font-black text-slate-900 dark:text-white">{careerMetrics?.primary_strength || '-'}</p>
                   <p className="text-sm text-slate-600 dark:text-slate-400 mt-2 leading-relaxed max-w-lg">Excels in programming paradigms and algorithm design. Highly competitive for Software Engineering roles.</p>
                 </div>
                 <div className="hidden sm:flex h-16 w-16 items-center justify-center rounded-full bg-emerald-100 dark:bg-emerald-900/50 text-emerald-600 dark:text-emerald-400 group-hover:scale-110 transition-transform">
                   <Target size={32} />
                 </div>
               </Card>
            </div>
          </div>

          {/* Right: Milestones & Actions */}
          <div className="lg:col-span-5 flex flex-col gap-6">
            
            <Card className="p-6">
              <h3 className="text-lg font-bold text-slate-900 dark:text-white mb-6 flex items-center gap-2">
                <Briefcase className="text-brand-600" /> Recent Career Milestones
              </h3>
              
              <div className="space-y-6 relative before:absolute before:inset-0 before:ml-[11px] before:-translate-x-px md:before:mx-auto md:before:translate-x-0 before:h-full before:w-0.5 before:bg-gradient-to-b before:from-transparent before:via-slate-200 dark:before:via-slate-700 before:to-transparent">
                {recentMilestones.map((milestone, idx) => (
                  <motion.div 
                    key={idx} 
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ delay: 0.1 * idx }}
                    className="relative flex items-center justify-between md:justify-normal md:odd:flex-row-reverse group cursor-pointer"
                  >
                    <div className="flex items-center justify-center w-6 h-6 rounded-full border-4 border-white dark:border-[#0c0d10] bg-brand-500 dark:bg-amber-500 shadow shrink-0 md:order-1 md:group-odd:-translate-x-1/2 md:group-even:translate-x-1/2 z-10 group-hover:scale-125 transition-transform duration-300"></div>
                    
                    <motion.div 
                      whileHover={{ scale: 1.03, y: -4 }}
                      whileTap={{ scale: 0.98 }}
                      className="w-[calc(100%-2rem)] md:w-[calc(50%-1.5rem)] p-4 rounded-xl border border-slate-100 dark:border-white/10 bg-white dark:bg-white/5 shadow-sm hover:shadow-lg dark:hover:bg-white/10 transition-all duration-300 relative overflow-hidden"
                    >
                      {/* Glow effect on hover */}
                      <div className="absolute inset-0 bg-gradient-to-r from-brand-500/0 via-brand-500/5 to-brand-500/0 dark:from-amber-500/0 dark:via-amber-500/10 dark:to-amber-500/0 -translate-x-full group-hover:animate-[shimmer_1.5s_infinite] pointer-events-none" />
                      
                      <div className="flex items-start justify-between mb-1 relative z-10">
                        <span className="font-bold text-slate-900 dark:text-white text-sm group-hover:text-brand-600 dark:group-hover:text-amber-400 transition-colors">{milestone.title}</span>
                        <ChevronRight size={16} className="text-slate-300 dark:text-slate-600 opacity-0 -translate-x-2 group-hover:opacity-100 group-hover:translate-x-0 transition-all duration-300" />
                      </div>
                      
                      <div className="text-xs text-slate-500 dark:text-slate-400 font-medium mb-2 relative z-10">{milestone.date}</div>
                      
                      {milestone.score && (
                        <div className="inline-flex items-center gap-1.5 px-2 py-1 rounded-md bg-emerald-50 dark:bg-emerald-950/30 text-emerald-700 dark:text-emerald-400 text-xs font-bold border border-emerald-200 dark:border-emerald-900/50 group-hover:bg-emerald-100 dark:group-hover:bg-emerald-900/50 transition-colors relative z-10">
                          <CheckCircle2 size={12}/> {milestone.score}
                        </div>
                      )}
                    </motion.div>
                  </motion.div>
                ))}
              </div>
            </Card>

            <Card className="p-0 bg-white dark:bg-[#12141a] overflow-hidden border border-slate-200 dark:border-white/5 shadow-xl">
               <div className="p-6 bg-gradient-to-r from-brand-600 to-indigo-700 dark:from-brand-900 dark:to-indigo-950 text-white relative overflow-hidden">
                 <div className="absolute top-0 right-0 p-4 opacity-10">
                   <Compass size={100} />
                 </div>
                 <h3 className="text-xl font-bold mb-2 relative z-10">AI Recommendations</h3>
                 <p className="text-brand-100 text-sm leading-relaxed relative z-10 max-w-sm">
                   Actionable steps to help improve their Day-1 placement chances based on current trajectory.
                 </p>
               </div>
               
               <div className="divide-y divide-slate-100 dark:divide-white/5">
                 {/* Rec 1 */}
                 <div className="p-5 flex gap-4 hover:bg-slate-50 dark:hover:bg-white/5 transition-colors cursor-pointer group">
                   <div className="w-10 h-10 rounded-full bg-blue-50 dark:bg-blue-900/30 flex items-center justify-center shrink-0 text-blue-600 dark:text-blue-400 mt-1">
                     <Award size={20} />
                   </div>
                   <div className="flex-1">
                     <h4 className="font-bold text-slate-900 dark:text-white text-sm group-hover:text-brand-600 dark:group-hover:text-amber-400 transition-colors">Encourage Open Source Contributions</h4>
                     <p className="text-xs text-slate-500 dark:text-slate-400 mt-1 leading-relaxed">Participating in open-source projects builds public proof of their technical skills.</p>
                   </div>
                   <ChevronRight size={18} className="text-slate-300 dark:text-slate-600 self-center opacity-0 group-hover:opacity-100 -translate-x-2 group-hover:translate-x-0 transition-all" />
                 </div>
                 
                 {/* Rec 2 */}
                 <div className="p-5 flex gap-4 hover:bg-slate-50 dark:hover:bg-white/5 transition-colors cursor-pointer group">
                   <div className="w-10 h-10 rounded-full bg-orange-50 dark:bg-orange-900/30 flex items-center justify-center shrink-0 text-orange-600 dark:text-orange-400 mt-1">
                     <Target size={20} />
                   </div>
                   <div className="flex-1">
                     <h4 className="font-bold text-slate-900 dark:text-white text-sm group-hover:text-brand-600 dark:group-hover:text-amber-400 transition-colors">Suggest a Mock Interview</h4>
                     <p className="text-xs text-slate-500 dark:text-slate-400 mt-1 leading-relaxed">Communication during technical rounds is crucial. A practice session will boost confidence.</p>
                   </div>
                   <ChevronRight size={18} className="text-slate-300 dark:text-slate-600 self-center opacity-0 group-hover:opacity-100 -translate-x-2 group-hover:translate-x-0 transition-all" />
                 </div>
               </div>
            </Card>

          </div>
        </motion.div>
      </div>
    </AppShell>
  )
}
