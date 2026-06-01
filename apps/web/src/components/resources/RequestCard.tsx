import React, { useState } from 'react';
import { supabase } from '../../lib/supabase';
import { useAuth } from '../../hooks/useAuth';

interface RequestCardProps {
  request: any;
  onUpdate: () => void;
}

export const RequestCard: React.FC<RequestCardProps> = ({ request, onUpdate }) => {
  const { user } = useAuth();
  const [isFulfilling, setIsFulfilling] = useState(false);
  const [fileUrl, setFileUrl] = useState('');
  const [uploading, setUploading] = useState(false);

  const isSubscribed = request.subscribers?.some((s: any) => s.user_id === user?.id);
  const isCreator = request.requester_id === user?.id;

  const handleSubscribe = async () => {
    if (!user) return;
    const { error } = await supabase
      .from('resource_request_subscribers')
      .insert({ request_id: request.id, user_id: user.id });
    if (!error) onUpdate();
  };

  const handleFulfill = async () => {
    if (!user || !fileUrl) return;
    const { error } = await supabase
      .from('resource_requests')
      .update({ status: 'fulfilled', fulfilled_by: user.id, file_url: fileUrl })
      .eq('id', request.id);
    if (!error) {
      setIsFulfilling(false);
      onUpdate();
    }
  };

  const handleFileUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    if (!e.target.files || e.target.files.length === 0) return;
    const file = e.target.files[0];
    setUploading(true);
    
    const fileExt = file.name.split('.').pop();
    const fileName = `${Math.random()}.${fileExt}`;
    const filePath = `${fileName}`;

    const { error: uploadError } = await supabase.storage
      .from('resources')
      .upload(filePath, file);

    if (uploadError) {
      console.error(uploadError);
      alert('Error uploading file!');
    } else {
      const { data } = supabase.storage.from('resources').getPublicUrl(filePath);
      setFileUrl(data.publicUrl);
    }
    setUploading(false);
  };

  return (
    <div className="bg-white rounded-xl shadow-sm border border-gray-100 p-6 hover:shadow-md transition-shadow">
      <div className="flex justify-between items-start mb-4">
        <div>
          <h3 className="text-lg font-bold text-gray-900">{request.title}</h3>
          <p className="text-sm text-gray-500 mt-1">Requested by {request.profiles?.full_name}</p>
        </div>
        <span className={`px-3 py-1 rounded-full text-xs font-semibold ${
          request.status === 'fulfilled' ? 'bg-green-100 text-green-700' : 'bg-yellow-100 text-yellow-700'
        }`}>
          {request.status.toUpperCase()}
        </span>
      </div>

      <p className="text-gray-700 mb-6">{request.description}</p>

      {request.status === 'pending' && (
        <div className="flex items-center justify-between border-t border-gray-100 pt-4">
          <div className="flex items-center text-sm text-gray-600">
            <span className="font-semibold mr-1">{request.subscribers?.length || 0}</span> students waiting
          </div>
          
          <div className="flex space-x-3">
            {!isSubscribed && !isCreator && (
              <button 
                onClick={handleSubscribe}
                className="px-4 py-2 bg-indigo-50 text-indigo-700 rounded-lg hover:bg-indigo-100 transition-colors text-sm font-medium"
              >
                I need this too
              </button>
            )}
            <button 
              onClick={() => setIsFulfilling(!isFulfilling)}
              className="px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 transition-colors text-sm font-medium"
            >
              Fulfill Request
            </button>
          </div>
        </div>
      )}

      {isFulfilling && (
        <div className="mt-4 p-4 bg-gray-50 rounded-lg border border-gray-200">
          <h4 className="text-sm font-semibold mb-3">Provide Resource</h4>
          <div className="space-y-3">
            <div>
              <label className="block text-xs text-gray-500 mb-1">Upload File</label>
              <input type="file" onChange={handleFileUpload} disabled={uploading} className="text-sm" />
            </div>
            <div className="text-xs text-gray-400 text-center">OR</div>
            <div>
              <label className="block text-xs text-gray-500 mb-1">Paste Link (Google Drive, etc.)</label>
              <input 
                type="text" 
                value={fileUrl} 
                onChange={(e) => setFileUrl(e.target.value)}
                placeholder="https://..."
                className="w-full px-3 py-2 border rounded-md text-sm"
              />
            </div>
            <button 
              onClick={handleFulfill}
              disabled={!fileUrl}
              className="w-full mt-2 py-2 bg-green-600 text-white rounded-md text-sm font-medium disabled:opacity-50"
            >
              {uploading ? 'Uploading...' : 'Submit Resource'}
            </button>
          </div>
        </div>
      )}

      {request.status === 'fulfilled' && (isSubscribed || isCreator || request.fulfilled_by === user?.id) && (
        <div className="mt-4 p-4 bg-green-50 rounded-lg border border-green-200">
          <p className="text-sm text-green-800 mb-2">
            <strong>Fulfilled by:</strong> {request.fulfiller?.full_name}
          </p>
          <a 
            href={request.file_url} 
            target="_blank" 
            rel="noopener noreferrer"
            className="inline-flex items-center px-4 py-2 bg-white border border-green-300 text-green-700 rounded-lg hover:bg-green-50 text-sm font-medium transition-colors"
          >
            Access Resource
          </a>
        </div>
      )}
    </div>
  );
};
