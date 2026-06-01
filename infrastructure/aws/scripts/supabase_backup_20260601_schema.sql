--
-- PostgreSQL database dump
--

\restrict fua2B22zYQ1CfhGrf8vTmXWCcMLFjFs5WKcnFAnT78DezUgchw91wjUXMqmbn11

-- Dumped from database version 17.6
-- Dumped by pg_dump version 18.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP POLICY IF EXISTS "users_update_own_user_notifications" ON "public"."user_notifications";
DROP POLICY IF EXISTS "users_update_own_profile" ON "public"."profiles";
DROP POLICY IF EXISTS "users_select_own_user_notifications" ON "public"."user_notifications";
DROP POLICY IF EXISTS "users_select_own_profile" ON "public"."profiles";
DROP POLICY IF EXISTS "users_insert_own_profile" ON "public"."profiles";
DROP POLICY IF EXISTS "students_select_reports" ON "public"."reports";
DROP POLICY IF EXISTS "students_select_own_iat_marks" ON "public"."iat_marks";
DROP POLICY IF EXISTS "students_select_own_grades" ON "public"."grades";
DROP POLICY IF EXISTS "students_select_own_enrollments" ON "public"."enrollments";
DROP POLICY IF EXISTS "students_select_own_attendance" ON "public"."attendance";
DROP POLICY IF EXISTS "students_select_enrolled_classes" ON "public"."classes";
DROP POLICY IF EXISTS "students_select_class_mentors" ON "public"."profiles";
DROP POLICY IF EXISTS "students_select_assigned_mentor" ON "public"."profiles";
DROP POLICY IF EXISTS "parents_select_linked_students_grades" ON "public"."grades";
DROP POLICY IF EXISTS "parents_select_linked_students_enrollments" ON "public"."enrollments";
DROP POLICY IF EXISTS "parents_select_linked_students_classes" ON "public"."classes";
DROP POLICY IF EXISTS "parents_select_linked_students_attendance" ON "public"."attendance";
DROP POLICY IF EXISTS "parents_select_linked_students" ON "public"."profiles";
DROP POLICY IF EXISTS "mentors_update_timetables" ON "public"."timetables";
DROP POLICY IF EXISTS "mentors_update_subjects" ON "public"."subjects";
DROP POLICY IF EXISTS "mentors_update_own_classes" ON "public"."classes";
DROP POLICY IF EXISTS "mentors_update_iat_marks" ON "public"."iat_marks";
DROP POLICY IF EXISTS "mentors_update_grades_for_assigned_students" ON "public"."grades";
DROP POLICY IF EXISTS "mentors_update_attendance_for_assigned_students" ON "public"."attendance";
DROP POLICY IF EXISTS "mentors_select_reports" ON "public"."reports";
DROP POLICY IF EXISTS "mentors_select_own_classes" ON "public"."classes";
DROP POLICY IF EXISTS "mentors_select_class_enrollments" ON "public"."enrollments";
DROP POLICY IF EXISTS "mentors_select_assigned_students_grades" ON "public"."grades";
DROP POLICY IF EXISTS "mentors_select_assigned_students_attendance" ON "public"."attendance";
DROP POLICY IF EXISTS "mentors_select_assigned_students" ON "public"."profiles";
DROP POLICY IF EXISTS "mentors_select_assigned_parents" ON "public"."profiles";
DROP POLICY IF EXISTS "mentors_select_assigned_iat_marks" ON "public"."iat_marks";
DROP POLICY IF EXISTS "mentors_insert_timetables" ON "public"."timetables";
DROP POLICY IF EXISTS "mentors_insert_subjects" ON "public"."subjects";
DROP POLICY IF EXISTS "mentors_insert_reports" ON "public"."reports";
DROP POLICY IF EXISTS "mentors_insert_own_classes" ON "public"."classes";
DROP POLICY IF EXISTS "mentors_insert_iat_marks" ON "public"."iat_marks";
DROP POLICY IF EXISTS "mentors_insert_grades_for_assigned_students" ON "public"."grades";
DROP POLICY IF EXISTS "mentors_insert_enrollments" ON "public"."enrollments";
DROP POLICY IF EXISTS "mentors_insert_attendance_for_assigned_students" ON "public"."attendance";
DROP POLICY IF EXISTS "mentors_delete_timetables" ON "public"."timetables";
DROP POLICY IF EXISTS "mentors_delete_subjects" ON "public"."subjects";
DROP POLICY IF EXISTS "mentors_delete_enrollments" ON "public"."enrollments";
DROP POLICY IF EXISTS "authenticated_select_timetables" ON "public"."timetables";
DROP POLICY IF EXISTS "authenticated_select_subjects" ON "public"."subjects";
DROP POLICY IF EXISTS "authenticated_select_notification_messages" ON "public"."notification_messages";
DROP POLICY IF EXISTS "Users can view their own achievements" ON "public"."achievements";
DROP POLICY IF EXISTS "Users can update their received messages (e.g. read_at)" ON "public"."direct_messages";
DROP POLICY IF EXISTS "Users can update their own achievements" ON "public"."achievements";
DROP POLICY IF EXISTS "Users can read their own parent_student_links" ON "public"."parent_student_links";
DROP POLICY IF EXISTS "Users can read their messages" ON "public"."direct_messages";
DROP POLICY IF EXISTS "Users can read career metrics" ON "public"."career_metrics";
DROP POLICY IF EXISTS "Users can insert their own achievements" ON "public"."achievements";
DROP POLICY IF EXISTS "Users can insert their messages" ON "public"."direct_messages";
DROP POLICY IF EXISTS "Users can delete their own achievements" ON "public"."achievements";
DROP POLICY IF EXISTS "Students can view their own semester results" ON "public"."semester_results";
DROP POLICY IF EXISTS "Students can view own resumes" ON "public"."resumes";
DROP POLICY IF EXISTS "Students can view own erp attendance" ON "public"."erp_attendance_summary";
DROP POLICY IF EXISTS "Students can view own credentials" ON "public"."erp_credentials";
DROP POLICY IF EXISTS "Students can view own cover letters" ON "public"."cover_letters";
DROP POLICY IF EXISTS "Students can view own applications" ON "public"."job_applications";
DROP POLICY IF EXISTS "Students can update own resumes" ON "public"."resumes";
DROP POLICY IF EXISTS "Students can update own payments" ON "public"."fee_payments";
DROP POLICY IF EXISTS "Students can update own credentials" ON "public"."erp_credentials";
DROP POLICY IF EXISTS "Students can update own cover letters" ON "public"."cover_letters";
DROP POLICY IF EXISTS "Students can update own applications" ON "public"."job_applications";
DROP POLICY IF EXISTS "Students can insert own resumes" ON "public"."resumes";
DROP POLICY IF EXISTS "Students can insert own payments" ON "public"."fee_payments";
DROP POLICY IF EXISTS "Students can insert own credentials" ON "public"."erp_credentials";
DROP POLICY IF EXISTS "Students can insert own cover letters" ON "public"."cover_letters";
DROP POLICY IF EXISTS "Students can insert own applications" ON "public"."job_applications";
DROP POLICY IF EXISTS "Students can delete own resumes" ON "public"."resumes";
DROP POLICY IF EXISTS "Students can delete own cover letters" ON "public"."cover_letters";
DROP POLICY IF EXISTS "Students can delete own applications" ON "public"."job_applications";
DROP POLICY IF EXISTS "Service role can manage erp attendance" ON "public"."erp_attendance_summary";
DROP POLICY IF EXISTS "Mentors can view their students grades" ON "public"."grades";
DROP POLICY IF EXISTS "Mentors can view their students attendance" ON "public"."attendance";
DROP POLICY IF EXISTS "Mentors can view their own interventions" ON "public"."interventions";
DROP POLICY IF EXISTS "Mentors can view student erp attendance" ON "public"."erp_attendance_summary";
DROP POLICY IF EXISTS "Mentors can view mentee fee payments" ON "public"."fee_payments";
DROP POLICY IF EXISTS "Mentors can view all semester results" ON "public"."semester_results";
DROP POLICY IF EXISTS "Mentors can update their own interventions" ON "public"."interventions";
DROP POLICY IF EXISTS "Mentors can update grades for their students" ON "public"."grades";
DROP POLICY IF EXISTS "Mentors can update attendance for their students" ON "public"."attendance";
DROP POLICY IF EXISTS "Mentors can manage their created codes" ON "public"."parent_access_codes";
DROP POLICY IF EXISTS "Mentors can insert grades for their students" ON "public"."grades";
DROP POLICY IF EXISTS "Mentors can insert attendance for their students" ON "public"."attendance";
DROP POLICY IF EXISTS "Mentors can delete their own interventions" ON "public"."interventions";
DROP POLICY IF EXISTS "Mentors can create their own interventions" ON "public"."interventions";
DROP POLICY IF EXISTS "Enable update for service role" ON "public"."telegram_sessions";
DROP POLICY IF EXISTS "Enable update for service role" ON "public"."parent_access_codes";
DROP POLICY IF EXISTS "Enable read access for service role" ON "public"."telegram_sessions";
DROP POLICY IF EXISTS "Enable read access for all authenticated users" ON "public"."academic_deadlines";
DROP POLICY IF EXISTS "Enable read access for all (for validation)" ON "public"."parent_access_codes";
DROP POLICY IF EXISTS "Enable insert for service role" ON "public"."telegram_sessions";
DROP POLICY IF EXISTS "Enable insert for service role" ON "public"."parent_access_codes";
DROP POLICY IF EXISTS "Enable all for service role on ai_chat_history" ON "public"."ai_chat_history";
DROP POLICY IF EXISTS "Authenticated users can insert examples" ON "public"."resume_examples";
DROP POLICY IF EXISTS "Anyone authenticated can view resume examples" ON "public"."resume_examples";
DROP POLICY IF EXISTS "Admins/System can insert parent_student_links" ON "public"."parent_student_links";
ALTER TABLE IF EXISTS ONLY "public"."user_notifications" DROP CONSTRAINT IF EXISTS "user_notifications_user_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."user_notifications" DROP CONSTRAINT IF EXISTS "user_notifications_message_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."timetables" DROP CONSTRAINT IF EXISTS "timetables_class_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."telegram_sessions" DROP CONSTRAINT IF EXISTS "telegram_sessions_user_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."telegram_sessions" DROP CONSTRAINT IF EXISTS "telegram_sessions_linked_student_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."semester_results" DROP CONSTRAINT IF EXISTS "semester_results_student_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."resumes" DROP CONSTRAINT IF EXISTS "resumes_student_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."reports" DROP CONSTRAINT IF EXISTS "reports_student_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."reports" DROP CONSTRAINT IF EXISTS "reports_mentor_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."profiles" DROP CONSTRAINT IF EXISTS "profiles_mentor_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."profiles" DROP CONSTRAINT IF EXISTS "profiles_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."parent_student_links" DROP CONSTRAINT IF EXISTS "parent_student_links_student_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."parent_student_links" DROP CONSTRAINT IF EXISTS "parent_student_links_parent_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."parent_access_codes" DROP CONSTRAINT IF EXISTS "parent_access_codes_student_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."parent_access_codes" DROP CONSTRAINT IF EXISTS "parent_access_codes_mentor_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."job_applications" DROP CONSTRAINT IF EXISTS "job_applications_student_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."job_applications" DROP CONSTRAINT IF EXISTS "job_applications_resume_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."interventions" DROP CONSTRAINT IF EXISTS "interventions_student_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."interventions" DROP CONSTRAINT IF EXISTS "interventions_mentor_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."iat_marks" DROP CONSTRAINT IF EXISTS "iat_marks_student_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."iat_marks" DROP CONSTRAINT IF EXISTS "iat_marks_class_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."grades" DROP CONSTRAINT IF EXISTS "grades_student_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."grades" DROP CONSTRAINT IF EXISTS "grades_mentor_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."grades" DROP CONSTRAINT IF EXISTS "grades_class_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."fee_payments" DROP CONSTRAINT IF EXISTS "fee_payments_student_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."erp_credentials" DROP CONSTRAINT IF EXISTS "erp_credentials_student_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."erp_attendance_summary" DROP CONSTRAINT IF EXISTS "erp_attendance_summary_student_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."erp_attendance_summary" DROP CONSTRAINT IF EXISTS "erp_attendance_summary_class_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."enrollments" DROP CONSTRAINT IF EXISTS "enrollments_student_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."enrollments" DROP CONSTRAINT IF EXISTS "enrollments_class_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."direct_messages" DROP CONSTRAINT IF EXISTS "direct_messages_sender_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."direct_messages" DROP CONSTRAINT IF EXISTS "direct_messages_receiver_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."cover_letters" DROP CONSTRAINT IF EXISTS "cover_letters_student_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."cover_letters" DROP CONSTRAINT IF EXISTS "cover_letters_application_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."classes" DROP CONSTRAINT IF EXISTS "classes_subject_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."classes" DROP CONSTRAINT IF EXISTS "classes_mentor_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."career_metrics" DROP CONSTRAINT IF EXISTS "career_metrics_student_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."attendance" DROP CONSTRAINT IF EXISTS "attendance_student_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."attendance" DROP CONSTRAINT IF EXISTS "attendance_mentor_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."attendance" DROP CONSTRAINT IF EXISTS "attendance_class_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."ai_chat_history" DROP CONSTRAINT IF EXISTS "ai_chat_history_session_id_fkey";
ALTER TABLE IF EXISTS ONLY "public"."achievements" DROP CONSTRAINT IF EXISTS "achievements_student_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."webauthn_credentials" DROP CONSTRAINT IF EXISTS "webauthn_credentials_user_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."webauthn_challenges" DROP CONSTRAINT IF EXISTS "webauthn_challenges_user_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."sso_domains" DROP CONSTRAINT IF EXISTS "sso_domains_sso_provider_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."sessions" DROP CONSTRAINT IF EXISTS "sessions_user_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."sessions" DROP CONSTRAINT IF EXISTS "sessions_oauth_client_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."saml_relay_states" DROP CONSTRAINT IF EXISTS "saml_relay_states_sso_provider_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."saml_relay_states" DROP CONSTRAINT IF EXISTS "saml_relay_states_flow_state_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."saml_providers" DROP CONSTRAINT IF EXISTS "saml_providers_sso_provider_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."refresh_tokens" DROP CONSTRAINT IF EXISTS "refresh_tokens_session_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."one_time_tokens" DROP CONSTRAINT IF EXISTS "one_time_tokens_user_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."oauth_consents" DROP CONSTRAINT IF EXISTS "oauth_consents_user_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."oauth_consents" DROP CONSTRAINT IF EXISTS "oauth_consents_client_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."oauth_authorizations" DROP CONSTRAINT IF EXISTS "oauth_authorizations_user_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."oauth_authorizations" DROP CONSTRAINT IF EXISTS "oauth_authorizations_client_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."mfa_factors" DROP CONSTRAINT IF EXISTS "mfa_factors_user_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."mfa_challenges" DROP CONSTRAINT IF EXISTS "mfa_challenges_auth_factor_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."mfa_amr_claims" DROP CONSTRAINT IF EXISTS "mfa_amr_claims_session_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."identities" DROP CONSTRAINT IF EXISTS "identities_user_id_fkey";
DROP TRIGGER IF EXISTS "update_resumes_modtime" ON "public"."resumes";
DROP TRIGGER IF EXISTS "update_job_applications_modtime" ON "public"."job_applications";
DROP TRIGGER IF EXISTS "update_cover_letters_modtime" ON "public"."cover_letters";
DROP TRIGGER IF EXISTS "trigger_grade_risk_notify" ON "public"."grades";
DROP TRIGGER IF EXISTS "trigger_attendance_risk_notify" ON "public"."attendance";
DROP TRIGGER IF EXISTS "set_profiles_updated_at" ON "public"."profiles";
DROP TRIGGER IF EXISTS "set_iat_marks_updated_at" ON "public"."iat_marks";
DROP TRIGGER IF EXISTS "set_grades_updated_at" ON "public"."grades";
DROP INDEX IF EXISTS "public"."interventions_student_id_idx";
DROP INDEX IF EXISTS "public"."interventions_mentor_id_idx";
DROP INDEX IF EXISTS "public"."idx_user_notifications_user_read";
DROP INDEX IF EXISTS "public"."idx_timetables_class_day";
DROP INDEX IF EXISTS "public"."idx_iat_marks_student";
DROP INDEX IF EXISTS "public"."idx_iat_marks_class";
DROP INDEX IF EXISTS "public"."idx_grades_student";
DROP INDEX IF EXISTS "public"."idx_enrollments_student";
DROP INDEX IF EXISTS "public"."idx_enrollments_class";
DROP INDEX IF EXISTS "public"."idx_direct_messages_participants";
DROP INDEX IF EXISTS "public"."idx_attendance_student_class";
DROP INDEX IF EXISTS "public"."idx_attendance_date";
DROP INDEX IF EXISTS "public"."idx_ai_chat_history_session_id";
DROP INDEX IF EXISTS "auth"."webauthn_credentials_user_id_idx";
DROP INDEX IF EXISTS "auth"."webauthn_credentials_credential_id_key";
DROP INDEX IF EXISTS "auth"."webauthn_challenges_user_id_idx";
DROP INDEX IF EXISTS "auth"."webauthn_challenges_expires_at_idx";
DROP INDEX IF EXISTS "auth"."users_is_anonymous_idx";
DROP INDEX IF EXISTS "auth"."users_instance_id_idx";
DROP INDEX IF EXISTS "auth"."users_instance_id_email_idx";
DROP INDEX IF EXISTS "auth"."users_email_partial_key";
DROP INDEX IF EXISTS "auth"."user_id_created_at_idx";
DROP INDEX IF EXISTS "auth"."unique_phone_factor_per_user";
DROP INDEX IF EXISTS "auth"."sso_providers_resource_id_pattern_idx";
DROP INDEX IF EXISTS "auth"."sso_providers_resource_id_idx";
DROP INDEX IF EXISTS "auth"."sso_domains_sso_provider_id_idx";
DROP INDEX IF EXISTS "auth"."sso_domains_domain_idx";
DROP INDEX IF EXISTS "auth"."sessions_user_id_idx";
DROP INDEX IF EXISTS "auth"."sessions_oauth_client_id_idx";
DROP INDEX IF EXISTS "auth"."sessions_not_after_idx";
DROP INDEX IF EXISTS "auth"."saml_relay_states_sso_provider_id_idx";
DROP INDEX IF EXISTS "auth"."saml_relay_states_for_email_idx";
DROP INDEX IF EXISTS "auth"."saml_relay_states_created_at_idx";
DROP INDEX IF EXISTS "auth"."saml_providers_sso_provider_id_idx";
DROP INDEX IF EXISTS "auth"."refresh_tokens_updated_at_idx";
DROP INDEX IF EXISTS "auth"."refresh_tokens_session_id_revoked_idx";
DROP INDEX IF EXISTS "auth"."refresh_tokens_parent_idx";
DROP INDEX IF EXISTS "auth"."refresh_tokens_instance_id_user_id_idx";
DROP INDEX IF EXISTS "auth"."refresh_tokens_instance_id_idx";
DROP INDEX IF EXISTS "auth"."recovery_token_idx";
DROP INDEX IF EXISTS "auth"."reauthentication_token_idx";
DROP INDEX IF EXISTS "auth"."one_time_tokens_user_id_token_type_key";
DROP INDEX IF EXISTS "auth"."one_time_tokens_token_hash_hash_idx";
DROP INDEX IF EXISTS "auth"."one_time_tokens_relates_to_hash_idx";
DROP INDEX IF EXISTS "auth"."oauth_consents_user_order_idx";
DROP INDEX IF EXISTS "auth"."oauth_consents_active_user_client_idx";
DROP INDEX IF EXISTS "auth"."oauth_consents_active_client_idx";
DROP INDEX IF EXISTS "auth"."oauth_clients_deleted_at_idx";
DROP INDEX IF EXISTS "auth"."oauth_auth_pending_exp_idx";
DROP INDEX IF EXISTS "auth"."mfa_factors_user_id_idx";
DROP INDEX IF EXISTS "auth"."mfa_factors_user_friendly_name_unique";
DROP INDEX IF EXISTS "auth"."mfa_challenge_created_at_idx";
DROP INDEX IF EXISTS "auth"."idx_users_name";
DROP INDEX IF EXISTS "auth"."idx_users_last_sign_in_at_desc";
DROP INDEX IF EXISTS "auth"."idx_users_email";
DROP INDEX IF EXISTS "auth"."idx_users_created_at_desc";
DROP INDEX IF EXISTS "auth"."idx_user_id_auth_method";
DROP INDEX IF EXISTS "auth"."idx_oauth_client_states_created_at";
DROP INDEX IF EXISTS "auth"."idx_auth_code";
DROP INDEX IF EXISTS "auth"."identities_user_id_idx";
DROP INDEX IF EXISTS "auth"."identities_email_idx";
DROP INDEX IF EXISTS "auth"."flow_state_created_at_idx";
DROP INDEX IF EXISTS "auth"."factor_id_created_at_idx";
DROP INDEX IF EXISTS "auth"."email_change_token_new_idx";
DROP INDEX IF EXISTS "auth"."email_change_token_current_idx";
DROP INDEX IF EXISTS "auth"."custom_oauth_providers_provider_type_idx";
DROP INDEX IF EXISTS "auth"."custom_oauth_providers_identifier_idx";
DROP INDEX IF EXISTS "auth"."custom_oauth_providers_enabled_idx";
DROP INDEX IF EXISTS "auth"."custom_oauth_providers_created_at_idx";
DROP INDEX IF EXISTS "auth"."confirmation_token_idx";
DROP INDEX IF EXISTS "auth"."audit_logs_instance_id_idx";
ALTER TABLE IF EXISTS ONLY "public"."user_notifications" DROP CONSTRAINT IF EXISTS "user_notifications_user_id_message_id_key";
ALTER TABLE IF EXISTS ONLY "public"."user_notifications" DROP CONSTRAINT IF EXISTS "user_notifications_pkey";
ALTER TABLE IF EXISTS ONLY "public"."timetables" DROP CONSTRAINT IF EXISTS "timetables_pkey";
ALTER TABLE IF EXISTS ONLY "public"."telegram_sessions" DROP CONSTRAINT IF EXISTS "telegram_sessions_telegram_chat_id_key";
ALTER TABLE IF EXISTS ONLY "public"."telegram_sessions" DROP CONSTRAINT IF EXISTS "telegram_sessions_pkey";
ALTER TABLE IF EXISTS ONLY "public"."subjects" DROP CONSTRAINT IF EXISTS "subjects_pkey";
ALTER TABLE IF EXISTS ONLY "public"."subjects" DROP CONSTRAINT IF EXISTS "subjects_code_key";
ALTER TABLE IF EXISTS ONLY "public"."semester_results" DROP CONSTRAINT IF EXISTS "semester_results_student_id_semester_key";
ALTER TABLE IF EXISTS ONLY "public"."semester_results" DROP CONSTRAINT IF EXISTS "semester_results_pkey";
ALTER TABLE IF EXISTS ONLY "public"."resumes" DROP CONSTRAINT IF EXISTS "resumes_pkey";
ALTER TABLE IF EXISTS ONLY "public"."resume_examples" DROP CONSTRAINT IF EXISTS "resume_examples_pkey";
ALTER TABLE IF EXISTS ONLY "public"."reports" DROP CONSTRAINT IF EXISTS "reports_pkey";
ALTER TABLE IF EXISTS ONLY "public"."profiles" DROP CONSTRAINT IF EXISTS "profiles_pkey";
ALTER TABLE IF EXISTS ONLY "public"."parent_student_links" DROP CONSTRAINT IF EXISTS "parent_student_links_pkey";
ALTER TABLE IF EXISTS ONLY "public"."parent_student_links" DROP CONSTRAINT IF EXISTS "parent_student_links_parent_id_student_id_key";
ALTER TABLE IF EXISTS ONLY "public"."parent_access_codes" DROP CONSTRAINT IF EXISTS "parent_access_codes_pkey";
ALTER TABLE IF EXISTS ONLY "public"."parent_access_codes" DROP CONSTRAINT IF EXISTS "parent_access_codes_code_key";
ALTER TABLE IF EXISTS ONLY "public"."notification_messages" DROP CONSTRAINT IF EXISTS "notification_messages_pkey";
ALTER TABLE IF EXISTS ONLY "public"."job_applications" DROP CONSTRAINT IF EXISTS "job_applications_pkey";
ALTER TABLE IF EXISTS ONLY "public"."interventions" DROP CONSTRAINT IF EXISTS "interventions_pkey";
ALTER TABLE IF EXISTS ONLY "public"."iat_marks" DROP CONSTRAINT IF EXISTS "iat_marks_student_class_key";
ALTER TABLE IF EXISTS ONLY "public"."iat_marks" DROP CONSTRAINT IF EXISTS "iat_marks_pkey";
ALTER TABLE IF EXISTS ONLY "public"."grades" DROP CONSTRAINT IF EXISTS "grades_student_id_class_id_key";
ALTER TABLE IF EXISTS ONLY "public"."grades" DROP CONSTRAINT IF EXISTS "grades_pkey";
ALTER TABLE IF EXISTS ONLY "public"."fee_payments" DROP CONSTRAINT IF EXISTS "fee_payments_pkey";
ALTER TABLE IF EXISTS ONLY "public"."erp_credentials" DROP CONSTRAINT IF EXISTS "erp_credentials_pkey";
ALTER TABLE IF EXISTS ONLY "public"."erp_attendance_summary" DROP CONSTRAINT IF EXISTS "erp_attendance_summary_student_id_class_id_key";
ALTER TABLE IF EXISTS ONLY "public"."erp_attendance_summary" DROP CONSTRAINT IF EXISTS "erp_attendance_summary_pkey";
ALTER TABLE IF EXISTS ONLY "public"."enrollments" DROP CONSTRAINT IF EXISTS "enrollments_student_id_class_id_key";
ALTER TABLE IF EXISTS ONLY "public"."enrollments" DROP CONSTRAINT IF EXISTS "enrollments_pkey";
ALTER TABLE IF EXISTS ONLY "public"."direct_messages" DROP CONSTRAINT IF EXISTS "direct_messages_pkey";
ALTER TABLE IF EXISTS ONLY "public"."cover_letters" DROP CONSTRAINT IF EXISTS "cover_letters_pkey";
ALTER TABLE IF EXISTS ONLY "public"."classes" DROP CONSTRAINT IF EXISTS "classes_subject_id_mentor_id_academic_year_semester_key";
ALTER TABLE IF EXISTS ONLY "public"."classes" DROP CONSTRAINT IF EXISTS "classes_pkey";
ALTER TABLE IF EXISTS ONLY "public"."career_metrics" DROP CONSTRAINT IF EXISTS "career_metrics_student_id_key";
ALTER TABLE IF EXISTS ONLY "public"."career_metrics" DROP CONSTRAINT IF EXISTS "career_metrics_pkey";
ALTER TABLE IF EXISTS ONLY "public"."attendance" DROP CONSTRAINT IF EXISTS "attendance_student_id_class_id_date_key";
ALTER TABLE IF EXISTS ONLY "public"."attendance" DROP CONSTRAINT IF EXISTS "attendance_pkey";
ALTER TABLE IF EXISTS ONLY "public"."ai_chat_history" DROP CONSTRAINT IF EXISTS "ai_chat_history_pkey";
ALTER TABLE IF EXISTS ONLY "public"."achievements" DROP CONSTRAINT IF EXISTS "achievements_pkey";
ALTER TABLE IF EXISTS ONLY "public"."academic_deadlines" DROP CONSTRAINT IF EXISTS "academic_deadlines_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."webauthn_credentials" DROP CONSTRAINT IF EXISTS "webauthn_credentials_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."webauthn_challenges" DROP CONSTRAINT IF EXISTS "webauthn_challenges_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."users" DROP CONSTRAINT IF EXISTS "users_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."users" DROP CONSTRAINT IF EXISTS "users_phone_key";
ALTER TABLE IF EXISTS ONLY "auth"."sso_providers" DROP CONSTRAINT IF EXISTS "sso_providers_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."sso_domains" DROP CONSTRAINT IF EXISTS "sso_domains_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."sessions" DROP CONSTRAINT IF EXISTS "sessions_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."schema_migrations" DROP CONSTRAINT IF EXISTS "schema_migrations_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."saml_relay_states" DROP CONSTRAINT IF EXISTS "saml_relay_states_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."saml_providers" DROP CONSTRAINT IF EXISTS "saml_providers_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."saml_providers" DROP CONSTRAINT IF EXISTS "saml_providers_entity_id_key";
ALTER TABLE IF EXISTS ONLY "auth"."refresh_tokens" DROP CONSTRAINT IF EXISTS "refresh_tokens_token_unique";
ALTER TABLE IF EXISTS ONLY "auth"."refresh_tokens" DROP CONSTRAINT IF EXISTS "refresh_tokens_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."one_time_tokens" DROP CONSTRAINT IF EXISTS "one_time_tokens_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."oauth_consents" DROP CONSTRAINT IF EXISTS "oauth_consents_user_client_unique";
ALTER TABLE IF EXISTS ONLY "auth"."oauth_consents" DROP CONSTRAINT IF EXISTS "oauth_consents_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."oauth_clients" DROP CONSTRAINT IF EXISTS "oauth_clients_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."oauth_client_states" DROP CONSTRAINT IF EXISTS "oauth_client_states_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."oauth_authorizations" DROP CONSTRAINT IF EXISTS "oauth_authorizations_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."oauth_authorizations" DROP CONSTRAINT IF EXISTS "oauth_authorizations_authorization_id_key";
ALTER TABLE IF EXISTS ONLY "auth"."oauth_authorizations" DROP CONSTRAINT IF EXISTS "oauth_authorizations_authorization_code_key";
ALTER TABLE IF EXISTS ONLY "auth"."mfa_factors" DROP CONSTRAINT IF EXISTS "mfa_factors_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."mfa_factors" DROP CONSTRAINT IF EXISTS "mfa_factors_last_challenged_at_key";
ALTER TABLE IF EXISTS ONLY "auth"."mfa_challenges" DROP CONSTRAINT IF EXISTS "mfa_challenges_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."mfa_amr_claims" DROP CONSTRAINT IF EXISTS "mfa_amr_claims_session_id_authentication_method_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."instances" DROP CONSTRAINT IF EXISTS "instances_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."identities" DROP CONSTRAINT IF EXISTS "identities_provider_id_provider_unique";
ALTER TABLE IF EXISTS ONLY "auth"."identities" DROP CONSTRAINT IF EXISTS "identities_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."flow_state" DROP CONSTRAINT IF EXISTS "flow_state_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."custom_oauth_providers" DROP CONSTRAINT IF EXISTS "custom_oauth_providers_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."custom_oauth_providers" DROP CONSTRAINT IF EXISTS "custom_oauth_providers_identifier_key";
ALTER TABLE IF EXISTS ONLY "auth"."audit_log_entries" DROP CONSTRAINT IF EXISTS "audit_log_entries_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."mfa_amr_claims" DROP CONSTRAINT IF EXISTS "amr_id_pk";
ALTER TABLE IF EXISTS "auth"."refresh_tokens" ALTER COLUMN "id" DROP DEFAULT;
DROP VIEW IF EXISTS "public"."v_student_timetables";
DROP TABLE IF EXISTS "public"."user_notifications";
DROP TABLE IF EXISTS "public"."timetables";
DROP TABLE IF EXISTS "public"."telegram_sessions";
DROP TABLE IF EXISTS "public"."subjects";
DROP TABLE IF EXISTS "public"."semester_results";
DROP TABLE IF EXISTS "public"."resumes";
DROP TABLE IF EXISTS "public"."resume_examples";
DROP TABLE IF EXISTS "public"."reports";
DROP TABLE IF EXISTS "public"."profiles";
DROP TABLE IF EXISTS "public"."parent_student_links";
DROP TABLE IF EXISTS "public"."parent_access_codes";
DROP TABLE IF EXISTS "public"."notification_messages";
DROP TABLE IF EXISTS "public"."job_applications";
DROP TABLE IF EXISTS "public"."interventions";
DROP TABLE IF EXISTS "public"."iat_marks";
DROP TABLE IF EXISTS "public"."grades";
DROP TABLE IF EXISTS "public"."fee_payments";
DROP TABLE IF EXISTS "public"."erp_credentials";
DROP TABLE IF EXISTS "public"."erp_attendance_summary";
DROP TABLE IF EXISTS "public"."enrollments";
DROP TABLE IF EXISTS "public"."direct_messages";
DROP TABLE IF EXISTS "public"."cover_letters";
DROP TABLE IF EXISTS "public"."classes";
DROP TABLE IF EXISTS "public"."career_metrics";
DROP TABLE IF EXISTS "public"."attendance";
DROP TABLE IF EXISTS "public"."ai_chat_history";
DROP TABLE IF EXISTS "public"."achievements";
DROP TABLE IF EXISTS "public"."academic_deadlines";
DROP TABLE IF EXISTS "auth"."webauthn_credentials";
DROP TABLE IF EXISTS "auth"."webauthn_challenges";
DROP TABLE IF EXISTS "auth"."users";
DROP TABLE IF EXISTS "auth"."sso_providers";
DROP TABLE IF EXISTS "auth"."sso_domains";
DROP TABLE IF EXISTS "auth"."sessions";
DROP TABLE IF EXISTS "auth"."schema_migrations";
DROP TABLE IF EXISTS "auth"."saml_relay_states";
DROP TABLE IF EXISTS "auth"."saml_providers";
DROP SEQUENCE IF EXISTS "auth"."refresh_tokens_id_seq";
DROP TABLE IF EXISTS "auth"."refresh_tokens";
DROP TABLE IF EXISTS "auth"."one_time_tokens";
DROP TABLE IF EXISTS "auth"."oauth_consents";
DROP TABLE IF EXISTS "auth"."oauth_clients";
DROP TABLE IF EXISTS "auth"."oauth_client_states";
DROP TABLE IF EXISTS "auth"."oauth_authorizations";
DROP TABLE IF EXISTS "auth"."mfa_factors";
DROP TABLE IF EXISTS "auth"."mfa_challenges";
DROP TABLE IF EXISTS "auth"."mfa_amr_claims";
DROP TABLE IF EXISTS "auth"."instances";
DROP TABLE IF EXISTS "auth"."identities";
DROP TABLE IF EXISTS "auth"."flow_state";
DROP TABLE IF EXISTS "auth"."custom_oauth_providers";
DROP TABLE IF EXISTS "auth"."audit_log_entries";
DROP FUNCTION IF EXISTS "public"."user_role"();
DROP FUNCTION IF EXISTS "public"."update_modified_column"();
DROP FUNCTION IF EXISTS "public"."set_updated_at"();
DROP FUNCTION IF EXISTS "public"."send_mentor_notification"("p_student_id" "uuid", "p_title" "text", "p_body" "text", "p_type" "text");
DROP FUNCTION IF EXISTS "public"."seed_demo_data"("p_student_id" "uuid");
DROP FUNCTION IF EXISTS "public"."notify_grade_risk"();
DROP FUNCTION IF EXISTS "public"."notify_attendance_risk"();
DROP FUNCTION IF EXISTS "public"."mark_notifications_read"("p_user_id" "uuid");
DROP FUNCTION IF EXISTS "public"."is_mentor_of_student"("p_student_id" "uuid");
DROP FUNCTION IF EXISTS "public"."handle_new_user"();
DROP FUNCTION IF EXISTS "public"."get_student_class_ids"("p_student_id" "uuid");
DROP FUNCTION IF EXISTS "public"."get_parent_student_ids"("p_parent_id" "uuid");
DROP FUNCTION IF EXISTS "public"."get_my_mentor_id"("p_user_id" "uuid");
DROP FUNCTION IF EXISTS "public"."get_mentor_student_ids"("p_mentor_id" "uuid");
DROP FUNCTION IF EXISTS "public"."get_mentor_parent_ids"("p_mentor_id" "uuid");
DROP FUNCTION IF EXISTS "public"."get_mentor_fee_payments"();
DROP FUNCTION IF EXISTS "public"."get_mentor_cohort_summary"("p_mentor_id" "uuid");
DROP FUNCTION IF EXISTS "public"."get_mentor_class_ids"("p_mentor_id" "uuid");
DROP FUNCTION IF EXISTS "public"."get_historical_cgpa"("p_student_id" "uuid");
DROP FUNCTION IF EXISTS "public"."get_decrypted_erp_credentials"("p_student_ids" "uuid"[]);
DROP FUNCTION IF EXISTS "public"."get_cohort_trends"("p_mentor_id" "uuid");
DROP FUNCTION IF EXISTS "public"."get_cohort_iat_averages"("p_mentor_id" "uuid");
DROP FUNCTION IF EXISTS "public"."get_class_mentor_ids"("p_student_id" "uuid");
DROP FUNCTION IF EXISTS "public"."get_attendance_summary"("p_student_id" "uuid");
DROP FUNCTION IF EXISTS "public"."generate_parent_code"("p_student_id" "uuid", "p_mentor_id" "uuid");
DROP FUNCTION IF EXISTS "public"."create_profile"("p_user_id" "uuid", "p_full_name" "text", "p_role" "public"."user_role", "p_branch" "text", "p_semester" smallint);
DROP FUNCTION IF EXISTS "public"."create_profile"("p_user_id" "uuid", "p_full_name" "text", "p_branch" "text", "p_semester" integer);
DROP FUNCTION IF EXISTS "auth"."uid"();
DROP FUNCTION IF EXISTS "auth"."role"();
DROP FUNCTION IF EXISTS "auth"."jwt"();
DROP FUNCTION IF EXISTS "auth"."email"();
DROP TYPE IF EXISTS "public"."user_role";
DROP TYPE IF EXISTS "public"."risk_level";
DROP TYPE IF EXISTS "public"."attendance_status";
DROP TYPE IF EXISTS "auth"."one_time_token_type";
DROP TYPE IF EXISTS "auth"."oauth_response_type";
DROP TYPE IF EXISTS "auth"."oauth_registration_type";
DROP TYPE IF EXISTS "auth"."oauth_client_type";
DROP TYPE IF EXISTS "auth"."oauth_authorization_status";
DROP TYPE IF EXISTS "auth"."factor_type";
DROP TYPE IF EXISTS "auth"."factor_status";
DROP TYPE IF EXISTS "auth"."code_challenge_method";
DROP TYPE IF EXISTS "auth"."aal_level";
DROP SCHEMA IF EXISTS "public";
DROP SCHEMA IF EXISTS "auth";
--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA "auth";


