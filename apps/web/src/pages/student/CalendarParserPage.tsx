import { useState, useRef, useCallback } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import {
  CalendarDays, Upload, FileUp, FileText, X, Loader2, Sparkles,
  Calendar, ChevronDown, Check, Download, AlertTriangle, PartyPopper,
  GraduationCap, Flag, Landmark, Globe, Clipboard
} from 'lucide-react'
import * as pdfjsLib from 'pdfjs-dist'
import pdfjsWorker from 'pdfjs-dist/build/pdf.worker.min.mjs?url'
import AppShell from '../../components/layout/AppShell'
import { supabase } from '../../lib/supabase'
import { cn } from '../../lib/utils'
import toast from 'react-hot-toast'

// Set up PDF.js worker via Vite's asset import
pdfjsLib.GlobalWorkerOptions.workerSrc = pdfjsWorker

// ─── Types ───
interface CalendarEvent {
  name: string
  start_date: string
  end_date: string | null
  days_off: number
  category: 'national' | 'religious' | 'regional' | 'academic' | 'exam' | 'cultural'
  is_holiday: boolean
  description?: string
}

interface ParsedCalendar {
  institution_name: string
  academic_year: string
  semester: string
  events: CalendarEvent[]
  total_holidays: number
  total_working_days_lost: number
  semester_start: string
  semester_end: string
  summary: string
}

interface UploadedFile {
  name: string
  type: string
  preview?: string
  base64: string
  mime_type: string
  isImage: boolean
  textContent?: string
}

const CATEGORY_META: Record<string, { icon: typeof Flag; color: string; bg: string; label: string }> = {
  national: { icon: Flag, color: 'text-red-700', bg: 'bg-red-50 border-red-100', label: 'National' },
  religious: { icon: Globe, color: 'text-amber-700', bg: 'bg-amber-50 border-amber-100', label: 'Religious' },
  regional: { icon: Landmark, color: 'text-emerald-700', bg: 'bg-emerald-50 border-emerald-100', label: 'Regional' },
  academic: { icon: GraduationCap, color: 'text-blue-700', bg: 'bg-blue-50 border-blue-100', label: 'Academic' },
  exam: { icon: Clipboard, color: 'text-purple-700', bg: 'bg-purple-50 border-purple-100', label: 'Exams' },
  cultural: { icon: PartyPopper, color: 'text-pink-700', bg: 'bg-pink-50 border-pink-100', label: 'Cultural' },
}

const ACCEPTED_IMAGE_TYPES = ['image/jpeg', 'image/png', 'image/webp', 'image/gif']
const ACCEPTED_DOC_TYPES = ['text/plain', 'text/csv', 'application/pdf']
const ALL_ACCEPTED = [...ACCEPTED_IMAGE_TYPES, ...ACCEPTED_DOC_TYPES].join(',')
const MAX_FILES = 10 // higher limit since PDFs can produce multiple pages

// Convert a single PDF page to a PNG base64 string
async function pdfPageToImage(pdfData: ArrayBuffer): Promise<UploadedFile[]> {
  const pdf = await pdfjsLib.getDocument({ data: pdfData }).promise
  const results: UploadedFile[] = []
  const scale = 2 // 2x for high resolution
  for (let i = 1; i <= pdf.numPages; i++) {
    const page = await pdf.getPage(i)
    const viewport = page.getViewport({ scale })
    const canvas = document.createElement('canvas')
    canvas.width = viewport.width
    canvas.height = viewport.height
    const ctx = canvas.getContext('2d')!
    await page.render({ canvasContext: ctx, viewport }).promise
    const dataUrl = canvas.toDataURL('image/png')
    const base64 = dataUrl.split(',')[1]
    results.push({
      name: `pdf-page-${i}.png`,
      type: 'image/png',
      preview: dataUrl,
      base64,
      mime_type: 'image/png',
      isImage: true,
    })
  }
  return results
}

