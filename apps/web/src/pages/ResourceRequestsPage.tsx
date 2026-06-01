import React, { useEffect, useState } from 'react';
import { supabase } from '../lib/supabase';
import { useAuth } from '../hooks/useAuth';
import { RequestCard } from '../components/resources/RequestCard';
import { Plus } from 'lucide-react';

export default function ResourceRequestsPage() {
  const { user } = useAuth();
  const [requests, setRequests] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [isCreating, setIsCreating] = useState(false);
  const [newRequest, setNewRequest] = useState({ title: '', description: '' });
  const [filter, setFilter] = useState<'all' | 'pending' | 'mine'>('all');

  const fetchRequests = async () => {
    setLoading(true);
    let query = supabase
      .from('resource_requests')
      .select(`
        *,
        profiles!resource_requests_requester_id_fkey(full_name),
        fulfiller:profiles!resource_requests_fulfilled_by_fkey(full_name),
        subscribers:resource_request_subscribers(user_id)
      `)
      .order('created_at', { ascending: false });

    if (filter === 'pending') {
      query = query.eq('status', 'pending');
    }

    const { data, error } = await query;
    
    if (error) {
      console.error(error);
    } else {
      let filteredData = data;
      if (filter === 'mine' && user) {
        filteredData = data.filter(r => 
          r.requester_id === user.id || 
          r.subscribers?.some((s: any) => s.user_id === user.id)
        );
      }
      setRequests(filteredData || []);
    }
    setLoading(false);
  };

  useEffect(() => {
    fetchRequests();
  }, [filter, user]);

  const handleCreateRequest = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!user) return;

    const { data, error } = await supabase
      .from('resource_requests')
      .insert({
        requester_id: user.id,
        title: newRequest.title,
        description: newRequest.description
      })
      .select()
      .single();

    if (!error && data) {
      // Auto-subscribe the creator
      await supabase
        .from('resource_request_subscribers')
        .insert({ request_id: data.id, user_id: user.id });

      setIsCreating(false);
      setNewRequest({ title: '', description: '' });
      fetchRequests();
    }
  };

  return (
    <div className="max-w-4xl mx-auto p-6">
      <div className="flex justify-between items-center mb-8">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Peer Resources</h1>
          <p className="text-gray-600 mt-2">Request notes, question papers, and study materials from other students.</p>
        </div>
        <button 
          onClick={() => setIsCreating(true)}
          className="flex items-center px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 font-medium transition-colors"
        >
          <Plus className="w-5 h-5 mr-2" />
          New Request
        </button>
      </div>

      <div className="flex space-x-2 mb-6">
        {['all', 'pending', 'mine'].map((f) => (
          <button
            key={f}
            onClick={() => setFilter(f as any)}
            className={`px-4 py-2 rounded-lg text-sm font-medium capitalize transition-colors ${
              filter === f 
                ? 'bg-gray-900 text-white' 
                : 'bg-white text-gray-600 hover:bg-gray-50 border border-gray-200'
            }`}
          >
            {f === 'mine' ? 'My Resources' : `${f} Requests`}
          </button>
        ))}
      </div>

      {isCreating && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
          <div className="bg-white rounded-xl p-6 w-full max-w-md shadow-xl">
            <h2 className="text-xl font-bold mb-4">Request a Resource</h2>
            <form onSubmit={handleCreateRequest} className="space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">What do you need?</label>
                <input 
                  type="text" 
                  required
                  placeholder="e.g. Physics Chapter 4 PDF Notes"
                  value={newRequest.title}
                  onChange={e => setNewRequest({...newRequest, title: e.target.value})}
                  className="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-indigo-500"
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Details (Optional)</label>
                <textarea 
                  rows={3}
                  placeholder="Any specific professor's notes or topics?"
                  value={newRequest.description}
                  onChange={e => setNewRequest({...newRequest, description: e.target.value})}
                  className="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-indigo-500"
                />
              </div>
              <div className="flex justify-end space-x-3 pt-4">
                <button 
                  type="button" 
                  onClick={() => setIsCreating(false)}
                  className="px-4 py-2 text-gray-600 hover:bg-gray-100 rounded-lg"
                >
                  Cancel
                </button>
                <button 
                  type="submit"
                  className="px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700"
                >
                  Post Request
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {loading ? (
        <div className="text-center py-12 text-gray-500">Loading requests...</div>
      ) : requests.length === 0 ? (
        <div className="text-center py-12 bg-white rounded-xl border border-gray-100">
          <h3 className="text-lg font-medium text-gray-900 mb-2">No requests found</h3>
          <p className="text-gray-500">Be the first to request a study resource!</p>
        </div>
      ) : (
        <div className="space-y-4">
          {requests.map(request => (
            <RequestCard 
              key={request.id} 
              request={request} 
              onUpdate={fetchRequests} 
            />
          ))}
        </div>
      )}
    </div>
  );
};