ALTER SCHEMA "auth" OWNER TO "supabase_admin";

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA "public";


ALTER SCHEMA "public" OWNER TO "pg_database_owner";

--
-- Name: SCHEMA "public"; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA "public" IS 'standard public schema';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE "auth"."aal_level" AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE "auth"."aal_level" OWNER TO "supabase_auth_admin";

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE "auth"."code_challenge_method" AS ENUM (
    's256',
    'plain'
);


ALTER TYPE "auth"."code_challenge_method" OWNER TO "supabase_auth_admin";

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE "auth"."factor_status" AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE "auth"."factor_status" OWNER TO "supabase_auth_admin";

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE "auth"."factor_type" AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE "auth"."factor_type" OWNER TO "supabase_auth_admin";

--
-- Name: oauth_authorization_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE "auth"."oauth_authorization_status" AS ENUM (
    'pending',
    'approved',
    'denied',
    'expired'
);


ALTER TYPE "auth"."oauth_authorization_status" OWNER TO "supabase_auth_admin";

--
-- Name: oauth_client_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE "auth"."oauth_client_type" AS ENUM (
    'public',
    'confidential'
);


ALTER TYPE "auth"."oauth_client_type" OWNER TO "supabase_auth_admin";

--
-- Name: oauth_registration_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE "auth"."oauth_registration_type" AS ENUM (
    'dynamic',
    'manual'
);


ALTER TYPE "auth"."oauth_registration_type" OWNER TO "supabase_auth_admin";

--
-- Name: oauth_response_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE "auth"."oauth_response_type" AS ENUM (
    'code'
);


ALTER TYPE "auth"."oauth_response_type" OWNER TO "supabase_auth_admin";

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE "auth"."one_time_token_type" AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE "auth"."one_time_token_type" OWNER TO "supabase_auth_admin";

--
-- Name: attendance_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE "public"."attendance_status" AS ENUM (
    'Present',
    'Absent',
    'Excused'
);


ALTER TYPE "public"."attendance_status" OWNER TO "postgres";

--
-- Name: risk_level; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE "public"."risk_level" AS ENUM (
    'Low',
    'Medium',
    'High'
);


ALTER TYPE "public"."risk_level" OWNER TO "postgres";

--
-- Name: user_role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE "public"."user_role" AS ENUM (
    'student',
    'mentor',
    'admin',
    'parent'
);


ALTER TYPE "public"."user_role" OWNER TO "postgres";

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION "auth"."email"() RETURNS "text"
    LANGUAGE "sql" STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION "auth"."email"() OWNER TO "supabase_auth_admin";

