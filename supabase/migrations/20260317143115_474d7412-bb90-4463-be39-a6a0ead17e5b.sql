CREATE TABLE public.quiz_attempts (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL,
  grade TEXT NOT NULL,
  subject TEXT NOT NULL,
  chapter TEXT NOT NULL DEFAULT 'Unknown',
  difficulty TEXT NOT NULL DEFAULT 'medium',
  score NUMERIC NOT NULL DEFAULT 0,
  correct_answers INTEGER NOT NULL DEFAULT 0,
  total_questions INTEGER NOT NULL DEFAULT 0,
  time_spent TEXT NOT NULL DEFAULT '',
  attempted_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

ALTER TABLE public.quiz_attempts ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their own attempts"
  ON public.quiz_attempts FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own attempts"
  ON public.quiz_attempts FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete their own attempts"
  ON public.quiz_attempts FOR DELETE
  TO authenticated
  USING (auth.uid() = user_id);