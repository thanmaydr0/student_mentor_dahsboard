import { Sun, Moon } from 'lucide-react'
import { motion } from 'framer-motion'
import { useTheme } from '../../context/ThemeContext'

export default function ThemeToggle() {
  const { theme, toggleTheme } = useTheme()

  return (
    <div className="flex items-center gap-2">
      <div className="relative flex rounded-full bg-slate-100 dark:bg-white/5 p-1 border border-brand-100 dark:border-white/10 backdrop-blur-md">
        {/* Sliding Indicator */}
        <motion.div
          layout
          transition={{ type: 'spring', stiffness: 350, damping: 25 }}
          className="absolute top-1 bottom-1 rounded-full bg-white dark:bg-amber-400 shadow-sm"
          style={{
            left: theme === 'light' ? '4px' : 'calc(50% + 2px)',
            width: 'calc(50% - 6px)',
          }}
        />

        {/* Light Option */}
        <button
          onClick={() => theme !== 'light' && toggleTheme()}
          className={`relative z-10 flex items-center justify-center gap-2 px-3 py-1.5 text-xs font-semibold rounded-full transition-colors duration-200 ${
            theme === 'light'
              ? 'text-brand-900'
              : 'text-slate-400 hover:text-slate-200'
          }`}
          aria-label="Light Mode"
        >
          <Sun size={14} className={theme === 'light' ? 'text-amber-500' : ''} />
          <span>Light</span>
        </button>

        {/* Dark Option */}
        <button
          onClick={() => theme !== 'dark' && toggleTheme()}
          className={`relative z-10 flex items-center justify-center gap-2 px-3 py-1.5 text-xs font-semibold rounded-full transition-colors duration-200 ${
            theme === 'dark'
              ? 'text-black font-bold'
              : 'text-brand-500 hover:text-brand-900'
          }`}
          aria-label="Dark Mode"
        >
          <Moon size={14} className={theme === 'dark' ? 'text-black fill-black' : ''} />
          <span>Dark</span>
        </button>
      </div>
    </div>
  )
}