--
-- Name: FUNCTION "email"(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION "auth"."email"() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION "auth"."jwt"() RETURNS "jsonb"
    LANGUAGE "sql" STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION "auth"."jwt"() OWNER TO "supabase_auth_admin";

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION "auth"."role"() RETURNS "text"
    LANGUAGE "sql" STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION "auth"."role"() OWNER TO "supabase_auth_admin";

--
-- Name: FUNCTION "role"(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION "auth"."role"() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION "auth"."uid"() RETURNS "uuid"
    LANGUAGE "sql" STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION "auth"."uid"() OWNER TO "supabase_auth_admin";

--
-- Name: FUNCTION "uid"(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION "auth"."uid"() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: create_profile("uuid", "text", "text", integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "public"."create_profile"("p_user_id" "uuid", "p_full_name" "text", "p_branch" "text", "p_semester" integer) RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  INSERT INTO public.profiles (id, full_name, role, branch, semester)
  VALUES (p_user_id, p_full_name, 'student', p_branch, p_semester);
END;
$$;


ALTER FUNCTION "public"."create_profile"("p_user_id" "uuid", "p_full_name" "text", "p_branch" "text", "p_semester" integer) OWNER TO "postgres";

--
-- Name: create_profile("uuid", "text", "public"."user_role", "text", smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "public"."create_profile"("p_user_id" "uuid", "p_full_name" "text", "p_role" "public"."user_role", "p_branch" "text", "p_semester" smallint) RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM auth.users WHERE id = p_user_id) THEN
    RAISE EXCEPTION 'User does not exist';
  END IF;

  INSERT INTO public.profiles (id, full_name, role, branch, semester)
  VALUES (p_user_id, p_full_name, p_role, p_branch, p_semester)
  ON CONFLICT (id) DO NOTHING;
END;
$$;


ALTER FUNCTION "public"."create_profile"("p_user_id" "uuid", "p_full_name" "text", "p_role" "public"."user_role", "p_branch" "text", "p_semester" smallint) OWNER TO "postgres";

--
-- Name: generate_parent_code("uuid", "uuid"); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "public"."generate_parent_code"("p_student_id" "uuid", "p_mentor_id" "uuid") RETURNS "text"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
DECLARE
    new_code TEXT;
    code_exists BOOLEAN;
BEGIN
    LOOP
        -- Generate a random 6-character alphanumeric uppercase code
        new_code := upper(substring(md5(random()::text), 1, 6));
        
        -- Check if it already exists
        SELECT EXISTS(SELECT 1 FROM public.parent_access_codes WHERE code = new_code) INTO code_exists;
        
        IF NOT code_exists THEN
            -- Insert the new code
            INSERT INTO public.parent_access_codes (code, student_id, mentor_id)
            VALUES (new_code, p_student_id, p_mentor_id);
            
            RETURN new_code;
        END IF;
    END LOOP;
END;
$$;


ALTER FUNCTION "public"."generate_parent_code"("p_student_id" "uuid", "p_mentor_id" "uuid") OWNER TO "postgres";

--
-- Name: get_attendance_summary("uuid"); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "public"."get_attendance_summary"("p_student_id" "uuid") RETURNS TABLE("class_id" "uuid", "subject_name" "text", "present_count" bigint, "total_count" bigint, "percentage" numeric)
    LANGUAGE "sql" STABLE SECURITY DEFINER
    AS $$
  SELECT
    e.class_id,
    s.name AS subject_name,
    COUNT(a.id) FILTER (WHERE a.status = 'Present') AS present_count,
    COUNT(a.id) AS total_count,
    ROUND(
      COUNT(a.id) FILTER (WHERE a.status = 'Present')::NUMERIC /
      NULLIF(COUNT(a.id), 0) * 100, 2
    ) AS percentage
  FROM enrollments e
  JOIN classes c ON c.id = e.class_id
  JOIN subjects s ON s.id = c.subject_id
  LEFT JOIN attendance a ON a.class_id = e.class_id AND a.student_id = e.student_id
  WHERE e.student_id = p_student_id
  GROUP BY e.class_id, s.name;
$$;


ALTER FUNCTION "public"."get_attendance_summary"("p_student_id" "uuid") OWNER TO "postgres";

--
-- Name: get_class_mentor_ids("uuid"); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "public"."get_class_mentor_ids"("p_student_id" "uuid") RETURNS SETOF "uuid"
    LANGUAGE "sql" STABLE SECURITY DEFINER
    AS $$
  SELECT DISTINCT c.mentor_id 
  FROM classes c 
  INNER JOIN enrollments e ON e.class_id = c.id 
  WHERE e.student_id = p_student_id;
$$;


ALTER FUNCTION "public"."get_class_mentor_ids"("p_student_id" "uuid") OWNER TO "postgres";

--
-- Name: get_cohort_iat_averages("uuid"); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "public"."get_cohort_iat_averages"("p_mentor_id" "uuid") RETURNS TABLE("student_id" "uuid", "avg_iat_marks" numeric, "iat_count" bigint)
    LANGUAGE "sql" STABLE SECURITY DEFINER
    AS $$
  SELECT im.student_id, ROUND(AVG(im.marks_obtained), 2), COUNT(im.id)
  FROM iat_marks im INNER JOIN profiles p ON p.id = im.student_id
  WHERE p.mentor_id = p_mentor_id AND p.role = 'student' GROUP BY im.student_id;
$$;


ALTER FUNCTION "public"."get_cohort_iat_averages"("p_mentor_id" "uuid") OWNER TO "postgres";

--
-- Name: get_cohort_trends("uuid"); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "public"."get_cohort_trends"("p_mentor_id" "uuid") RETURNS TABLE("student_id" "uuid", "attendance_weekly" "jsonb", "iat_scores" "jsonb", "subject_scores" "jsonb")
    LANGUAGE "sql" STABLE SECURITY DEFINER
    AS $$
  SELECT p.id,
    COALESCE((SELECT jsonb_agg(row_to_json(w) ORDER BY w.week_start) FROM (
      SELECT date_trunc('week', a.date)::date AS week_start,
        ROUND(COUNT(*) FILTER (WHERE a.status='Present')::numeric/NULLIF(COUNT(*),0)*100,1) AS pct
      FROM attendance a WHERE a.student_id=p.id AND a.date>=CURRENT_DATE-INTERVAL '35 days'
      GROUP BY date_trunc('week', a.date)) w), '[]'::jsonb),
    COALESCE((SELECT jsonb_agg(row_to_json(i) ORDER BY i.iat_num) FROM (
      SELECT im.iat_number AS iat_num, ROUND(AVG(im.marks_obtained),1) AS avg_marks, im.max_marks
      FROM iat_marks im WHERE im.student_id=p.id GROUP BY im.iat_number,im.max_marks) i), '[]'::jsonb),
    COALESCE((SELECT jsonb_agg(row_to_json(ss) ORDER BY ss.name) FROM (
      SELECT s.name, g.total_score AS score FROM grades g
      JOIN classes c ON c.id=g.class_id JOIN subjects s ON s.id=c.subject_id
      WHERE g.student_id=p.id) ss), '[]'::jsonb)
  FROM profiles p WHERE p.mentor_id=p_mentor_id AND p.role='student';
$$;


ALTER FUNCTION "public"."get_cohort_trends"("p_mentor_id" "uuid") OWNER TO "postgres";

--
-- Name: get_decrypted_erp_credentials("uuid"[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "public"."get_decrypted_erp_credentials"("p_student_ids" "uuid"[]) RETURNS TABLE("student_id" "uuid", "username" "text", "password" "text")
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
BEGIN
  RETURN QUERY
  SELECT 
    e.student_id, 
    e.username, 
    pgp_sym_decrypt(e.password_encrypted, 'edupredict_erp_secret_key') AS password
  FROM public.erp_credentials e
  WHERE e.student_id = ANY(p_student_ids);
END;
$$;


ALTER FUNCTION "public"."get_decrypted_erp_credentials"("p_student_ids" "uuid"[]) OWNER TO "postgres";

--
-- Name: get_historical_cgpa("uuid"); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "public"."get_historical_cgpa"("p_student_id" "uuid") RETURNS TABLE("semester" smallint, "cgpa" numeric)
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  RETURN QUERY
  SELECT 
    c.semester,
    ROUND(AVG(
      CASE
        WHEN (g.internal_marks + g.external_marks) >= 85 THEN 10.0
        WHEN (g.internal_marks + g.external_marks) >= 70 THEN 8.0
        WHEN (g.internal_marks + g.external_marks) >= 55 THEN 6.0
        WHEN (g.internal_marks + g.external_marks) >= 40 THEN 4.0
        ELSE 0.0
      END
    ), 2) AS cgpa
  FROM grades g
  JOIN classes c ON g.class_id = c.id
  WHERE g.student_id = p_student_id
  GROUP BY c.semester
  ORDER BY c.semester ASC;
END;
$$;


ALTER FUNCTION "public"."get_historical_cgpa"("p_student_id" "uuid") OWNER TO "postgres";

--
-- Name: get_mentor_class_ids("uuid"); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "public"."get_mentor_class_ids"("p_mentor_id" "uuid") RETURNS SETOF "uuid"
    LANGUAGE "sql" STABLE SECURITY DEFINER
    AS $$
  SELECT id FROM classes WHERE mentor_id = p_mentor_id;
$$;


ALTER FUNCTION "public"."get_mentor_class_ids"("p_mentor_id" "uuid") OWNER TO "postgres";

--
-- Name: get_mentor_cohort_summary("uuid"); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "public"."get_mentor_cohort_summary"("p_mentor_id" "uuid") RETURNS TABLE("student_id" "uuid", "full_name" "text", "branch" "text", "semester" smallint, "avg_attendance" numeric, "avg_total_score" numeric, "failing_subjects" bigint, "risk_level" "text")
    LANGUAGE "sql" STABLE SECURITY DEFINER
    AS $$
  SELECT
    p.id AS student_id, p.full_name, p.branch, p.semester,
    ROUND(AVG(att.percentage), 2) AS avg_attendance,
    ROUND(AVG(g.total_score), 2) AS avg_total_score,
    COUNT(g.id) FILTER (WHERE g.grade = 'F') AS failing_subjects,
    CASE
      WHEN COUNT(g.id) FILTER (WHERE g.grade = 'F') > 1 THEN 'High'
      WHEN COUNT(g.id) FILTER (WHERE g.grade IN ('D','F')) > 0 THEN 'Medium'
      ELSE 'Low'
    END AS risk_level
  FROM profiles p
  LEFT JOIN LATERAL get_attendance_summary(p.id) att ON TRUE
  LEFT JOIN grades g ON g.student_id = p.id
  WHERE p.mentor_id = p_mentor_id AND p.role = 'student'
  GROUP BY p.id, p.full_name, p.branch, p.semester;
$$;


ALTER FUNCTION "public"."get_mentor_cohort_summary"("p_mentor_id" "uuid") OWNER TO "postgres";

--
-- Name: get_mentor_fee_payments(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "public"."get_mentor_fee_payments"() RETURNS TABLE("id" "uuid", "student_id" "uuid", "payment_type" "text", "amount" numeric, "status" "text", "razorpay_order_id" "text", "razorpay_payment_id" "text", "subjects" "jsonb", "created_at" timestamp with time zone, "student_name" "text")
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  RETURN QUERY
  SELECT 
    fp.id,
    fp.student_id,
    fp.payment_type,
    fp.amount,
    fp.status,
    fp.razorpay_order_id,
    fp.razorpay_payment_id,
    fp.subjects,
    fp.created_at,
    p.full_name AS student_name
  FROM fee_payments fp
  JOIN profiles p ON p.id = fp.student_id
  WHERE p.mentor_id = auth.uid()
  ORDER BY fp.created_at DESC;
END;
$$;


ALTER FUNCTION "public"."get_mentor_fee_payments"() OWNER TO "postgres";

--
-- Name: get_mentor_parent_ids("uuid"); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "public"."get_mentor_parent_ids"("p_mentor_id" "uuid") RETURNS SETOF "uuid"
    LANGUAGE "sql" STABLE SECURITY DEFINER
    AS $$
  SELECT parent_id FROM parent_student_links WHERE student_id IN (
    SELECT id FROM profiles WHERE mentor_id = p_mentor_id
  );
$$;


ALTER FUNCTION "public"."get_mentor_parent_ids"("p_mentor_id" "uuid") OWNER TO "postgres";

--
-- Name: get_mentor_student_ids("uuid"); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "public"."get_mentor_student_ids"("p_mentor_id" "uuid") RETURNS SETOF "uuid"
    LANGUAGE "sql" STABLE SECURITY DEFINER
    AS $$
  SELECT id FROM profiles WHERE mentor_id = p_mentor_id;
$$;


ALTER FUNCTION "public"."get_mentor_student_ids"("p_mentor_id" "uuid") OWNER TO "postgres";

--
-- Name: get_my_mentor_id("uuid"); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "public"."get_my_mentor_id"("p_user_id" "uuid") RETURNS "uuid"
    LANGUAGE "sql" STABLE SECURITY DEFINER
    AS $$
  SELECT mentor_id FROM profiles WHERE id = p_user_id;
$$;


ALTER FUNCTION "public"."get_my_mentor_id"("p_user_id" "uuid") OWNER TO "postgres";

--
-- Name: get_parent_student_ids("uuid"); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "public"."get_parent_student_ids"("p_parent_id" "uuid") RETURNS SETOF "uuid"
    LANGUAGE "sql" STABLE SECURITY DEFINER
    AS $$
  SELECT student_id FROM parent_student_links WHERE parent_id = p_parent_id;
$$;


ALTER FUNCTION "public"."get_parent_student_ids"("p_parent_id" "uuid") OWNER TO "postgres";

--
-- Name: get_student_class_ids("uuid"); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "public"."get_student_class_ids"("p_student_id" "uuid") RETURNS SETOF "uuid"
    LANGUAGE "sql" STABLE SECURITY DEFINER
    AS $$
  SELECT class_id FROM enrollments WHERE student_id = p_student_id;
$$;


ALTER FUNCTION "public"."get_student_class_ids"("p_student_id" "uuid") OWNER TO "postgres";

--
-- Name: handle_new_user(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "public"."handle_new_user"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
DECLARE
  v_role user_role := 'student';
  v_semester smallint := 1;
BEGIN
  BEGIN
    v_role := (NEW.raw_user_meta_data->>'role')::user_role;
  EXCEPTION WHEN OTHERS THEN
    v_role := 'student';
  END;

  BEGIN
    v_semester := (NEW.raw_user_meta_data->>'semester')::smallint;
  EXCEPTION WHEN OTHERS THEN
    v_semester := 1;
  END;

  INSERT INTO public.profiles (id, full_name, role, branch, semester)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'full_name', 'New User'),
    COALESCE(v_role, 'student'::user_role),
    COALESCE(NEW.raw_user_meta_data->>'branch', 'General'),
    COALESCE(v_semester, 1::smallint)
  );
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."handle_new_user"() OWNER TO "postgres";

--
-- Name: is_mentor_of_student("uuid"); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "public"."is_mentor_of_student"("p_student_id" "uuid") RETURNS boolean
    LANGUAGE "sql" STABLE SECURITY DEFINER
    AS $$
  SELECT EXISTS (
    SELECT 1 FROM profiles 
    WHERE id = p_student_id 
    AND mentor_id = auth.uid()
  );
$$;


ALTER FUNCTION "public"."is_mentor_of_student"("p_student_id" "uuid") OWNER TO "postgres";

--
-- Name: mark_notifications_read("uuid"); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "public"."mark_notifications_read"("p_user_id" "uuid") RETURNS "void"
    LANGUAGE "sql" SECURITY DEFINER
    AS $$
  UPDATE user_notifications
  SET is_read = TRUE
  WHERE user_id = p_user_id AND is_read = FALSE;
$$;


ALTER FUNCTION "public"."mark_notifications_read"("p_user_id" "uuid") OWNER TO "postgres";

--
-- Name: notify_attendance_risk(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "public"."notify_attendance_risk"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
DECLARE
  v_percentage NUMERIC;
  v_subject_name TEXT;
  v_msg_id UUID;
BEGIN
  SELECT percentage, subject_name
  INTO v_percentage, v_subject_name
  FROM get_attendance_summary(NEW.student_id)
  WHERE class_id = NEW.class_id;

  IF v_percentage IS NOT NULL AND v_percentage < 75 THEN
    INSERT INTO notification_messages (title, body, type, deep_link)
    VALUES (
      'Attendance Alert: ' || v_subject_name,
      'Your attendance in ' || v_subject_name || ' has dropped to ' ||
      ROUND(v_percentage, 1) || '%. Minimum required is 75%.',
      'attendance_risk',
      '/dashboard/attendance'
    )
    RETURNING id INTO v_msg_id;

    INSERT INTO user_notifications (user_id, message_id)
    VALUES (NEW.student_id, v_msg_id)
    ON CONFLICT (user_id, message_id) DO NOTHING;
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."notify_attendance_risk"() OWNER TO "postgres";

--
-- Name: notify_grade_risk(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "public"."notify_grade_risk"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
DECLARE
  v_subject_name TEXT;
  v_new_grade TEXT;
  v_msg_id UUID;
BEGIN
  -- Compute the grade from the new marks (mirrors the generated column logic)
  v_new_grade := CASE
    WHEN (NEW.internal_marks + NEW.external_marks) >= 85 THEN 'A'
    WHEN (NEW.internal_marks + NEW.external_marks) >= 70 THEN 'B'
    WHEN (NEW.internal_marks + NEW.external_marks) >= 55 THEN 'C'
    WHEN (NEW.internal_marks + NEW.external_marks) >= 40 THEN 'D'
    ELSE 'F'
  END;

  IF v_new_grade IN ('D', 'F') THEN
    SELECT s.name INTO v_subject_name
    FROM classes c
    JOIN subjects s ON s.id = c.subject_id
    WHERE c.id = NEW.class_id;

    INSERT INTO notification_messages (title, body, type, deep_link)
    VALUES (
      'Grade Alert: ' || v_subject_name,
      'Your grade in ' || v_subject_name || ' has dropped to ' || v_new_grade ||
      ' (Total: ' || ROUND(NEW.internal_marks + NEW.external_marks, 1) ||
      '/100). Please consult your mentor.',
      'grade_risk',
      '/dashboard/grades'
    )
    RETURNING id INTO v_msg_id;

    INSERT INTO user_notifications (user_id, message_id)
    VALUES (NEW.student_id, v_msg_id)
    ON CONFLICT (user_id, message_id) DO NOTHING;
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."notify_grade_risk"() OWNER TO "postgres";

--
-- Name: seed_demo_data("uuid"); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "public"."seed_demo_data"("p_student_id" "uuid") RETURNS "text"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
DECLARE
    v_mentor_id UUID;
    v_sub_ds UUID;
    v_sub_ml UUID;
    v_sub_os UUID;
    v_sub_db UUID;
    v_class_ds UUID;
    v_class_ml UUID;
    v_class_os UUID;
    v_class_db UUID;
    v_notif_id UUID;
    i INT;
    sim_date DATE;
    rand_status attendance_status;
BEGIN
    -- Verify the student exists
    IF NOT EXISTS (SELECT 1 FROM profiles WHERE id = p_student_id AND role = 'student') THEN
        RETURN 'Error: Student profile not found';
    END IF;

    -- Ensure a Mentor exists
    SELECT id INTO v_mentor_id FROM profiles WHERE role = 'mentor' LIMIT 1;
    
    IF v_mentor_id IS NULL THEN
       v_mentor_id := gen_random_uuid();
       -- Create mentor in auth.users
       INSERT INTO auth.users (id, instance_id, email, encrypted_password, email_confirmed_at, raw_user_meta_data, role, aud, created_at, updated_at)
       VALUES (
         v_mentor_id, 
         '00000000-0000-0000-0000-000000000000',
         'demo.mentor@edupredict.com', 
         crypt('mentor123', gen_salt('bf')),
         NOW(), 
         '{"role": "mentor", "full_name": "Prof. Alan Turing"}'::jsonb,
         'authenticated',
         'authenticated',
         NOW(),
         NOW()
       )
       ON CONFLICT (id) DO NOTHING;
       
       INSERT INTO profiles (id, full_name, role, branch, semester)
       VALUES (v_mentor_id, 'Prof. Alan Turing', 'mentor', 'Computer Science', 6)
       ON CONFLICT (id) DO NOTHING;
    END IF;

    -- Assign mentor to the student
    UPDATE profiles SET mentor_id = v_mentor_id WHERE id = p_student_id;

    -- Create Subjects
    INSERT INTO subjects (name, code, description) VALUES ('Data Structures', 'CS301', 'Core DSA concepts') ON CONFLICT (code) DO NOTHING;
    INSERT INTO subjects (name, code, description) VALUES ('Machine Learning', 'CS405', 'Intro to ML and Neural Networks') ON CONFLICT (code) DO NOTHING;
    INSERT INTO subjects (name, code, description) VALUES ('Operating Systems', 'CS302', 'System kernels and memory management') ON CONFLICT (code) DO NOTHING;
    INSERT INTO subjects (name, code, description) VALUES ('Database Management', 'CS303', 'SQL and NoSQL architecture') ON CONFLICT (code) DO NOTHING;

    -- Fetch subject IDs
    SELECT id INTO v_sub_ds FROM subjects WHERE code = 'CS301';
    SELECT id INTO v_sub_ml FROM subjects WHERE code = 'CS405';
    SELECT id INTO v_sub_os FROM subjects WHERE code = 'CS302';
    SELECT id INTO v_sub_db FROM subjects WHERE code = 'CS303';

    -- Create Classes (Current Semester)
    INSERT INTO classes (subject_id, mentor_id, academic_year, semester) VALUES (v_sub_ds, v_mentor_id, '2025-2026', 6) ON CONFLICT DO NOTHING;
    INSERT INTO classes (subject_id, mentor_id, academic_year, semester) VALUES (v_sub_ml, v_mentor_id, '2025-2026', 6) ON CONFLICT DO NOTHING;
    INSERT INTO classes (subject_id, mentor_id, academic_year, semester) VALUES (v_sub_os, v_mentor_id, '2025-2026', 6) ON CONFLICT DO NOTHING;
    INSERT INTO classes (subject_id, mentor_id, academic_year, semester) VALUES (v_sub_db, v_mentor_id, '2025-2026', 6) ON CONFLICT DO NOTHING;

    -- Fetch class IDs
    SELECT id INTO v_class_ds FROM classes WHERE subject_id = v_sub_ds AND academic_year = '2025-2026' LIMIT 1;
    SELECT id INTO v_class_ml FROM classes WHERE subject_id = v_sub_ml AND academic_year = '2025-2026' LIMIT 1;
    SELECT id INTO v_class_os FROM classes WHERE subject_id = v_sub_os AND academic_year = '2025-2026' LIMIT 1;
    SELECT id INTO v_class_db FROM classes WHERE subject_id = v_sub_db AND academic_year = '2025-2026' LIMIT 1;

    -- Enroll Student
    INSERT INTO enrollments (student_id, class_id) VALUES 
        (p_student_id, v_class_ds),
        (p_student_id, v_class_ml),
        (p_student_id, v_class_os),
        (p_student_id, v_class_db)
    ON CONFLICT DO NOTHING;

    -- Insert Timetables (clear first to avoid duplicates on re-run)
    DELETE FROM timetables WHERE class_id IN (v_class_ds, v_class_ml, v_class_os, v_class_db);
    
    INSERT INTO timetables (class_id, day_of_week, start_time, end_time, location) VALUES
        (v_class_ds, 1, '09:00:00', '10:30:00', 'Room 304'),
        (v_class_ml, 1, '11:00:00', '12:30:00', 'Lab A'),
        (v_class_os, 2, '10:00:00', '11:30:00', 'Room 201'),
        (v_class_db, 2, '14:00:00', '15:30:00', 'Lab B'),
        (v_class_ds, 3, '09:00:00', '10:30:00', 'Room 304'),
        (v_class_ml, 3, '13:00:00', '15:00:00', 'Lab A'),
        (v_class_os, 4, '09:00:00', '11:00:00', 'Room 201'),
        (v_class_db, 4, '11:30:00', '13:00:00', 'Lab B'),
        (v_class_ml, 5, '10:00:00', '12:00:00', 'Lab A');

    -- Insert Grades
    INSERT INTO grades (student_id, class_id, internal_marks, external_marks) VALUES
        (p_student_id, v_class_ds, 42, 38),
        (p_student_id, v_class_ml, 48, 45),
        (p_student_id, v_class_os, 35, 30),
        (p_student_id, v_class_db, 45, 42)
    ON CONFLICT (student_id, class_id) DO UPDATE SET 
        internal_marks = EXCLUDED.internal_marks,
        external_marks = EXCLUDED.external_marks;

    -- Simulate 30 days of attendance (clear first)
    DELETE FROM attendance 
    WHERE student_id = p_student_id 
    AND class_id IN (v_class_ds, v_class_ml, v_class_os, v_class_db);

    FOR i IN 0..30 LOOP
        sim_date := CURRENT_DATE - i;
        
        IF random() > 0.2 THEN
            rand_status := 'Present';
        ELSE
            rand_status := 'Absent';
        END IF;

        IF extract(isodow from sim_date) < 6 THEN
            INSERT INTO attendance (student_id, class_id, status, date) VALUES
                (p_student_id, v_class_ds, rand_status, sim_date),
                (p_student_id, v_class_ml, rand_status, sim_date),
                (p_student_id, v_class_os, rand_status, sim_date),
                (p_student_id, v_class_db, rand_status, sim_date)
            ON CONFLICT DO NOTHING;
        END IF;
    END LOOP;

    -- Create notification
    INSERT INTO notification_messages (title, body, type, deep_link)
    VALUES ('🎉 Demo Setup Complete', 'Your account is now populated with subjects, grades, timetables, and 30 days of attendance records.', 'info', '/student/timetable')
    RETURNING id INTO v_notif_id;

    INSERT INTO user_notifications (user_id, message_id, is_read)
    VALUES (p_student_id, v_notif_id, false)
    ON CONFLICT DO NOTHING;

    RETURN 'Success: Demo data seeded for student ' || p_student_id::text;
END;
$$;


ALTER FUNCTION "public"."seed_demo_data"("p_student_id" "uuid") OWNER TO "postgres";

--
-- Name: send_mentor_notification("uuid", "text", "text", "text"); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "public"."send_mentor_notification"("p_student_id" "uuid", "p_title" "text", "p_body" "text", "p_type" "text") RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
DECLARE
  v_mentor_id UUID;
  v_msg_id UUID;
BEGIN
  -- Verify the caller is the student's mentor
  SELECT mentor_id INTO v_mentor_id
  FROM profiles
  WHERE id = p_student_id;

  IF v_mentor_id != auth.uid() THEN
    RAISE EXCEPTION 'Unauthorized: You are not the mentor for this student.';
  END IF;

  -- Insert the message
  INSERT INTO notification_messages (title, body, type, deep_link)
  VALUES (
    p_title,
    p_body,
    p_type,
    '/student/notifications'
  )
  RETURNING id INTO v_msg_id;

  -- Link to the student
  INSERT INTO user_notifications (user_id, message_id)
  VALUES (p_student_id, v_msg_id)
  ON CONFLICT (user_id, message_id) DO NOTHING;

END;
$$;


ALTER FUNCTION "public"."send_mentor_notification"("p_student_id" "uuid", "p_title" "text", "p_body" "text", "p_type" "text") OWNER TO "postgres";

--
-- Name: set_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "public"."set_updated_at"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN 
  NEW.updated_at = NOW(); 
  RETURN NEW; 
END;
$$;


ALTER FUNCTION "public"."set_updated_at"() OWNER TO "postgres";

--
-- Name: update_modified_column(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "public"."update_modified_column"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
   NEW.updated_at = NOW();
   RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."update_modified_column"() OWNER TO "postgres";

--
-- Name: user_role(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "public"."user_role"() RETURNS "text"
    LANGUAGE "sql" STABLE SECURITY DEFINER
    AS $$
  SELECT COALESCE(
    current_setting('request.jwt.claims', true)::json->>'user_role',
    (SELECT role::text FROM public.profiles WHERE id = auth.uid())
  );
$$;


ALTER FUNCTION "public"."user_role"() OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."audit_log_entries" (
    "instance_id" "uuid",
    "id" "uuid" NOT NULL,
    "payload" json,
    "created_at" timestamp with time zone,
    "ip_address" character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE "auth"."audit_log_entries" OWNER TO "supabase_auth_admin";

--
-- Name: TABLE "audit_log_entries"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE "auth"."audit_log_entries" IS 'Auth: Audit trail for user actions.';


--
-- Name: custom_oauth_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."custom_oauth_providers" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "provider_type" "text" NOT NULL,
    "identifier" "text" NOT NULL,
    "name" "text" NOT NULL,
    "client_id" "text" NOT NULL,
    "client_secret" "text" NOT NULL,
    "acceptable_client_ids" "text"[] DEFAULT '{}'::"text"[] NOT NULL,
    "scopes" "text"[] DEFAULT '{}'::"text"[] NOT NULL,
    "pkce_enabled" boolean DEFAULT true NOT NULL,
    "attribute_mapping" "jsonb" DEFAULT '{}'::"jsonb" NOT NULL,
    "authorization_params" "jsonb" DEFAULT '{}'::"jsonb" NOT NULL,
    "enabled" boolean DEFAULT true NOT NULL,
    "email_optional" boolean DEFAULT false NOT NULL,
    "issuer" "text",
    "discovery_url" "text",
    "skip_nonce_check" boolean DEFAULT false NOT NULL,
    "cached_discovery" "jsonb",
    "discovery_cached_at" timestamp with time zone,
    "authorization_url" "text",
    "token_url" "text",
    "userinfo_url" "text",
    "jwks_uri" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "custom_oauth_providers_authorization_url_https" CHECK ((("authorization_url" IS NULL) OR ("authorization_url" ~~ 'https://%'::"text"))),
    CONSTRAINT "custom_oauth_providers_authorization_url_length" CHECK ((("authorization_url" IS NULL) OR ("char_length"("authorization_url") <= 2048))),
    CONSTRAINT "custom_oauth_providers_client_id_length" CHECK ((("char_length"("client_id") >= 1) AND ("char_length"("client_id") <= 512))),
    CONSTRAINT "custom_oauth_providers_discovery_url_length" CHECK ((("discovery_url" IS NULL) OR ("char_length"("discovery_url") <= 2048))),
    CONSTRAINT "custom_oauth_providers_identifier_format" CHECK (("identifier" ~ '^[a-z0-9][a-z0-9:-]{0,48}[a-z0-9]$'::"text")),
    CONSTRAINT "custom_oauth_providers_issuer_length" CHECK ((("issuer" IS NULL) OR (("char_length"("issuer") >= 1) AND ("char_length"("issuer") <= 2048)))),
    CONSTRAINT "custom_oauth_providers_jwks_uri_https" CHECK ((("jwks_uri" IS NULL) OR ("jwks_uri" ~~ 'https://%'::"text"))),
    CONSTRAINT "custom_oauth_providers_jwks_uri_length" CHECK ((("jwks_uri" IS NULL) OR ("char_length"("jwks_uri") <= 2048))),
    CONSTRAINT "custom_oauth_providers_name_length" CHECK ((("char_length"("name") >= 1) AND ("char_length"("name") <= 100))),
    CONSTRAINT "custom_oauth_providers_oauth2_requires_endpoints" CHECK ((("provider_type" <> 'oauth2'::"text") OR (("authorization_url" IS NOT NULL) AND ("token_url" IS NOT NULL) AND ("userinfo_url" IS NOT NULL)))),
    CONSTRAINT "custom_oauth_providers_oidc_discovery_url_https" CHECK ((("provider_type" <> 'oidc'::"text") OR ("discovery_url" IS NULL) OR ("discovery_url" ~~ 'https://%'::"text"))),
    CONSTRAINT "custom_oauth_providers_oidc_issuer_https" CHECK ((("provider_type" <> 'oidc'::"text") OR ("issuer" IS NULL) OR ("issuer" ~~ 'https://%'::"text"))),
    CONSTRAINT "custom_oauth_providers_oidc_requires_issuer" CHECK ((("provider_type" <> 'oidc'::"text") OR ("issuer" IS NOT NULL))),
    CONSTRAINT "custom_oauth_providers_provider_type_check" CHECK (("provider_type" = ANY (ARRAY['oauth2'::"text", 'oidc'::"text"]))),
    CONSTRAINT "custom_oauth_providers_token_url_https" CHECK ((("token_url" IS NULL) OR ("token_url" ~~ 'https://%'::"text"))),
    CONSTRAINT "custom_oauth_providers_token_url_length" CHECK ((("token_url" IS NULL) OR ("char_length"("token_url") <= 2048))),
    CONSTRAINT "custom_oauth_providers_userinfo_url_https" CHECK ((("userinfo_url" IS NULL) OR ("userinfo_url" ~~ 'https://%'::"text"))),
    CONSTRAINT "custom_oauth_providers_userinfo_url_length" CHECK ((("userinfo_url" IS NULL) OR ("char_length"("userinfo_url") <= 2048)))
);


ALTER TABLE "auth"."custom_oauth_providers" OWNER TO "supabase_auth_admin";

--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."flow_state" (
    "id" "uuid" NOT NULL,
    "user_id" "uuid",
    "auth_code" "text",
    "code_challenge_method" "auth"."code_challenge_method",
    "code_challenge" "text",
    "provider_type" "text" NOT NULL,
    "provider_access_token" "text",
    "provider_refresh_token" "text",
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    "authentication_method" "text" NOT NULL,
    "auth_code_issued_at" timestamp with time zone,
    "invite_token" "text",
    "referrer" "text",
    "oauth_client_state_id" "uuid",
    "linking_target_id" "uuid",
    "email_optional" boolean DEFAULT false NOT NULL
);


ALTER TABLE "auth"."flow_state" OWNER TO "supabase_auth_admin";

--
-- Name: TABLE "flow_state"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE "auth"."flow_state" IS 'Stores metadata for all OAuth/SSO login flows';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."identities" (
    "provider_id" "text" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "identity_data" "jsonb" NOT NULL,
    "provider" "text" NOT NULL,
    "last_sign_in_at" timestamp with time zone,
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    "email" "text" GENERATED ALWAYS AS ("lower"(("identity_data" ->> 'email'::"text"))) STORED,
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL
);


ALTER TABLE "auth"."identities" OWNER TO "supabase_auth_admin";

--
-- Name: TABLE "identities"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE "auth"."identities" IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN "identities"."email"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN "auth"."identities"."email" IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."instances" (
    "id" "uuid" NOT NULL,
    "uuid" "uuid",
    "raw_base_config" "text",
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone
);


ALTER TABLE "auth"."instances" OWNER TO "supabase_auth_admin";

--
-- Name: TABLE "instances"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE "auth"."instances" IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."mfa_amr_claims" (
    "session_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone NOT NULL,
    "updated_at" timestamp with time zone NOT NULL,
    "authentication_method" "text" NOT NULL,
    "id" "uuid" NOT NULL
);


ALTER TABLE "auth"."mfa_amr_claims" OWNER TO "supabase_auth_admin";

--
-- Name: TABLE "mfa_amr_claims"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE "auth"."mfa_amr_claims" IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."mfa_challenges" (
    "id" "uuid" NOT NULL,
    "factor_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone NOT NULL,
    "verified_at" timestamp with time zone,
    "ip_address" "inet" NOT NULL,
    "otp_code" "text",
    "web_authn_session_data" "jsonb"
);


ALTER TABLE "auth"."mfa_challenges" OWNER TO "supabase_auth_admin";

--
-- Name: TABLE "mfa_challenges"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE "auth"."mfa_challenges" IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."mfa_factors" (
    "id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "friendly_name" "text",
    "factor_type" "auth"."factor_type" NOT NULL,
    "status" "auth"."factor_status" NOT NULL,
    "created_at" timestamp with time zone NOT NULL,
    "updated_at" timestamp with time zone NOT NULL,
    "secret" "text",
    "phone" "text",
    "last_challenged_at" timestamp with time zone,
    "web_authn_credential" "jsonb",
    "web_authn_aaguid" "uuid",
    "last_webauthn_challenge_data" "jsonb"
);


ALTER TABLE "auth"."mfa_factors" OWNER TO "supabase_auth_admin";

--
-- Name: TABLE "mfa_factors"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE "auth"."mfa_factors" IS 'auth: stores metadata about factors';


--
-- Name: COLUMN "mfa_factors"."last_webauthn_challenge_data"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN "auth"."mfa_factors"."last_webauthn_challenge_data" IS 'Stores the latest WebAuthn challenge data including attestation/assertion for customer verification';


--
-- Name: oauth_authorizations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."oauth_authorizations" (
    "id" "uuid" NOT NULL,
    "authorization_id" "text" NOT NULL,
    "client_id" "uuid" NOT NULL,
    "user_id" "uuid",
    "redirect_uri" "text" NOT NULL,
    "scope" "text" NOT NULL,
    "state" "text",
    "resource" "text",
    "code_challenge" "text",
    "code_challenge_method" "auth"."code_challenge_method",
    "response_type" "auth"."oauth_response_type" DEFAULT 'code'::"auth"."oauth_response_type" NOT NULL,
    "status" "auth"."oauth_authorization_status" DEFAULT 'pending'::"auth"."oauth_authorization_status" NOT NULL,
    "authorization_code" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "expires_at" timestamp with time zone DEFAULT ("now"() + '00:03:00'::interval) NOT NULL,
    "approved_at" timestamp with time zone,
    "nonce" "text",
    CONSTRAINT "oauth_authorizations_authorization_code_length" CHECK (("char_length"("authorization_code") <= 255)),
    CONSTRAINT "oauth_authorizations_code_challenge_length" CHECK (("char_length"("code_challenge") <= 128)),
    CONSTRAINT "oauth_authorizations_expires_at_future" CHECK (("expires_at" > "created_at")),
    CONSTRAINT "oauth_authorizations_nonce_length" CHECK (("char_length"("nonce") <= 255)),
    CONSTRAINT "oauth_authorizations_redirect_uri_length" CHECK (("char_length"("redirect_uri") <= 2048)),
    CONSTRAINT "oauth_authorizations_resource_length" CHECK (("char_length"("resource") <= 2048)),
    CONSTRAINT "oauth_authorizations_scope_length" CHECK (("char_length"("scope") <= 4096)),
    CONSTRAINT "oauth_authorizations_state_length" CHECK (("char_length"("state") <= 4096))
);


ALTER TABLE "auth"."oauth_authorizations" OWNER TO "supabase_auth_admin";

--
-- Name: oauth_client_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."oauth_client_states" (
    "id" "uuid" NOT NULL,
    "provider_type" "text" NOT NULL,
    "code_verifier" "text",
    "created_at" timestamp with time zone NOT NULL
);


ALTER TABLE "auth"."oauth_client_states" OWNER TO "supabase_auth_admin";

--
-- Name: TABLE "oauth_client_states"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE "auth"."oauth_client_states" IS 'Stores OAuth states for third-party provider authentication flows where Supabase acts as the OAuth client.';


--
-- Name: oauth_clients; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."oauth_clients" (
    "id" "uuid" NOT NULL,
    "client_secret_hash" "text",
    "registration_type" "auth"."oauth_registration_type" NOT NULL,
    "redirect_uris" "text" NOT NULL,
    "grant_types" "text" NOT NULL,
    "client_name" "text",
    "client_uri" "text",
    "logo_uri" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "deleted_at" timestamp with time zone,
    "client_type" "auth"."oauth_client_type" DEFAULT 'confidential'::"auth"."oauth_client_type" NOT NULL,
    "token_endpoint_auth_method" "text" NOT NULL,
    CONSTRAINT "oauth_clients_client_name_length" CHECK (("char_length"("client_name") <= 1024)),
    CONSTRAINT "oauth_clients_client_uri_length" CHECK (("char_length"("client_uri") <= 2048)),
    CONSTRAINT "oauth_clients_logo_uri_length" CHECK (("char_length"("logo_uri") <= 2048)),
    CONSTRAINT "oauth_clients_token_endpoint_auth_method_check" CHECK (("token_endpoint_auth_method" = ANY (ARRAY['client_secret_basic'::"text", 'client_secret_post'::"text", 'none'::"text"])))
);


ALTER TABLE "auth"."oauth_clients" OWNER TO "supabase_auth_admin";

--
-- Name: oauth_consents; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."oauth_consents" (
    "id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "client_id" "uuid" NOT NULL,
    "scopes" "text" NOT NULL,
    "granted_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "revoked_at" timestamp with time zone,
    CONSTRAINT "oauth_consents_revoked_after_granted" CHECK ((("revoked_at" IS NULL) OR ("revoked_at" >= "granted_at"))),
    CONSTRAINT "oauth_consents_scopes_length" CHECK (("char_length"("scopes") <= 2048)),
    CONSTRAINT "oauth_consents_scopes_not_empty" CHECK (("char_length"(TRIM(BOTH FROM "scopes")) > 0))
);


ALTER TABLE "auth"."oauth_consents" OWNER TO "supabase_auth_admin";

--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."one_time_tokens" (
    "id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "token_type" "auth"."one_time_token_type" NOT NULL,
    "token_hash" "text" NOT NULL,
    "relates_to" "text" NOT NULL,
    "created_at" timestamp without time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp without time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "one_time_tokens_token_hash_check" CHECK (("char_length"("token_hash") > 0))
);


ALTER TABLE "auth"."one_time_tokens" OWNER TO "supabase_auth_admin";

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."refresh_tokens" (
    "instance_id" "uuid",
    "id" bigint NOT NULL,
    "token" character varying(255),
    "user_id" character varying(255),
    "revoked" boolean,
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    "parent" character varying(255),
    "session_id" "uuid"
);


ALTER TABLE "auth"."refresh_tokens" OWNER TO "supabase_auth_admin";

--
-- Name: TABLE "refresh_tokens"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE "auth"."refresh_tokens" IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE "auth"."refresh_tokens_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "auth"."refresh_tokens_id_seq" OWNER TO "supabase_auth_admin";

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE "auth"."refresh_tokens_id_seq" OWNED BY "auth"."refresh_tokens"."id";


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."saml_providers" (
    "id" "uuid" NOT NULL,
    "sso_provider_id" "uuid" NOT NULL,
    "entity_id" "text" NOT NULL,
    "metadata_xml" "text" NOT NULL,
    "metadata_url" "text",
    "attribute_mapping" "jsonb",
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    "name_id_format" "text",
    CONSTRAINT "entity_id not empty" CHECK (("char_length"("entity_id") > 0)),
    CONSTRAINT "metadata_url not empty" CHECK ((("metadata_url" = NULL::"text") OR ("char_length"("metadata_url") > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK (("char_length"("metadata_xml") > 0))
);


ALTER TABLE "auth"."saml_providers" OWNER TO "supabase_auth_admin";

--
-- Name: TABLE "saml_providers"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE "auth"."saml_providers" IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."saml_relay_states" (
    "id" "uuid" NOT NULL,
    "sso_provider_id" "uuid" NOT NULL,
    "request_id" "text" NOT NULL,
    "for_email" "text",
    "redirect_to" "text",
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    "flow_state_id" "uuid",
    CONSTRAINT "request_id not empty" CHECK (("char_length"("request_id") > 0))
);


ALTER TABLE "auth"."saml_relay_states" OWNER TO "supabase_auth_admin";

--
-- Name: TABLE "saml_relay_states"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE "auth"."saml_relay_states" IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."schema_migrations" (
    "version" character varying(255) NOT NULL
);


ALTER TABLE "auth"."schema_migrations" OWNER TO "supabase_auth_admin";

--
-- Name: TABLE "schema_migrations"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE "auth"."schema_migrations" IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."sessions" (
    "id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    "factor_id" "uuid",
    "aal" "auth"."aal_level",
    "not_after" timestamp with time zone,
    "refreshed_at" timestamp without time zone,
    "user_agent" "text",
    "ip" "inet",
    "tag" "text",
    "oauth_client_id" "uuid",
    "refresh_token_hmac_key" "text",
    "refresh_token_counter" bigint,
    "scopes" "text",
    CONSTRAINT "sessions_scopes_length" CHECK (("char_length"("scopes") <= 4096))
);


ALTER TABLE "auth"."sessions" OWNER TO "supabase_auth_admin";

--
-- Name: TABLE "sessions"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE "auth"."sessions" IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN "sessions"."not_after"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN "auth"."sessions"."not_after" IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: COLUMN "sessions"."refresh_token_hmac_key"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN "auth"."sessions"."refresh_token_hmac_key" IS 'Holds a HMAC-SHA256 key used to sign refresh tokens for this session.';


--
-- Name: COLUMN "sessions"."refresh_token_counter"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN "auth"."sessions"."refresh_token_counter" IS 'Holds the ID (counter) of the last issued refresh token.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."sso_domains" (
    "id" "uuid" NOT NULL,
    "sso_provider_id" "uuid" NOT NULL,
    "domain" "text" NOT NULL,
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK (("char_length"("domain") > 0))
);


ALTER TABLE "auth"."sso_domains" OWNER TO "supabase_auth_admin";

--
-- Name: TABLE "sso_domains"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE "auth"."sso_domains" IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."sso_providers" (
    "id" "uuid" NOT NULL,
    "resource_id" "text",
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    "disabled" boolean,
    CONSTRAINT "resource_id not empty" CHECK ((("resource_id" = NULL::"text") OR ("char_length"("resource_id") > 0)))
);


ALTER TABLE "auth"."sso_providers" OWNER TO "supabase_auth_admin";

--
-- Name: TABLE "sso_providers"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE "auth"."sso_providers" IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN "sso_providers"."resource_id"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN "auth"."sso_providers"."resource_id" IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."users" (
    "instance_id" "uuid",
    "id" "uuid" NOT NULL,
    "aud" character varying(255),
    "role" character varying(255),
    "email" character varying(255),
    "encrypted_password" character varying(255),
    "email_confirmed_at" timestamp with time zone,
    "invited_at" timestamp with time zone,
    "confirmation_token" character varying(255),
    "confirmation_sent_at" timestamp with time zone,
    "recovery_token" character varying(255),
    "recovery_sent_at" timestamp with time zone,
    "email_change_token_new" character varying(255),
    "email_change" character varying(255),
    "email_change_sent_at" timestamp with time zone,
    "last_sign_in_at" timestamp with time zone,
    "raw_app_meta_data" "jsonb",
    "raw_user_meta_data" "jsonb",
    "is_super_admin" boolean,
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    "phone" "text" DEFAULT NULL::character varying,
    "phone_confirmed_at" timestamp with time zone,
    "phone_change" "text" DEFAULT ''::character varying,
    "phone_change_token" character varying(255) DEFAULT ''::character varying,
    "phone_change_sent_at" timestamp with time zone,
    "confirmed_at" timestamp with time zone GENERATED ALWAYS AS (LEAST("email_confirmed_at", "phone_confirmed_at")) STORED,
    "email_change_token_current" character varying(255) DEFAULT ''::character varying,
    "email_change_confirm_status" smallint DEFAULT 0,
    "banned_until" timestamp with time zone,
    "reauthentication_token" character varying(255) DEFAULT ''::character varying,
    "reauthentication_sent_at" timestamp with time zone,
    "is_sso_user" boolean DEFAULT false NOT NULL,
    "deleted_at" timestamp with time zone,
    "is_anonymous" boolean DEFAULT false NOT NULL,
    CONSTRAINT "users_email_change_confirm_status_check" CHECK ((("email_change_confirm_status" >= 0) AND ("email_change_confirm_status" <= 2)))
);


ALTER TABLE "auth"."users" OWNER TO "supabase_auth_admin";

--
-- Name: TABLE "users"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE "auth"."users" IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN "users"."is_sso_user"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN "auth"."users"."is_sso_user" IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: webauthn_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."webauthn_challenges" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid",
    "challenge_type" "text" NOT NULL,
    "session_data" "jsonb" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "expires_at" timestamp with time zone NOT NULL,
    CONSTRAINT "webauthn_challenges_challenge_type_check" CHECK (("challenge_type" = ANY (ARRAY['signup'::"text", 'registration'::"text", 'authentication'::"text"])))
);


ALTER TABLE "auth"."webauthn_challenges" OWNER TO "supabase_auth_admin";

--
-- Name: webauthn_credentials; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."webauthn_credentials" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "credential_id" "bytea" NOT NULL,
    "public_key" "bytea" NOT NULL,
    "attestation_type" "text" DEFAULT ''::"text" NOT NULL,
    "aaguid" "uuid",
    "sign_count" bigint DEFAULT 0 NOT NULL,
    "transports" "jsonb" DEFAULT '[]'::"jsonb" NOT NULL,
    "backup_eligible" boolean DEFAULT false NOT NULL,
    "backed_up" boolean DEFAULT false NOT NULL,
    "friendly_name" "text" DEFAULT ''::"text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "last_used_at" timestamp with time zone
);


ALTER TABLE "auth"."webauthn_credentials" OWNER TO "supabase_auth_admin";

--
-- Name: academic_deadlines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."academic_deadlines" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "title" "text" NOT NULL,
    "date" "date" NOT NULL,
    "type" "text" NOT NULL,
    "status" "text" NOT NULL,
    "amount" "text",
    "description" "text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "academic_deadlines_status_check" CHECK (("status" = ANY (ARRAY['urgent'::"text", 'upcoming'::"text"]))),
    CONSTRAINT "academic_deadlines_type_check" CHECK (("type" = ANY (ARRAY['fee'::"text", 'exam'::"text", 'scholarship'::"text", 'other'::"text"])))
);


ALTER TABLE "public"."academic_deadlines" OWNER TO "postgres";

--
-- Name: achievements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."achievements" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "student_id" "uuid" NOT NULL,
    "title" "text" NOT NULL,
    "category" "text" NOT NULL,
    "event_date" "date",
    "event_time" "text",
    "cert_url" "text",
    "attendance_claimed" boolean DEFAULT false,
    "notes" "text",
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."achievements" OWNER TO "postgres";

--
-- Name: ai_chat_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."ai_chat_history" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "session_id" "uuid" NOT NULL,
    "role" "text" NOT NULL,
    "content" "text",
    "tool_calls" "jsonb",
    "tool_call_id" "text",
    "name" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "ai_chat_history_role_check" CHECK (("role" = ANY (ARRAY['user'::"text", 'assistant'::"text", 'system'::"text", 'tool'::"text"])))
);


ALTER TABLE "public"."ai_chat_history" OWNER TO "postgres";

--
-- Name: attendance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."attendance" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "student_id" "uuid" NOT NULL,
    "class_id" "uuid" NOT NULL,
    "status" "public"."attendance_status" DEFAULT 'Present'::"public"."attendance_status" NOT NULL,
    "date" "date" DEFAULT CURRENT_DATE NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "mentor_id" "uuid" NOT NULL
);


ALTER TABLE "public"."attendance" OWNER TO "postgres";

--
-- Name: career_metrics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."career_metrics" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "student_id" "uuid" NOT NULL,
    "problem_solving" integer DEFAULT 0 NOT NULL,
    "communication" integer DEFAULT 0 NOT NULL,
    "technical_skills" integer DEFAULT 0 NOT NULL,
    "teamwork" integer DEFAULT 0 NOT NULL,
    "leadership" integer DEFAULT 0 NOT NULL,
    "adaptability" integer DEFAULT 0 NOT NULL,
    "recent_milestones" "jsonb" DEFAULT '[]'::"jsonb",
    "primary_strength" "text",
    "growth_area" "text",
    "updated_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "career_metrics_adaptability_check" CHECK ((("adaptability" >= 0) AND ("adaptability" <= 100))),
    CONSTRAINT "career_metrics_communication_check" CHECK ((("communication" >= 0) AND ("communication" <= 100))),
    CONSTRAINT "career_metrics_leadership_check" CHECK ((("leadership" >= 0) AND ("leadership" <= 100))),
    CONSTRAINT "career_metrics_problem_solving_check" CHECK ((("problem_solving" >= 0) AND ("problem_solving" <= 100))),
    CONSTRAINT "career_metrics_teamwork_check" CHECK ((("teamwork" >= 0) AND ("teamwork" <= 100))),
    CONSTRAINT "career_metrics_technical_skills_check" CHECK ((("technical_skills" >= 0) AND ("technical_skills" <= 100)))
);


ALTER TABLE "public"."career_metrics" OWNER TO "postgres";

--
-- Name: classes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."classes" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "subject_id" "uuid" NOT NULL,
    "mentor_id" "uuid" NOT NULL,
    "academic_year" "text" NOT NULL,
    "semester" smallint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."classes" OWNER TO "postgres";

--
-- Name: cover_letters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."cover_letters" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "student_id" "uuid" NOT NULL,
    "application_id" "uuid",
    "content" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."cover_letters" OWNER TO "postgres";

--
-- Name: direct_messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."direct_messages" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "sender_id" "uuid" NOT NULL,
    "receiver_id" "uuid" NOT NULL,
    "content_type" "text" DEFAULT 'text'::"text" NOT NULL,
    "content_url_or_text" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "read_at" timestamp with time zone,
    CONSTRAINT "direct_messages_content_type_check" CHECK (("content_type" = ANY (ARRAY['text'::"text", 'audio'::"text"])))
);


ALTER TABLE "public"."direct_messages" OWNER TO "postgres";

--
-- Name: enrollments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."enrollments" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "student_id" "uuid" NOT NULL,
    "class_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."enrollments" OWNER TO "postgres";

--
-- Name: erp_attendance_summary; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."erp_attendance_summary" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "student_id" "uuid",
    "class_id" "uuid",
    "theory_held" integer DEFAULT 0,
    "theory_attended" integer DEFAULT 0,
    "theory_percentage" numeric DEFAULT 0,
    "lab_held" integer DEFAULT 0,
    "lab_attended" integer DEFAULT 0,
    "lab_percentage" numeric DEFAULT 0,
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"())
);


ALTER TABLE "public"."erp_attendance_summary" OWNER TO "postgres";

--
-- Name: erp_credentials; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."erp_credentials" (
    "student_id" "uuid" NOT NULL,
    "username" "text" NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()),
    "password_encrypted" "bytea"
);


ALTER TABLE "public"."erp_credentials" OWNER TO "postgres";

--
-- Name: fee_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."fee_payments" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "student_id" "uuid" NOT NULL,
    "payment_type" "text" NOT NULL,
    "amount" numeric(10,2) NOT NULL,
    "status" "text" DEFAULT 'pending'::"text" NOT NULL,
    "razorpay_order_id" "text",
    "razorpay_payment_id" "text",
    "receipt_url" "text",
    "subjects" "jsonb",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "fee_payments_payment_type_check" CHECK (("payment_type" = ANY (ARRAY['revaluation'::"text", 'exam_registration'::"text"]))),
    CONSTRAINT "fee_payments_status_check" CHECK (("status" = ANY (ARRAY['pending'::"text", 'completed'::"text", 'failed'::"text"])))
);


ALTER TABLE "public"."fee_payments" OWNER TO "postgres";

--
-- Name: grades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."grades" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "student_id" "uuid" NOT NULL,
    "class_id" "uuid" NOT NULL,
    "internal_marks" numeric(5,2) DEFAULT 0 NOT NULL,
    "external_marks" numeric(5,2) DEFAULT 0 NOT NULL,
    "total_score" numeric(5,2) GENERATED ALWAYS AS (("internal_marks" + "external_marks")) STORED,
    "grade" "text" GENERATED ALWAYS AS (
CASE
    WHEN (("internal_marks" + "external_marks") >= (85)::numeric) THEN 'A'::"text"
    WHEN (("internal_marks" + "external_marks") >= (70)::numeric) THEN 'B'::"text"
    WHEN (("internal_marks" + "external_marks") >= (55)::numeric) THEN 'C'::"text"
    WHEN (("internal_marks" + "external_marks") >= (40)::numeric) THEN 'D'::"text"
    ELSE 'F'::"text"
END) STORED,
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "created_at" timestamp with time zone DEFAULT "now"(),
    "mentor_id" "uuid" NOT NULL,
    CONSTRAINT "grades_external_marks_check" CHECK ((("external_marks" >= (0)::numeric) AND ("external_marks" <= (50)::numeric))),
    CONSTRAINT "grades_internal_marks_check" CHECK ((("internal_marks" >= (0)::numeric) AND ("internal_marks" <= (50)::numeric)))
);


ALTER TABLE "public"."grades" OWNER TO "postgres";

--
-- Name: iat_marks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."iat_marks" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "student_id" "uuid" NOT NULL,
    "class_id" "uuid" NOT NULL,
    "remarks" "text",
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "created_at" timestamp with time zone DEFAULT "now"(),
    "iat1" numeric(5,2),
    "iat2" numeric(5,2),
    "lab_iat1" numeric(5,2),
    "lab_iat2" numeric(5,2),
    "assignment1" numeric(5,2),
    "assignment2" numeric(5,2),
    CONSTRAINT "iat_marks_assignment1_check" CHECK ((("assignment1" >= (0)::numeric) AND ("assignment1" <= (50)::numeric))),
    CONSTRAINT "iat_marks_assignment2_check" CHECK ((("assignment2" >= (0)::numeric) AND ("assignment2" <= (50)::numeric))),
    CONSTRAINT "iat_marks_iat1_check" CHECK ((("iat1" >= (0)::numeric) AND ("iat1" <= (50)::numeric))),
    CONSTRAINT "iat_marks_iat2_check" CHECK ((("iat2" >= (0)::numeric) AND ("iat2" <= (50)::numeric))),
    CONSTRAINT "iat_marks_lab_iat1_check" CHECK ((("lab_iat1" >= (0)::numeric) AND ("lab_iat1" <= (50)::numeric))),
    CONSTRAINT "iat_marks_lab_iat2_check" CHECK ((("lab_iat2" >= (0)::numeric) AND ("lab_iat2" <= (50)::numeric)))
);


