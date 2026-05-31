import { BaseRepository } from './BaseRepository';
import { supabase } from '../../lib/supabase';

export interface Intervention {
  id: string;
  student_id: string;
  mentor_id: string;
  type: string;
  notes: string;
  date: string;
  created_at: string;
}

export class InterventionService extends BaseRepository<Intervention> {
  constructor() {
    super('interventions');
  }

  async getByStudentId(studentId: string): Promise<Intervention[]> {
    const { data, error } = await supabase
      .from(this.tableName)
      .select('*')
      .eq('student_id', studentId)
      .order('created_at', { ascending: false });
      
    if (error) throw error;
    return data as Intervention[];
  }

  async bulkCreate(payloads: Partial<Intervention>[]): Promise<void> {
    const { error } = await supabase.from(this.tableName).insert(payloads);
    if (error) throw error;
  }
}

export const interventionService = new InterventionService();
