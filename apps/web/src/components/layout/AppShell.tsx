import { useState, type ReactNode } from 'react'
import Sidebar from './Sidebar'
import TopBar from './TopBar'
import { useTheme } from '../../context/ThemeContext'
import LightRays from '../ui/LightRays'

interface AppShellProps {
  role: 'student' | 'mentor'
  children: ReactNode
}

export default function AppShell({ role, children }: AppShellProps) {
  const [isSidebarOpen, setIsSidebarOpen] = useState(false)
  const { theme } = useTheme()

  // Use a title for TopBar. Might need dynamic logic later.
  const topBarTitle = "EduPredict" 

  return (
    <div className="relative flex min-h-screen font-sans bg-surface-50 text-slate-900 dark:bg-slate-950 dark:text-slate-100 transition-colors duration-300 overflow-x-hidden">
      
      {/* Cinematic WebGL LightRays background for dark mode */}
      {theme === 'dark' && (
        <div className="fixed inset-0 z-0 pointer-events-none overflow-hidden bg-gradient-to-br from-[#07080a] via-[#0c0d10] to-[#11141b]">
          {/* Gold ray on the left */}
          <LightRays
            raysOrigin="top-left"
            raysColor="#d97706"
            raysSpeed={0.7}
            lightSpread={1.4}
            rayLength={1.7}
            followMouse={true}
            mouseInfluence={0.15}
            noiseAmount={0.01}
            distortion={0.04}
            className="opacity-40"
          />
          {/* Cyan ray on the right */}
          <LightRays
            raysOrigin="top-right"
            raysColor="#0891b2"
            raysSpeed={0.9}
            lightSpread={1.2}
            rayLength={1.7}
            followMouse={true}
            mouseInfluence={0.15}
            noiseAmount={0.01}
            distortion={0.03}
            className="opacity-35"
          />
        </div>
      )}

      {/* Main content layer positioned above the background effect */}
      <div className="relative z-10 flex flex-1 w-full min-h-screen">
        <Sidebar 
          role={role} 
          isOpen={isSidebarOpen} 
          onClose={() => setIsSidebarOpen(false)} 
        />

        <div className="flex flex-1 flex-col md:pl-[240px] w-full">
          <TopBar 
            onMenuClick={() => setIsSidebarOpen(true)} 
            title={topBarTitle}
          />
          
          <main className="flex-1 p-4 md:p-8">
            <div className="mx-auto max-w-6xl">
              {children}
            </div>
          </main>
        </div>
      </div>
    </div>
  )
}