ALTER TABLE "public"."iat_marks" OWNER TO "postgres";

--
-- Name: interventions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."interventions" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "mentor_id" "uuid" NOT NULL,
    "student_id" "uuid" NOT NULL,
    "type" "text" NOT NULL,
    "notes" "text",
    "date" "date" DEFAULT CURRENT_DATE NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."interventions" OWNER TO "postgres";

--
-- Name: job_applications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."job_applications" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "student_id" "uuid" NOT NULL,
    "company_name" "text" NOT NULL,
    "job_title" "text" NOT NULL,
    "location" "text",
    "status" "text" DEFAULT 'Applied'::"text" NOT NULL,
    "salary_range" "text",
    "notes" "text",
    "resume_id" "uuid",
    "applied_date" "date" DEFAULT CURRENT_DATE,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."job_applications" OWNER TO "postgres";

--
-- Name: notification_messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."notification_messages" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "title" "text" NOT NULL,
    "body" "text" NOT NULL,
    "type" "text" DEFAULT 'info'::"text" NOT NULL,
    "deep_link" "text",
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."notification_messages" OWNER TO "postgres";

--
-- Name: parent_access_codes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."parent_access_codes" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "code" "text" NOT NULL,
    "student_id" "uuid" NOT NULL,
    "mentor_id" "uuid" NOT NULL,
    "used" boolean DEFAULT false,
    "used_by_chat_id" bigint,
    "expires_at" timestamp with time zone DEFAULT ("now"() + '7 days'::interval),
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."parent_access_codes" OWNER TO "postgres";