export default function CalendarParserPage() {
  const [calendarText, setCalendarText] = useState('')
  const [uploadedFiles, setUploadedFiles] = useState<UploadedFile[]>([])
  const [isParsing, setIsParsing] = useState(false)
  const [result, setResult] = useState<ParsedCalendar | null>(null)
  const [isDragOver, setIsDragOver] = useState(false)
  const [selectedEvents, setSelectedEvents] = useState<Set<string>>(new Set())
  const [filterCategory, setFilterCategory] = useState<string | null>(null)
  const fileInputRef = useRef<HTMLInputElement>(null)

  const processFile = useCallback(async (file: File): Promise<UploadedFile[] | null> => {
    if (file.size > 10 * 1024 * 1024) {
      toast.error(`${file.name} is too large (max 10 MB)`)
      return null
    }

    // PDFs: convert every page to PNG images
    if (file.type === 'application/pdf') {
      try {
        const arrayBuf = await file.arrayBuffer()
        const pages = await pdfPageToImage(arrayBuf)
        toast.success(`Converted ${pages.length} page(s) from ${file.name}`)
        return pages
      } catch (err) {
        toast.error(`Failed to process PDF: ${file.name}`)
        return null
      }
    }

    const isImage = ACCEPTED_IMAGE_TYPES.includes(file.type)
    return new Promise((resolve) => {
      if (file.type === 'text/plain' || file.type === 'text/csv') {
        const textReader = new FileReader()
        textReader.onload = (e) => {
          const textContent = e.target?.result as string
          const b64Reader = new FileReader()
          b64Reader.onload = (e2) => {
            const dataUrl = e2.target?.result as string
            resolve([{
              name: file.name, type: file.type,
              base64: dataUrl.split(',')[1], mime_type: file.type,
              isImage: false, textContent,
            }])
          }
          b64Reader.readAsDataURL(file)
        }
        textReader.readAsText(file)
        return
      }
      const reader = new FileReader()
      reader.onload = (e) => {
        const dataUrl = e.target?.result as string
        resolve([{
          name: file.name, type: file.type,
          preview: isImage ? dataUrl : undefined,
          base64: dataUrl.split(',')[1], mime_type: file.type, isImage,
        }])
      }
      reader.readAsDataURL(file)
    })
  }, [])

  const handleFiles = useCallback(async (files: FileList | File[]) => {
    const fileArray = Array.from(files)
    const remaining = MAX_FILES - uploadedFiles.length
    if (remaining <= 0) { toast.error(`Maximum ${MAX_FILES} files`); return }
    const results = await Promise.all(fileArray.slice(0, remaining).map(processFile))
    // Flatten since processFile now returns arrays (PDF pages expand to multiple)
    const flat = results.filter(Boolean).flat() as UploadedFile[]
    setUploadedFiles(prev => [...prev, ...flat])
  }, [uploadedFiles.length, processFile])

  const handleDrop = useCallback((e: React.DragEvent) => {
    e.preventDefault(); setIsDragOver(false); handleFiles(e.dataTransfer.files)
  }, [handleFiles])

  const handleParse = async () => {
    if (!calendarText.trim() && uploadedFiles.length === 0) {
      toast.error('Upload a calendar image/document or paste text')
      return
    }
    setIsParsing(true)
    setResult(null)
    try {
      const { data: { session } } = await supabase.auth.getSession()
      if (!session) throw new Error('Not authenticated')

      let combinedText = calendarText
      for (const f of uploadedFiles) {
        if (f.textContent) combinedText += `\n\n--- ${f.name} ---\n${f.textContent}`
      }

      // Send ALL binary files (images + PDFs) to the edge function
      const imagePayloads = uploadedFiles
        .filter(f => !f.textContent) // include images AND PDFs — exclude only text files
        .map(f => ({ data: f.base64, mime_type: f.mime_type }))

      const response = await fetch(
        `${import.meta.env.VITE_SUPABASE_URL}/functions/v1/parse-calendar`,
        {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${session.access_token}`,
          },
          body: JSON.stringify({
            calendar_text: combinedText || undefined,
            images: imagePayloads.length > 0 ? imagePayloads : undefined,
          }),
        }
      )

      if (!response.ok) {
        const errData = await response.json()
        throw new Error(errData.error || 'Failed to parse calendar')
      }

      const data: ParsedCalendar = await response.json()
      setResult(data)
      // Auto-select all holiday events
      setSelectedEvents(new Set(data.events.filter(e => e.is_holiday).map(e => e.name)))
      toast.success(`Found ${data.events.length} events!`)
    } catch (error: any) {
      toast.error(error.message || 'Failed to parse calendar')
    } finally {
      setIsParsing(false)
    }
  }

  const toggleEvent = (name: string) => {
    setSelectedEvents(prev => {
      const next = new Set(prev)
      if (next.has(name)) next.delete(name); else next.add(name)
      return next
    })
  }

  const filteredEvents = result
    ? (filterCategory ? result.events.filter(e => e.category === filterCategory) : result.events)
    : []

  const selectedDaysOff = result
    ? result.events.filter(e => selectedEvents.has(e.name)).reduce((s, e) => s + e.days_off, 0)
    : 0

  const hasInput = calendarText.trim().length > 0 || uploadedFiles.length > 0

  return (
    <AppShell role="student">
      <div className="flex flex-col gap-6 max-w-3xl mx-auto w-full pb-10">
        {/* Header */}
        <div className="text-center">
          <motion.div
            initial={{ scale: 0.8, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            className="inline-flex items-center gap-2 rounded-full bg-gradient-to-r from-violet-100 to-indigo-100 px-4 py-1.5 text-sm font-bold text-violet-700 mb-3 border border-violet-200/50"
          >
            <CalendarDays size={16} /> AI Calendar Parser
          </motion.div>
          <h1 className="text-2xl sm:text-3xl font-black tracking-tight text-slate-900">
            Upload your Academic Calendar 📅
          </h1>
          <p className="text-sm text-slate-500 mt-1 font-medium">
            Upload your college's Calendar of Events — AI extracts all holidays, exams & events automatically
          </p>
        </div>

        {!result ? (
          <motion.div
            initial={{ opacity: 0, y: 10 }}
            animate={{ opacity: 1, y: 0 }}
            className="bg-white rounded-2xl border border-slate-200 shadow-sm p-5 flex flex-col gap-5"
          >
            {/* Upload Zone */}
            <div>
              <label className="mb-1.5 flex items-center gap-2 text-sm font-semibold text-slate-700">
                <Upload size={16} className="text-slate-400" />
                Upload Calendar of Events
              </label>
              <div
                onDragOver={(e) => { e.preventDefault(); setIsDragOver(true) }}
                onDragLeave={() => setIsDragOver(false)}
                onDrop={handleDrop}
                onClick={() => fileInputRef.current?.click()}
                className={cn(
                  'flex flex-col items-center justify-center gap-2 rounded-xl border-2 border-dashed p-8 cursor-pointer transition-all',
                  isDragOver
                    ? 'border-violet-500 bg-violet-50'
                    : 'border-slate-200 bg-slate-50/50 hover:border-violet-300 hover:bg-violet-50/30'
                )}
              >
                <div className={cn(
                  'flex h-14 w-14 items-center justify-center rounded-full transition-colors',
                  isDragOver ? 'bg-violet-100 text-violet-600' : 'bg-slate-100 text-slate-400'
                )}>
                  <FileUp size={28} />
                </div>
                <p className="text-sm font-medium text-slate-600">
                  {isDragOver ? 'Drop calendar here' : 'Drag & drop or click to upload'}
                </p>
                <p className="text-xs text-slate-400">
                  Images (JPG, PNG, WebP) • PDF (auto-converted) • Text (TXT, CSV)
                </p>
                <input
                  ref={fileInputRef} type="file" multiple accept={ALL_ACCEPTED}
                  onChange={(e) => e.target.files && handleFiles(e.target.files)}
                  className="hidden"
                />
              </div>

              {uploadedFiles.length > 0 && (
                <div className="mt-3 flex flex-wrap gap-2">
                  {uploadedFiles.map((file, idx) => (
                    <div key={idx} className="group relative flex items-center gap-2 rounded-lg border border-slate-200 bg-white px-3 py-2 shadow-sm">
                      {file.isImage && file.preview ? (
                        <img src={file.preview} alt={file.name} className="h-8 w-8 rounded object-cover" />
                      ) : (
                        <div className="flex h-8 w-8 items-center justify-center rounded bg-slate-100">
                          <FileText size={16} className="text-slate-500" />
                        </div>
                      )}
                      <span className="max-w-[120px] truncate text-xs font-medium text-slate-700">{file.name}</span>
                      <button
                        onClick={(e) => { e.stopPropagation(); setUploadedFiles(prev => prev.filter((_, i) => i !== idx)) }}
                        className="flex h-5 w-5 items-center justify-center rounded-full bg-slate-100 text-slate-400 opacity-0 group-hover:opacity-100 hover:bg-red-100 hover:text-red-500 transition-opacity"
                      >
                        <X size={12} />
                      </button>
                    </div>
                  ))}
                </div>
              )}
            </div>

            {/* Divider */}
            <div className="flex items-center gap-3">
              <div className="h-px flex-1 bg-slate-200" />
              <span className="text-xs font-medium text-slate-400 uppercase tracking-wider">or paste text</span>
              <div className="h-px flex-1 bg-slate-200" />
            </div>

            {/* Text Input */}
            <div>
              <label className="mb-1.5 flex items-center gap-2 text-sm font-semibold text-slate-700">
                <FileText size={16} className="text-slate-400" />
                Paste Calendar Text
              </label>
              <textarea
                value={calendarText}
                onChange={(e) => setCalendarText(e.target.value)}
                placeholder="Paste your college's Calendar of Events text here..."
                className="w-full min-h-[120px] rounded-xl border border-slate-200 bg-slate-50/50 p-3 text-sm text-slate-800 placeholder:text-slate-400 focus:border-violet-500 focus:ring-1 focus:ring-violet-500 transition-all resize-y"
              />
            </div>

            {/* Parse Button */}
            <button
              onClick={handleParse}
              disabled={isParsing || !hasInput}
              className="group flex w-full items-center justify-center gap-2 rounded-xl bg-violet-600 px-4 py-3 text-sm font-semibold text-white shadow-sm transition-all hover:bg-violet-500 disabled:opacity-70 disabled:cursor-not-allowed"
            >
              {isParsing ? (
                <><Loader2 size={18} className="animate-spin" /> Parsing Calendar...</>
              ) : (
                <><Sparkles size={18} className="transition-transform group-hover:scale-110 group-hover:rotate-12" /> Extract Events with AI</>
              )}
            </button>
          </motion.div>
        ) : (
          <AnimatePresence>
            <motion.div
              initial={{ opacity: 0, y: 10 }}
              animate={{ opacity: 1, y: 0 }}
              className="flex flex-col gap-5"
            >
              {/* Summary Card */}
              <div className="rounded-2xl border border-violet-100 bg-gradient-to-br from-violet-50 to-indigo-50 p-5 relative overflow-hidden">
                <div className="absolute top-0 right-0 p-4 opacity-10">
                  <CalendarDays size={80} />
                </div>
                <div className="relative z-10">
                  {result.institution_name && (
                    <p className="text-xs font-bold text-violet-500 uppercase tracking-wider mb-1">{result.institution_name}</p>
                  )}
                  <h2 className="text-lg font-black text-slate-900 mb-1">
                    {result.academic_year} • {result.semester || 'Full Year'}
                  </h2>
                  <p className="text-sm text-slate-600 leading-relaxed">{result.summary}</p>

                  <div className="flex flex-wrap gap-3 mt-3">
                    <div className="rounded-lg bg-white border border-slate-200 px-3 py-2 text-center shadow-sm">
                      <p className="text-xl font-black text-violet-700">{result.events.length}</p>
                      <p className="text-[10px] font-bold text-slate-500 uppercase">Events Found</p>
                    </div>
                    <div className="rounded-lg bg-white border border-slate-200 px-3 py-2 text-center shadow-sm">
                      <p className="text-xl font-black text-red-600">{result.total_holidays}</p>
                      <p className="text-[10px] font-bold text-slate-500 uppercase">Holidays</p>
                    </div>
                    <div className="rounded-lg bg-white border border-slate-200 px-3 py-2 text-center shadow-sm">
                      <p className="text-xl font-black text-amber-600">{result.total_working_days_lost}</p>
                      <p className="text-[10px] font-bold text-slate-500 uppercase">Days Off</p>
                    </div>
                    <div className="rounded-lg bg-white border border-indigo-200 px-3 py-2 text-center shadow-sm">
                      <p className="text-xl font-black text-indigo-600">{selectedEvents.size}</p>
                      <p className="text-[10px] font-bold text-slate-500 uppercase">Selected</p>
                    </div>
                  </div>
                </div>
              </div>

              {/* Selection Summary */}
              <div className="flex items-center justify-between rounded-xl bg-amber-50 border border-amber-200 px-4 py-2.5">
                <div className="flex items-center gap-2 text-sm font-bold text-amber-800">
                  <AlertTriangle size={16} />
                  <span>{selectedEvents.size} events selected — ~{selectedDaysOff} working days off</span>
                </div>
                <div className="flex gap-2">
                  <button
                    onClick={() => setSelectedEvents(new Set(result.events.map(e => e.name)))}
                    className="text-[10px] font-bold text-indigo-600 hover:text-indigo-700"
                  >Select All</button>
                  <span className="text-slate-300">|</span>
                  <button
                    onClick={() => setSelectedEvents(new Set())}
                    className="text-[10px] font-bold text-red-500 hover:text-red-600"
                  >Clear</button>
                </div>
              </div>

              {/* Category Filters */}
              <div className="flex items-center gap-2 flex-wrap">
                <button
                  onClick={() => setFilterCategory(null)}
                  className={cn(
                    'px-3 py-1.5 rounded-full text-xs font-bold transition-all',
                    !filterCategory ? 'bg-slate-800 text-white' : 'bg-white text-slate-600 border border-slate-200 hover:bg-slate-50'
                  )}
                >
                  All ({result.events.length})
                </button>
                {Object.entries(CATEGORY_META).map(([key, meta]) => {
                  const count = result.events.filter(e => e.category === key).length
                  if (count === 0) return null
                  const Icon = meta.icon
                  return (
                    <button
                      key={key}
                      onClick={() => setFilterCategory(filterCategory === key ? null : key)}
                      className={cn(
                        'flex items-center gap-1 px-3 py-1.5 rounded-full text-xs font-bold transition-all',
                        filterCategory === key
                          ? 'bg-slate-800 text-white'
                          : `${meta.bg} ${meta.color} border hover:opacity-80`
                      )}
                    >
                      <Icon size={12} /> {meta.label} ({count})
                    </button>
                  )
                })}
              </div>

              {/* Events List */}
              <div className="bg-white rounded-2xl border border-slate-200 shadow-sm overflow-hidden">
                <div className="px-5 py-3 border-b border-slate-100 bg-slate-50/50 flex items-center gap-2">
                  <Calendar size={16} className="text-slate-400" />
                  <h3 className="text-sm font-bold text-slate-700">Extracted Events</h3>
                  <span className="text-xs text-slate-400 font-medium ml-auto">
                    Click to select/deselect for attendance planning
                  </span>
                </div>

                <div className="divide-y divide-slate-50 max-h-[400px] overflow-y-auto">
                  {filteredEvents.map((event, idx) => {
                    const catMeta = CATEGORY_META[event.category] || CATEGORY_META.academic
                    const CatIcon = catMeta.icon
                    const isSelected = selectedEvents.has(event.name)

                    return (
                      <motion.div
                        key={`${event.name}-${idx}`}
                        initial={{ opacity: 0, x: -8 }}
                        animate={{ opacity: 1, x: 0 }}
                        transition={{ delay: idx * 0.02 }}
                        onClick={() => toggleEvent(event.name)}
                        className={cn(
                          'flex items-center gap-3 px-5 py-3 cursor-pointer transition-colors',
                          isSelected ? 'bg-indigo-50/50' : 'hover:bg-slate-50'
                        )}
                      >
                        {/* Checkbox */}
                        <div className={cn(
                          'flex h-5 w-5 shrink-0 items-center justify-center rounded border-2 transition-colors',
                          isSelected ? 'border-indigo-600 bg-indigo-600 text-white' : 'border-slate-300'
                        )}>
                          {isSelected && <Check size={12} strokeWidth={3} />}
                        </div>

                        {/* Category Icon */}
                        <div className={cn('flex h-8 w-8 shrink-0 items-center justify-center rounded-lg border', catMeta.bg)}>
                          <CatIcon size={14} className={catMeta.color} />
                        </div>

                        {/* Event Details */}
                        <div className="flex-1 min-w-0">
                          <p className={cn('text-sm font-semibold truncate', isSelected ? 'text-indigo-800' : 'text-slate-800')}>
                            {event.name}
                          </p>
                          <div className="flex items-center gap-2 mt-0.5">
                            <span className="text-[10px] font-medium text-slate-500">
                              {event.start_date}{event.end_date ? ` → ${event.end_date}` : ''}
                            </span>
                            {event.description && (
                              <span className="text-[10px] text-slate-400 truncate max-w-[150px]">{event.description}</span>
                            )}
                          </div>
                        </div>

                        {/* Days off badge */}
                        <div className="flex items-center gap-2 shrink-0">
                          {event.is_holiday && (
                            <span className="text-[9px] font-bold bg-red-100 text-red-700 px-1.5 py-0.5 rounded-full">
                              Holiday
                            </span>
                          )}
                          <span className={cn(
                            'text-[10px] font-bold px-2 py-0.5 rounded-full',
                            event.days_off > 3 ? 'bg-amber-100 text-amber-800' : 'bg-slate-100 text-slate-600'
                          )}>
                            {event.days_off}d off
                          </span>
                        </div>
                      </motion.div>
                    )
                  })}
                </div>
              </div>

              {/* Actions */}
              <div className="flex gap-3">
                <button
                  onClick={() => { setResult(null); setUploadedFiles([]); setSelectedEvents(new Set()) }}
                  className="flex-1 text-sm font-medium text-slate-600 hover:text-slate-700 border border-slate-200 rounded-xl py-2.5 transition-colors hover:bg-slate-50"
                >
                  ← Parse another calendar
                </button>
                <button
                  onClick={() => {
                    const selected = result.events.filter(e => selectedEvents.has(e.name))
                    const text = selected.map(e =>
                      `${e.start_date}${e.end_date ? ' to ' + e.end_date : ''}: ${e.name} (${e.days_off}d off)`
                    ).join('\n')
                    navigator.clipboard.writeText(text)
                    toast.success(`Copied ${selected.length} events to clipboard!`)
                  }}
                  className="flex items-center gap-2 px-5 py-2.5 rounded-xl bg-violet-600 text-white text-sm font-semibold hover:bg-violet-500 transition-colors"
                >
                  <Download size={16} /> Copy Selected
                </button>
              </div>
            </motion.div>
          </AnimatePresence>
        )}
      </div>
    </AppShell>
  )
}
