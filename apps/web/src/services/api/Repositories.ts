import { BaseRepository } from './BaseRepository';
import { supabase } from '../../lib/supabase';

// Profiles
export class ProfileService extends BaseRepository<any> {
  constructor() { super('profiles'); }
  async getStudentInfo(id: string) {
    const { data, error } = await supabase.from(this.tableName).select('full_name, branch, semester').eq('id', id).single();
    if (error) throw error;
    return data;
  }
}

// Attendance
export class AttendanceService extends BaseRepository<any> {
  constructor() { super('attendance'); }
  async getSummary(studentId: string) {
    const { data, error } = await supabase.rpc('get_attendance_summary', { p_student_id: studentId });
    if (error) throw error;
    return data;
  }
}

// Grades
export class GradesService extends BaseRepository<any> {
  constructor() { super('grades'); }
  async getGradesWithSubjects(studentId: string) {
    const { data, error } = await supabase.from(this.tableName).select('*, classes(subjects(name))').eq('student_id', studentId);
    if (error) throw error;
    return data;
  }
}

// Auth
export class AuthService {
  async getCurrentUser() {
    const { data: { user }, error } = await supabase.auth.getUser();
    if (error) throw error;
    return user;
  }
}

export const profileService = new ProfileService();
export const attendanceService = new AttendanceService();
export const gradesService = new GradesService();
export const authService = new AuthService();
