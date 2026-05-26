import React from 'react'
import { motion } from 'framer-motion'
import { CalendarDays, CreditCard, BookOpen, GraduationCap, Clock, AlertCircle } from 'lucide-react'
import { useQuery } from '@tanstack/react-query'
import AppShell from '../../components/layout/AppShell'
import Card from '../../components/ui/Card'
import { supabase } from '../../lib/supabase'
import { cn } from '../../lib/utils'

export default function SmartDeadlinesPage() {
  const { data: upcomingDeadlines = [], isLoading } = useQuery({
    queryKey: ['academic-deadlines'],
    queryFn: async () => {
      const { data, error } = await supabase
        .from('academic_deadlines')
        .select('*')
        .order('date', { ascending: true })
      
      if (error) throw error
      return data
    }
  })
  const getIcon = (type: string) => {
    switch(type) {
      case 'fee': return <CreditCard size={20} />;
      case 'exam': return <BookOpen size={20} />;
      case 'scholarship': return <GraduationCap size={20} />;
      default: return <CalendarDays size={20} />;
    }
  }

  const getColorClass = (type: string, part: 'bg' | 'text' | 'border' | 'gradient') => {
    switch(type) {
      case 'fee': 
        if (part === 'bg') return 'bg-rose-50 dark:bg-rose-950/20'
        if (part === 'text') return 'text-rose-600 dark:text-rose-400'
        if (part === 'border') return 'border-rose-200 dark:border-rose-900/30'
        return 'from-rose-500 to-red-600'
      case 'exam': 
        if (part === 'bg') return 'bg-indigo-50 dark:bg-indigo-950/20'
        if (part === 'text') return 'text-indigo-600 dark:text-indigo-400'
        if (part === 'border') return 'border-indigo-200 dark:border-indigo-900/30'
        return 'from-indigo-500 to-purple-600'
      case 'scholarship': 
        if (part === 'bg') return 'bg-emerald-50 dark:bg-emerald-950/20'
        if (part === 'text') return 'text-emerald-600 dark:text-emerald-400'
        if (part === 'border') return 'border-emerald-200 dark:border-emerald-900/30'
        return 'from-emerald-500 to-teal-600'
      default: 
        return 'bg-slate-50 text-slate-600 border-slate-200 from-slate-500 to-slate-600'
    }
  }

  return (
    <AppShell role="parent">
      <div className="max-w-4xl mx-auto flex flex-col gap-8 pb-10">
        
        {/* Header */}
        <div className="flex flex-col gap-3 border-b border-slate-200 dark:border-white/10 pb-6 shrink-0">
          <h1 className="text-3xl font-bold text-slate-900 dark:text-white flex items-center gap-3">
            <div className="p-2.5 bg-gradient-to-br from-sky-500 to-blue-600 rounded-xl shadow-sm text-white">
              <CalendarDays size={24} />
            </div>
            Smart Deadlines
          </h1>
          <p className="text-slate-500 dark:text-slate-400 max-w-2xl text-sm leading-relaxed">
            Never miss an important university deadline again. We aggregate all critical dates for fee payments, exam registrations, and scholarships in one place.
          </p>
        </div>

        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} className="space-y-6">
          
          <div className="flex items-center justify-between mb-2">
            <h2 className="text-lg font-bold text-slate-900 dark:text-white">Upcoming Timeline</h2>
            <div className="flex items-center gap-2 text-sm font-semibold text-slate-500">
               <Clock size={16} /> Auto-syncing with VTU Calendar
            </div>
          </div>

          <div className="relative before:absolute before:inset-0 before:ml-[28px] before:-translate-x-px md:before:mx-auto md:before:translate-x-0 before:h-full before:w-1 before:bg-gradient-to-b before:from-slate-200 before:via-slate-200 before:to-transparent dark:before:from-white/10 dark:before:via-white/10 space-y-8">
            
            {isLoading && <p className="text-center text-slate-500 py-10">Loading deadlines...</p>}
            
            {!isLoading && upcomingDeadlines.length === 0 && (
               <p className="text-center text-slate-500 py-10">No upcoming deadlines.</p>
            )}

            {upcomingDeadlines.map((item: any) => (
              <div key={item.id} className="relative flex items-center justify-between md:justify-normal md:odd:flex-row-reverse group is-active">
                
                {/* Timeline Dot */}
                <div className={cn(
                  "flex items-center justify-center w-14 h-14 rounded-full border-4 border-white dark:border-[#0c0d10] shadow-md shrink-0 md:order-1 md:group-odd:-translate-x-1/2 md:group-even:translate-x-1/2 z-10 text-white",
                  `bg-gradient-to-br ${getColorClass(item.type, 'gradient')}`
                )}>
                  {getIcon(item.type)}
                </div>
                
                {/* Content Card */}
                <Card className={cn(
                  "w-[calc(100%-4rem)] md:w-[calc(50%-2.5rem)] p-6 transition-all hover:shadow-lg border-2",
                  item.status === 'urgent' ? 'border-rose-400 dark:border-rose-500/50 shadow-rose-100 dark:shadow-rose-900/20' : 'border-transparent hover:border-slate-200 dark:hover:border-white/10'
                )}>
                  <div className="flex items-center justify-between mb-3">
                    <span className={cn(
                      "px-3 py-1 rounded-full text-xs font-bold uppercase tracking-wider",
                      getColorClass(item.type, 'bg'),
                      getColorClass(item.type, 'text'),
                      getColorClass(item.type, 'border'),
                      "border"
                    )}>
                      {item.type}
                    </span>
                    {item.status === 'urgent' && (
                      <span className="flex items-center gap-1 text-xs font-bold text-rose-600 dark:text-rose-400 animate-pulse">
                        <AlertCircle size={14} /> ACTION REQUIRED
                      </span>
                    )}
                  </div>
                  
                  <h3 className="text-xl font-bold text-slate-900 dark:text-white mb-1">{item.title}</h3>
                  <p className="text-sm font-bold text-slate-500 dark:text-slate-400 mb-4 flex items-center gap-2">
                    <CalendarDays size={16} /> Due: {item.date}
                  </p>
                  
                  <p className="text-sm text-slate-600 dark:text-slate-300 leading-relaxed mb-4">
                    {item.description}
                  </p>
                  
                  {item.amount && (
                    <div className="inline-flex items-center gap-2 px-4 py-2 bg-slate-50 dark:bg-white/5 rounded-lg border border-slate-200 dark:border-white/10 mb-4">
                      <span className="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">Amount Due:</span>
                      <span className="text-lg font-black text-slate-900 dark:text-white">{item.amount}</span>
                    </div>
                  )}

                  <div className="pt-4 border-t border-slate-100 dark:border-white/10">
                    <button className={cn(
                      "w-full py-2.5 rounded-lg font-bold text-sm text-white shadow-sm transition-all",
                      item.status === 'urgent' ? 'bg-rose-600 hover:bg-rose-700' : 'bg-brand-600 hover:bg-brand-700'
                    )}>
                      {item.type === 'fee' ? 'Pay Now via Portal' : 'View Details'}
                    </button>
                  </div>
                </Card>

              </div>
            ))}

          </div>

        </motion.div>
      </div>
    </AppShell>
  )
}