--
-- Name: parent_student_links; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."parent_student_links" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "parent_id" "uuid" NOT NULL,
    "student_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."parent_student_links" OWNER TO "postgres";

--
-- Name: profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."profiles" (
    "id" "uuid" NOT NULL,
    "full_name" "text" NOT NULL,
    "role" "public"."user_role" DEFAULT 'student'::"public"."user_role" NOT NULL,
    "branch" "text" NOT NULL,
    "semester" smallint NOT NULL,
    "mentor_id" "uuid",
    "avatar_url" "text",
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "created_at" timestamp with time zone DEFAULT "now"(),
    "parent_email" "text",
    "parent_phone" "text",
    CONSTRAINT "profiles_semester_check" CHECK ((("semester" >= 1) AND ("semester" <= 8)))
);


ALTER TABLE "public"."profiles" OWNER TO "postgres";

--
-- Name: reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."reports" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "student_id" "uuid" NOT NULL,
    "mentor_id" "uuid" NOT NULL,
    "report_type" "text" NOT NULL,
    "content" "jsonb" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "reports_report_type_check" CHECK (("report_type" = ANY (ARRAY['summary'::"text", 'detailed'::"text", 'parent'::"text"])))
);


ALTER TABLE "public"."reports" OWNER TO "postgres";

--
-- Name: resume_examples; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."resume_examples" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "industry" "text" NOT NULL,
    "title" "text" NOT NULL,
    "resume_data" "jsonb" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."resume_examples" OWNER TO "postgres";

--
-- Name: resumes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."resumes" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "student_id" "uuid" NOT NULL,
    "title" "text" NOT NULL,
    "resume_data" "jsonb" DEFAULT '{}'::"jsonb" NOT NULL,
    "ats_score" integer DEFAULT 0,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."resumes" OWNER TO "postgres";

--
-- Name: semester_results; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."semester_results" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "student_id" "uuid" NOT NULL,
    "usn" "text" NOT NULL,
    "semester" smallint NOT NULL,
    "sgpa" numeric(4,2),
    "total_credits" smallint,
    "earned_credits" smallint,
    "status" "text" NOT NULL,
    "raw_data" "jsonb",
    "created_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "semester_results_status_check" CHECK (("status" = ANY (ARRAY['PASS'::"text", 'FAIL'::"text"])))
);


ALTER TABLE "public"."semester_results" OWNER TO "postgres";

--
-- Name: subjects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."subjects" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "name" "text" NOT NULL,
    "code" "text" NOT NULL,
    "description" "text",
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."subjects" OWNER TO "postgres";

--
-- Name: telegram_sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."telegram_sessions" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "telegram_chat_id" bigint NOT NULL,
    "user_id" "uuid",
    "role" "text",
    "linked_student_id" "uuid",
    "state" "text" DEFAULT 'idle'::"text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "telegram_sessions_role_check" CHECK (("role" = ANY (ARRAY['student'::"text", 'mentor'::"text", 'parent'::"text"])))
);


ALTER TABLE "public"."telegram_sessions" OWNER TO "postgres";

--
-- Name: timetables; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."timetables" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "class_id" "uuid" NOT NULL,
    "day_of_week" smallint NOT NULL,
    "start_time" time without time zone NOT NULL,
    "end_time" time without time zone NOT NULL,
    "location" "text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "timetables_check" CHECK (("end_time" > "start_time")),
    CONSTRAINT "timetables_day_of_week_check" CHECK ((("day_of_week" >= 0) AND ("day_of_week" <= 6)))
);


ALTER TABLE "public"."timetables" OWNER TO "postgres";

--
-- Name: user_notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."user_notifications" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "message_id" "uuid" NOT NULL,
    "is_read" boolean DEFAULT false NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."user_notifications" OWNER TO "postgres";

--
-- Name: v_student_timetables; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW "public"."v_student_timetables" WITH ("security_invoker"='true') AS
 SELECT "t"."id" AS "timetable_id",
    "t"."day_of_week",
    "t"."start_time",
    "t"."end_time",
    "t"."location",
    "s"."name" AS "subject_name",
    "s"."code" AS "subject_code",
    "m"."full_name" AS "mentor_name",
    "e"."student_id"
   FROM (((("public"."timetables" "t"
     JOIN "public"."classes" "c" ON (("t"."class_id" = "c"."id")))
     JOIN "public"."subjects" "s" ON (("c"."subject_id" = "s"."id")))
     JOIN "public"."profiles" "m" ON (("c"."mentor_id" = "m"."id")))
     JOIN "public"."enrollments" "e" ON (("c"."id" = "e"."class_id")));


ALTER VIEW "public"."v_student_timetables" OWNER TO "postgres";

--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."refresh_tokens" ALTER COLUMN "id" SET DEFAULT "nextval"('"auth"."refresh_tokens_id_seq"'::"regclass");


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."mfa_amr_claims"
    ADD CONSTRAINT "amr_id_pk" PRIMARY KEY ("id");


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."audit_log_entries"
    ADD CONSTRAINT "audit_log_entries_pkey" PRIMARY KEY ("id");


--
-- Name: custom_oauth_providers custom_oauth_providers_identifier_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."custom_oauth_providers"
    ADD CONSTRAINT "custom_oauth_providers_identifier_key" UNIQUE ("identifier");


--
-- Name: custom_oauth_providers custom_oauth_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."custom_oauth_providers"
    ADD CONSTRAINT "custom_oauth_providers_pkey" PRIMARY KEY ("id");


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."flow_state"
    ADD CONSTRAINT "flow_state_pkey" PRIMARY KEY ("id");


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."identities"
    ADD CONSTRAINT "identities_pkey" PRIMARY KEY ("id");


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."identities"
    ADD CONSTRAINT "identities_provider_id_provider_unique" UNIQUE ("provider_id", "provider");


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."instances"
    ADD CONSTRAINT "instances_pkey" PRIMARY KEY ("id");


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."mfa_amr_claims"
    ADD CONSTRAINT "mfa_amr_claims_session_id_authentication_method_pkey" UNIQUE ("session_id", "authentication_method");


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."mfa_challenges"
    ADD CONSTRAINT "mfa_challenges_pkey" PRIMARY KEY ("id");


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."mfa_factors"
    ADD CONSTRAINT "mfa_factors_last_challenged_at_key" UNIQUE ("last_challenged_at");


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."mfa_factors"
    ADD CONSTRAINT "mfa_factors_pkey" PRIMARY KEY ("id");


--
-- Name: oauth_authorizations oauth_authorizations_authorization_code_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."oauth_authorizations"
    ADD CONSTRAINT "oauth_authorizations_authorization_code_key" UNIQUE ("authorization_code");


--
-- Name: oauth_authorizations oauth_authorizations_authorization_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."oauth_authorizations"
    ADD CONSTRAINT "oauth_authorizations_authorization_id_key" UNIQUE ("authorization_id");


--
-- Name: oauth_authorizations oauth_authorizations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."oauth_authorizations"
    ADD CONSTRAINT "oauth_authorizations_pkey" PRIMARY KEY ("id");


--
-- Name: oauth_client_states oauth_client_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."oauth_client_states"
    ADD CONSTRAINT "oauth_client_states_pkey" PRIMARY KEY ("id");


--
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."oauth_clients"
    ADD CONSTRAINT "oauth_clients_pkey" PRIMARY KEY ("id");


--
-- Name: oauth_consents oauth_consents_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."oauth_consents"
    ADD CONSTRAINT "oauth_consents_pkey" PRIMARY KEY ("id");


--
-- Name: oauth_consents oauth_consents_user_client_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."oauth_consents"
    ADD CONSTRAINT "oauth_consents_user_client_unique" UNIQUE ("user_id", "client_id");


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."one_time_tokens"
    ADD CONSTRAINT "one_time_tokens_pkey" PRIMARY KEY ("id");


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."refresh_tokens"
    ADD CONSTRAINT "refresh_tokens_pkey" PRIMARY KEY ("id");


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."refresh_tokens"
    ADD CONSTRAINT "refresh_tokens_token_unique" UNIQUE ("token");


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."saml_providers"
    ADD CONSTRAINT "saml_providers_entity_id_key" UNIQUE ("entity_id");


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."saml_providers"
    ADD CONSTRAINT "saml_providers_pkey" PRIMARY KEY ("id");


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."saml_relay_states"
    ADD CONSTRAINT "saml_relay_states_pkey" PRIMARY KEY ("id");


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."schema_migrations"
    ADD CONSTRAINT "schema_migrations_pkey" PRIMARY KEY ("version");


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."sessions"
    ADD CONSTRAINT "sessions_pkey" PRIMARY KEY ("id");


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."sso_domains"
    ADD CONSTRAINT "sso_domains_pkey" PRIMARY KEY ("id");


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."sso_providers"
    ADD CONSTRAINT "sso_providers_pkey" PRIMARY KEY ("id");


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."users"
    ADD CONSTRAINT "users_phone_key" UNIQUE ("phone");


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."users"
    ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");


--
-- Name: webauthn_challenges webauthn_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."webauthn_challenges"
    ADD CONSTRAINT "webauthn_challenges_pkey" PRIMARY KEY ("id");


--
-- Name: webauthn_credentials webauthn_credentials_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."webauthn_credentials"
    ADD CONSTRAINT "webauthn_credentials_pkey" PRIMARY KEY ("id");


--
-- Name: academic_deadlines academic_deadlines_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."academic_deadlines"
    ADD CONSTRAINT "academic_deadlines_pkey" PRIMARY KEY ("id");


--
-- Name: achievements achievements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."achievements"
    ADD CONSTRAINT "achievements_pkey" PRIMARY KEY ("id");


--
-- Name: ai_chat_history ai_chat_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."ai_chat_history"
    ADD CONSTRAINT "ai_chat_history_pkey" PRIMARY KEY ("id");


--
-- Name: attendance attendance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."attendance"
    ADD CONSTRAINT "attendance_pkey" PRIMARY KEY ("id");


--
-- Name: attendance attendance_student_id_class_id_date_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."attendance"
    ADD CONSTRAINT "attendance_student_id_class_id_date_key" UNIQUE ("student_id", "class_id", "date");


--
-- Name: career_metrics career_metrics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."career_metrics"
    ADD CONSTRAINT "career_metrics_pkey" PRIMARY KEY ("id");


--
-- Name: career_metrics career_metrics_student_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."career_metrics"
    ADD CONSTRAINT "career_metrics_student_id_key" UNIQUE ("student_id");


--
-- Name: classes classes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."classes"
    ADD CONSTRAINT "classes_pkey" PRIMARY KEY ("id");


--
-- Name: classes classes_subject_id_mentor_id_academic_year_semester_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."classes"
    ADD CONSTRAINT "classes_subject_id_mentor_id_academic_year_semester_key" UNIQUE ("subject_id", "mentor_id", "academic_year", "semester");


--
-- Name: cover_letters cover_letters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."cover_letters"
    ADD CONSTRAINT "cover_letters_pkey" PRIMARY KEY ("id");


--
-- Name: direct_messages direct_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."direct_messages"
    ADD CONSTRAINT "direct_messages_pkey" PRIMARY KEY ("id");


--
-- Name: enrollments enrollments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."enrollments"
    ADD CONSTRAINT "enrollments_pkey" PRIMARY KEY ("id");


--
-- Name: enrollments enrollments_student_id_class_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."enrollments"
    ADD CONSTRAINT "enrollments_student_id_class_id_key" UNIQUE ("student_id", "class_id");


--
-- Name: erp_attendance_summary erp_attendance_summary_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."erp_attendance_summary"
    ADD CONSTRAINT "erp_attendance_summary_pkey" PRIMARY KEY ("id");


--
-- Name: erp_attendance_summary erp_attendance_summary_student_id_class_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."erp_attendance_summary"
    ADD CONSTRAINT "erp_attendance_summary_student_id_class_id_key" UNIQUE ("student_id", "class_id");


--
-- Name: erp_credentials erp_credentials_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."erp_credentials"
    ADD CONSTRAINT "erp_credentials_pkey" PRIMARY KEY ("student_id");


--
-- Name: fee_payments fee_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."fee_payments"
    ADD CONSTRAINT "fee_payments_pkey" PRIMARY KEY ("id");


--
-- Name: grades grades_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."grades"
    ADD CONSTRAINT "grades_pkey" PRIMARY KEY ("id");


--
-- Name: grades grades_student_id_class_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."grades"
    ADD CONSTRAINT "grades_student_id_class_id_key" UNIQUE ("student_id", "class_id");


--
-- Name: iat_marks iat_marks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."iat_marks"
    ADD CONSTRAINT "iat_marks_pkey" PRIMARY KEY ("id");


--
-- Name: iat_marks iat_marks_student_class_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."iat_marks"
    ADD CONSTRAINT "iat_marks_student_class_key" UNIQUE ("student_id", "class_id");


--
-- Name: interventions interventions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."interventions"
    ADD CONSTRAINT "interventions_pkey" PRIMARY KEY ("id");


--
-- Name: job_applications job_applications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."job_applications"
    ADD CONSTRAINT "job_applications_pkey" PRIMARY KEY ("id");


--
-- Name: notification_messages notification_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."notification_messages"
    ADD CONSTRAINT "notification_messages_pkey" PRIMARY KEY ("id");


--
-- Name: parent_access_codes parent_access_codes_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."parent_access_codes"
    ADD CONSTRAINT "parent_access_codes_code_key" UNIQUE ("code");


--
-- Name: parent_access_codes parent_access_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."parent_access_codes"
    ADD CONSTRAINT "parent_access_codes_pkey" PRIMARY KEY ("id");


--
-- Name: parent_student_links parent_student_links_parent_id_student_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."parent_student_links"
    ADD CONSTRAINT "parent_student_links_parent_id_student_id_key" UNIQUE ("parent_id", "student_id");


--
-- Name: parent_student_links parent_student_links_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."parent_student_links"
    ADD CONSTRAINT "parent_student_links_pkey" PRIMARY KEY ("id");


--
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_pkey" PRIMARY KEY ("id");


--
-- Name: reports reports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."reports"
    ADD CONSTRAINT "reports_pkey" PRIMARY KEY ("id");


--
-- Name: resume_examples resume_examples_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."resume_examples"
    ADD CONSTRAINT "resume_examples_pkey" PRIMARY KEY ("id");


--
-- Name: resumes resumes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."resumes"
    ADD CONSTRAINT "resumes_pkey" PRIMARY KEY ("id");


--
-- Name: semester_results semester_results_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."semester_results"
    ADD CONSTRAINT "semester_results_pkey" PRIMARY KEY ("id");


--
-- Name: semester_results semester_results_student_id_semester_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."semester_results"
    ADD CONSTRAINT "semester_results_student_id_semester_key" UNIQUE ("student_id", "semester");


--
-- Name: subjects subjects_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."subjects"
    ADD CONSTRAINT "subjects_code_key" UNIQUE ("code");


--
-- Name: subjects subjects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."subjects"
    ADD CONSTRAINT "subjects_pkey" PRIMARY KEY ("id");


--
-- Name: telegram_sessions telegram_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."telegram_sessions"
    ADD CONSTRAINT "telegram_sessions_pkey" PRIMARY KEY ("id");


--
-- Name: telegram_sessions telegram_sessions_telegram_chat_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."telegram_sessions"
    ADD CONSTRAINT "telegram_sessions_telegram_chat_id_key" UNIQUE ("telegram_chat_id");


--
-- Name: timetables timetables_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."timetables"
    ADD CONSTRAINT "timetables_pkey" PRIMARY KEY ("id");


--
-- Name: user_notifications user_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."user_notifications"
    ADD CONSTRAINT "user_notifications_pkey" PRIMARY KEY ("id");


--
-- Name: user_notifications user_notifications_user_id_message_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."user_notifications"
    ADD CONSTRAINT "user_notifications_user_id_message_id_key" UNIQUE ("user_id", "message_id");


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "audit_logs_instance_id_idx" ON "auth"."audit_log_entries" USING "btree" ("instance_id");


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX "confirmation_token_idx" ON "auth"."users" USING "btree" ("confirmation_token") WHERE (("confirmation_token")::"text" !~ '^[0-9 ]*$'::"text");


--
-- Name: custom_oauth_providers_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "custom_oauth_providers_created_at_idx" ON "auth"."custom_oauth_providers" USING "btree" ("created_at");


--
-- Name: custom_oauth_providers_enabled_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "custom_oauth_providers_enabled_idx" ON "auth"."custom_oauth_providers" USING "btree" ("enabled");


