import React, { useState, useEffect } from 'react'
import { motion } from 'framer-motion'
import { TrendingUp, Compass, Target, Info, Sparkles, Loader2, AlertTriangle, CheckCircle2 } from 'lucide-react'
import AppShell from '../../components/layout/AppShell'
import Card from '../../components/ui/Card'
import { useAuth } from '../../hooks/useAuth'
import { AreaChart, Area, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, ReferenceLine } from 'recharts'
import { supabase } from '../../lib/supabase'
import { cn } from '../../lib/utils'

export default function AcademicGPSPage() {
  const { user } = useAuth()
  const [isLoading, setIsLoading] = useState(true)
  const [predictionData, setPredictionData] = useState<any[]>([])
  const [insights, setInsights] = useState<{ positive: string[], attention: string[] }>({ positive: [], attention: [] })
  const [studentId, setStudentId] = useState<string | null>(null)

  useEffect(() => {
    async function fetchTrajectory() {
      try {
        // Fetch the linked student for this parent
        const { data: linkData } = await supabase
          .from('parent_student_links')
          .select('student_id')
          .eq('parent_id', user?.id)
          .single()

        if (!linkData) return

        setStudentId(linkData.student_id)

        // Invoke Edge Function
        const { data, error } = await supabase.functions.invoke('predict-trajectory', {
          body: { student_id: linkData.student_id }
        })

        if (error) throw error

        setPredictionData(data.data)
        setInsights(data.insights)
      } catch (e) {
        console.error('Error fetching trajectory', e)
      } finally {
        setIsLoading(false)
      }
    }
    
    if (user?.id) fetchTrajectory()
  }, [user?.id])

  const currentCGPA = predictionData.filter(d => d.cgpa !== null).pop()?.cgpa || 0
  const projectedCGPA = predictionData[predictionData.length - 1]?.predicted || 0

  return (
    <AppShell role="parent">
      <div className="max-w-6xl mx-auto flex flex-col gap-8 pb-10">
        
        {/* Header */}
        <div className="flex flex-col gap-3 border-b border-slate-200 dark:border-white/10 pb-6">
          <h1 className="text-3xl font-bold text-slate-900 dark:text-white flex items-center gap-3">
            <div className="p-2.5 bg-gradient-to-br from-indigo-500 to-brand-600 rounded-xl shadow-sm text-white">
               <TrendingUp size={24} />
            </div>
            Academic GPS
          </h1>
          <p className="text-slate-500 dark:text-slate-400 max-w-2xl text-sm leading-relaxed">
            Our AI analyzes past performance, current attendance trends, and internal assessment trajectories to forecast your child's graduation outcomes. Track if they are meeting the minimum criteria for campus placements.
          </p>
        </div>

        {isLoading ? (
          <div className="flex flex-col items-center justify-center py-20 bg-white dark:bg-white/5 rounded-3xl border border-slate-100 dark:border-white/10 shadow-sm">
            <div className="relative">
              <Compass size={48} className="text-brand-500/50 animate-pulse" />
              <div className="absolute inset-0 border-t-2 border-brand-500 rounded-full animate-spin"></div>
            </div>
            <p className="text-slate-600 dark:text-slate-400 mt-6 font-semibold animate-pulse tracking-wide">
              AI Engine calculating future trajectories...
            </p>
          </div>
        ) : (
          <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} className="space-y-8">
            
            {/* Top Stats */}
            <div className="grid grid-cols-1 sm:grid-cols-3 gap-6">
              <Card className="p-6 relative overflow-hidden flex flex-col justify-between group">
                <div className="absolute right-0 top-0 w-32 h-32 bg-brand-50 dark:bg-brand-900/20 rounded-bl-[100px] -z-10 transition-transform group-hover:scale-110"></div>
                <div>
                  <p className="text-xs uppercase tracking-wider font-bold text-slate-500 dark:text-slate-400 flex items-center gap-1.5"><Target size={14}/> Target CGPA</p>
                  <p className="text-4xl font-black text-slate-900 dark:text-white mt-3">7.50</p>
                </div>
                <p className="text-xs text-slate-500 dark:text-slate-400 mt-4 font-medium">Minimum threshold required for Tier-1 placements.</p>
              </Card>
              
              <Card className="p-6 relative overflow-hidden flex flex-col justify-between group">
                <div className="absolute right-0 top-0 w-32 h-32 bg-indigo-50 dark:bg-indigo-900/20 rounded-bl-[100px] -z-10 transition-transform group-hover:scale-110"></div>
                <div>
                  <p className="text-xs uppercase tracking-wider font-bold text-slate-500 dark:text-slate-400 flex items-center gap-1.5"><TrendingUp size={14}/> Current CGPA</p>
                  <p className="text-4xl font-black text-indigo-700 dark:text-indigo-400 mt-3">{currentCGPA.toFixed(2)}</p>
                </div>
                <p className="text-xs text-indigo-600 dark:text-indigo-400 mt-4 font-bold flex items-center gap-1.5"><CheckCircle2 size={14}/> {currentCGPA >= 7.5 ? `+${(currentCGPA - 7.5).toFixed(2)} above target` : `${(7.5 - currentCGPA).toFixed(2)} below target`}</p>
              </Card>

              <Card className="p-6 relative overflow-hidden flex flex-col justify-between group bg-gradient-to-br from-brand-600 to-indigo-800 text-white border-0 shadow-lg shadow-brand-500/20">
                <div className="absolute right-[-20px] top-[-20px] w-40 h-40 bg-white/10 rounded-full blur-2xl -z-10"></div>
                <div>
                  <p className="text-xs uppercase tracking-wider font-bold text-brand-100 flex items-center gap-1.5"><Sparkles size={14}/> AI Projected CGPA</p>
                  <p className="text-4xl font-black text-white mt-3 flex items-baseline gap-2">
                    {projectedCGPA.toFixed(2)} <span className="text-sm font-medium text-brand-200">/ 10</span>
                  </p>
                </div>
                <p className="text-xs text-brand-100 mt-4 font-medium leading-relaxed">Based on current strong attendance and upward quiz score trends.</p>
              </Card>
            </div>

            {/* AI Chart */}
            <Card className="p-6 sm:p-8">
              <div className="flex flex-col sm:flex-row sm:items-center justify-between mb-8 gap-4">
                <div>
                  <h3 className="text-lg font-bold text-slate-900 dark:text-white flex items-center gap-2">
                    Trajectory Forecast Model
                  </h3>
                  <p className="text-sm text-slate-500 dark:text-slate-400 mt-1">Historical actuals vs machine-learning projections</p>
                </div>
                <div className="flex items-center gap-4 text-xs font-semibold text-slate-600 dark:text-slate-300">
                  <div className="flex items-center gap-2"><div className="w-3 h-3 rounded-full bg-slate-800 dark:bg-slate-200"></div> Actual CGPA</div>
                  <div className="flex items-center gap-2"><div className="w-3 h-3 rounded-full bg-brand-500"></div> Projected (AI)</div>
                  <div className="flex items-center gap-2"><div className="w-3 h-0.5 bg-red-400 border border-dashed"></div> Placement Cutoff</div>
                </div>
              </div>

              <div className="h-[400px] w-full">
                <ResponsiveContainer width="100%" height="100%">
                  <AreaChart data={predictionData} margin={{ top: 20, right: 30, left: 0, bottom: 0 }}>
                    <defs>
                      <linearGradient id="colorActual" x1="0" y1="0" x2="0" y2="1">
                        <stop offset="5%" stopColor="#1e293b" stopOpacity={0.3}/>
                        <stop offset="95%" stopColor="#1e293b" stopOpacity={0}/>
                      </linearGradient>
                      <linearGradient id="colorPredicted" x1="0" y1="0" x2="0" y2="1">
                        <stop offset="5%" stopColor="#6366f1" stopOpacity={0.3}/>
                        <stop offset="95%" stopColor="#6366f1" stopOpacity={0}/>
                      </linearGradient>
                    </defs>
                    <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#e2e8f0" />
                    <XAxis dataKey="semester" axisLine={false} tickLine={false} tick={{ fontSize: 12, fill: '#64748b' }} dy={10} />
                    <YAxis domain={[5, 10]} axisLine={false} tickLine={false} tick={{ fontSize: 12, fill: '#64748b' }} dx={-10} />
                    <Tooltip 
                      contentStyle={{ borderRadius: '12px', border: 'none', boxShadow: '0 10px 15px -3px rgb(0 0 0 / 0.1)' }}
                      labelStyle={{ fontWeight: 'bold', color: '#0f172a', marginBottom: '8px' }}
                    />
                    <ReferenceLine y={7.5} stroke="#ef4444" strokeDasharray="4 4" label={{ position: 'insideTopRight', value: '7.5 Tier-1 Cutoff', fill: '#ef4444', fontSize: 11, fontWeight: 'bold' }} />
                    <Area type="monotone" dataKey="cgpa" stroke="#1e293b" strokeWidth={3} fillOpacity={1} fill="url(#colorActual)" activeDot={{ r: 6 }} name="Actual CGPA" connectNulls />
                    <Area type="monotone" dataKey="predicted" stroke="#6366f1" strokeWidth={3} strokeDasharray="5 5" fillOpacity={1} fill="url(#colorPredicted)" activeDot={{ r: 6 }} name="Predicted CGPA" connectNulls />
                  </AreaChart>
                </ResponsiveContainer>
              </div>
            </Card>

            {/* AI Insights */}
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <Card className="p-6 bg-emerald-50/50 dark:bg-emerald-950/10 border-emerald-100 dark:border-emerald-900/30">
                <h4 className="font-bold text-emerald-900 dark:text-emerald-400 flex items-center gap-2 mb-4">
                  <TrendingUp size={18} /> Positive Trajectories
                </h4>
                <ul className="space-y-3 text-sm text-emerald-800 dark:text-emerald-300">
                  {insights.positive.map((text, i) => (
                    <li key={i} className="flex items-start gap-2"><span className="mt-1 font-bold">•</span> {text}</li>
                  ))}
                  {insights.positive.length === 0 && (
                    <li className="flex items-start gap-2"><span className="mt-1 font-bold">•</span> No specific positive trends identified currently.</li>
                  )}
                </ul>
              </Card>

              <Card className="p-6 bg-amber-50/50 dark:bg-amber-950/10 border-amber-100 dark:border-amber-900/30">
                <h4 className="font-bold text-amber-900 dark:text-amber-400 flex items-center gap-2 mb-4">
                  <AlertTriangle size={18} /> Attention Areas
                </h4>
                <ul className="space-y-3 text-sm text-amber-800 dark:text-amber-300">
                  {insights.attention.map((text, i) => (
                    <li key={i} className="flex items-start gap-2"><span className="mt-1 font-bold">•</span> {text}</li>
                  ))}
                  {insights.attention.length === 0 && (
                    <li className="flex items-start gap-2"><span className="mt-1 font-bold">•</span> No major risk areas identified. Keep it up!</li>
                  )}
                </ul>
              </Card>
            </div>

          </motion.div>
        )}
      </div>
    </AppShell>
  )
}
