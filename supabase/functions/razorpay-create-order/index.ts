const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }

  try {
    const body = await req.json();
    const amount = body.amount;
    const receipt = body.receipt;

    if (!amount || amount <= 0) {
      throw new Error('Invalid amount');
    }

    // Razorpay expects amount in paise (1 INR = 100 paise)
    const amountInPaise = Math.round(amount * 100);

    const RAZORPAY_KEY_ID = 'rzp_test_Su6bNJI8GYLGXS';
    const RAZORPAY_KEY_SECRET = 'ruGMHotiocKxUIncwpQpefjN';

    const auth = btoa(`${RAZORPAY_KEY_ID}:${RAZORPAY_KEY_SECRET}`);

    console.log(`[razorpay] Creating order: ${amountInPaise} paise, receipt=${receipt}`);

    const response = await fetch('https://api.razorpay.com/v1/orders', {
      method: 'POST',
      headers: {
        'Authorization': `Basic ${auth}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        amount: amountInPaise,
        currency: 'INR',
        receipt: receipt || `rcpt_${Date.now()}`
      }),
    });

    const data = await response.json();
    console.log(`[razorpay] Response: status=${response.status}`, JSON.stringify(data));

    if (!response.ok) {
      return new Response(JSON.stringify({
        error: data.error?.description || 'Razorpay API error',
        razorpay_error: data
      }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        status: 400,
      });
    }

    return new Response(JSON.stringify(data), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  } catch (error: any) {
    console.error('[razorpay] Error:', error.message);
    return new Response(JSON.stringify({ error: error.message }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 400,
    });
  }
});
