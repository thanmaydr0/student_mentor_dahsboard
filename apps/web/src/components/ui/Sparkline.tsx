import { cn } from '../../lib/utils'

interface SparklineProps {
  data: number[]
  labels?: string[]
  max?: number
  min?: number
  color?: string
  height?: number
  width?: number
  showDots?: boolean
  showArea?: boolean
  className?: string
}

export default function Sparkline({
  data,
  labels,
  max: maxProp,
  min: minProp,
  color = '#6366f1',
  height = 40,
  width = 120,
  showDots = true,
  showArea = true,
  className,
}: SparklineProps) {
  if (!data || data.length === 0) {
    return (
      <div className={cn('flex items-center justify-center text-[10px] text-slate-400 font-medium', className)} style={{ width, height }}>
        No data
      </div>
    )
  }

  const pad = 4
  const dotR = 2.5
  const w = width - pad * 2
  const h = height - pad * 2

  const mn = minProp ?? (Math.min(...data) * 0.9)
  const mx = maxProp ?? (Math.max(...data) * 1.1) || 1

  const points = data.map((v, i) => ({
    x: pad + (data.length === 1 ? w / 2 : (i / (data.length - 1)) * w),
    y: pad + h - ((v - mn) / (mx - mn)) * h,
  }))

  const linePath = points.map((p, i) => `${i === 0 ? 'M' : 'L'} ${p.x} ${p.y}`).join(' ')
  const areaPath = `${linePath} L ${points[points.length - 1].x} ${pad + h} L ${points[0].x} ${pad + h} Z`

  return (
    <div className={cn('relative', className)}>
      <svg width={width} height={height} viewBox={`0 0 ${width} ${height}`}>
        {showArea && (
          <path d={areaPath} fill={color} opacity={0.1} />
        )}
        <path d={linePath} fill="none" stroke={color} strokeWidth={1.5} strokeLinecap="round" strokeLinejoin="round" />
        {showDots && points.map((p, i) => (
          <circle key={i} cx={p.x} cy={p.y} r={dotR} fill={color} />
        ))}
      </svg>
      {labels && labels.length > 0 && (
        <div className="flex justify-between px-1 mt-0.5">
          {labels.map((l, i) => (
            <span key={i} className="text-[8px] text-slate-400 font-medium">{l}</span>
          ))}
        </div>
      )}
    </div>
  )
}