--
-- Name: custom_oauth_providers_identifier_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "custom_oauth_providers_identifier_idx" ON "auth"."custom_oauth_providers" USING "btree" ("identifier");


--
-- Name: custom_oauth_providers_provider_type_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "custom_oauth_providers_provider_type_idx" ON "auth"."custom_oauth_providers" USING "btree" ("provider_type");


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX "email_change_token_current_idx" ON "auth"."users" USING "btree" ("email_change_token_current") WHERE (("email_change_token_current")::"text" !~ '^[0-9 ]*$'::"text");


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX "email_change_token_new_idx" ON "auth"."users" USING "btree" ("email_change_token_new") WHERE (("email_change_token_new")::"text" !~ '^[0-9 ]*$'::"text");


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "factor_id_created_at_idx" ON "auth"."mfa_factors" USING "btree" ("user_id", "created_at");


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "flow_state_created_at_idx" ON "auth"."flow_state" USING "btree" ("created_at" DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "identities_email_idx" ON "auth"."identities" USING "btree" ("email" "text_pattern_ops");


--
-- Name: INDEX "identities_email_idx"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX "auth"."identities_email_idx" IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "identities_user_id_idx" ON "auth"."identities" USING "btree" ("user_id");


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "idx_auth_code" ON "auth"."flow_state" USING "btree" ("auth_code");


--
-- Name: idx_oauth_client_states_created_at; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "idx_oauth_client_states_created_at" ON "auth"."oauth_client_states" USING "btree" ("created_at");


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "idx_user_id_auth_method" ON "auth"."flow_state" USING "btree" ("user_id", "authentication_method");


--
-- Name: idx_users_created_at_desc; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "idx_users_created_at_desc" ON "auth"."users" USING "btree" ("created_at" DESC);


--
-- Name: idx_users_email; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "idx_users_email" ON "auth"."users" USING "btree" ("email");


--
-- Name: idx_users_last_sign_in_at_desc; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "idx_users_last_sign_in_at_desc" ON "auth"."users" USING "btree" ("last_sign_in_at" DESC);


--
-- Name: idx_users_name; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "idx_users_name" ON "auth"."users" USING "btree" ((("raw_user_meta_data" ->> 'name'::"text"))) WHERE (("raw_user_meta_data" ->> 'name'::"text") IS NOT NULL);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "mfa_challenge_created_at_idx" ON "auth"."mfa_challenges" USING "btree" ("created_at" DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX "mfa_factors_user_friendly_name_unique" ON "auth"."mfa_factors" USING "btree" ("friendly_name", "user_id") WHERE (TRIM(BOTH FROM "friendly_name") <> ''::"text");


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "mfa_factors_user_id_idx" ON "auth"."mfa_factors" USING "btree" ("user_id");


--
-- Name: oauth_auth_pending_exp_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "oauth_auth_pending_exp_idx" ON "auth"."oauth_authorizations" USING "btree" ("expires_at") WHERE ("status" = 'pending'::"auth"."oauth_authorization_status");


--
-- Name: oauth_clients_deleted_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "oauth_clients_deleted_at_idx" ON "auth"."oauth_clients" USING "btree" ("deleted_at");


--
-- Name: oauth_consents_active_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "oauth_consents_active_client_idx" ON "auth"."oauth_consents" USING "btree" ("client_id") WHERE ("revoked_at" IS NULL);


--
-- Name: oauth_consents_active_user_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "oauth_consents_active_user_client_idx" ON "auth"."oauth_consents" USING "btree" ("user_id", "client_id") WHERE ("revoked_at" IS NULL);


--
-- Name: oauth_consents_user_order_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "oauth_consents_user_order_idx" ON "auth"."oauth_consents" USING "btree" ("user_id", "granted_at" DESC);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "one_time_tokens_relates_to_hash_idx" ON "auth"."one_time_tokens" USING "hash" ("relates_to");


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "one_time_tokens_token_hash_hash_idx" ON "auth"."one_time_tokens" USING "hash" ("token_hash");


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX "one_time_tokens_user_id_token_type_key" ON "auth"."one_time_tokens" USING "btree" ("user_id", "token_type");


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX "reauthentication_token_idx" ON "auth"."users" USING "btree" ("reauthentication_token") WHERE (("reauthentication_token")::"text" !~ '^[0-9 ]*$'::"text");


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX "recovery_token_idx" ON "auth"."users" USING "btree" ("recovery_token") WHERE (("recovery_token")::"text" !~ '^[0-9 ]*$'::"text");


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "refresh_tokens_instance_id_idx" ON "auth"."refresh_tokens" USING "btree" ("instance_id");


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "refresh_tokens_instance_id_user_id_idx" ON "auth"."refresh_tokens" USING "btree" ("instance_id", "user_id");


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "refresh_tokens_parent_idx" ON "auth"."refresh_tokens" USING "btree" ("parent");


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "refresh_tokens_session_id_revoked_idx" ON "auth"."refresh_tokens" USING "btree" ("session_id", "revoked");


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "refresh_tokens_updated_at_idx" ON "auth"."refresh_tokens" USING "btree" ("updated_at" DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "saml_providers_sso_provider_id_idx" ON "auth"."saml_providers" USING "btree" ("sso_provider_id");


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "saml_relay_states_created_at_idx" ON "auth"."saml_relay_states" USING "btree" ("created_at" DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "saml_relay_states_for_email_idx" ON "auth"."saml_relay_states" USING "btree" ("for_email");


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "saml_relay_states_sso_provider_id_idx" ON "auth"."saml_relay_states" USING "btree" ("sso_provider_id");


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "sessions_not_after_idx" ON "auth"."sessions" USING "btree" ("not_after" DESC);


--
-- Name: sessions_oauth_client_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "sessions_oauth_client_id_idx" ON "auth"."sessions" USING "btree" ("oauth_client_id");


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "sessions_user_id_idx" ON "auth"."sessions" USING "btree" ("user_id");


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX "sso_domains_domain_idx" ON "auth"."sso_domains" USING "btree" ("lower"("domain"));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "sso_domains_sso_provider_id_idx" ON "auth"."sso_domains" USING "btree" ("sso_provider_id");


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX "sso_providers_resource_id_idx" ON "auth"."sso_providers" USING "btree" ("lower"("resource_id"));


--
-- Name: sso_providers_resource_id_pattern_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "sso_providers_resource_id_pattern_idx" ON "auth"."sso_providers" USING "btree" ("resource_id" "text_pattern_ops");


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX "unique_phone_factor_per_user" ON "auth"."mfa_factors" USING "btree" ("user_id", "phone");


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "user_id_created_at_idx" ON "auth"."sessions" USING "btree" ("user_id", "created_at");


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX "users_email_partial_key" ON "auth"."users" USING "btree" ("email") WHERE ("is_sso_user" = false);


--
-- Name: INDEX "users_email_partial_key"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX "auth"."users_email_partial_key" IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "users_instance_id_email_idx" ON "auth"."users" USING "btree" ("instance_id", "lower"(("email")::"text"));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "users_instance_id_idx" ON "auth"."users" USING "btree" ("instance_id");


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "users_is_anonymous_idx" ON "auth"."users" USING "btree" ("is_anonymous");


--
-- Name: webauthn_challenges_expires_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "webauthn_challenges_expires_at_idx" ON "auth"."webauthn_challenges" USING "btree" ("expires_at");


--
-- Name: webauthn_challenges_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "webauthn_challenges_user_id_idx" ON "auth"."webauthn_challenges" USING "btree" ("user_id");


--
-- Name: webauthn_credentials_credential_id_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX "webauthn_credentials_credential_id_key" ON "auth"."webauthn_credentials" USING "btree" ("credential_id");


--
-- Name: webauthn_credentials_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "webauthn_credentials_user_id_idx" ON "auth"."webauthn_credentials" USING "btree" ("user_id");


--
-- Name: idx_ai_chat_history_session_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_ai_chat_history_session_id" ON "public"."ai_chat_history" USING "btree" ("session_id");


--
-- Name: idx_attendance_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_attendance_date" ON "public"."attendance" USING "btree" ("date");


--
-- Name: idx_attendance_student_class; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_attendance_student_class" ON "public"."attendance" USING "btree" ("student_id", "class_id");


--
-- Name: idx_direct_messages_participants; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_direct_messages_participants" ON "public"."direct_messages" USING "btree" ("sender_id", "receiver_id");


--
-- Name: idx_enrollments_class; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_enrollments_class" ON "public"."enrollments" USING "btree" ("class_id");


--
-- Name: idx_enrollments_student; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_enrollments_student" ON "public"."enrollments" USING "btree" ("student_id");


--
-- Name: idx_grades_student; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_grades_student" ON "public"."grades" USING "btree" ("student_id");


--
-- Name: idx_iat_marks_class; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_iat_marks_class" ON "public"."iat_marks" USING "btree" ("class_id");


--
-- Name: idx_iat_marks_student; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_iat_marks_student" ON "public"."iat_marks" USING "btree" ("student_id");


--
-- Name: idx_timetables_class_day; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_timetables_class_day" ON "public"."timetables" USING "btree" ("class_id", "day_of_week");


--
-- Name: idx_user_notifications_user_read; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_user_notifications_user_read" ON "public"."user_notifications" USING "btree" ("user_id", "is_read");


--
-- Name: interventions_mentor_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "interventions_mentor_id_idx" ON "public"."interventions" USING "btree" ("mentor_id");


--
-- Name: interventions_student_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "interventions_student_id_idx" ON "public"."interventions" USING "btree" ("student_id");


--
-- Name: grades set_grades_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "set_grades_updated_at" BEFORE UPDATE ON "public"."grades" FOR EACH ROW EXECUTE FUNCTION "public"."set_updated_at"();


--
-- Name: iat_marks set_iat_marks_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "set_iat_marks_updated_at" BEFORE UPDATE ON "public"."iat_marks" FOR EACH ROW EXECUTE FUNCTION "public"."set_updated_at"();


--
-- Name: profiles set_profiles_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "set_profiles_updated_at" BEFORE UPDATE ON "public"."profiles" FOR EACH ROW EXECUTE FUNCTION "public"."set_updated_at"();


--
-- Name: attendance trigger_attendance_risk_notify; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "trigger_attendance_risk_notify" AFTER INSERT OR UPDATE ON "public"."attendance" FOR EACH ROW EXECUTE FUNCTION "public"."notify_attendance_risk"();


--
-- Name: grades trigger_grade_risk_notify; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "trigger_grade_risk_notify" AFTER UPDATE ON "public"."grades" FOR EACH ROW EXECUTE FUNCTION "public"."notify_grade_risk"();


--
-- Name: cover_letters update_cover_letters_modtime; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "update_cover_letters_modtime" BEFORE UPDATE ON "public"."cover_letters" FOR EACH ROW EXECUTE FUNCTION "public"."update_modified_column"();


--
-- Name: job_applications update_job_applications_modtime; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "update_job_applications_modtime" BEFORE UPDATE ON "public"."job_applications" FOR EACH ROW EXECUTE FUNCTION "public"."update_modified_column"();


--
-- Name: resumes update_resumes_modtime; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "update_resumes_modtime" BEFORE UPDATE ON "public"."resumes" FOR EACH ROW EXECUTE FUNCTION "public"."update_modified_column"();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."identities"
    ADD CONSTRAINT "identities_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."mfa_amr_claims"
    ADD CONSTRAINT "mfa_amr_claims_session_id_fkey" FOREIGN KEY ("session_id") REFERENCES "auth"."sessions"("id") ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."mfa_challenges"
    ADD CONSTRAINT "mfa_challenges_auth_factor_id_fkey" FOREIGN KEY ("factor_id") REFERENCES "auth"."mfa_factors"("id") ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."mfa_factors"
    ADD CONSTRAINT "mfa_factors_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."oauth_authorizations"
    ADD CONSTRAINT "oauth_authorizations_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "auth"."oauth_clients"("id") ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."oauth_authorizations"
    ADD CONSTRAINT "oauth_authorizations_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."oauth_consents"
    ADD CONSTRAINT "oauth_consents_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "auth"."oauth_clients"("id") ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."oauth_consents"
    ADD CONSTRAINT "oauth_consents_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."one_time_tokens"
    ADD CONSTRAINT "one_time_tokens_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."refresh_tokens"
    ADD CONSTRAINT "refresh_tokens_session_id_fkey" FOREIGN KEY ("session_id") REFERENCES "auth"."sessions"("id") ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."saml_providers"
    ADD CONSTRAINT "saml_providers_sso_provider_id_fkey" FOREIGN KEY ("sso_provider_id") REFERENCES "auth"."sso_providers"("id") ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."saml_relay_states"
    ADD CONSTRAINT "saml_relay_states_flow_state_id_fkey" FOREIGN KEY ("flow_state_id") REFERENCES "auth"."flow_state"("id") ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."saml_relay_states"
    ADD CONSTRAINT "saml_relay_states_sso_provider_id_fkey" FOREIGN KEY ("sso_provider_id") REFERENCES "auth"."sso_providers"("id") ON DELETE CASCADE;


--
-- Name: sessions sessions_oauth_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."sessions"
    ADD CONSTRAINT "sessions_oauth_client_id_fkey" FOREIGN KEY ("oauth_client_id") REFERENCES "auth"."oauth_clients"("id") ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."sessions"
    ADD CONSTRAINT "sessions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."sso_domains"
    ADD CONSTRAINT "sso_domains_sso_provider_id_fkey" FOREIGN KEY ("sso_provider_id") REFERENCES "auth"."sso_providers"("id") ON DELETE CASCADE;


--
-- Name: webauthn_challenges webauthn_challenges_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."webauthn_challenges"
    ADD CONSTRAINT "webauthn_challenges_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;


--
-- Name: webauthn_credentials webauthn_credentials_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."webauthn_credentials"
    ADD CONSTRAINT "webauthn_credentials_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;


--
-- Name: achievements achievements_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."achievements"
    ADD CONSTRAINT "achievements_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "auth"."users"("id");


--
-- Name: ai_chat_history ai_chat_history_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."ai_chat_history"
    ADD CONSTRAINT "ai_chat_history_session_id_fkey" FOREIGN KEY ("session_id") REFERENCES "public"."telegram_sessions"("id") ON DELETE CASCADE;


--
-- Name: attendance attendance_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."attendance"
    ADD CONSTRAINT "attendance_class_id_fkey" FOREIGN KEY ("class_id") REFERENCES "public"."classes"("id") ON DELETE CASCADE;


--
-- Name: attendance attendance_mentor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."attendance"
    ADD CONSTRAINT "attendance_mentor_id_fkey" FOREIGN KEY ("mentor_id") REFERENCES "public"."profiles"("id");


--
-- Name: attendance attendance_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."attendance"
    ADD CONSTRAINT "attendance_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;


--
-- Name: career_metrics career_metrics_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."career_metrics"
    ADD CONSTRAINT "career_metrics_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;


--
-- Name: classes classes_mentor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."classes"
    ADD CONSTRAINT "classes_mentor_id_fkey" FOREIGN KEY ("mentor_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;


--
-- Name: classes classes_subject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."classes"
    ADD CONSTRAINT "classes_subject_id_fkey" FOREIGN KEY ("subject_id") REFERENCES "public"."subjects"("id") ON DELETE CASCADE;


--
-- Name: cover_letters cover_letters_application_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."cover_letters"
    ADD CONSTRAINT "cover_letters_application_id_fkey" FOREIGN KEY ("application_id") REFERENCES "public"."job_applications"("id") ON DELETE CASCADE;


--
-- Name: cover_letters cover_letters_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."cover_letters"
    ADD CONSTRAINT "cover_letters_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;


--
-- Name: direct_messages direct_messages_receiver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."direct_messages"
    ADD CONSTRAINT "direct_messages_receiver_id_fkey" FOREIGN KEY ("receiver_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;


--
-- Name: direct_messages direct_messages_sender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."direct_messages"
    ADD CONSTRAINT "direct_messages_sender_id_fkey" FOREIGN KEY ("sender_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;


--
-- Name: enrollments enrollments_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."enrollments"
    ADD CONSTRAINT "enrollments_class_id_fkey" FOREIGN KEY ("class_id") REFERENCES "public"."classes"("id") ON DELETE CASCADE;


--
-- Name: enrollments enrollments_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."enrollments"
    ADD CONSTRAINT "enrollments_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;


--
-- Name: erp_attendance_summary erp_attendance_summary_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."erp_attendance_summary"
    ADD CONSTRAINT "erp_attendance_summary_class_id_fkey" FOREIGN KEY ("class_id") REFERENCES "public"."classes"("id") ON DELETE CASCADE;


--
-- Name: erp_attendance_summary erp_attendance_summary_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."erp_attendance_summary"
    ADD CONSTRAINT "erp_attendance_summary_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;


--
-- Name: erp_credentials erp_credentials_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."erp_credentials"
    ADD CONSTRAINT "erp_credentials_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;


--
-- Name: fee_payments fee_payments_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."fee_payments"
    ADD CONSTRAINT "fee_payments_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;


--
-- Name: grades grades_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."grades"
    ADD CONSTRAINT "grades_class_id_fkey" FOREIGN KEY ("class_id") REFERENCES "public"."classes"("id") ON DELETE CASCADE;


--
-- Name: grades grades_mentor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."grades"
    ADD CONSTRAINT "grades_mentor_id_fkey" FOREIGN KEY ("mentor_id") REFERENCES "public"."profiles"("id");


--
-- Name: grades grades_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."grades"
    ADD CONSTRAINT "grades_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;


--
-- Name: iat_marks iat_marks_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."iat_marks"
    ADD CONSTRAINT "iat_marks_class_id_fkey" FOREIGN KEY ("class_id") REFERENCES "public"."classes"("id") ON DELETE CASCADE;


--
-- Name: iat_marks iat_marks_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."iat_marks"
    ADD CONSTRAINT "iat_marks_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;


--
-- Name: interventions interventions_mentor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."interventions"
    ADD CONSTRAINT "interventions_mentor_id_fkey" FOREIGN KEY ("mentor_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;


--
-- Name: interventions interventions_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."interventions"
    ADD CONSTRAINT "interventions_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;


--
-- Name: job_applications job_applications_resume_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."job_applications"
    ADD CONSTRAINT "job_applications_resume_id_fkey" FOREIGN KEY ("resume_id") REFERENCES "public"."resumes"("id") ON DELETE SET NULL;


--
-- Name: job_applications job_applications_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."job_applications"
    ADD CONSTRAINT "job_applications_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;


--
-- Name: parent_access_codes parent_access_codes_mentor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."parent_access_codes"
    ADD CONSTRAINT "parent_access_codes_mentor_id_fkey" FOREIGN KEY ("mentor_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;


--
-- Name: parent_access_codes parent_access_codes_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."parent_access_codes"
    ADD CONSTRAINT "parent_access_codes_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;


--
-- Name: parent_student_links parent_student_links_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."parent_student_links"
    ADD CONSTRAINT "parent_student_links_parent_id_fkey" FOREIGN KEY ("parent_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;


--
-- Name: parent_student_links parent_student_links_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."parent_student_links"
    ADD CONSTRAINT "parent_student_links_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;


--
-- Name: profiles profiles_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_id_fkey" FOREIGN KEY ("id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;


--
-- Name: profiles profiles_mentor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_mentor_id_fkey" FOREIGN KEY ("mentor_id") REFERENCES "public"."profiles"("id") ON DELETE SET NULL;


--
-- Name: reports reports_mentor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."reports"
    ADD CONSTRAINT "reports_mentor_id_fkey" FOREIGN KEY ("mentor_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;


--
-- Name: reports reports_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."reports"
    ADD CONSTRAINT "reports_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;


--
-- Name: resumes resumes_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."resumes"
    ADD CONSTRAINT "resumes_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;


--
-- Name: semester_results semester_results_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."semester_results"
    ADD CONSTRAINT "semester_results_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;


--
-- Name: telegram_sessions telegram_sessions_linked_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."telegram_sessions"
    ADD CONSTRAINT "telegram_sessions_linked_student_id_fkey" FOREIGN KEY ("linked_student_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;


--
-- Name: telegram_sessions telegram_sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."telegram_sessions"
    ADD CONSTRAINT "telegram_sessions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;


--
-- Name: timetables timetables_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."timetables"
    ADD CONSTRAINT "timetables_class_id_fkey" FOREIGN KEY ("class_id") REFERENCES "public"."classes"("id") ON DELETE CASCADE;


--
-- Name: user_notifications user_notifications_message_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."user_notifications"
    ADD CONSTRAINT "user_notifications_message_id_fkey" FOREIGN KEY ("message_id") REFERENCES "public"."notification_messages"("id") ON DELETE CASCADE;


--
-- Name: user_notifications user_notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."user_notifications"
    ADD CONSTRAINT "user_notifications_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE "auth"."audit_log_entries" ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE "auth"."flow_state" ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE "auth"."identities" ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE "auth"."instances" ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE "auth"."mfa_amr_claims" ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE "auth"."mfa_challenges" ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE "auth"."mfa_factors" ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE "auth"."one_time_tokens" ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE "auth"."refresh_tokens" ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE "auth"."saml_providers" ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE "auth"."saml_relay_states" ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE "auth"."schema_migrations" ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE "auth"."sessions" ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE "auth"."sso_domains" ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE "auth"."sso_providers" ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE "auth"."users" ENABLE ROW LEVEL SECURITY;

--
-- Name: parent_student_links Admins/System can insert parent_student_links; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins/System can insert parent_student_links" ON "public"."parent_student_links" FOR INSERT WITH CHECK (true);


--
-- Name: resume_examples Anyone authenticated can view resume examples; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Anyone authenticated can view resume examples" ON "public"."resume_examples" FOR SELECT USING (("auth"."role"() = 'authenticated'::"text"));


--
-- Name: resume_examples Authenticated users can insert examples; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Authenticated users can insert examples" ON "public"."resume_examples" FOR INSERT WITH CHECK (("auth"."role"() = 'authenticated'::"text"));


--
-- Name: ai_chat_history Enable all for service role on ai_chat_history; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable all for service role on ai_chat_history" ON "public"."ai_chat_history" USING (true) WITH CHECK (true);


--
-- Name: parent_access_codes Enable insert for service role; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable insert for service role" ON "public"."parent_access_codes" FOR INSERT WITH CHECK (true);


--
-- Name: telegram_sessions Enable insert for service role; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable insert for service role" ON "public"."telegram_sessions" FOR INSERT WITH CHECK (true);


--
-- Name: parent_access_codes Enable read access for all (for validation); Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all (for validation)" ON "public"."parent_access_codes" FOR SELECT USING (true);


--
-- Name: academic_deadlines Enable read access for all authenticated users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all authenticated users" ON "public"."academic_deadlines" FOR SELECT TO "authenticated" USING (true);


--
-- Name: telegram_sessions Enable read access for service role; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for service role" ON "public"."telegram_sessions" FOR SELECT USING (true);


--
-- Name: parent_access_codes Enable update for service role; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable update for service role" ON "public"."parent_access_codes" FOR UPDATE USING (true);


--
-- Name: telegram_sessions Enable update for service role; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable update for service role" ON "public"."telegram_sessions" FOR UPDATE USING (true);


--
-- Name: interventions Mentors can create their own interventions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Mentors can create their own interventions" ON "public"."interventions" FOR INSERT WITH CHECK (("auth"."uid"() = "mentor_id"));


--
-- Name: interventions Mentors can delete their own interventions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Mentors can delete their own interventions" ON "public"."interventions" FOR DELETE USING (("auth"."uid"() = "mentor_id"));


--
-- Name: attendance Mentors can insert attendance for their students; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Mentors can insert attendance for their students" ON "public"."attendance" FOR INSERT TO "authenticated" WITH CHECK (("auth"."uid"() = "mentor_id"));


--
-- Name: grades Mentors can insert grades for their students; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Mentors can insert grades for their students" ON "public"."grades" FOR INSERT TO "authenticated" WITH CHECK (("auth"."uid"() = "mentor_id"));


--
-- Name: parent_access_codes Mentors can manage their created codes; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Mentors can manage their created codes" ON "public"."parent_access_codes" USING (("auth"."uid"() = "mentor_id"));


--
-- Name: attendance Mentors can update attendance for their students; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Mentors can update attendance for their students" ON "public"."attendance" FOR UPDATE TO "authenticated" USING (("auth"."uid"() = "mentor_id")) WITH CHECK (("auth"."uid"() = "mentor_id"));


--
-- Name: grades Mentors can update grades for their students; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Mentors can update grades for their students" ON "public"."grades" FOR UPDATE TO "authenticated" USING (("auth"."uid"() = "mentor_id")) WITH CHECK (("auth"."uid"() = "mentor_id"));


--
-- Name: interventions Mentors can update their own interventions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Mentors can update their own interventions" ON "public"."interventions" FOR UPDATE USING (("auth"."uid"() = "mentor_id"));


--
-- Name: semester_results Mentors can view all semester results; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Mentors can view all semester results" ON "public"."semester_results" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."profiles"
  WHERE (("profiles"."id" = "auth"."uid"()) AND ("profiles"."role" = ANY (ARRAY['mentor'::"public"."user_role", 'admin'::"public"."user_role"]))))));


--
-- Name: fee_payments Mentors can view mentee fee payments; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Mentors can view mentee fee payments" ON "public"."fee_payments" FOR SELECT TO "authenticated" USING ((("auth"."uid"() = "student_id") OR "public"."is_mentor_of_student"("student_id")));


--
-- Name: erp_attendance_summary Mentors can view student erp attendance; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Mentors can view student erp attendance" ON "public"."erp_attendance_summary" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."profiles"
  WHERE (("profiles"."id" = "erp_attendance_summary"."student_id") AND ("profiles"."mentor_id" = "auth"."uid"())))));


--
-- Name: interventions Mentors can view their own interventions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Mentors can view their own interventions" ON "public"."interventions" FOR SELECT USING (("auth"."uid"() = "mentor_id"));


--
-- Name: attendance Mentors can view their students attendance; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Mentors can view their students attendance" ON "public"."attendance" FOR SELECT TO "authenticated" USING (("auth"."uid"() = "mentor_id"));


--
-- Name: grades Mentors can view their students grades; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Mentors can view their students grades" ON "public"."grades" FOR SELECT TO "authenticated" USING (("auth"."uid"() = "mentor_id"));


--
-- Name: erp_attendance_summary Service role can manage erp attendance; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Service role can manage erp attendance" ON "public"."erp_attendance_summary" USING (true) WITH CHECK (true);


--
-- Name: job_applications Students can delete own applications; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Students can delete own applications" ON "public"."job_applications" FOR DELETE USING (("auth"."uid"() = "student_id"));


--
-- Name: cover_letters Students can delete own cover letters; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Students can delete own cover letters" ON "public"."cover_letters" FOR DELETE USING (("auth"."uid"() = "student_id"));


--
-- Name: resumes Students can delete own resumes; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Students can delete own resumes" ON "public"."resumes" FOR DELETE USING (("auth"."uid"() = "student_id"));


--
-- Name: job_applications Students can insert own applications; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Students can insert own applications" ON "public"."job_applications" FOR INSERT WITH CHECK (("auth"."uid"() = "student_id"));


--
-- Name: cover_letters Students can insert own cover letters; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Students can insert own cover letters" ON "public"."cover_letters" FOR INSERT WITH CHECK (("auth"."uid"() = "student_id"));


--
-- Name: erp_credentials Students can insert own credentials; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Students can insert own credentials" ON "public"."erp_credentials" FOR INSERT WITH CHECK (("auth"."uid"() = "student_id"));


--
-- Name: fee_payments Students can insert own payments; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Students can insert own payments" ON "public"."fee_payments" FOR INSERT TO "authenticated" WITH CHECK (("auth"."uid"() = "student_id"));


--
-- Name: resumes Students can insert own resumes; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Students can insert own resumes" ON "public"."resumes" FOR INSERT WITH CHECK (("auth"."uid"() = "student_id"));


--
-- Name: job_applications Students can update own applications; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Students can update own applications" ON "public"."job_applications" FOR UPDATE USING (("auth"."uid"() = "student_id"));


--
-- Name: cover_letters Students can update own cover letters; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Students can update own cover letters" ON "public"."cover_letters" FOR UPDATE USING (("auth"."uid"() = "student_id"));


--
-- Name: erp_credentials Students can update own credentials; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Students can update own credentials" ON "public"."erp_credentials" FOR UPDATE USING (("auth"."uid"() = "student_id"));


--
-- Name: fee_payments Students can update own payments; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Students can update own payments" ON "public"."fee_payments" FOR UPDATE TO "authenticated" USING (("auth"."uid"() = "student_id"));


--
-- Name: resumes Students can update own resumes; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Students can update own resumes" ON "public"."resumes" FOR UPDATE USING (("auth"."uid"() = "student_id"));


--
-- Name: job_applications Students can view own applications; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Students can view own applications" ON "public"."job_applications" FOR SELECT USING (("auth"."uid"() = "student_id"));


--
-- Name: cover_letters Students can view own cover letters; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Students can view own cover letters" ON "public"."cover_letters" FOR SELECT USING (("auth"."uid"() = "student_id"));


--
-- Name: erp_credentials Students can view own credentials; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Students can view own credentials" ON "public"."erp_credentials" FOR SELECT USING (("auth"."uid"() = "student_id"));


--
-- Name: erp_attendance_summary Students can view own erp attendance; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Students can view own erp attendance" ON "public"."erp_attendance_summary" FOR SELECT USING (("auth"."uid"() = "student_id"));


--
-- Name: resumes Students can view own resumes; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Students can view own resumes" ON "public"."resumes" FOR SELECT USING (("auth"."uid"() = "student_id"));


--
-- Name: semester_results Students can view their own semester results; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Students can view their own semester results" ON "public"."semester_results" FOR SELECT USING (("student_id" = "auth"."uid"()));


--
-- Name: achievements Users can delete their own achievements; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can delete their own achievements" ON "public"."achievements" FOR DELETE USING (("auth"."uid"() = "student_id"));


--
-- Name: direct_messages Users can insert their messages; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can insert their messages" ON "public"."direct_messages" FOR INSERT WITH CHECK (("auth"."uid"() = "sender_id"));


--
-- Name: achievements Users can insert their own achievements; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can insert their own achievements" ON "public"."achievements" FOR INSERT WITH CHECK (("auth"."uid"() = "student_id"));


--
-- Name: career_metrics Users can read career metrics; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can read career metrics" ON "public"."career_metrics" FOR SELECT TO "authenticated" USING ((("auth"."uid"() = "student_id") OR ("auth"."uid"() IN ( SELECT "profiles"."mentor_id"
   FROM "public"."profiles"
  WHERE ("profiles"."id" = "career_metrics"."student_id"))) OR ("auth"."uid"() IN ( SELECT "parent_student_links"."parent_id"
   FROM "public"."parent_student_links"
  WHERE ("parent_student_links"."student_id" = "career_metrics"."student_id")))));


--
-- Name: direct_messages Users can read their messages; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can read their messages" ON "public"."direct_messages" FOR SELECT USING ((("auth"."uid"() = "sender_id") OR ("auth"."uid"() = "receiver_id")));


--
-- Name: parent_student_links Users can read their own parent_student_links; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can read their own parent_student_links" ON "public"."parent_student_links" FOR SELECT USING ((("auth"."uid"() = "parent_id") OR ("auth"."uid"() = "student_id") OR ("auth"."uid"() IN ( SELECT "profiles"."mentor_id"
   FROM "public"."profiles"
  WHERE ("profiles"."id" = "parent_student_links"."student_id")))));


