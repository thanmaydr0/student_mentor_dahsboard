import { useState } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { Search, Play, BookOpen, Star, X, Clock, Video } from 'lucide-react'

const MOCK_VIDEOS = [
  { id: 'HG68Ymazo18', title: 'How to Answer "Tell Me About Yourself"', author: 'CareerVidz', thumb: 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=600&auto=format&fit=crop&q=80', duration: '12:45' },
  { id: '8PiewhNV7s0', title: 'The STAR Method for Behavioral Interviews', author: 'Dan Croitor', thumb: 'https://images.unsplash.com/photo-1542744173-8e7e53415bb0?w=600&auto=format&fit=crop&q=80', duration: '08:20' },
  { id: 'XY52padHVzQ', title: 'Salary Negotiation Strategies', author: 'Harvard Business Review', thumb: 'https://images.unsplash.com/photo-1554224155-8d04cb21cd6c?w=600&auto=format&fit=crop&q=80', duration: '15:10' },
  { id: 'Tt08KmFfIYQ', title: 'Top 10 Resume Mistakes to Avoid', author: 'Jeff Su', thumb: 'https://images.unsplash.com/photo-1586281380349-632531db7ed4?w=600&auto=format&fit=crop&q=80', duration: '10:05' },
]

export default function InterviewPrepPage() {
  const [query, setQuery] = useState('')
  const [videos, setVideos] = useState(MOCK_VIDEOS)
  const [playingVideoId, setPlayingVideoId] = useState<string | null>(null)

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault()
    if (!query) setVideos(MOCK_VIDEOS)
    else setVideos(MOCK_VIDEOS.filter(v => v.title.toLowerCase().includes(query.toLowerCase())))
  }

  return (
    <div className="flex flex-col gap-12 pb-10 h-full">
      
      {/* Search Header */}
      <motion.div initial={{ opacity: 0, y: -10 }} animate={{ opacity: 1, y: 0 }} className="flex justify-end mb-2">
        <form onSubmit={handleSearch} className="flex relative w-full md:w-96 group">
           <input 
             type="text" 
             placeholder="Search masterclasses..." 
             value={query}
             onChange={e => setQuery(e.target.value)}
             className="w-full pl-14 pr-5 py-4 bg-white/70 dark:bg-[#1a1d24]/80 backdrop-blur-2xl border border-slate-200/50 dark:border-white/5 rounded-2xl focus:border-brand-500 dark:focus:border-cyan-500 outline-none text-sm font-bold text-slate-900 dark:text-white shadow-[0_8px_30px_rgba(0,0,0,0.05)] dark:shadow-[0_8px_30px_rgba(0,0,0,0.4)] transition-all"
           />
           <Search size={20} className="absolute left-5 top-4 text-slate-400 group-focus-within:text-brand-500 dark:group-focus-within:text-cyan-500 transition-colors" />
           <button type="submit" className="hidden">Search</button>
        </form>
      </motion.div>

      {/* Video Grid */}
      <div>
         <motion.h2 initial={{ opacity: 0 }} animate={{ opacity: 1 }} className="text-sm font-black tracking-widest uppercase text-slate-400 dark:text-slate-500 mb-6 pl-1 flex items-center gap-2">
           <Video size={16} className="text-brand-500 dark:text-cyan-500" /> Featured Masterclasses
         </motion.h2>
         <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
            <AnimatePresence>
              {videos.map((video, idx) => (
                <motion.div 
                  key={video.id} 
                  initial={{ opacity: 0, y: 20, scale: 0.95 }}
                  animate={{ opacity: 1, y: 0, scale: 1 }}
                  transition={{ delay: idx * 0.1, type: 'spring', stiffness: 300, damping: 24 }}
                  onClick={() => setPlayingVideoId(video.id)}
                  className="group relative cursor-pointer"
                >
                   {/* Hover Glow */}
                   <div className="absolute inset-0 bg-brand-500/20 dark:bg-cyan-500/20 blur-2xl rounded-[2rem] opacity-0 group-hover:opacity-100 transition-opacity duration-500 -z-10" />
                   
                   <div className="bg-white dark:bg-[#12141a] rounded-[2rem] border border-slate-200/50 dark:border-white/5 overflow-hidden shadow-lg transition-all duration-500 transform group-hover:-translate-y-2 group-hover:shadow-2xl">
                     <div className="relative h-56 overflow-hidden">
                        <img src={video.thumb} alt={video.title} className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-1000 ease-out" />
                        <div className="absolute inset-0 bg-gradient-to-t from-black/90 via-black/20 to-transparent transition-colors duration-500" />
                        
                        {/* Play Button Overlay */}
                        <div className="absolute inset-0 flex items-center justify-center">
                           <div className="w-16 h-16 bg-white/10 backdrop-blur-md rounded-full flex items-center justify-center border border-white/20 transform scale-75 opacity-0 group-hover:scale-100 group-hover:opacity-100 transition-all duration-300">
                              <Play size={24} className="text-white ml-1" fill="currentColor" />
                           </div>
                        </div>

                        <div className="absolute bottom-4 right-4 px-3 py-1.5 bg-black/60 backdrop-blur-md rounded-lg text-xs font-black tracking-widest text-white flex items-center gap-2 border border-white/10">
                           <Clock size={12} className="text-cyan-400" /> {video.duration}
                        </div>
                     </div>
                     <div className="p-6">
                        <h3 className="font-black text-slate-900 dark:text-white line-clamp-2 leading-snug group-hover:text-brand-600 dark:group-hover:text-cyan-400 transition-colors text-lg">{video.title}</h3>
                        <p className="text-xs font-bold text-slate-500 dark:text-slate-400 mt-4 flex items-center gap-2 uppercase tracking-widest">
                          <span className="w-2 h-2 rounded-full bg-brand-500 dark:bg-cyan-500 animate-pulse" /> {video.author}
                        </p>
                     </div>
                   </div>
                </motion.div>
              ))}
            </AnimatePresence>
         </div>
      </div>

      {/* Templates Section */}
      <div className="pt-12">
         <motion.h2 initial={{ opacity: 0 }} animate={{ opacity: 1 }} className="text-sm font-black tracking-widest uppercase text-slate-400 dark:text-slate-500 mb-6 pl-1 flex items-center gap-2">
           <Star size={16} className="text-brand-500 dark:text-cyan-500" /> Premium Templates
         </motion.h2>
         <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            {['Software Engineering', 'Data Science', 'Product Management'].map((industry, idx) => (
               <motion.div 
                 key={industry} 
                 initial={{ opacity: 0, y: 20 }}
                 animate={{ opacity: 1, y: 0 }}
                 transition={{ delay: 0.3 + idx * 0.1 }}
                 className="p-8 rounded-[2rem] bg-white/70 dark:bg-[#12141a]/80 backdrop-blur-2xl border border-slate-200/50 dark:border-white/5 shadow-lg hover:shadow-2xl transition-all duration-500 cursor-pointer group relative overflow-hidden"
               >
                  <div className="absolute -right-12 -top-12 w-40 h-40 bg-brand-500/10 dark:bg-cyan-500/10 rounded-full group-hover:scale-[3] transition-transform duration-1000 ease-out z-0 blur-3xl"></div>
                  <div className="relative z-10">
                    <div className="w-14 h-14 bg-brand-50 dark:bg-[#1a1d24] rounded-2xl flex items-center justify-center mb-6 shadow-sm border border-brand-100 dark:border-white/5 group-hover:scale-110 transition-transform duration-300">
                      <BookOpen size={24} className="text-brand-600 dark:text-cyan-400" />
                    </div>
                    <h3 className="font-black text-xl text-slate-900 dark:text-white mb-3 tracking-tight">{industry}</h3>
                    <p className="text-sm font-medium text-slate-500 dark:text-slate-400 mb-8 leading-relaxed">Highly optimized, industry-standard examples.</p>
                    <span className="inline-flex items-center text-xs font-black tracking-widest uppercase text-brand-600 dark:text-cyan-400 group-hover:text-brand-700 dark:group-hover:text-cyan-300">
                      Explore <span className="ml-2 group-hover:translate-x-2 transition-transform">&rarr;</span>
                    </span>
                  </div>
               </motion.div>
            ))}
         </div>
      </div>

      {/* Cinematic Player */}
      <AnimatePresence>
        {playingVideoId && (
          <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 sm:p-6 bg-black/95 backdrop-blur-2xl">
            <motion.div initial={{ opacity: 0, scale: 0.9, y: 20 }} animate={{ opacity: 1, scale: 1, y: 0 }} exit={{ opacity: 0, scale: 0.9, y: 20 }} className="w-full max-w-6xl bg-black rounded-[2rem] overflow-hidden shadow-2xl relative border border-white/10 ring-1 ring-white/5">
               <button onClick={() => setPlayingVideoId(null)} className="absolute top-6 right-6 text-white/50 hover:text-white p-3 bg-white/10 hover:bg-white/20 rounded-full backdrop-blur-md transition-all z-10 active:scale-95">
                 <X size={24}/>
               </button>
               <div className="relative pt-[56.25%] w-full bg-[#050505]">
                 <iframe 
                   className="absolute inset-0 w-full h-full"
                   src={`https://www.youtube.com/embed/${playingVideoId}?autoplay=1&rel=0&modestbranding=1`} 
                   title="YouTube video player" 
                   frameBorder="0" 
                   allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
                   allowFullScreen
                 ></iframe>
               </div>
            </motion.div>
          </div>
        )}
      </AnimatePresence>

    </div>
  )
}
