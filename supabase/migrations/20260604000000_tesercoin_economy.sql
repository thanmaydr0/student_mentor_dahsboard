-- 1. Create Wallets Table
CREATE TABLE public.user_wallets (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE UNIQUE NOT NULL,
    balance INTEGER DEFAULT 0 NOT NULL CHECK (balance >= 0),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 2. Create Transactions Ledger
CREATE TABLE public.token_transactions (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    wallet_id UUID REFERENCES public.user_wallets(id) ON DELETE CASCADE NOT NULL,
    amount INTEGER NOT NULL,
    transaction_type TEXT NOT NULL CHECK (transaction_type IN ('earned', 'spent')),
    description TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 3. Create Subscriptions Table
CREATE TABLE public.user_subscriptions (
    user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE PRIMARY KEY,
    is_premium BOOLEAN DEFAULT false NOT NULL,
    premium_until TIMESTAMP WITH TIME ZONE,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Turn on RLS
ALTER TABLE public.user_wallets ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.token_transactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_subscriptions ENABLE ROW LEVEL SECURITY;

-- Policies
CREATE POLICY "Users can view their own wallet" 
    ON public.user_wallets FOR SELECT 
    USING (auth.uid() = user_id);

CREATE POLICY "Users can view their own transactions" 
    ON public.token_transactions FOR SELECT 
    USING (wallet_id IN (SELECT id FROM public.user_wallets WHERE user_id = auth.uid()));

CREATE POLICY "Users can view their subscription" 
    ON public.user_subscriptions FOR SELECT 
    USING (auth.uid() = user_id);

-- Initialize wallets and subscriptions for existing users
INSERT INTO public.user_wallets (user_id, balance)
SELECT id, 100 FROM public.profiles -- Give everyone a 100 TSR starting bonus!
ON CONFLICT (user_id) DO NOTHING;

INSERT INTO public.user_subscriptions (user_id)
SELECT id FROM public.profiles
ON CONFLICT (user_id) DO NOTHING;

-- Trigger to create wallet and sub for new users
CREATE OR REPLACE FUNCTION public.handle_new_user_economy() 
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.user_wallets (user_id, balance) VALUES (NEW.id, 100);
    INSERT INTO public.user_subscriptions (user_id) VALUES (NEW.id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_profile_created_economy
    AFTER INSERT ON public.profiles
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_user_economy();

-- 4. RPC to Purchase Premium (EduPredict Plus)
CREATE OR REPLACE FUNCTION public.purchase_premium()
RETURNS json AS $$
DECLARE
    v_wallet_id UUID;
    v_balance INTEGER;
    v_cost INTEGER := 500;
BEGIN
    -- Get wallet info
    SELECT id, balance INTO v_wallet_id, v_balance 
    FROM public.user_wallets 
    WHERE user_id = auth.uid();

    IF v_balance < v_cost THEN
        RETURN json_build_object('success', false, 'error', 'Insufficient TeserCoins');
    END IF;

    -- Deduct tokens
    UPDATE public.user_wallets 
    SET balance = balance - v_cost 
    WHERE id = v_wallet_id;

    -- Log transaction
    INSERT INTO public.token_transactions (wallet_id, amount, transaction_type, description)
    VALUES (v_wallet_id, v_cost, 'spent', 'Purchased 30-Day EduPredict Plus Subscription');

    -- Grant Premium
    UPDATE public.user_subscriptions
    SET is_premium = true,
        premium_until = now() + interval '30 days',
        updated_at = now()
    WHERE user_id = auth.uid();

    RETURN json_build_object('success', true, 'message', 'Premium activated!');
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 5. RPC for Mentors to Award Tokens
CREATE OR REPLACE FUNCTION public.mentor_award_tokens(p_student_id UUID, p_amount INTEGER, p_reason TEXT)
RETURNS json AS $$
DECLARE
    v_mentor_role TEXT;
    v_wallet_id UUID;
BEGIN
    -- Verify the caller is a mentor
    SELECT role INTO v_mentor_role FROM public.profiles WHERE id = auth.uid();
    IF v_mentor_role != 'mentor' THEN
        RETURN json_build_object('success', false, 'error', 'Only mentors can award tokens');
    END IF;

    -- Get student wallet
    SELECT id INTO v_wallet_id FROM public.user_wallets WHERE user_id = p_student_id;

    -- Add tokens
    UPDATE public.user_wallets 
    SET balance = balance + p_amount 
    WHERE id = v_wallet_id;

    -- Log transaction
    INSERT INTO public.token_transactions (wallet_id, amount, transaction_type, description)
    VALUES (v_wallet_id, p_amount, 'earned', p_reason);

    RETURN json_build_object('success', true);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 6. Trigger to automatically award 50 TSR when a resource request is fulfilled
CREATE OR REPLACE FUNCTION public.reward_resource_fulfillment()
RETURNS TRIGGER AS $$
DECLARE
    v_wallet_id UUID;
BEGIN
    -- If status changed from pending to fulfilled
    IF OLD.status = 'pending' AND NEW.status = 'fulfilled' AND NEW.fulfilled_by IS NOT NULL THEN
        
        -- Find the fulfiller's wallet
        SELECT id INTO v_wallet_id FROM public.user_wallets WHERE user_id = NEW.fulfilled_by;

        IF v_wallet_id IS NOT NULL THEN
            -- Add 50 TSR
            UPDATE public.user_wallets SET balance = balance + 50 WHERE id = v_wallet_id;

            -- Log transaction
            INSERT INTO public.token_transactions (wallet_id, amount, transaction_type, description)
            VALUES (v_wallet_id, 50, 'earned', 'Educator Bounty: Fulfilled a resource request');
        END IF;

    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_resource_fulfilled
    AFTER UPDATE ON public.resource_requests
    FOR EACH ROW EXECUTE FUNCTION public.reward_resource_fulfillment();