--
-- Name: achievements Users can update their own achievements; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update their own achievements" ON "public"."achievements" FOR UPDATE USING (("auth"."uid"() = "student_id")) WITH CHECK (("auth"."uid"() = "student_id"));


--
-- Name: direct_messages Users can update their received messages (e.g. read_at); Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update their received messages (e.g. read_at)" ON "public"."direct_messages" FOR UPDATE USING (("auth"."uid"() = "receiver_id"));


--
-- Name: achievements Users can view their own achievements; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view their own achievements" ON "public"."achievements" FOR SELECT USING (("auth"."uid"() = "student_id"));


--
-- Name: academic_deadlines; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."academic_deadlines" ENABLE ROW LEVEL SECURITY;

--
-- Name: achievements; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."achievements" ENABLE ROW LEVEL SECURITY;

--
-- Name: ai_chat_history; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."ai_chat_history" ENABLE ROW LEVEL SECURITY;

--
-- Name: attendance; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."attendance" ENABLE ROW LEVEL SECURITY;

--
-- Name: notification_messages authenticated_select_notification_messages; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "authenticated_select_notification_messages" ON "public"."notification_messages" FOR SELECT TO "authenticated" USING (true);


--
-- Name: subjects authenticated_select_subjects; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "authenticated_select_subjects" ON "public"."subjects" FOR SELECT TO "authenticated" USING (true);


--
-- Name: timetables authenticated_select_timetables; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "authenticated_select_timetables" ON "public"."timetables" FOR SELECT USING ((("public"."user_role"() = ANY (ARRAY['mentor'::"text", 'admin'::"text"])) OR (("public"."user_role"() = 'student'::"text") AND ("class_id" IN ( SELECT "public"."get_student_class_ids"("auth"."uid"()) AS "get_student_class_ids")))));


--
-- Name: career_metrics; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."career_metrics" ENABLE ROW LEVEL SECURITY;

--
-- Name: classes; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."classes" ENABLE ROW LEVEL SECURITY;

--
-- Name: cover_letters; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."cover_letters" ENABLE ROW LEVEL SECURITY;

--
-- Name: direct_messages; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."direct_messages" ENABLE ROW LEVEL SECURITY;

--
-- Name: enrollments; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."enrollments" ENABLE ROW LEVEL SECURITY;

--
-- Name: erp_attendance_summary; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."erp_attendance_summary" ENABLE ROW LEVEL SECURITY;

--
-- Name: erp_credentials; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."erp_credentials" ENABLE ROW LEVEL SECURITY;

--
-- Name: fee_payments; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."fee_payments" ENABLE ROW LEVEL SECURITY;

--
-- Name: grades; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."grades" ENABLE ROW LEVEL SECURITY;

--
-- Name: iat_marks; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."iat_marks" ENABLE ROW LEVEL SECURITY;

--
-- Name: interventions; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."interventions" ENABLE ROW LEVEL SECURITY;

--
-- Name: job_applications; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."job_applications" ENABLE ROW LEVEL SECURITY;

--
-- Name: enrollments mentors_delete_enrollments; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "mentors_delete_enrollments" ON "public"."enrollments" FOR DELETE USING ((("public"."user_role"() = 'mentor'::"text") AND ("class_id" IN ( SELECT "public"."get_mentor_class_ids"("auth"."uid"()) AS "get_mentor_class_ids"))));


--
-- Name: subjects mentors_delete_subjects; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "mentors_delete_subjects" ON "public"."subjects" FOR DELETE USING (("public"."user_role"() = 'mentor'::"text"));


--
-- Name: timetables mentors_delete_timetables; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "mentors_delete_timetables" ON "public"."timetables" FOR DELETE USING (("public"."user_role"() = 'mentor'::"text"));


--
-- Name: attendance mentors_insert_attendance_for_assigned_students; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "mentors_insert_attendance_for_assigned_students" ON "public"."attendance" FOR INSERT WITH CHECK ((("public"."user_role"() = 'mentor'::"text") AND ("student_id" IN ( SELECT "public"."get_mentor_student_ids"("auth"."uid"()) AS "get_mentor_student_ids"))));


--
-- Name: enrollments mentors_insert_enrollments; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "mentors_insert_enrollments" ON "public"."enrollments" FOR INSERT WITH CHECK ((("public"."user_role"() = 'mentor'::"text") AND ("class_id" IN ( SELECT "public"."get_mentor_class_ids"("auth"."uid"()) AS "get_mentor_class_ids"))));


--
-- Name: grades mentors_insert_grades_for_assigned_students; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "mentors_insert_grades_for_assigned_students" ON "public"."grades" FOR INSERT WITH CHECK ((("public"."user_role"() = 'mentor'::"text") AND ("student_id" IN ( SELECT "public"."get_mentor_student_ids"("auth"."uid"()) AS "get_mentor_student_ids"))));


--
-- Name: iat_marks mentors_insert_iat_marks; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "mentors_insert_iat_marks" ON "public"."iat_marks" FOR INSERT WITH CHECK ((("public"."user_role"() = 'mentor'::"text") AND ("student_id" IN ( SELECT "profiles"."id"
   FROM "public"."profiles"
  WHERE ("profiles"."mentor_id" = "auth"."uid"())))));


--
-- Name: classes mentors_insert_own_classes; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "mentors_insert_own_classes" ON "public"."classes" FOR INSERT WITH CHECK ((("public"."user_role"() = 'mentor'::"text") AND ("mentor_id" = "auth"."uid"())));


--
-- Name: reports mentors_insert_reports; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "mentors_insert_reports" ON "public"."reports" FOR INSERT TO "authenticated" WITH CHECK ((("auth"."uid"() = "mentor_id") AND ("public"."user_role"() = 'mentor'::"text")));


--
-- Name: subjects mentors_insert_subjects; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "mentors_insert_subjects" ON "public"."subjects" FOR INSERT WITH CHECK (("public"."user_role"() = 'mentor'::"text"));


--
-- Name: timetables mentors_insert_timetables; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "mentors_insert_timetables" ON "public"."timetables" FOR INSERT WITH CHECK (("public"."user_role"() = 'mentor'::"text"));


--
-- Name: iat_marks mentors_select_assigned_iat_marks; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "mentors_select_assigned_iat_marks" ON "public"."iat_marks" FOR SELECT USING ((("public"."user_role"() = 'mentor'::"text") AND ("student_id" IN ( SELECT "profiles"."id"
   FROM "public"."profiles"
  WHERE ("profiles"."mentor_id" = "auth"."uid"())))));


--
-- Name: profiles mentors_select_assigned_parents; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "mentors_select_assigned_parents" ON "public"."profiles" FOR SELECT USING ((("public"."user_role"() = 'mentor'::"text") AND ("id" IN ( SELECT "public"."get_mentor_parent_ids"("auth"."uid"()) AS "get_mentor_parent_ids"))));


--
-- Name: profiles mentors_select_assigned_students; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "mentors_select_assigned_students" ON "public"."profiles" FOR SELECT USING ((("public"."user_role"() = 'mentor'::"text") AND ("auth"."uid"() = "mentor_id")));


--
-- Name: attendance mentors_select_assigned_students_attendance; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "mentors_select_assigned_students_attendance" ON "public"."attendance" FOR SELECT USING ((("public"."user_role"() = 'mentor'::"text") AND ("student_id" IN ( SELECT "public"."get_mentor_student_ids"("auth"."uid"()) AS "get_mentor_student_ids"))));


--
-- Name: grades mentors_select_assigned_students_grades; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "mentors_select_assigned_students_grades" ON "public"."grades" FOR SELECT USING ((("public"."user_role"() = 'mentor'::"text") AND ("student_id" IN ( SELECT "public"."get_mentor_student_ids"("auth"."uid"()) AS "get_mentor_student_ids"))));


--
-- Name: enrollments mentors_select_class_enrollments; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "mentors_select_class_enrollments" ON "public"."enrollments" FOR SELECT USING ((("public"."user_role"() = 'mentor'::"text") AND ("class_id" IN ( SELECT "public"."get_mentor_class_ids"("auth"."uid"()) AS "get_mentor_class_ids"))));


--
-- Name: classes mentors_select_own_classes; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "mentors_select_own_classes" ON "public"."classes" FOR SELECT USING ((("public"."user_role"() = 'mentor'::"text") AND ("mentor_id" = "auth"."uid"())));


--
-- Name: reports mentors_select_reports; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "mentors_select_reports" ON "public"."reports" FOR SELECT TO "authenticated" USING (("auth"."uid"() = "mentor_id"));


--
-- Name: attendance mentors_update_attendance_for_assigned_students; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "mentors_update_attendance_for_assigned_students" ON "public"."attendance" FOR UPDATE USING ((("public"."user_role"() = 'mentor'::"text") AND ("student_id" IN ( SELECT "public"."get_mentor_student_ids"("auth"."uid"()) AS "get_mentor_student_ids")))) WITH CHECK ((("public"."user_role"() = 'mentor'::"text") AND ("student_id" IN ( SELECT "public"."get_mentor_student_ids"("auth"."uid"()) AS "get_mentor_student_ids"))));


--
-- Name: grades mentors_update_grades_for_assigned_students; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "mentors_update_grades_for_assigned_students" ON "public"."grades" FOR UPDATE USING ((("public"."user_role"() = 'mentor'::"text") AND ("student_id" IN ( SELECT "public"."get_mentor_student_ids"("auth"."uid"()) AS "get_mentor_student_ids")))) WITH CHECK ((("public"."user_role"() = 'mentor'::"text") AND ("student_id" IN ( SELECT "public"."get_mentor_student_ids"("auth"."uid"()) AS "get_mentor_student_ids"))));


--
-- Name: iat_marks mentors_update_iat_marks; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "mentors_update_iat_marks" ON "public"."iat_marks" FOR UPDATE USING ((("public"."user_role"() = 'mentor'::"text") AND ("student_id" IN ( SELECT "profiles"."id"
   FROM "public"."profiles"
  WHERE ("profiles"."mentor_id" = "auth"."uid"()))))) WITH CHECK ((("public"."user_role"() = 'mentor'::"text") AND ("student_id" IN ( SELECT "profiles"."id"
   FROM "public"."profiles"
  WHERE ("profiles"."mentor_id" = "auth"."uid"())))));


--
-- Name: classes mentors_update_own_classes; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "mentors_update_own_classes" ON "public"."classes" FOR UPDATE USING ((("public"."user_role"() = 'mentor'::"text") AND ("mentor_id" = "auth"."uid"()))) WITH CHECK ((("public"."user_role"() = 'mentor'::"text") AND ("mentor_id" = "auth"."uid"())));


--
-- Name: subjects mentors_update_subjects; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "mentors_update_subjects" ON "public"."subjects" FOR UPDATE USING (("public"."user_role"() = 'mentor'::"text"));


--
-- Name: timetables mentors_update_timetables; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "mentors_update_timetables" ON "public"."timetables" FOR UPDATE USING (("public"."user_role"() = 'mentor'::"text")) WITH CHECK (("public"."user_role"() = 'mentor'::"text"));


--
-- Name: notification_messages; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."notification_messages" ENABLE ROW LEVEL SECURITY;

--
-- Name: parent_access_codes; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."parent_access_codes" ENABLE ROW LEVEL SECURITY;

--
-- Name: parent_student_links; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."parent_student_links" ENABLE ROW LEVEL SECURITY;

--
-- Name: profiles parents_select_linked_students; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "parents_select_linked_students" ON "public"."profiles" FOR SELECT USING ((("public"."user_role"() = 'parent'::"text") AND ("id" IN ( SELECT "public"."get_parent_student_ids"("auth"."uid"()) AS "get_parent_student_ids"))));


--
-- Name: attendance parents_select_linked_students_attendance; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "parents_select_linked_students_attendance" ON "public"."attendance" FOR SELECT USING ((("public"."user_role"() = 'parent'::"text") AND ("student_id" IN ( SELECT "public"."get_parent_student_ids"("auth"."uid"()) AS "get_parent_student_ids"))));


--
-- Name: classes parents_select_linked_students_classes; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "parents_select_linked_students_classes" ON "public"."classes" FOR SELECT USING ((("public"."user_role"() = 'parent'::"text") AND ("id" IN ( SELECT "enrollments"."class_id"
   FROM "public"."enrollments"
  WHERE ("enrollments"."student_id" IN ( SELECT "public"."get_parent_student_ids"("auth"."uid"()) AS "get_parent_student_ids"))))));


--
-- Name: enrollments parents_select_linked_students_enrollments; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "parents_select_linked_students_enrollments" ON "public"."enrollments" FOR SELECT USING ((("public"."user_role"() = 'parent'::"text") AND ("student_id" IN ( SELECT "public"."get_parent_student_ids"("auth"."uid"()) AS "get_parent_student_ids"))));


--
-- Name: grades parents_select_linked_students_grades; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "parents_select_linked_students_grades" ON "public"."grades" FOR SELECT USING ((("public"."user_role"() = 'parent'::"text") AND ("student_id" IN ( SELECT "public"."get_parent_student_ids"("auth"."uid"()) AS "get_parent_student_ids"))));


--
-- Name: profiles; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."profiles" ENABLE ROW LEVEL SECURITY;

--
-- Name: reports; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."reports" ENABLE ROW LEVEL SECURITY;

--
-- Name: resume_examples; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."resume_examples" ENABLE ROW LEVEL SECURITY;

--
-- Name: resumes; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."resumes" ENABLE ROW LEVEL SECURITY;

--
-- Name: semester_results; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."semester_results" ENABLE ROW LEVEL SECURITY;

--
-- Name: profiles students_select_assigned_mentor; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "students_select_assigned_mentor" ON "public"."profiles" FOR SELECT USING ((("public"."user_role"() = 'student'::"text") AND ("id" = "public"."get_my_mentor_id"("auth"."uid"()))));


--
-- Name: profiles students_select_class_mentors; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "students_select_class_mentors" ON "public"."profiles" FOR SELECT USING ((("public"."user_role"() = 'student'::"text") AND ("id" IN ( SELECT "public"."get_class_mentor_ids"("auth"."uid"()) AS "get_class_mentor_ids"))));


--
-- Name: classes students_select_enrolled_classes; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "students_select_enrolled_classes" ON "public"."classes" FOR SELECT USING ((("public"."user_role"() = 'student'::"text") AND ("id" IN ( SELECT "public"."get_student_class_ids"("auth"."uid"()) AS "get_student_class_ids"))));


--
-- Name: attendance students_select_own_attendance; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "students_select_own_attendance" ON "public"."attendance" FOR SELECT USING (("student_id" = "auth"."uid"()));


--
-- Name: enrollments students_select_own_enrollments; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "students_select_own_enrollments" ON "public"."enrollments" FOR SELECT USING (("student_id" = "auth"."uid"()));


--
-- Name: grades students_select_own_grades; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "students_select_own_grades" ON "public"."grades" FOR SELECT USING (("student_id" = "auth"."uid"()));


--
-- Name: iat_marks students_select_own_iat_marks; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "students_select_own_iat_marks" ON "public"."iat_marks" FOR SELECT USING (("student_id" = "auth"."uid"()));


--
-- Name: reports students_select_reports; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "students_select_reports" ON "public"."reports" FOR SELECT TO "authenticated" USING (("auth"."uid"() = "student_id"));


--
-- Name: subjects; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."subjects" ENABLE ROW LEVEL SECURITY;

