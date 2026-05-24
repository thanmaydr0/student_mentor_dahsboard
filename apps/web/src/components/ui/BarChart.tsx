import { motion } from 'framer-motion'
import { cn } from '../../lib/utils'

interface BarItem {
  label: string
  value: number
  isYou?: boolean
}

interface BarChartProps {
  data: BarItem[]
  max: number
  unit?: string
  threshold?: number
  thresholdLabel?: string
  barColor?: string
  dangerColor?: string
  className?: string
}

export default function BarChart({
  data,
  max,
  unit = '',
  threshold,
  thresholdLabel,
  barColor = '#6366f1',
  dangerColor = '#ef4444',
  className,
}: BarChartProps) {
  if (!data || data.length === 0) {
    return (
      <div className={cn('flex items-center justify-center text-xs text-slate-400 py-6', className)}>
        No data available
      </div>
    )
  }

  const chartH = 180
  const barGap = data.length > 15 ? 2 : 4
  const labelH = 28
  const yAxisW = 40
  const topPad = 8

  // Y-axis ticks
  const ticks = [0, 0.25, 0.5, 0.75, 1].map(f => Math.round(max * f))

  const belowThreshold = threshold != null ? data.filter(d => d.value < threshold).length : 0

  return (
    <div className={cn('w-full', className)}>
      {/* Threshold warning */}
      {threshold != null && belowThreshold > 0 && (
        <div className="flex items-center gap-2 mb-3 px-3 py-2 rounded-lg bg-red-50 border border-red-100 text-xs font-semibold text-red-700">
          <span>⚠️</span>
          <span>{belowThreshold} student{belowThreshold > 1 ? 's' : ''} below the {thresholdLabel || `${threshold}${unit}`} threshold.</span>
        </div>
      )}

      <div className="flex" style={{ height: chartH + labelH + topPad }}>
        {/* Y-axis */}
        <div className="flex flex-col justify-between shrink-0 pr-1 pb-7 pt-1" style={{ width: yAxisW, height: chartH + topPad }}>
          {ticks.slice().reverse().map((t, i) => (
            <span key={i} className="text-[10px] text-slate-400 font-medium text-right leading-none">
              {t}{unit}
            </span>
          ))}
        </div>

        {/* Chart area */}
        <div className="flex-1 relative">
          {/* Grid lines */}
          <div className="absolute inset-0" style={{ bottom: labelH }}>
            {ticks.map((t, i) => (
              <div
                key={i}
                className="absolute w-full border-t border-dashed border-slate-100"
                style={{ top: `${(1 - t / max) * 100}%` }}
              />
            ))}
            {/* Threshold line */}
            {threshold != null && (
              <div
                className="absolute w-full border-t-2 border-red-300 z-10"
                style={{ top: `${(1 - threshold / max) * 100}%` }}
              >
                <span className="absolute -top-4 right-0 text-[9px] font-bold text-red-400 bg-white px-1 rounded">
                  {threshold}{unit}
                </span>
              </div>
            )}
          </div>

          {/* Bars */}
          <div className="relative flex items-end h-full" style={{ paddingBottom: labelH }}>
            <div className="flex items-end justify-around w-full h-full gap-px" style={{ paddingTop: topPad }}>
              {data.map((item, i) => {
                const pct = Math.min(100, Math.max(0, (item.value / max) * 100))
                const isBelowThreshold = threshold != null && item.value < threshold

                return (
                  <div key={i} className="flex flex-col items-center flex-1 h-full justify-end group relative">
                    {/* Tooltip */}
                    <div className="absolute -top-1 opacity-0 group-hover:opacity-100 transition-opacity z-20 pointer-events-none">
                      <div className="bg-slate-800 text-white text-[10px] font-bold px-2 py-1 rounded-md shadow-lg whitespace-nowrap">
                        {item.label}: {item.value}{unit}
                      </div>
                    </div>

                    {/* Bar */}
                    <motion.div
                      initial={{ height: 0 }}
                      animate={{ height: `${pct}%` }}
                      transition={{ duration: 0.5, delay: i * 0.03, ease: 'circOut' }}
                      className={cn(
                        'w-full rounded-t-md cursor-pointer transition-opacity hover:opacity-80',
                        data.length > 20 ? 'max-w-[12px]' : data.length > 12 ? 'max-w-[18px]' : 'max-w-[28px]'
                      )}
                      style={{
                        backgroundColor: isBelowThreshold ? dangerColor : (item.isYou ? '#818cf8' : barColor),
                        marginLeft: barGap / 2,
                        marginRight: barGap / 2,
                        border: item.isYou ? '2px solid #4f46e5' : 'none',
                        boxShadow: item.isYou ? '0 0 8px rgba(99,102,241,0.4)' : 'none',
                      }}
                    />

                    {/* Label */}
                    <div className="mt-1.5 flex flex-col items-center" style={{ height: labelH - 4 }}>
                      <span className={cn(
                        'text-[8px] font-bold leading-tight text-center truncate w-full',
                        item.isYou ? 'text-indigo-600' : 'text-slate-500'
                      )} style={{ maxWidth: 36 }}>
                        {item.label.split(' ')[0]}
                      </span>
                      {item.isYou && (
                        <span className="text-[7px] font-black text-indigo-500 bg-indigo-50 px-1 rounded mt-0.5">YOU</span>
                      )}
                    </div>
                  </div>
                )
              })}
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}
