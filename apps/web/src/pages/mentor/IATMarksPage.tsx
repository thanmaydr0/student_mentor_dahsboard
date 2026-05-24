import { useState, useMemo, useEffect } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { ClipboardEdit, Save, Loader2, CheckCircle2, Users, ChevronDown, DownloadCloud } from 'lucide-react'
import { useAuth } from '../../hooks/useAuth'
import AppShell from '../../components/layout/AppShell'
import { supabase } from '../../lib/supabase'
import { cn } from '../../lib/utils'
import toast from 'react-hot-toast'

interface StudentIAT {
  student_id: string
  full_name: string
  class_id: string
  subject_name: string
  iat1: number | null
  iat2: number | null
  lab_iat1: number | null
  lab_iat2: number | null
  assignment1: number | null
  assignment2: number | null
}

export default function IATMarksPage() {
  const { user } = useAuth()
  const [loading, setLoading] = useState(true)
  const [saving, setSaving] = useState(false)
  const [data, setData] = useState<StudentIAT[]>([])
  const [editedCells, setEditedCells] = useState<Map<string, number | null>>(new Map())
  const [selectedClass, setSelectedClass] = useState<string>('all')
  const [isSyncModalOpen, setIsSyncModalOpen] = useState(false)
  const [syncing, setSyncing] = useState(false)
  const [syncPreview, setSyncPreview] = useState<{ matched: any[], unmatched: string[] } | null>(null)

  // Fetch all data
  useEffect(() => {
    if (!user?.id) return
    fetchData()
  }, [user?.id])

  const fetchData = async () => {
    setLoading(true)
    try {
      const { data: students, error: sErr } = await supabase
        .from('profiles')
        .select('id, full_name')
        .eq('mentor_id', user!.id)
        .eq('role', 'student')

      if (sErr) throw sErr
      if (!students || students.length === 0) {
        setData([])
        setLoading(false)
        return
      }

      const studentIds = students.map((s) => s.id)

      const { data: enrollments, error: eErr } = await supabase
        .from('enrollments')
        .select('student_id, class_id')
        .in('student_id', studentIds)

      if (eErr) throw eErr

      const classIds = [...new Set((enrollments || []).map((e) => e.class_id))]
      const { data: classes } = await supabase
        .from('classes')
        .select('id, subject_id')
        .in('id', classIds)

      const subjectIds = [...new Set((classes || []).map((c) => c.subject_id))]
      const { data: subjects } = await supabase
        .from('subjects')
        .select('id, name')
        .in('id', subjectIds)

      const subjectMap = new Map((subjects || []).map((s) => [s.id, s.name]))
      const classSubjectMap = new Map((classes || []).map((c) => [c.id, subjectMap.get(c.subject_id) || 'Unknown']))

      const { data: iatMarks } = await supabase
        .from('iat_marks')
        .select('student_id, class_id, iat1, iat2, lab_iat1, lab_iat2, assignment1, assignment2')
        .in('student_id', studentIds)

      const iatMap = new Map<string, any>()
      ;(iatMarks || []).forEach((m) => {
        iatMap.set(`${m.student_id}-${m.class_id}`, m)
      })

      const studentMap = new Map(students.map((s) => [s.id, s.full_name]))
      const classToSubjectId = new Map((classes || []).map((c) => [c.id, c.subject_id]))

      const seen = new Set<string>()
      const uniqueEnrollments = (enrollments || []).filter((e) => {
        const subjectId = classToSubjectId.get(e.class_id)
        const dedupeKey = `${e.student_id}::${subjectId}`
        if (seen.has(dedupeKey)) return false
        seen.add(dedupeKey)
        return true
      })

      const rows: StudentIAT[] = uniqueEnrollments.map((e) => {
        const marks = iatMap.get(`${e.student_id}-${e.class_id}`) || {}
        return {
          student_id: e.student_id,
          full_name: studentMap.get(e.student_id) || 'Unknown',
          class_id: e.class_id,
          subject_name: classSubjectMap.get(e.class_id) || 'Unknown',
          iat1: marks.iat1 ?? null,
          iat2: marks.iat2 ?? null,
          lab_iat1: marks.lab_iat1 ?? null,
          lab_iat2: marks.lab_iat2 ?? null,
          assignment1: marks.assignment1 ?? null,
          assignment2: marks.assignment2 ?? null,
        }
      })

      setData(rows.sort((a, b) => a.full_name.localeCompare(b.full_name)))
    } catch (err: any) {
      console.error('Failed to load IAT data:', err)
      toast.error('Failed to load IAT data')
    }
    setLoading(false)
  }

  const allowedSubjects = useMemo(() => ['dbms', 'database', 'ai', 'artificial intelligence', 'dms', 'discrete', 'ada', 'algorithm'], [])

  const availableClasses = useMemo(() => {
    const uniqueSubjects = new Map<string, string>() // subject_name -> class_id
    data.forEach((d) => {
      const name = d.subject_name.toLowerCase()
      if (allowedSubjects.some(a => name.includes(a) || name === 'ai' || name === 'ada' || name === 'dms')) {
        if (!uniqueSubjects.has(d.subject_name)) {
          uniqueSubjects.set(d.subject_name, d.class_id)
        }
      }
    })
    return Array.from(uniqueSubjects.entries()).map(([name, id]) => [id, name])
  }, [data, allowedSubjects])

  const sortedAndFilteredData = useMemo(() => {
    // 1. Filter to only allowed subjects globally
    let result = data.filter((d) => {
      const name = d.subject_name.toLowerCase()
      return allowedSubjects.some(a => name.includes(a) || name === 'ai' || name === 'ada' || name === 'dms')
    })
    
    // 2. Filter by selected class if not 'all'
    if (selectedClass !== 'all') {
      result = result.filter((d) => d.class_id === selectedClass)
    }

    // 3. Sort by student full name, then subject name
    return result.sort((a, b) => {
      const nameCmp = a.full_name.localeCompare(b.full_name)
      if (nameCmp !== 0) return nameCmp
      return a.subject_name.localeCompare(b.subject_name)
    })
  }, [data, selectedClass, allowedSubjects])

  const studentRowSpans = useMemo(() => {
    const spans = new Map<string, number>()
    sortedAndFilteredData.forEach(d => {
      spans.set(d.student_id, (spans.get(d.student_id) || 0) + 1)
    })
    return spans
  }, [sortedAndFilteredData])

  const handleMarkChange = (studentId: string, classId: string, field: string, value: string) => {
    const key = `${studentId}-${classId}-${field}`
    if (value === '') {
      setEditedCells((prev) => {
        const n = new Map(prev)
        n.set(key, null)
        return n
      })
      return
    }
    const num = parseFloat(value)
    if (!isNaN(num) && num >= 0 && num <= 50) {
      setEditedCells((prev) => {
        const n = new Map(prev)
        n.set(key, num)
        return n
      })
    }
  }

  const getDisplayValue = (row: StudentIAT, field: keyof Omit<StudentIAT, 'student_id'|'full_name'|'class_id'|'subject_name'>): string => {
    const key = `${row.student_id}-${row.class_id}-${field}`
    if (editedCells.has(key)) {
      const val = editedCells.get(key)
      return val !== null && val !== undefined ? String(val) : ''
    }
    const existing = row[field]
    return existing !== null && existing !== undefined ? String(existing) : ''
  }

  const hasChanges = editedCells.size > 0

  const handleSave = async () => {
    if (!hasChanges) return
    setSaving(true)

    try {
      const operations: Promise<any>[] = []
      
      const rowUpdates = new Map<string, any>()
      
      editedCells.forEach((value, key) => {
        const [studentId, classId, field] = key.split('-')
        const rowKey = `${studentId}-${classId}`
        if (!rowUpdates.has(rowKey)) {
          rowUpdates.set(rowKey, { student_id: studentId, class_id: classId })
        }
        rowUpdates.get(rowKey)[field] = value
      })

      for (const update of rowUpdates.values()) {
        operations.push(
          supabase.from('iat_marks').upsert(update, { onConflict: 'student_id,class_id' })
        )
      }

      const results = await Promise.all(operations)
      const errors = results.filter((r) => r.error)
      if (errors.length > 0) {
        console.error('Some saves failed:', errors)
        toast.error(`${errors.length} mark(s) failed to save`)
      } else {
        toast.success('Marks saved successfully!')
        setEditedCells(new Map())
        await fetchData()
      }
    } catch (err: any) {
      toast.error('Failed to save marks')
      console.error(err)
    }
    setSaving(false)
  }

  const selectedSubjectName = useMemo(() => {
    return availableClasses.find(([id]) => id === selectedClass)?.[1] || ''
  }, [availableClasses, selectedClass])

  const handleSyncPreview = async () => {
    if (selectedClass === 'all') return toast.error('Please select a specific subject first')

    setSyncing(true)
    setSyncPreview(null)
    try {
      const { data: result, error } = await supabase.functions.invoke('sync-sheet', {
        body: { subjectName: selectedSubjectName }
      })

      if (error) throw new Error(error.message || 'Failed to fetch sheet')
      if (result.error) throw new Error(result.error)

      const csvData = result.data as any[]
      const matched = []
      const unmatched = []

      for (const row of csvData) {
        const sheetName = row['Student Name'] || row['Name'] || row['name']
        if (!sheetName) continue

        const student = sortedAndFilteredData.find((s) => s.full_name.toLowerCase() === sheetName.toLowerCase())
        if (student) {
          const parseMark = (val: any) => val && !isNaN(parseFloat(val)) ? parseFloat(val) : null
          matched.push({
            student_id: student.student_id,
            class_id: student.class_id,
            iat1: parseMark(row['IAT 1'] || row['iat1']),
            iat2: parseMark(row['IAT 2'] || row['iat2']),
            lab_iat1: parseMark(row['Lab IAT 1'] || row['lab_iat1']),
            lab_iat2: parseMark(row['Lab IAT 2'] || row['lab_iat2']),
            assignment1: parseMark(row['Assignment 1'] || row['assignment1']),
            assignment2: parseMark(row['Assignment 2'] || row['assignment2']),
          })
        } else {
          unmatched.push(sheetName)
        }
      }

      setSyncPreview({ matched, unmatched })
    } catch (err: any) {
      toast.error(err.message || 'Error fetching Google Sheet')
    }
    setSyncing(false)
  }

  const handleConfirmSync = async () => {
    if (!syncPreview || syncPreview.matched.length === 0) return
    setSyncing(true)
    try {
      const { error } = await supabase.from('iat_marks').upsert(syncPreview.matched, { onConflict: 'student_id,class_id' })
      if (error) throw error
      toast.success('Synced successfully from Google Sheets!')
      setIsSyncModalOpen(false)
      setSyncPreview(null)
      await fetchData()
    } catch (err: any) {
      toast.error('Failed to sync marks')
      console.error(err)
    }
    setSyncing(false)
  }

  const getColStatus = (row: StudentIAT) => {
    const total = [row.iat1, row.iat2, row.lab_iat1, row.lab_iat2, row.assignment1, row.assignment2].filter(v => v !== null).length
    return total > 0 ? (
      <span className="inline-flex items-center gap-1 rounded-full bg-green-100 px-2 py-0.5 text-xs font-semibold text-green-700">
        <CheckCircle2 size={12} /> {total}/6 Entered
      </span>
    ) : (
      <span className="text-xs font-medium text-slate-400">Pending</span>
    )
  }

  return (
    <AppShell role="mentor">
      <div className="flex flex-col gap-6 max-w-7xl mx-auto w-full pb-10">
        {/* Header */}
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
          <div>
            <h1 className="text-2xl font-bold text-slate-900 dark:text-white flex items-center gap-3">
              <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-purple-100 text-purple-600 shadow-sm">
                <ClipboardEdit size={20} />
              </div>
              Assessments Entry
            </h1>
            <p className="text-sm text-slate-500 dark:text-slate-400 mt-1">Enter IAT, Lab IAT, and Assignment marks</p>
          </div>

          <div className="flex items-center gap-3">
            <button
              onClick={() => setIsSyncModalOpen(true)}
              className="flex items-center gap-2 px-4 py-2 text-sm font-semibold text-purple-700 bg-purple-100 hover:bg-purple-200 rounded-xl transition-colors"
            >
              <DownloadCloud size={16} />
              Sync Google Sheets
            </button>

            {/* Subject Filter */}
            <div className="relative">
              <select
                value={selectedClass}
                onChange={(e) => setSelectedClass(e.target.value)}
                className="appearance-none rounded-xl border border-slate-200 dark:border-white/10 bg-white dark:bg-[#13151a] pl-3 pr-9 py-2 text-sm font-medium text-slate-700 dark:text-slate-200 shadow-sm focus:border-purple-500 focus:ring-purple-500"
              >
                <option value="all">All Subjects</option>
                {availableClasses.map(([id, name]) => (
                  <option key={id} value={id}>{name}</option>
                ))}
              </select>
              <ChevronDown size={14} className="absolute right-3 top-1/2 -translate-y-1/2 text-slate-400 pointer-events-none" />
            </div>
          </div>
        </div>

        {/* Save Bar */}
        <AnimatePresence>
          {hasChanges && (
            <motion.div
              initial={{ opacity: 0, y: -10 }}
              animate={{ opacity: 1, y: 0 }}
              exit={{ opacity: 0, y: -10 }}
              className="flex items-center justify-between rounded-xl bg-purple-50 border border-purple-200 px-5 py-3"
            >
              <p className="text-sm font-medium text-purple-800">
                {editedCells.size} unsaved change{editedCells.size > 1 ? 's' : ''}
              </p>
              <div className="flex gap-2">
                <button
                  onClick={() => setEditedCells(new Map())}
                  className="px-4 py-2 text-sm font-medium text-purple-600 hover:text-purple-700 transition-colors"
                >
                  Discard
                </button>
                <button
                  onClick={handleSave}
                  disabled={saving}
                  className="flex items-center gap-2 rounded-lg bg-purple-600 px-4 py-2 text-sm font-semibold text-white shadow-sm hover:bg-purple-500 disabled:opacity-50 transition-colors"
                >
                  {saving ? <Loader2 size={16} className="animate-spin" /> : <Save size={16} />}
                  {saving ? 'Saving...' : 'Save All'}
                </button>
              </div>
            </motion.div>
          )}
        </AnimatePresence>

        {/* Table */}
        <div className="bg-white dark:bg-[#13151a]/50 rounded-2xl shadow-sm border border-slate-200 dark:border-white/10 overflow-hidden">
          {loading ? (
            <div className="flex items-center justify-center py-20">
              <Loader2 size={24} className="animate-spin text-purple-500" />
            </div>
          ) : sortedAndFilteredData.length === 0 ? (
            <div className="flex flex-col items-center justify-center py-20 text-slate-400">
              <Users size={40} className="mb-3 opacity-50" />
              <p className="text-sm font-medium">No students found for this selection</p>
            </div>
          ) : (
            <div className="overflow-x-auto">
              <table className="w-full text-left text-sm whitespace-nowrap">
                <thead className="bg-slate-50 dark:bg-white/5 border-b border-slate-200 dark:border-white/10 text-xs uppercase font-semibold text-slate-500 dark:text-slate-400 tracking-wider">
                  <tr>
                    <th className="px-6 py-4 sticky left-0 bg-slate-50 z-20 shadow-[1px_0_0_rgba(0,0,0,0.05)] w-64 min-w-[16rem]">Student</th>
                    <th className="px-6 py-4 border-l border-slate-200">Subject</th>
                    <th className="px-4 py-4 text-center">IAT 1</th>
                    <th className="px-4 py-4 text-center">IAT 2</th>
                    <th className="px-4 py-4 text-center">Lab 1</th>
                    <th className="px-4 py-4 text-center">Lab 2</th>
                    <th className="px-4 py-4 text-center">Ass 1</th>
                    <th className="px-4 py-4 text-center">Ass 2</th>
                    <th className="px-6 py-4 text-center border-l border-slate-200">Status</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-slate-100">
                  {(() => {
                    let currentStudentId = ''
                    return sortedAndFilteredData.map((row, index) => {
                      const isFirstRowForStudent = row.student_id !== currentStudentId
                      if (isFirstRowForStudent) {
                        currentStudentId = row.student_id
                      }
                      const rowSpan = studentRowSpans.get(row.student_id)
                      const isLastRowForStudent = sortedAndFilteredData[index + 1]?.student_id !== row.student_id

                      return (
                        <tr 
                          key={`${row.student_id}-${row.class_id}`} 
                          className={cn("hover:bg-slate-50 transition-colors", isLastRowForStudent ? "border-b-[2px] border-slate-200" : "")}
                        >
                          {isFirstRowForStudent && (
                            <td 
                              rowSpan={rowSpan} 
                              className="px-6 py-4 sticky left-0 bg-white z-20 border-r border-slate-100 shadow-[1px_0_0_rgba(0,0,0,0.05)] align-top"
                            >
                              <div className="flex items-start gap-3">
                                <div className="flex h-10 w-10 items-center justify-center rounded-full bg-purple-100 text-purple-700 text-sm font-bold shrink-0 mt-0.5">
                                  {row.full_name.charAt(0).toUpperCase()}
                                </div>
                                <div className="flex flex-col pt-1">
                                  <span className="font-bold text-slate-900 text-base">{row.full_name}</span>
                                  <span className="text-xs text-slate-500 font-medium">{rowSpan} Subjects</span>
                                </div>
                              </div>
                            </td>
                          )}
                          <td className="px-6 py-3 border-l border-slate-100">
                            <div className="flex flex-col">
                              <span className="font-semibold text-slate-700">{row.subject_name}</span>
                            </div>
                          </td>
                          {(['iat1', 'iat2', 'lab_iat1', 'lab_iat2', 'assignment1', 'assignment2'] as const).map((field) => {
                            const isEdited = editedCells.has(`${row.student_id}-${row.class_id}-${field}`)
                            return (
                              <td key={field} className="px-4 py-3">
                                <div className="flex justify-center">
                                  <input
                                    type="number"
                                    min={0}
                                    max={50}
                                    step={0.5}
                                    value={getDisplayValue(row, field)}
                                    onChange={(e) => handleMarkChange(row.student_id, row.class_id, field, e.target.value)}
                                    placeholder="—"
                                    className={cn(
                                      'w-16 rounded-lg border px-2 py-1.5 text-center text-sm font-medium transition-all focus:ring-2 focus:ring-purple-500 focus:border-purple-500',
                                      isEdited ? 'border-purple-400 bg-purple-50' : 'border-slate-200 bg-white'
                                    )}
                                  />
                                </div>
                              </td>
                            )
                          })}
                          <td className="px-6 py-3 text-center border-l border-slate-100">
                            {getColStatus(row)}
                          </td>
                        </tr>
                      )
                    })
                  })()}
                </tbody>
              </table>
            </div>
          )}
        </div>

        {/* Sync Modal */}
        {isSyncModalOpen && (
          <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm p-4">
            <motion.div
              initial={{ opacity: 0, scale: 0.95 }}
              animate={{ opacity: 1, scale: 1 }}
              className="bg-white rounded-2xl shadow-xl w-full max-w-lg overflow-hidden"
            >
              <div className="p-6 border-b border-slate-100">
                <h2 className="text-xl font-bold text-slate-900">Sync from Google Sheets</h2>
                <p className="text-sm text-slate-500 mt-1">
                  Ensure your sheet is set to "Anyone with the link can view". It must contain columns: <br/>
                  <span className="font-mono text-xs bg-slate-100 px-1 py-0.5 rounded">Student Name</span>, 
                  <span className="font-mono text-xs bg-slate-100 px-1 py-0.5 rounded ml-1">IAT 1</span>, 
                  <span className="font-mono text-xs bg-slate-100 px-1 py-0.5 rounded ml-1">IAT 2</span>, etc.
                </p>
              </div>

              <div className="p-6 space-y-4 bg-slate-50">
                {!syncPreview ? (
                  <div>
                    {selectedClass === 'all' && (
                      <div className="p-4 bg-amber-50 rounded-xl border border-amber-200">
                        <p className="font-semibold text-amber-800">No Subject Selected</p>
                        <p className="text-xs text-amber-700 mt-1">Please select a specific subject from the dropdown on the main page first.</p>
                      </div>
                    )}
                    {selectedClass !== 'all' && (
                      <p className="text-sm text-slate-700 font-medium">Ready to sync from the central <span className="font-bold text-purple-700">{selectedSubjectName}</span> Google Sheet.</p>
                    )}
                  </div>
                ) : (
                  <div className="space-y-4">
                    <div className="p-4 bg-green-50 rounded-xl border border-green-200">
                      <p className="font-semibold text-green-800">Preview Ready</p>
                      <p className="text-sm text-green-700 mt-1">Matched <strong>{syncPreview.matched.length}</strong> students successfully.</p>
                    </div>
                    {syncPreview.unmatched.length > 0 && (
                      <div className="p-4 bg-amber-50 rounded-xl border border-amber-200">
                        <p className="font-semibold text-amber-800">Unmatched ({syncPreview.unmatched.length})</p>
                        <p className="text-xs text-amber-700 mt-1">Could not match these names from the sheet:</p>
                        <div className="mt-2 text-xs text-amber-900 bg-white p-2 rounded border border-amber-100 h-24 overflow-y-auto font-mono">
                          {syncPreview.unmatched.join(', ')}
                        </div>
                      </div>
                    )}
                  </div>
                )}
              </div>

              <div className="p-5 border-t border-slate-100 flex justify-end gap-3 bg-white">
                <button
                  onClick={() => { setIsSyncModalOpen(false); setSyncPreview(null); }}
                  className="px-4 py-2 text-sm font-medium text-slate-600 hover:bg-slate-100 rounded-lg transition-colors"
                >
                  Cancel
                </button>
                {!syncPreview ? (
                  <button
                    onClick={handleSyncPreview}
                    disabled={syncing || selectedClass === 'all'}
                    className="flex items-center gap-2 px-4 py-2 text-sm font-semibold text-white bg-purple-600 hover:bg-purple-700 rounded-lg disabled:opacity-50 transition-colors"
                  >
                    {syncing && <Loader2 size={16} className="animate-spin" />}
                    Preview Sync
                  </button>
                ) : (
                  <button
                    onClick={handleConfirmSync}
                    disabled={syncing}
                    className="flex items-center gap-2 px-4 py-2 text-sm font-semibold text-white bg-green-600 hover:bg-green-700 rounded-lg disabled:opacity-50 transition-colors"
                  >
                    {syncing && <Loader2 size={16} className="animate-spin" />}
                    Confirm Sync
                  </button>
                )}
              </div>
            </motion.div>
          </div>
        )}

      </div>
    </AppShell>
  )
}