--
-- Name: telegram_sessions; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."telegram_sessions" ENABLE ROW LEVEL SECURITY;

--
-- Name: timetables; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."timetables" ENABLE ROW LEVEL SECURITY;

--
-- Name: user_notifications; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."user_notifications" ENABLE ROW LEVEL SECURITY;

--
-- Name: profiles users_insert_own_profile; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "users_insert_own_profile" ON "public"."profiles" FOR INSERT WITH CHECK (("auth"."uid"() = "id"));


--
-- Name: profiles users_select_own_profile; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "users_select_own_profile" ON "public"."profiles" FOR SELECT USING (("auth"."uid"() = "id"));


--
-- Name: user_notifications users_select_own_user_notifications; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "users_select_own_user_notifications" ON "public"."user_notifications" FOR SELECT USING (("user_id" = "auth"."uid"()));


--
-- Name: profiles users_update_own_profile; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "users_update_own_profile" ON "public"."profiles" FOR UPDATE USING (("auth"."uid"() = "id")) WITH CHECK (("auth"."uid"() = "id"));


--
-- Name: user_notifications users_update_own_user_notifications; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "users_update_own_user_notifications" ON "public"."user_notifications" FOR UPDATE USING (("user_id" = "auth"."uid"())) WITH CHECK (("user_id" = "auth"."uid"()));


--
-- Name: SCHEMA "auth"; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA "auth" TO "anon";
GRANT USAGE ON SCHEMA "auth" TO "authenticated";
GRANT USAGE ON SCHEMA "auth" TO "service_role";
GRANT ALL ON SCHEMA "auth" TO "supabase_auth_admin";
GRANT ALL ON SCHEMA "auth" TO "dashboard_user";
GRANT USAGE ON SCHEMA "auth" TO "postgres";


--
-- Name: SCHEMA "public"; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";


--
-- Name: FUNCTION "email"(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION "auth"."email"() TO "dashboard_user";


--
-- Name: FUNCTION "jwt"(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION "auth"."jwt"() TO "postgres";
GRANT ALL ON FUNCTION "auth"."jwt"() TO "dashboard_user";


--
-- Name: FUNCTION "role"(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION "auth"."role"() TO "dashboard_user";


--
-- Name: FUNCTION "uid"(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION "auth"."uid"() TO "dashboard_user";


--
-- Name: FUNCTION "create_profile"("p_user_id" "uuid", "p_full_name" "text", "p_branch" "text", "p_semester" integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION "public"."create_profile"("p_user_id" "uuid", "p_full_name" "text", "p_branch" "text", "p_semester" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."create_profile"("p_user_id" "uuid", "p_full_name" "text", "p_branch" "text", "p_semester" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."create_profile"("p_user_id" "uuid", "p_full_name" "text", "p_branch" "text", "p_semester" integer) TO "service_role";


--
-- Name: FUNCTION "create_profile"("p_user_id" "uuid", "p_full_name" "text", "p_role" "public"."user_role", "p_branch" "text", "p_semester" smallint); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION "public"."create_profile"("p_user_id" "uuid", "p_full_name" "text", "p_role" "public"."user_role", "p_branch" "text", "p_semester" smallint) TO "anon";
GRANT ALL ON FUNCTION "public"."create_profile"("p_user_id" "uuid", "p_full_name" "text", "p_role" "public"."user_role", "p_branch" "text", "p_semester" smallint) TO "authenticated";
GRANT ALL ON FUNCTION "public"."create_profile"("p_user_id" "uuid", "p_full_name" "text", "p_role" "public"."user_role", "p_branch" "text", "p_semester" smallint) TO "service_role";


--
-- Name: FUNCTION "generate_parent_code"("p_student_id" "uuid", "p_mentor_id" "uuid"); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION "public"."generate_parent_code"("p_student_id" "uuid", "p_mentor_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."generate_parent_code"("p_student_id" "uuid", "p_mentor_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."generate_parent_code"("p_student_id" "uuid", "p_mentor_id" "uuid") TO "service_role";


--
-- Name: FUNCTION "get_attendance_summary"("p_student_id" "uuid"); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION "public"."get_attendance_summary"("p_student_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_attendance_summary"("p_student_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_attendance_summary"("p_student_id" "uuid") TO "service_role";


--
-- Name: FUNCTION "get_class_mentor_ids"("p_student_id" "uuid"); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION "public"."get_class_mentor_ids"("p_student_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_class_mentor_ids"("p_student_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_class_mentor_ids"("p_student_id" "uuid") TO "service_role";


--
-- Name: FUNCTION "get_cohort_iat_averages"("p_mentor_id" "uuid"); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION "public"."get_cohort_iat_averages"("p_mentor_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_cohort_iat_averages"("p_mentor_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_cohort_iat_averages"("p_mentor_id" "uuid") TO "service_role";


--
-- Name: FUNCTION "get_cohort_trends"("p_mentor_id" "uuid"); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION "public"."get_cohort_trends"("p_mentor_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_cohort_trends"("p_mentor_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_cohort_trends"("p_mentor_id" "uuid") TO "service_role";


--
-- Name: FUNCTION "get_decrypted_erp_credentials"("p_student_ids" "uuid"[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION "public"."get_decrypted_erp_credentials"("p_student_ids" "uuid"[]) TO "anon";
GRANT ALL ON FUNCTION "public"."get_decrypted_erp_credentials"("p_student_ids" "uuid"[]) TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_decrypted_erp_credentials"("p_student_ids" "uuid"[]) TO "service_role";


--
-- Name: FUNCTION "get_historical_cgpa"("p_student_id" "uuid"); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION "public"."get_historical_cgpa"("p_student_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_historical_cgpa"("p_student_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_historical_cgpa"("p_student_id" "uuid") TO "service_role";


--
-- Name: FUNCTION "get_mentor_class_ids"("p_mentor_id" "uuid"); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION "public"."get_mentor_class_ids"("p_mentor_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_mentor_class_ids"("p_mentor_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_mentor_class_ids"("p_mentor_id" "uuid") TO "service_role";


--
-- Name: FUNCTION "get_mentor_cohort_summary"("p_mentor_id" "uuid"); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION "public"."get_mentor_cohort_summary"("p_mentor_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_mentor_cohort_summary"("p_mentor_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_mentor_cohort_summary"("p_mentor_id" "uuid") TO "service_role";


--
-- Name: FUNCTION "get_mentor_fee_payments"(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION "public"."get_mentor_fee_payments"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_mentor_fee_payments"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_mentor_fee_payments"() TO "service_role";


--
-- Name: FUNCTION "get_mentor_parent_ids"("p_mentor_id" "uuid"); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION "public"."get_mentor_parent_ids"("p_mentor_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_mentor_parent_ids"("p_mentor_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_mentor_parent_ids"("p_mentor_id" "uuid") TO "service_role";


--
-- Name: FUNCTION "get_mentor_student_ids"("p_mentor_id" "uuid"); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION "public"."get_mentor_student_ids"("p_mentor_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_mentor_student_ids"("p_mentor_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_mentor_student_ids"("p_mentor_id" "uuid") TO "service_role";


--
-- Name: FUNCTION "get_my_mentor_id"("p_user_id" "uuid"); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION "public"."get_my_mentor_id"("p_user_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_my_mentor_id"("p_user_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_my_mentor_id"("p_user_id" "uuid") TO "service_role";


--
-- Name: FUNCTION "get_parent_student_ids"("p_parent_id" "uuid"); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION "public"."get_parent_student_ids"("p_parent_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_parent_student_ids"("p_parent_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_parent_student_ids"("p_parent_id" "uuid") TO "service_role";


--
-- Name: FUNCTION "get_student_class_ids"("p_student_id" "uuid"); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION "public"."get_student_class_ids"("p_student_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_student_class_ids"("p_student_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_student_class_ids"("p_student_id" "uuid") TO "service_role";


--
-- Name: FUNCTION "handle_new_user"(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "service_role";


--
-- Name: FUNCTION "is_mentor_of_student"("p_student_id" "uuid"); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION "public"."is_mentor_of_student"("p_student_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."is_mentor_of_student"("p_student_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_mentor_of_student"("p_student_id" "uuid") TO "service_role";


--
-- Name: FUNCTION "mark_notifications_read"("p_user_id" "uuid"); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION "public"."mark_notifications_read"("p_user_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."mark_notifications_read"("p_user_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."mark_notifications_read"("p_user_id" "uuid") TO "service_role";


--
-- Name: FUNCTION "notify_attendance_risk"(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION "public"."notify_attendance_risk"() TO "anon";
GRANT ALL ON FUNCTION "public"."notify_attendance_risk"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."notify_attendance_risk"() TO "service_role";


--
-- Name: FUNCTION "notify_grade_risk"(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION "public"."notify_grade_risk"() TO "anon";
GRANT ALL ON FUNCTION "public"."notify_grade_risk"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."notify_grade_risk"() TO "service_role";


--
-- Name: FUNCTION "seed_demo_data"("p_student_id" "uuid"); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION "public"."seed_demo_data"("p_student_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."seed_demo_data"("p_student_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."seed_demo_data"("p_student_id" "uuid") TO "service_role";


--
-- Name: FUNCTION "send_mentor_notification"("p_student_id" "uuid", "p_title" "text", "p_body" "text", "p_type" "text"); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION "public"."send_mentor_notification"("p_student_id" "uuid", "p_title" "text", "p_body" "text", "p_type" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."send_mentor_notification"("p_student_id" "uuid", "p_title" "text", "p_body" "text", "p_type" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."send_mentor_notification"("p_student_id" "uuid", "p_title" "text", "p_body" "text", "p_type" "text") TO "service_role";


--
-- Name: FUNCTION "set_updated_at"(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION "public"."set_updated_at"() TO "anon";
GRANT ALL ON FUNCTION "public"."set_updated_at"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."set_updated_at"() TO "service_role";


--
-- Name: FUNCTION "update_modified_column"(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION "public"."update_modified_column"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_modified_column"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_modified_column"() TO "service_role";


--
-- Name: FUNCTION "user_role"(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION "public"."user_role"() TO "anon";
GRANT ALL ON FUNCTION "public"."user_role"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."user_role"() TO "service_role";


--
-- Name: TABLE "audit_log_entries"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE "auth"."audit_log_entries" TO "dashboard_user";
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE "auth"."audit_log_entries" TO "postgres";
GRANT SELECT ON TABLE "auth"."audit_log_entries" TO "postgres" WITH GRANT OPTION;


--
-- Name: TABLE "custom_oauth_providers"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE "auth"."custom_oauth_providers" TO "postgres";
GRANT ALL ON TABLE "auth"."custom_oauth_providers" TO "dashboard_user";


--
-- Name: TABLE "flow_state"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE "auth"."flow_state" TO "postgres";
GRANT SELECT ON TABLE "auth"."flow_state" TO "postgres" WITH GRANT OPTION;
GRANT ALL ON TABLE "auth"."flow_state" TO "dashboard_user";


--
-- Name: TABLE "identities"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE "auth"."identities" TO "postgres";
GRANT SELECT ON TABLE "auth"."identities" TO "postgres" WITH GRANT OPTION;
GRANT ALL ON TABLE "auth"."identities" TO "dashboard_user";


--
-- Name: TABLE "instances"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE "auth"."instances" TO "dashboard_user";
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE "auth"."instances" TO "postgres";
GRANT SELECT ON TABLE "auth"."instances" TO "postgres" WITH GRANT OPTION;


--
-- Name: TABLE "mfa_amr_claims"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE "auth"."mfa_amr_claims" TO "postgres";
GRANT SELECT ON TABLE "auth"."mfa_amr_claims" TO "postgres" WITH GRANT OPTION;
GRANT ALL ON TABLE "auth"."mfa_amr_claims" TO "dashboard_user";


--
-- Name: TABLE "mfa_challenges"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE "auth"."mfa_challenges" TO "postgres";
GRANT SELECT ON TABLE "auth"."mfa_challenges" TO "postgres" WITH GRANT OPTION;
GRANT ALL ON TABLE "auth"."mfa_challenges" TO "dashboard_user";


--
-- Name: TABLE "mfa_factors"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE "auth"."mfa_factors" TO "postgres";
GRANT SELECT ON TABLE "auth"."mfa_factors" TO "postgres" WITH GRANT OPTION;
GRANT ALL ON TABLE "auth"."mfa_factors" TO "dashboard_user";


--
-- Name: TABLE "oauth_authorizations"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE "auth"."oauth_authorizations" TO "postgres";
GRANT ALL ON TABLE "auth"."oauth_authorizations" TO "dashboard_user";


--
-- Name: TABLE "oauth_client_states"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE "auth"."oauth_client_states" TO "postgres";
GRANT ALL ON TABLE "auth"."oauth_client_states" TO "dashboard_user";


--
-- Name: TABLE "oauth_clients"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE "auth"."oauth_clients" TO "postgres";
GRANT ALL ON TABLE "auth"."oauth_clients" TO "dashboard_user";


--
-- Name: TABLE "oauth_consents"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE "auth"."oauth_consents" TO "postgres";
GRANT ALL ON TABLE "auth"."oauth_consents" TO "dashboard_user";


--
-- Name: TABLE "one_time_tokens"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE "auth"."one_time_tokens" TO "postgres";
GRANT SELECT ON TABLE "auth"."one_time_tokens" TO "postgres" WITH GRANT OPTION;
GRANT ALL ON TABLE "auth"."one_time_tokens" TO "dashboard_user";


--
-- Name: TABLE "refresh_tokens"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE "auth"."refresh_tokens" TO "dashboard_user";
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE "auth"."refresh_tokens" TO "postgres";
GRANT SELECT ON TABLE "auth"."refresh_tokens" TO "postgres" WITH GRANT OPTION;


--
-- Name: SEQUENCE "refresh_tokens_id_seq"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE "auth"."refresh_tokens_id_seq" TO "dashboard_user";
GRANT ALL ON SEQUENCE "auth"."refresh_tokens_id_seq" TO "postgres";


--
-- Name: TABLE "saml_providers"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE "auth"."saml_providers" TO "postgres";
GRANT SELECT ON TABLE "auth"."saml_providers" TO "postgres" WITH GRANT OPTION;
GRANT ALL ON TABLE "auth"."saml_providers" TO "dashboard_user";


--
-- Name: TABLE "saml_relay_states"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE "auth"."saml_relay_states" TO "postgres";
GRANT SELECT ON TABLE "auth"."saml_relay_states" TO "postgres" WITH GRANT OPTION;
GRANT ALL ON TABLE "auth"."saml_relay_states" TO "dashboard_user";


--
-- Name: TABLE "schema_migrations"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT ON TABLE "auth"."schema_migrations" TO "postgres" WITH GRANT OPTION;


--
-- Name: TABLE "sessions"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE "auth"."sessions" TO "postgres";
GRANT SELECT ON TABLE "auth"."sessions" TO "postgres" WITH GRANT OPTION;
GRANT ALL ON TABLE "auth"."sessions" TO "dashboard_user";


--
-- Name: TABLE "sso_domains"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE "auth"."sso_domains" TO "postgres";
GRANT SELECT ON TABLE "auth"."sso_domains" TO "postgres" WITH GRANT OPTION;
GRANT ALL ON TABLE "auth"."sso_domains" TO "dashboard_user";


--
-- Name: TABLE "sso_providers"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE "auth"."sso_providers" TO "postgres";
GRANT SELECT ON TABLE "auth"."sso_providers" TO "postgres" WITH GRANT OPTION;
GRANT ALL ON TABLE "auth"."sso_providers" TO "dashboard_user";


--
-- Name: TABLE "users"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE "auth"."users" TO "dashboard_user";
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE "auth"."users" TO "postgres";
GRANT SELECT ON TABLE "auth"."users" TO "postgres" WITH GRANT OPTION;


--
-- Name: TABLE "webauthn_challenges"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE "auth"."webauthn_challenges" TO "postgres";
GRANT ALL ON TABLE "auth"."webauthn_challenges" TO "dashboard_user";


--
-- Name: TABLE "webauthn_credentials"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE "auth"."webauthn_credentials" TO "postgres";
GRANT ALL ON TABLE "auth"."webauthn_credentials" TO "dashboard_user";


--
-- Name: TABLE "academic_deadlines"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."academic_deadlines" TO "anon";
GRANT ALL ON TABLE "public"."academic_deadlines" TO "authenticated";
GRANT ALL ON TABLE "public"."academic_deadlines" TO "service_role";


--
-- Name: TABLE "achievements"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."achievements" TO "anon";
GRANT ALL ON TABLE "public"."achievements" TO "authenticated";
GRANT ALL ON TABLE "public"."achievements" TO "service_role";


--
-- Name: TABLE "ai_chat_history"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."ai_chat_history" TO "anon";
GRANT ALL ON TABLE "public"."ai_chat_history" TO "authenticated";
GRANT ALL ON TABLE "public"."ai_chat_history" TO "service_role";


--
-- Name: TABLE "attendance"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."attendance" TO "anon";
GRANT ALL ON TABLE "public"."attendance" TO "authenticated";
GRANT ALL ON TABLE "public"."attendance" TO "service_role";


--
-- Name: TABLE "career_metrics"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."career_metrics" TO "anon";
GRANT ALL ON TABLE "public"."career_metrics" TO "authenticated";
GRANT ALL ON TABLE "public"."career_metrics" TO "service_role";


--
-- Name: TABLE "classes"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."classes" TO "anon";
GRANT ALL ON TABLE "public"."classes" TO "authenticated";
GRANT ALL ON TABLE "public"."classes" TO "service_role";


--
-- Name: TABLE "cover_letters"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."cover_letters" TO "anon";
GRANT ALL ON TABLE "public"."cover_letters" TO "authenticated";
GRANT ALL ON TABLE "public"."cover_letters" TO "service_role";


--
-- Name: TABLE "direct_messages"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."direct_messages" TO "anon";
GRANT ALL ON TABLE "public"."direct_messages" TO "authenticated";
GRANT ALL ON TABLE "public"."direct_messages" TO "service_role";


--
-- Name: TABLE "enrollments"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."enrollments" TO "anon";
GRANT ALL ON TABLE "public"."enrollments" TO "authenticated";
GRANT ALL ON TABLE "public"."enrollments" TO "service_role";


--
-- Name: TABLE "erp_attendance_summary"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."erp_attendance_summary" TO "anon";
GRANT ALL ON TABLE "public"."erp_attendance_summary" TO "authenticated";
GRANT ALL ON TABLE "public"."erp_attendance_summary" TO "service_role";


--
-- Name: TABLE "erp_credentials"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."erp_credentials" TO "anon";
GRANT ALL ON TABLE "public"."erp_credentials" TO "authenticated";
GRANT ALL ON TABLE "public"."erp_credentials" TO "service_role";


--
-- Name: TABLE "fee_payments"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."fee_payments" TO "anon";
GRANT ALL ON TABLE "public"."fee_payments" TO "authenticated";
GRANT ALL ON TABLE "public"."fee_payments" TO "service_role";


--
-- Name: TABLE "grades"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."grades" TO "anon";
GRANT ALL ON TABLE "public"."grades" TO "authenticated";
GRANT ALL ON TABLE "public"."grades" TO "service_role";


--
-- Name: TABLE "iat_marks"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."iat_marks" TO "anon";
GRANT ALL ON TABLE "public"."iat_marks" TO "authenticated";
GRANT ALL ON TABLE "public"."iat_marks" TO "service_role";


--
-- Name: TABLE "interventions"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."interventions" TO "anon";
GRANT ALL ON TABLE "public"."interventions" TO "authenticated";
GRANT ALL ON TABLE "public"."interventions" TO "service_role";


--
-- Name: TABLE "job_applications"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."job_applications" TO "anon";
GRANT ALL ON TABLE "public"."job_applications" TO "authenticated";
GRANT ALL ON TABLE "public"."job_applications" TO "service_role";


--
-- Name: TABLE "notification_messages"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."notification_messages" TO "anon";
GRANT ALL ON TABLE "public"."notification_messages" TO "authenticated";
GRANT ALL ON TABLE "public"."notification_messages" TO "service_role";


--
-- Name: TABLE "parent_access_codes"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."parent_access_codes" TO "anon";
GRANT ALL ON TABLE "public"."parent_access_codes" TO "authenticated";
GRANT ALL ON TABLE "public"."parent_access_codes" TO "service_role";


--
-- Name: TABLE "parent_student_links"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."parent_student_links" TO "anon";
GRANT ALL ON TABLE "public"."parent_student_links" TO "authenticated";
GRANT ALL ON TABLE "public"."parent_student_links" TO "service_role";


--
-- Name: TABLE "profiles"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."profiles" TO "anon";
GRANT ALL ON TABLE "public"."profiles" TO "authenticated";
GRANT ALL ON TABLE "public"."profiles" TO "service_role";


--
-- Name: TABLE "reports"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."reports" TO "anon";
GRANT ALL ON TABLE "public"."reports" TO "authenticated";
GRANT ALL ON TABLE "public"."reports" TO "service_role";


--
-- Name: TABLE "resume_examples"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."resume_examples" TO "anon";
GRANT ALL ON TABLE "public"."resume_examples" TO "authenticated";
GRANT ALL ON TABLE "public"."resume_examples" TO "service_role";


--
-- Name: TABLE "resumes"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."resumes" TO "anon";
GRANT ALL ON TABLE "public"."resumes" TO "authenticated";
GRANT ALL ON TABLE "public"."resumes" TO "service_role";


--
-- Name: TABLE "semester_results"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."semester_results" TO "anon";
GRANT ALL ON TABLE "public"."semester_results" TO "authenticated";
GRANT ALL ON TABLE "public"."semester_results" TO "service_role";


--
-- Name: TABLE "subjects"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."subjects" TO "anon";
GRANT ALL ON TABLE "public"."subjects" TO "authenticated";
GRANT ALL ON TABLE "public"."subjects" TO "service_role";


--
-- Name: TABLE "telegram_sessions"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."telegram_sessions" TO "anon";
GRANT ALL ON TABLE "public"."telegram_sessions" TO "authenticated";
GRANT ALL ON TABLE "public"."telegram_sessions" TO "service_role";


--
-- Name: TABLE "timetables"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."timetables" TO "anon";
GRANT ALL ON TABLE "public"."timetables" TO "authenticated";
GRANT ALL ON TABLE "public"."timetables" TO "service_role";


--
-- Name: TABLE "user_notifications"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."user_notifications" TO "anon";
GRANT ALL ON TABLE "public"."user_notifications" TO "authenticated";
GRANT ALL ON TABLE "public"."user_notifications" TO "service_role";


--
-- Name: TABLE "v_student_timetables"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."v_student_timetables" TO "anon";
GRANT ALL ON TABLE "public"."v_student_timetables" TO "authenticated";
GRANT ALL ON TABLE "public"."v_student_timetables" TO "service_role";


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_auth_admin" IN SCHEMA "auth" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_auth_admin" IN SCHEMA "auth" GRANT ALL ON SEQUENCES TO "dashboard_user";


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_auth_admin" IN SCHEMA "auth" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_auth_admin" IN SCHEMA "auth" GRANT ALL ON FUNCTIONS TO "dashboard_user";


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_auth_admin" IN SCHEMA "auth" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_auth_admin" IN SCHEMA "auth" GRANT ALL ON TABLES TO "dashboard_user";


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";


--
-- PostgreSQL database dump complete
--

\unrestrict fua2B22zYQ1CfhGrf8vTmXWCcMLFjFs5WKcnFAnT78DezUgchw91wjUXMqmbn11

