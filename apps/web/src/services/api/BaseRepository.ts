import { supabase } from '../../lib/supabase'

export class BaseRepository<T> {
  protected tableName: string;

  constructor(tableName: string) {
    this.tableName = tableName;
  }

  async getAll(): Promise<T[]> {
    const { data, error } = await supabase.from(this.tableName).select('*');
    if (error) throw error;
    return data as T[];
  }

  async getById(id: string): Promise<T | null> {
    const { data, error } = await supabase.from(this.tableName).select('*').eq('id', id).single();
    if (error) throw error;
    return data as T;
  }

  async create(payload: Partial<T>): Promise<T> {
    const { data, error } = await supabase.from(this.tableName).insert(payload).select().single();
    if (error) throw error;
    return data as T;
  }

  async update(id: string, payload: Partial<T>): Promise<T> {
    const { data, error } = await supabase.from(this.tableName).update(payload).eq('id', id).select().single();
    if (error) throw error;
    return data as T;
  }

  async delete(id: string): Promise<void> {
    const { error } = await supabase.from(this.tableName).delete().eq('id', id);
    if (error) throw error;
  }
}
