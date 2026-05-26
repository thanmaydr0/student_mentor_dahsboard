import React, { useState, useEffect } from 'react'
import { CreditCard, Receipt, FileText, CheckCircle, Search, Calendar, ChevronRight, Loader2 } from 'lucide-react'
import AppShell from '../../components/layout/AppShell'
import Card from '../../components/ui/Card'
import { supabase } from '../../lib/supabase'
import { useAuth } from '../../hooks/useAuth'
import toast from 'react-hot-toast'

interface Subject {
  code: string;
  name: string;
}

export default function FeePaymentPage() {
  const { user } = useAuth()
  const [activeTab, setActiveTab] = useState<'revaluation' | 'exam'>('revaluation')
  
  const [subjects, setSubjects] = useState<Subject[]>([])
  const [selectedSubjects, setSelectedSubjects] = useState<string[]>([])
  const [isLoadingSubjects, setIsLoadingSubjects] = useState(false)
  
  const [isProcessing, setIsProcessing] = useState(false)

  useEffect(() => {
    if (activeTab === 'exam') {
      fetchSubjects()
    }
  }, [activeTab])

  const fetchSubjects = async () => {
    setIsLoadingSubjects(true)
    try {
      const { data, error } = await supabase.functions.invoke('erp-exam-sync')
      if (error) throw error
      if (data && data.subjects) {
        setSubjects(data.subjects)
      }
    } catch (error) {
      console.error('Failed to fetch subjects:', error)
      // Fallback demo subjects if edge function not deployed
      setSubjects([
        { code: '21CS61', name: 'Software Engineering & Project Management' },
        { code: '21CS62', name: 'Fullstack Development' },
        { code: '21CS63', name: 'Computer Graphics and Fundamentals of Image Processing' },
        { code: '21CS641', name: 'Cryptography and Network Security' },
        { code: '21CSL66', name: 'Computer Graphics Laboratory' }
      ])
    } finally {
      setIsLoadingSubjects(false)
    }
  }

  const toggleSubject = (code: string) => {
    setSelectedSubjects(prev => 
      prev.includes(code) ? prev.filter(c => c !== code) : [...prev, code]
    )
  }

  const loadRazorpayScript = (): Promise<boolean> => {
    return new Promise((resolve) => {
      if ((window as any).Razorpay) {
        resolve(true);
        return;
      }
      const script = document.createElement('script');
      script.src = 'https://checkout.razorpay.com/v1/checkout.js';
      script.onload = () => resolve(true);
      script.onerror = () => resolve(false);
      document.body.appendChild(script);
    });
  };

  const handlePayment = async () => {
    let amount = 0;
    if (activeTab === 'revaluation') {
      amount = 500;
    } else {
      if (selectedSubjects.length === 0) {
        toast.error('Please select at least one subject');
        return;
      }
      amount = selectedSubjects.length * 300;
    }

    setIsProcessing(true);

    try {
      // 1. Load Razorpay SDK
      const loaded = await loadRazorpayScript();
      if (!loaded) {
        toast.error('Razorpay SDK failed to load. Check your internet connection.');
        setIsProcessing(false);
        return;
      }

      // 2. Create order via Edge Function
      const { data: orderData, error: orderError } = await supabase.functions.invoke('razorpay-create-order', {
        body: { amount, receipt: `rcpt_${user?.id?.substring(0, 8)}_${Date.now()}` }
      });

      if (orderError || !orderData?.id) {
        console.error('Order creation failed:', orderError, orderData);
        toast.error(orderData?.error || 'Failed to create payment order. Please try again.');
        setIsProcessing(false);
        return;
      }

      console.log('Razorpay order created:', orderData.id);

      // 3. Open Razorpay Checkout
      const options = {
        key: 'rzp_test_Su6bNJI8GYLGXS',
        amount: orderData.amount,
        currency: orderData.currency || 'INR',
        name: 'EduPredict Institutional Fees',
        description: activeTab === 'revaluation' ? 'Revaluation Application Fee' : 'Semester Exam Registration Fee',
        order_id: orderData.id,
        handler: async function (response: any) {
          // Payment succeeded
          console.log('Payment success:', response);
          const { error: insertError } = await supabase.from('fee_payments').insert({
            student_id: user?.id,
            payment_type: activeTab === 'revaluation' ? 'revaluation' : 'exam_registration',
            amount: amount,
            status: 'completed',
            razorpay_order_id: response.razorpay_order_id,
            razorpay_payment_id: response.razorpay_payment_id,
            subjects: activeTab === 'exam' ? selectedSubjects : null
          });
          if (insertError) {
            console.error('DB insert error:', insertError);
            toast.error('Payment succeeded but failed to save receipt. Contact admin.');
          } else {
            toast.success('Payment successful! Receipt sent to Mentor.');
            if (activeTab === 'exam') setSelectedSubjects([]);
          }
        },
        modal: {
          ondismiss: function () {
            toast('Payment cancelled.', { icon: '⚠️' });
          }
        },
        prefill: {
          name: user?.user_metadata?.full_name || 'Student',
          email: user?.email || '',
        },
        theme: {
          color: '#4f46e5'
        }
      };

      const rzp = new (window as any).Razorpay(options);
      rzp.on('payment.failed', function (response: any) {
        console.error('Payment failed:', response.error);
        toast.error(`Payment failed: ${response.error.description}`);
      });
      rzp.open();

    } catch (err: any) {
      console.error('Payment error:', err);
      toast.error('Something went wrong. Please try again.');
    } finally {
      setIsProcessing(false);
    }
  };

  return (
    <AppShell role="student">
      <div className="max-w-6xl mx-auto space-y-8">
        
        {/* Header */}
        <div className="flex flex-col sm:flex-row justify-between items-start sm:items-end gap-4">
          <div>
            <h1 className="text-3xl font-black text-slate-900 dark:text-white flex items-center gap-3">
              <CreditCard className="text-brand-600" size={32} />
              Fee Payments
            </h1>
            <p className="mt-2 text-slate-600 dark:text-slate-400">
              Manage your academic payments and registrations seamlessly.
            </p>
          </div>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          
          <div className="lg:col-span-2 space-y-6">
            {/* Tabs */}
            <div className="flex bg-slate-100 dark:bg-white/5 p-1.5 rounded-xl">
               <button 
                 onClick={() => setActiveTab('revaluation')}
                 className={`flex-1 py-3 text-sm font-bold rounded-lg transition-all ${activeTab === 'revaluation' ? 'bg-white dark:bg-brand-600 text-brand-900 dark:text-white shadow-sm' : 'text-slate-500 hover:text-slate-700 dark:text-slate-400 dark:hover:text-slate-200'}`}
               >
                 Revaluation Form
               </button>
               <button 
                 onClick={() => setActiveTab('exam')}
                 className={`flex-1 py-3 text-sm font-bold rounded-lg transition-all ${activeTab === 'exam' ? 'bg-white dark:bg-brand-600 text-brand-900 dark:text-white shadow-sm' : 'text-slate-500 hover:text-slate-700 dark:text-slate-400 dark:hover:text-slate-200'}`}
               >
                 Exam Registration
               </button>
            </div>

            <Card className="p-8 border border-slate-200 dark:border-white/10 shadow-sm">
               {activeTab === 'revaluation' ? (
                 <div className="space-y-6 animate-in fade-in slide-in-from-bottom-2">
                    <div className="flex items-center gap-4 text-brand-600 dark:text-brand-400">
                      <div className="p-3 bg-brand-50 dark:bg-brand-900/30 rounded-xl">
                        <FileText size={24} />
                      </div>
                      <div>
                        <h3 className="text-lg font-bold text-slate-900 dark:text-white">Apply for Revaluation</h3>
                        <p className="text-sm text-slate-500">Fast-track paper re-evaluation request.</p>
                      </div>
                    </div>
                    
                    <div className="bg-amber-50 dark:bg-amber-900/10 border border-amber-200 dark:border-amber-900/30 p-4 rounded-xl text-sm text-amber-800 dark:text-amber-300">
                      <strong>Note:</strong> The standard fee for revaluation is fixed at ₹500 per semester cycle. 
                      Ensure you have consulted with your mentor before proceeding.
                    </div>

                    <div className="pt-4 flex justify-between items-center border-t border-slate-100 dark:border-white/10">
                      <span className="text-slate-600 dark:text-slate-400 font-medium">Total Amount</span>
                      <span className="text-2xl font-black text-slate-900 dark:text-white">₹500.00</span>
                    </div>
                 </div>
               ) : (
                 <div className="space-y-6 animate-in fade-in slide-in-from-bottom-2">
                    <div className="flex items-center justify-between">
                      <div className="flex items-center gap-4 text-brand-600 dark:text-brand-400">
                        <div className="p-3 bg-brand-50 dark:bg-brand-900/30 rounded-xl">
                          <Calendar size={24} />
                        </div>
                        <div>
                          <h3 className="text-lg font-bold text-slate-900 dark:text-white">Semester Exam Registration</h3>
                          <p className="text-sm text-slate-500">Select subjects fetched directly from LERP.</p>
                        </div>
                      </div>
                      {isLoadingSubjects && <Loader2 size={18} className="animate-spin text-brand-500" />}
                    </div>

                    {!isLoadingSubjects && subjects.length === 0 ? (
                      <div className="text-center py-8 text-slate-500 bg-slate-50 dark:bg-white/5 rounded-xl border border-dashed border-slate-200 dark:border-white/10">
                         No subjects found. Please ensure your ERP credentials are valid.
                      </div>
                    ) : (
                      <div className="space-y-3 mt-6">
                        {subjects.map((sub, i) => (
                          <div 
                            key={i} 
                            onClick={() => toggleSubject(sub.code)}
                            className={`flex items-center p-4 rounded-xl border cursor-pointer transition-all ${
                              selectedSubjects.includes(sub.code)
                                ? 'border-brand-500 bg-brand-50 dark:bg-brand-900/20'
                                : 'border-slate-200 dark:border-white/10 hover:border-brand-300 bg-white dark:bg-[#13151a]'
                            }`}
                          >
                            <div className="flex-1">
                              <p className="font-bold text-slate-900 dark:text-white">{sub.code}</p>
                              <p className="text-sm text-slate-500 dark:text-slate-400">{sub.name}</p>
                            </div>
                            <div className={`w-6 h-6 rounded-full border-2 flex items-center justify-center ${
                              selectedSubjects.includes(sub.code) ? 'border-brand-600 bg-brand-600' : 'border-slate-300 dark:border-slate-600'
                            }`}>
                              {selectedSubjects.includes(sub.code) && <CheckCircle size={14} className="text-white" />}
                            </div>
                          </div>
                        ))}
                      </div>
                    )}

                    <div className="pt-4 flex justify-between items-center border-t border-slate-100 dark:border-white/10">
                      <span className="text-slate-600 dark:text-slate-400 font-medium">Total Amount ({selectedSubjects.length} subjects @ ₹300)</span>
                      <span className="text-2xl font-black text-slate-900 dark:text-white">₹{selectedSubjects.length * 300}.00</span>
                    </div>
                 </div>
               )}
            </Card>
          </div>

          {/* Right Sidebar */}
          <div className="space-y-6">
             <Card className="p-6 border border-slate-200 dark:border-white/10 shadow-sm sticky top-24">
                <h3 className="font-bold text-slate-900 dark:text-white mb-6">Payment Summary</h3>
                
                <div className="space-y-4 mb-6">
                   <div className="flex justify-between text-sm">
                      <span className="text-slate-500">Subtotal</span>
                      <span className="font-medium text-slate-900 dark:text-white">
                        ₹{activeTab === 'revaluation' ? 500 : selectedSubjects.length * 300}
                      </span>
                   </div>
                   <div className="flex justify-between text-sm">
                      <span className="text-slate-500">Convenience Fee</span>
                      <span className="font-medium text-slate-900 dark:text-white">₹0.00</span>
                   </div>
                   <div className="h-px bg-slate-200 dark:bg-white/10 w-full" />
                   <div className="flex justify-between">
                      <span className="font-bold text-slate-900 dark:text-white">Total</span>
                      <span className="font-black text-brand-600 text-lg">
                        ₹{activeTab === 'revaluation' ? 500 : selectedSubjects.length * 300}
                      </span>
                   </div>
                </div>

                <button 
                  onClick={handlePayment}
                  disabled={isProcessing || (activeTab === 'exam' && selectedSubjects.length === 0)}
                  className="w-full flex items-center justify-center gap-2 py-4 bg-brand-600 hover:bg-brand-700 disabled:bg-slate-300 dark:disabled:bg-white/10 text-white rounded-xl font-bold transition-all disabled:cursor-not-allowed shadow-md shadow-brand-500/20"
                >
                  {isProcessing ? <Loader2 size={18} className="animate-spin" /> : 'Pay with Razorpay'}
                </button>

                <div className="mt-4 flex items-center justify-center gap-2 text-xs text-slate-400">
                  <CheckCircle size={12} className="text-emerald-500" />
                  Secured by Razorpay Test API
                </div>
             </Card>
          </div>

        </div>
      </div>
    </AppShell>
  )
}
