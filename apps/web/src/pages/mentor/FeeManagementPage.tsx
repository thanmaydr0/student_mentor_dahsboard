import React, { useState, useEffect } from 'react'
import { Receipt, Search, Printer, Download, Filter, FileText } from 'lucide-react'
import AppShell from '../../components/layout/AppShell'
import Card from '../../components/ui/Card'
import Input from '../../components/ui/Input'
import { supabase } from '../../lib/supabase'
import { useAuth } from '../../hooks/useAuth'

interface FeePayment {
  id: string
  student_id: string
  payment_type: string
  amount: number
  status: string
  razorpay_payment_id: string
  subjects: string[]
  created_at: string
  profiles: {
    full_name: string
    usn: string
  }
}

export default function FeeManagementPage() {
  const { user } = useAuth()
  const [payments, setPayments] = useState<FeePayment[]>([])
  const [search, setSearch] = useState('')
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    if (user?.id) fetchPayments()
  }, [user?.id])

  const [debugInfo, setDebugInfo] = useState<string>('')

  const fetchPayments = async () => {
    try {
      let debugStr = 'Fetching fees...\\n';
      // Try RPC first
      const { data: rpcData, error: rpcError } = await supabase.rpc('get_mentor_fee_payments')
      
      if (rpcError) {
        debugStr += `RPC Error: ${rpcError.message}\\n`;
      } else if (rpcData && rpcData.length > 0) {
        debugStr += `RPC Success: Found ${rpcData.length} records.\\n`;
        const mappedData = rpcData.map((item: any) => ({
          ...item,
          profiles: { full_name: item.student_name }
        }))
        setPayments(mappedData as FeePayment[])
        setDebugInfo(debugStr)
        setLoading(false)
        return
      } else {
        debugStr += `RPC returned 0 records.\\n`;
      }

      // Try direct query fallback
      debugStr += `Trying direct query...\\n`;
      const { data: directData, error: directError } = await supabase
        .from('fee_payments')
        .select(`*, profiles:student_id (full_name)`)
        .order('created_at', { ascending: false })

      if (directError) {
        debugStr += `Direct Query Error: ${directError.message}\\n`;
      } else if (directData && directData.length > 0) {
        debugStr += `Direct Query Success: Found ${directData.length} records.\\n`;
        setPayments(directData as unknown as FeePayment[])
      } else {
        debugStr += `Direct Query returned 0 records.\\n`;
        
        // Debug: Check if there are ANY students for this mentor
        const { data: myStudents } = await supabase.from('profiles').select('id, full_name').eq('mentor_id', user?.id);
        debugStr += `Mentor has ${myStudents?.length || 0} students assigned.\\n`;
        if (myStudents && myStudents.length > 0) {
           debugStr += `Students: ${myStudents.map(s => s.full_name).join(', ')}`;
        }
      }
      setDebugInfo(debugStr)
      
    } catch (error: any) {
      console.error('Error fetching payments:', error)
      setDebugInfo(prev => prev + `\\nException: ${error.message}`)
    } finally {
      setLoading(false)
    }
  }

  const handlePrintReceipt = (payment: FeePayment) => {
    const printWindow = window.open('', '', 'width=800,height=600')
    if (!printWindow) return

    const dateStr = new Date(payment.created_at).toLocaleDateString('en-IN', {
      year: 'numeric', month: 'long', day: 'numeric',
      hour: '2-digit', minute: '2-digit'
    })

    const receiptHtml = `
      <html>
        <head>
          <title>Fee Receipt - ${payment.razorpay_payment_id}</title>
          <style>
            body { font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; padding: 40px; color: #333; }
            .header { text-align: center; margin-bottom: 40px; border-bottom: 2px solid #eee; padding-bottom: 20px; }
            .logo { font-size: 24px; font-weight: bold; color: #4f46e5; }
            .title { font-size: 18px; color: #666; margin-top: 10px; }
            .grid { display: flex; justify-content: space-between; margin-bottom: 30px; }
            .details strong { display: block; margin-bottom: 5px; color: #555; font-size: 12px; text-transform: uppercase; }
            .details p { margin: 0 0 15px 0; font-size: 16px; font-weight: bold; }
            table { w-full: 100%; width: 100%; border-collapse: collapse; margin-bottom: 30px; }
            th { text-align: left; padding: 12px; background: #f8fafc; border-bottom: 2px solid #e2e8f0; color: #64748b; }
            td { padding: 12px; border-bottom: 1px solid #e2e8f0; }
            .total { text-align: right; font-size: 20px; font-weight: bold; padding-top: 20px; border-top: 2px solid #333; }
            .footer { text-align: center; color: #888; font-size: 12px; margin-top: 50px; }
            .badge { display: inline-block; padding: 4px 8px; background: #dcfce7; color: #166534; border-radius: 4px; font-size: 12px; font-weight: bold; }
          </style>
        </head>
        <body>
          <div class="header">
            <div class="logo">EduPredict Fees Gateway</div>
            <div class="title">Official Transaction Receipt</div>
          </div>
          
          <div class="grid">
            <div class="details">
              <strong>Student Name</strong>
              <p>${payment.profiles.full_name}</p>
              <strong>Student ID</strong>
              <p>${payment.student_id.substring(0,8).toUpperCase()}</p>
            </div>
            <div class="details" style="text-align: right;">
              <strong>Receipt No / RZP ID</strong>
              <p>${payment.razorpay_payment_id || 'N/A'}</p>
              <strong>Date of Payment</strong>
              <p>${dateStr}</p>
              <strong>Status</strong>
              <p><span class="badge">SUCCESS</span></p>
            </div>
          </div>

          <table>
            <thead>
              <tr>
                <th>Description</th>
                <th style="text-align: right;">Amount</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>
                  <strong>${payment.payment_type === 'revaluation' ? 'Revaluation Application Fee' : 'Semester Exam Registration Fee'}</strong>
                  ${payment.subjects ? `<br><small style="color:#666">Subjects: ${payment.subjects.join(', ')}</small>` : ''}
                </td>
                <td style="text-align: right;">₹${payment.amount.toFixed(2)}</td>
              </tr>
            </tbody>
          </table>

          <div class="total">
            Total Paid: ₹${payment.amount.toFixed(2)}
          </div>

          <div class="footer">
            This is a computer-generated receipt and requires no physical signature.<br>
            Powered by Razorpay Secure.
          </div>
          
          <script>
            window.onload = function() { window.print(); }
          </script>
        </body>
      </html>
    `

    printWindow.document.open()
    printWindow.document.write(receiptHtml)
    printWindow.document.close()
  }

  const filtered = payments.filter(p => 
    p.profiles.full_name.toLowerCase().includes(search.toLowerCase()) || 
    p.razorpay_payment_id?.toLowerCase().includes(search.toLowerCase())
  )

  return (
    <AppShell role="mentor">
      <div className="max-w-6xl mx-auto space-y-8">
        
        {/* Header */}
        <div className="flex flex-col sm:flex-row justify-between items-start sm:items-end gap-4">
          <div>
            <h1 className="text-3xl font-black text-slate-900 dark:text-white flex items-center gap-3">
              <Receipt className="text-brand-600" size={32} />
              Fee Management
            </h1>
            <p className="mt-2 text-slate-600 dark:text-slate-400">
              Track and print fee receipts for all your assigned mentees.
            </p>
          </div>
          
          <div className="flex items-center gap-3 w-full sm:w-auto">
            <div className="relative flex-1 sm:w-64">
              <Search className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400" size={18} />
              <input
                type="text"
                placeholder="Search student or receipt..."
                value={search}
                onChange={(e) => setSearch(e.target.value)}
                className="w-full pl-10 pr-4 py-2 bg-white dark:bg-[#13151a] border border-slate-200 dark:border-white/10 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-brand-500/20"
              />
            </div>
            <button className="p-2.5 bg-white dark:bg-[#13151a] border border-slate-200 dark:border-white/10 rounded-xl hover:bg-slate-50 dark:hover:bg-white/5 transition">
              <Filter size={18} className="text-slate-600 dark:text-slate-400" />
            </button>
          </div>
        </div>

        {debugInfo && (
          <div className="p-4 bg-slate-900 text-green-400 font-mono text-xs rounded-xl overflow-auto whitespace-pre-wrap">
            {debugInfo}
          </div>
        )}

        {/* Data Table */}
        <Card className="overflow-hidden border border-slate-200 dark:border-white/10 shadow-sm">
           <div className="overflow-x-auto">
             <table className="w-full text-left text-sm">
                <thead className="bg-slate-50 dark:bg-white/5 text-slate-600 dark:text-slate-400 border-b border-slate-200 dark:border-white/10">
                  <tr>
                    <th className="px-6 py-4 font-bold">Student</th>
                    <th className="px-6 py-4 font-bold">Payment Type</th>
                    <th className="px-6 py-4 font-bold">Amount</th>
                    <th className="px-6 py-4 font-bold">Date & Time</th>
                    <th className="px-6 py-4 font-bold">Status</th>
                    <th className="px-6 py-4 font-bold text-right">Actions</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-slate-100 dark:divide-white/5 bg-white dark:bg-[#0c0d10]">
                   {loading ? (
                     <tr>
                       <td colSpan={6} className="px-6 py-8 text-center text-slate-500">
                         Loading receipts...
                       </td>
                     </tr>
                   ) : filtered.length === 0 ? (
                     <tr>
                       <td colSpan={6} className="px-6 py-12 text-center text-slate-500 flex flex-col items-center">
                         <FileText size={32} className="opacity-20 mb-3" />
                         No payment records found.
                       </td>
                     </tr>
                   ) : (
                     filtered.map((payment) => (
                       <tr key={payment.id} className="hover:bg-slate-50/50 dark:hover:bg-white/[0.02] transition-colors">
                         <td className="px-6 py-4">
                           <p className="font-bold text-slate-900 dark:text-white">{payment.profiles?.full_name || 'Student'}</p>
                           <p className="text-xs text-slate-500">ID: {payment.student_id.substring(0,8).toUpperCase()}</p>
                         </td>
                         <td className="px-6 py-4">
                           <div className="flex flex-col">
                             <span className="font-medium text-slate-900 dark:text-slate-200">
                               {payment.payment_type === 'revaluation' ? 'Revaluation' : 'Exam Registration'}
                             </span>
                             {payment.subjects && (
                               <span className="text-[10px] text-brand-600 dark:text-brand-400 font-bold mt-1">
                                 {payment.subjects.length} Subjects
                               </span>
                             )}
                           </div>
                         </td>
                         <td className="px-6 py-4">
                           <span className="font-black text-slate-900 dark:text-white">₹{payment.amount}</span>
                         </td>
                         <td className="px-6 py-4 text-slate-500 text-xs font-medium">
                           {new Date(payment.created_at).toLocaleDateString('en-IN', { month: 'short', day: 'numeric', hour: '2-digit', minute:'2-digit' })}
                         </td>
                         <td className="px-6 py-4">
                           <span className={`px-2.5 py-1 text-[10px] font-bold uppercase tracking-wider rounded-full ${
                             payment.status === 'completed' ? 'bg-emerald-100 text-emerald-700 dark:bg-emerald-500/10 dark:text-emerald-400'
                             : 'bg-amber-100 text-amber-700 dark:bg-amber-500/10 dark:text-amber-400'
                           }`}>
                             {payment.status}
                           </span>
                         </td>
                         <td className="px-6 py-4 text-right">
                           <button 
                             onClick={() => handlePrintReceipt(payment)}
                             className="inline-flex items-center gap-1.5 px-3 py-1.5 text-xs font-bold text-brand-700 bg-brand-50 hover:bg-brand-100 dark:text-brand-300 dark:bg-brand-900/30 dark:hover:bg-brand-900/50 rounded-lg transition-colors"
                           >
                             <Printer size={14} /> Print
                           </button>
                         </td>
                       </tr>
                     ))
                   )}
                </tbody>
             </table>
           </div>
        </Card>
      </div>
    </AppShell>
  )
}
