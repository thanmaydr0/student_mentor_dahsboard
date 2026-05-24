import { type HTMLAttributes, type ReactNode } from 'react'
import { cn } from '../../lib/utils'

export interface CardProps extends HTMLAttributes<HTMLDivElement> {
  title?: string
  action?: ReactNode
}

export default function Card({ title, action, className, children, ...props }: CardProps) {
  return (
    <div
      className={cn(
        'rounded-2xl border border-slate-100 bg-white dark:border-white/5 dark:bg-[#13151a]/80 dark:shadow-[0_4px_30px_rgba(0,0,0,0.5)] dark:backdrop-blur-md p-6 shadow-card transition-colors duration-300',
        className
      )}
      {...props}
    >
      {(title || action) && (
        <div className="mb-4 flex items-center justify-between">
          {title && <h3 className="text-lg font-semibold text-brand-900 dark:text-white">{title}</h3>}
          {action && <div>{action}</div>}
        </div>
      )}
      {children}
    </div>
  )
}
