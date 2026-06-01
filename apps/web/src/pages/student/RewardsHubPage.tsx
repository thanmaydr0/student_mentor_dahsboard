import React, { useEffect, useState } from 'react';
import { supabase } from '../../lib/supabase';
import { useAuth } from '../../hooks/useAuth';
import { Coins, ArrowUpRight, ArrowDownRight, Sparkles, CheckCircle2 } from 'lucide-react';
import toast from 'react-hot-toast';

export default function RewardsHubPage() {
  const { user } = useAuth();
  const [balance, setBalance] = useState(0);
  const [transactions, setTransactions] = useState<any[]>([]);
  const [isPremium, setIsPremium] = useState(false);
  const [loading, setLoading] = useState(true);
  const [purchasing, setPurchasing] = useState(false);

  useEffect(() => {
    if (user) {
      fetchWalletData();
    }
  }, [user]);

  const fetchWalletData = async () => {
    if (!user) return;
    
    // Fetch balance
    const { data: walletData } = await supabase
      .from('user_wallets')
      .select('balance')
      .eq('user_id', user.id)
      .single();
    
    if (walletData) setBalance(walletData.balance);

    // Fetch subscription
    const { data: subData } = await supabase
      .from('user_subscriptions')
      .select('is_premium')
      .eq('user_id', user.id)
      .single();
    
    if (subData) setIsPremium(subData.is_premium);

    // Fetch transactions
    const { data: txData } = await supabase
      .from('token_transactions')
      .select('*')
      .order('created_at', { ascending: false })
      .limit(10);
      
    if (txData) setTransactions(txData);

    setLoading(false);
  };

  const handlePurchasePlus = async () => {
    if (balance < 500) {
      toast.error('Not enough TeserCoins!');
      return;
    }
    
    setPurchasing(true);
    const { data, error } = await supabase.rpc('purchase_premium');
    
    if (error || !data?.success) {
      toast.error(data?.error || 'Failed to purchase subscription');
    } else {
      toast.success('Welcome to EduPredict Plus!');
      fetchWalletData();
    }
    setPurchasing(false);
  };

  if (loading) return <div className="p-8 text-center text-gray-500">Loading wallet...</div>;

  return (
    <div className="max-w-5xl mx-auto p-6">
      <div className="mb-8">
        <h1 className="text-3xl font-bold text-gray-900">Rewards Hub</h1>
        <p className="text-gray-600 mt-2">Earn TeserCoins by helping peers and unlock premium features.</p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        {/* Wallet Card */}
        <div className="bg-gradient-to-br from-indigo-900 to-indigo-700 rounded-2xl p-6 text-white shadow-lg col-span-1">
          <div className="flex items-center space-x-2 text-indigo-200 mb-4">
            <Coins size={20} />
            <span className="font-medium">TeserCoin Balance</span>
          </div>
          <div className="text-5xl font-bold mb-2">{balance} <span className="text-2xl text-indigo-300">TSR</span></div>
          <p className="text-indigo-200 text-sm">Earn 50 TSR by fulfilling resource requests!</p>
        </div>

        {/* Premium Upgrade Card */}
        <div className="bg-white rounded-2xl p-6 border border-amber-200 shadow-sm col-span-2 relative overflow-hidden">
          <div className="absolute top-0 right-0 p-6 opacity-10">
            <Sparkles size={120} className="text-amber-500" />
          </div>
          
          <div className="relative z-10">
            <div className="flex items-center space-x-2 mb-2">
              <span className="px-3 py-1 bg-amber-100 text-amber-800 rounded-full text-xs font-bold tracking-wider">PREMIUM</span>
              {isPremium && <span className="text-green-600 text-sm font-bold flex items-center"><CheckCircle2 size={16} className="mr-1"/> Active</span>}
            </div>
            <h2 className="text-2xl font-bold text-gray-900 mb-2">EduPredict Plus</h2>
            <p className="text-gray-600 mb-6 max-w-md">Upgrade your account to unlock advanced AI models (GPT-4o), unlimited alumni connections, and priority resume reviews.</p>
            
            <button 
              onClick={handlePurchasePlus}
              disabled={isPremium || purchasing || balance < 500}
              className={`px-6 py-3 rounded-xl font-bold transition-all shadow-sm ${
                isPremium ? 'bg-gray-100 text-gray-500 cursor-not-allowed' :
                balance < 500 ? 'bg-gray-100 text-gray-400 cursor-not-allowed' :
                'bg-gradient-to-r from-amber-400 to-amber-500 text-amber-950 hover:shadow-md hover:scale-105'
              }`}
            >
              {purchasing ? 'Processing...' : isPremium ? 'Plus Active' : 'Upgrade for 500 TSR / month'}
            </button>
          </div>
        </div>
      </div>

      {/* Transaction Ledger */}
      <div className="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
        <div className="px-6 py-4 border-b border-gray-100 bg-gray-50">
          <h3 className="text-lg font-bold text-gray-900">Transaction History</h3>
        </div>
        <div className="divide-y divide-gray-100">
          {transactions.length === 0 ? (
            <div className="p-8 text-center text-gray-500">No transactions yet. Start helping students to earn TeserCoins!</div>
          ) : (
            transactions.map(tx => (
              <div key={tx.id} className="p-6 flex items-center justify-between hover:bg-gray-50 transition-colors">
                <div className="flex items-center space-x-4">
                  <div className={`p-3 rounded-full ${tx.transaction_type === 'earned' ? 'bg-green-100 text-green-600' : 'bg-red-100 text-red-600'}`}>
                    {tx.transaction_type === 'earned' ? <ArrowDownRight size={20} /> : <ArrowUpRight size={20} />}
                  </div>
                  <div>
                    <p className="font-semibold text-gray-900">{tx.description}</p>
                    <p className="text-sm text-gray-500">{new Date(tx.created_at).toLocaleDateString()} at {new Date(tx.created_at).toLocaleTimeString()}</p>
                  </div>
                </div>
                <div className={`text-lg font-bold ${tx.transaction_type === 'earned' ? 'text-green-600' : 'text-gray-900'}`}>
                  {tx.transaction_type === 'earned' ? '+' : '-'}{tx.amount} TSR
                </div>
              </div>
            ))
          )}
        </div>
      </div>
    </div>
  );
}
