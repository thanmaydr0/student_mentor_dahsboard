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

            <div className="grid grid-cols-1 sm:grid-cols-2 gap-6">
               <Card className="p-6 bg-gradient-to-br from-rose-50 to-orange-50 dark:from-rose-950/20 dark:to-orange-950/20 border-rose-100 dark:border-rose-900/30">
                 <h4 className="font-bold text-rose-900 dark:text-rose-400 text-sm uppercase tracking-wider mb-2">Primary Strength</h4>
                 <p className="text-2xl font-black text-slate-900 dark:text-white">{careerMetrics?.primary_strength || '-'}</p>
                 <p className="text-sm text-slate-600 dark:text-slate-400 mt-2 leading-relaxed">Excels in programming paradigms and algorithm design. Highly competitive for SDE roles.</p>
               </Card>
               <Card className="p-6 bg-slate-50 dark:bg-white/5 border-slate-100 dark:border-white/10">
                 <h4 className="font-bold text-slate-500 dark:text-slate-400 text-sm uppercase tracking-wider mb-2">Growth Area</h4>
                 <p className="text-2xl font-black text-slate-900 dark:text-white">{careerMetrics?.growth_area || '-'}</p>
                 <p className="text-sm text-slate-600 dark:text-slate-400 mt-2 leading-relaxed">Could benefit from mock interviews and group discussions to boost confidence.</p>
               </Card>
            </div>
          </div>

          {/* Right: Milestones & Actions */}
          <div className="lg:col-span-5 flex flex-col gap-6">
            
            <Card className="p-6">
              <h3 className="text-lg font-bold text-slate-900 dark:text-white mb-6 flex items-center gap-2">
                <Briefcase className="text-brand-600" /> Recent Career Milestones
              </h3>
              
              <div className="space-y-6 relative before:absolute before:inset-0 before:ml-[11px] before:-translate-x-px md:before:mx-auto md:before:translate-x-0 before:h-full before:w-0.5 before:bg-gradient-to-b before:from-transparent before:via-slate-200 before:to-transparent">
                {recentMilestones.map((milestone, idx) => (
                  <div key={idx} className="relative flex items-center justify-between md:justify-normal md:odd:flex-row-reverse group is-active">
                    <div className="flex items-center justify-center w-6 h-6 rounded-full border-4 border-white dark:border-[#0c0d10] bg-brand-500 shadow shrink-0 md:order-1 md:group-odd:-translate-x-1/2 md:group-even:translate-x-1/2 z-10"></div>
                    <div className="w-[calc(100%-2rem)] md:w-[calc(50%-1.5rem)] p-4 rounded-xl border border-slate-100 dark:border-white/10 bg-white dark:bg-white/5 shadow-sm">
                      <div className="flex items-center justify-between mb-1">
                        <span className="font-bold text-slate-900 dark:text-white text-sm">{milestone.title}</span>
                      </div>
                      <div className="text-xs text-slate-500 dark:text-slate-400 font-medium mb-2">{milestone.date}</div>
                      {milestone.score && (
                        <div className="inline-flex items-center gap-1.5 px-2 py-1 rounded-md bg-emerald-50 dark:bg-emerald-950/30 text-emerald-700 dark:text-emerald-400 text-xs font-bold border border-emerald-200 dark:border-emerald-900/50">
                          <CheckCircle2 size={12}/> {milestone.score}
                        </div>
                      )}
                    </div>
                  </div>
                ))}
              </div>
            </Card>

            <Card className="p-6 bg-brand-900 text-white overflow-hidden relative">
               <div className="absolute top-0 right-0 p-8 opacity-10">
                 <Compass size={120} />
               </div>
               <div className="relative z-10">
                 <h3 className="text-xl font-bold mb-2">How to help?</h3>
                 <p className="text-brand-200 text-sm leading-relaxed mb-6">
                   Based on the current trajectory, encouraging participation in open-source projects or a short communication skills workshop will vastly improve their Day-1 placement chances.
                 </p>
                 <button className="flex items-center gap-2 text-sm font-bold bg-white text-brand-900 px-5 py-2.5 rounded-lg hover:bg-brand-50 transition-colors">
                   View Recommended Resources <ChevronRight size={16}/>
                 </button>
               </div>
            </Card>

          </div>
        </motion.div>
      </div>
    </AppShell>
  )
}
