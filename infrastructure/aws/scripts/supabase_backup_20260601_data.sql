--
-- PostgreSQL database dump
--

\restrict 0Tj56uokqg4KiX9X3eP94hVztj6jd1yONasitrngTf6bsLfFOboo43arV70BcO8

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

--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
\.


--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.custom_oauth_providers (id, provider_type, identifier, name, client_id, client_secret, acceptable_client_ids, scopes, pkce_enabled, attribute_mapping, authorization_params, enabled, email_optional, issuer, discovery_url, skip_nonce_check, cached_discovery, discovery_cached_at, authorization_url, token_url, userinfo_url, jwks_uri, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at, invite_token, referrer, oauth_client_state_id, linking_target_id, email_optional) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
00000000-0000-0000-0000-000000000000	8c20d36c-6246-4026-9938-65eac0eb0ca3	authenticated	authenticated	lalithrajeshwari537@gmail.com	$2a$10$cxULIXfIZNufKBpip8LIgOmdgiD.K47i7j5I2HrmdntofDXzh3swO	2026-05-23 10:41:06.096114+00	\N		2026-05-23 10:40:38.098065+00		\N			\N	2026-05-23 10:41:42.177176+00	{"provider": "email", "providers": ["email"]}	{"sub": "8c20d36c-6246-4026-9938-65eac0eb0ca3", "role": "student", "email": "lalithrajeshwari537@gmail.com", "branch": "CSEAIML", "semester": 4, "full_name": "lalith kishore M", "email_verified": true, "phone_verified": false}	\N	2026-05-23 10:40:38.036293+00	2026-05-24 17:23:57.036732+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	bc8f862e-ec2c-4c37-b924-c34864013f1c	authenticated	authenticated	student6@edupredict.com	$2a$06$c4/J7Ecka7QfSJhKT57Cp.4533SLztsr/UX.cw2SQi5xXUg0jihvG	2026-05-12 15:11:10.943022+00	\N		\N		2026-05-12 15:11:10.943022+00			\N	2026-05-12 15:11:10.943022+00	{"provider": "email", "providers": ["email"]}	{"name": "Student 6", "role": "student"}	\N	2026-05-12 15:11:10.943022+00	2026-05-12 15:11:10.943022+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	14aad89b-3a0a-46c6-9297-56b4ce8f8280	authenticated	authenticated	thanmaydambekodi@gmail.com	$2a$10$Dk0kN0aBYVuq.1oBS5wfMOCR8s.gOnetPsgDvRZVA0EuJhO7QdbF6	2026-05-12 15:09:32.984281+00	\N		2026-05-12 15:08:44.170836+00		\N			\N	2026-05-14 11:14:06.067121+00	{"provider": "email", "providers": ["email"]}	{"sub": "14aad89b-3a0a-46c6-9297-56b4ce8f8280", "role": "mentor", "email": "thanmaydambekodi@gmail.com", "branch": "CSE(AIML)", "semester": 4, "full_name": "Neha", "email_verified": true, "phone_verified": false}	\N	2026-05-12 15:08:44.155679+00	2026-05-26 11:41:18.789158+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	380e4e1d-f169-474c-812b-d9a157b98930	authenticated	authenticated	student7@edupredict.com	$2a$06$I8qiWJ2aJtg.jJknaF6gbenQXu0CKJEa/eOdOf2FNCEZ9aHy5z0Je	2026-05-12 15:11:10.943022+00	\N		\N		2026-05-12 15:11:10.943022+00			\N	2026-05-12 15:11:10.943022+00	{"provider": "email", "providers": ["email"]}	{"name": "Student 7", "role": "student"}	\N	2026-05-12 15:11:10.943022+00	2026-05-12 15:11:10.943022+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	39259dfa-72e0-4568-b6ae-7beb2b01b10f	authenticated	authenticated	student8@edupredict.com	$2a$06$wUg6OQ7MUdKLuleXK9DTgu/qOzpkf3yA51PtQxZQ6vKN9ZBj0Rv6u	2026-05-12 15:11:10.943022+00	\N		\N		2026-05-12 15:11:10.943022+00			\N	2026-05-12 15:11:10.943022+00	{"provider": "email", "providers": ["email"]}	{"name": "Student 8", "role": "student"}	\N	2026-05-12 15:11:10.943022+00	2026-05-12 15:11:10.943022+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	c544629d-bb02-4c51-9c23-dc743e51a9b1	authenticated	authenticated	sejal.kumari@edupredict.com	$2a$06$TYC3JbESu7kP574ejnuvOe5IE10.aQj6Kcin/Wfl9Hveib.MvOAz6	2026-05-12 19:23:35.79817+00	\N		\N		\N			\N	2026-05-28 17:33:41.449724+00	{"provider": "email", "providers": ["email"]}	{"name": "sejal kumari", "role": "student"}	\N	2026-05-12 19:23:35.79817+00	2026-05-31 07:17:18.327909+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	299efed3-47cc-4a52-a203-96f8ed2f50c0	authenticated	authenticated	student1@edupredict.com	$2a$06$otBGdVjblQe/MCv2i4kVseDeR79yfJYwXomnNcwjg/V.uEJ3chzbi	2026-05-12 15:11:10.943022+00	\N		\N		2026-05-12 15:11:10.943022+00			\N	2026-05-12 15:11:10.943022+00	{"provider": "email", "providers": ["email"]}	{"name": "Student 1", "role": "student"}	\N	2026-05-12 15:11:10.943022+00	2026-05-12 15:11:10.943022+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	a0dee1a9-0426-4878-9726-cb5b880dd961	authenticated	authenticated	student2@edupredict.com	$2a$06$P70wU1zIIG4/LA8FrcLPNuky5fWFhDdw4mef9diVfY9oyOL4U4PN6	2026-05-12 15:11:10.943022+00	\N		\N		2026-05-12 15:11:10.943022+00			\N	2026-05-12 15:11:10.943022+00	{"provider": "email", "providers": ["email"]}	{"name": "Student 2", "role": "student"}	\N	2026-05-12 15:11:10.943022+00	2026-05-12 15:11:10.943022+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	31e328af-0472-4281-a2f9-8db26e83f2bb	authenticated	authenticated	student3@edupredict.com	$2a$06$ylcZod3EQPth8fF1ulPeTu8rcHatpscuwhyWkGWzYIBneHMazYJuS	2026-05-12 15:11:10.943022+00	\N		\N		2026-05-12 15:11:10.943022+00			\N	2026-05-12 15:11:10.943022+00	{"provider": "email", "providers": ["email"]}	{"name": "Student 3", "role": "student"}	\N	2026-05-12 15:11:10.943022+00	2026-05-12 15:11:10.943022+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	502755cd-0595-4ac7-8dba-eb20ac1f69a6	authenticated	authenticated	student4@edupredict.com	$2a$06$.EGjqLSK3N9D6XnsSdY6v.5OcZ04nUPaE83tzRbLHVSHJDoElTiPy	2026-05-12 15:11:10.943022+00	\N		\N		2026-05-12 15:11:10.943022+00			\N	2026-05-12 15:11:10.943022+00	{"provider": "email", "providers": ["email"]}	{"name": "Student 4", "role": "student"}	\N	2026-05-12 15:11:10.943022+00	2026-05-12 15:11:10.943022+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	f65d5767-5fed-4aa5-9a94-739006d87bb2	authenticated	authenticated	student5@edupredict.com	$2a$06$6XkaP3AQmPosf/KXPBpmH.I8uvv/estXTffIh53aGSB1UQ/eXg5ne	2026-05-12 15:11:10.943022+00	\N		\N		2026-05-12 15:11:10.943022+00			\N	2026-05-12 15:11:10.943022+00	{"provider": "email", "providers": ["email"]}	{"name": "Student 5", "role": "student"}	\N	2026-05-12 15:11:10.943022+00	2026-05-12 15:11:10.943022+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	c2ad89fd-2583-4f46-ad0d-8232f6269718	authenticated	authenticated	student9@edupredict.com	$2a$06$237WpEsMa0aguGtD9QhgqO3d9mSKB0iAOUq6Fd.Vregna0uQI6ma2	2026-05-12 15:11:10.943022+00	\N		\N		2026-05-12 15:11:10.943022+00			\N	2026-05-12 15:11:10.943022+00	{"provider": "email", "providers": ["email"]}	{"name": "Student 9", "role": "student"}	\N	2026-05-12 15:11:10.943022+00	2026-05-12 15:11:10.943022+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	b0000000-0000-0000-0000-000000000002	authenticated	authenticated	amogh.cseaiml24@cmrit.ac.in	$2a$06$840elSvyQjaw.5qnf5o3NeeW7i8X./BDeSH7SOOQux2Kob4brEANG	2026-05-20 20:48:06.980007+00	\N	\N	\N	\N	\N	\N	\N	\N	\N	{"provider": "email", "providers": ["email"]}	{}	\N	2026-05-20 20:48:06.980007+00	2026-05-20 20:48:06.980007+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	29dfd21e-5b74-420b-bb49-48143f8e2b6c	authenticated	authenticated	dgchb@smail.com	$2a$10$p7BVZz1Ptl/drh7TuzQGsekWgtRL.TMZXi185TqAtMOehpVdS5JDy	\N	\N	49d4067f887b4118e014026a458959ae85fd6be78f431ac3cb24d10d	2026-05-24 11:14:27.972331+00		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"sub": "29dfd21e-5b74-420b-bb49-48143f8e2b6c", "role": "student", "email": "dgchb@smail.com", "branch": "Fcgv", "semester": 1, "full_name": "Skgv", "email_verified": false, "phone_verified": false}	\N	2026-05-24 11:14:27.9653+00	2026-05-24 11:14:30.597749+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	1ba77db0-84e2-405d-883e-7de7ddf34bfb	authenticated	authenticated	thanmaydr777+2@gmail.com	$2a$10$AWHscnYpd8GFsc4ggveUvu6t2Y7eeY87HLvlti./uh/80e.KPdSB6	\N	\N	98dfad871d5b1e541861853c19c52d10faa539ffd20b7524ca6ca64c	2026-05-26 17:07:57.00149+00		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"sub": "1ba77db0-84e2-405d-883e-7de7ddf34bfb", "role": "student", "email": "thanmaydr777+2@gmail.com", "branch": "CSE(AIML)", "semester": 1, "full_name": "Thanmay DR", "email_verified": false, "phone_verified": false}	\N	2026-05-26 17:07:56.967432+00	2026-05-26 17:07:59.754047+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	5dde9013-8b74-4b6b-ad20-21285dafbf66	authenticated	authenticated	cgpranav796@gmail.com	$2a$10$fe7q/OfDNjpMOjKc1JIYQeVThzan.PF1F.Uf77arjjSl78BdqbMui	2026-05-28 06:49:37.221488+00	\N		2026-05-28 06:48:59.515181+00		\N			\N	2026-05-28 06:49:37.226185+00	{"provider": "email", "providers": ["email"]}	{"sub": "5dde9013-8b74-4b6b-ad20-21285dafbf66", "role": "student", "email": "cgpranav796@gmail.com", "branch": "CSE-AIML", "semester": 4, "full_name": "..", "email_verified": true, "phone_verified": false}	\N	2026-05-28 06:48:59.505813+00	2026-05-28 06:49:37.256472+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	44010cff-1b62-4c8a-abab-f43160ecd001	authenticated	authenticated	dambekodirajesh30511@gmail.com	$2a$10$aI375yxuTJ.dOm2NEOLwiOsXWZ0pcYI6OKcfEpZgBZEYvtnKNjPZO	2026-05-26 17:09:41.992496+00	\N		2026-05-26 17:08:38.878989+00		\N			\N	2026-05-26 17:09:49.888837+00	{"provider": "email", "providers": ["email"]}	{"sub": "44010cff-1b62-4c8a-abab-f43160ecd001", "role": "student", "email": "dambekodirajesh30511@gmail.com", "branch": "CSE(AIML)", "semester": 1, "full_name": "John Becker", "email_verified": true, "phone_verified": false}	\N	2026-05-26 17:08:38.85205+00	2026-05-26 17:09:49.891516+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	49a03840-db37-4a6f-bf88-1553a0cb2950	authenticated	authenticated	tammisettyanandkumar1@gmail.com	$2a$10$B6Y0D76WB1X6KMjmQ3017OoGgUQpIBikcZHuTvh8DwT5CAwi/SRdG	2026-05-23 15:30:43.68199+00	\N		2026-05-23 15:30:26.427748+00	fa5fe8c81d4ac996431ff25fc0054d1b15890e0cffcdee79f9f1ccab	2026-05-30 16:13:37.883359+00			\N	2026-05-23 15:31:00.989946+00	{"provider": "email", "providers": ["email"]}	{"sub": "49a03840-db37-4a6f-bf88-1553a0cb2950", "role": "student", "email": "tammisettyanandkumar1@gmail.com", "branch": "Computer science", "semester": 4, "full_name": "Anand", "email_verified": true, "phone_verified": false}	\N	2026-05-23 15:30:26.422583+00	2026-05-30 16:13:40.705203+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	5fd7dc38-f545-4e42-9597-4d981ea55f9e	authenticated	authenticated	sejal.parent@edupredict.com	$2a$06$OiaK7Q3BvamZrJCoaqjiB.Wr4dXPy7gxBoX2lrmy.oZ8Q6HMP0lQi	2026-05-24 11:52:40.193211+00	\N		\N		\N			\N	2026-05-28 12:22:12.784944+00	{"provider": "email", "providers": ["email"]}	{"role": "parent", "full_name": "Parent of Sejal"}	\N	2026-05-24 11:52:40.193211+00	2026-05-28 12:22:12.801211+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	d35f1354-038a-4273-a177-0c07105cd9d6	authenticated	authenticated	nehaismyname02@gmail.com	$2a$06$Gc/jh62UI6y8CH.ZmyeWPeocBkNIXEQOl5S4fKNGVaiRsN/QgMEue	2026-05-13 13:30:53.428617+00	\N		2026-05-13 13:30:19.041881+00		\N			\N	2026-05-31 17:19:02.33232+00	{"provider": "email", "providers": ["email"]}	{"sub": "d35f1354-038a-4273-a177-0c07105cd9d6", "role": "mentor", "email": "nehaismyname02@gmail.com", "branch": "Cse aiml", "semester": 4, "full_name": "Neha Pandey", "email_verified": true, "phone_verified": false}	\N	2026-05-13 13:30:18.998193+00	2026-05-31 19:17:52.283199+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
14aad89b-3a0a-46c6-9297-56b4ce8f8280	14aad89b-3a0a-46c6-9297-56b4ce8f8280	{"sub": "14aad89b-3a0a-46c6-9297-56b4ce8f8280", "role": "mentor", "email": "thanmaydambekodi@gmail.com", "branch": "CSE(AIML)", "semester": 4, "full_name": "Neha", "email_verified": true, "phone_verified": false}	email	2026-05-12 15:08:44.166942+00	2026-05-12 15:08:44.166993+00	2026-05-12 15:08:44.166993+00	a4d5bb18-9df0-411e-b45c-548eb8448568
d35f1354-038a-4273-a177-0c07105cd9d6	d35f1354-038a-4273-a177-0c07105cd9d6	{"sub": "d35f1354-038a-4273-a177-0c07105cd9d6", "role": "mentor", "email": "nehaismyname02@gmail.com", "branch": "Cse aiml", "semester": 4, "full_name": "Neha Pandey", "email_verified": true, "phone_verified": false}	email	2026-05-13 13:30:19.034314+00	2026-05-13 13:30:19.034373+00	2026-05-13 13:30:19.034373+00	d94254ea-e713-4d20-9d63-63a0feffca66
8c20d36c-6246-4026-9938-65eac0eb0ca3	8c20d36c-6246-4026-9938-65eac0eb0ca3	{"sub": "8c20d36c-6246-4026-9938-65eac0eb0ca3", "role": "student", "email": "lalithrajeshwari537@gmail.com", "branch": "CSEAIML", "semester": 4, "full_name": "lalith kishore M", "email_verified": true, "phone_verified": false}	email	2026-05-23 10:40:38.086593+00	2026-05-23 10:40:38.086643+00	2026-05-23 10:40:38.086643+00	52a1111e-a924-4eb0-ae9a-4f2dd2174192
49a03840-db37-4a6f-bf88-1553a0cb2950	49a03840-db37-4a6f-bf88-1553a0cb2950	{"sub": "49a03840-db37-4a6f-bf88-1553a0cb2950", "role": "student", "email": "tammisettyanandkumar1@gmail.com", "branch": "Computer science", "semester": 4, "full_name": "Anand", "email_verified": true, "phone_verified": false}	email	2026-05-23 15:30:26.425345+00	2026-05-23 15:30:26.425391+00	2026-05-23 15:30:26.425391+00	6b28282c-7f8b-436d-9976-335473861743
29dfd21e-5b74-420b-bb49-48143f8e2b6c	29dfd21e-5b74-420b-bb49-48143f8e2b6c	{"sub": "29dfd21e-5b74-420b-bb49-48143f8e2b6c", "role": "student", "email": "dgchb@smail.com", "branch": "Fcgv", "semester": 1, "full_name": "Skgv", "email_verified": false, "phone_verified": false}	email	2026-05-24 11:14:27.969267+00	2026-05-24 11:14:27.969337+00	2026-05-24 11:14:27.969337+00	867e546d-9417-478f-9af7-f7680e95e068
5fd7dc38-f545-4e42-9597-4d981ea55f9e	5fd7dc38-f545-4e42-9597-4d981ea55f9e	{"sub": "5fd7dc38-f545-4e42-9597-4d981ea55f9e", "email": "sejal.parent@edupredict.com"}	email	2026-05-24 11:52:40.193211+00	2026-05-24 11:52:40.193211+00	2026-05-24 11:52:40.193211+00	b2ae4f83-8e47-47f4-85f5-6cec19ccc946
1ba77db0-84e2-405d-883e-7de7ddf34bfb	1ba77db0-84e2-405d-883e-7de7ddf34bfb	{"sub": "1ba77db0-84e2-405d-883e-7de7ddf34bfb", "role": "student", "email": "thanmaydr777+2@gmail.com", "branch": "CSE(AIML)", "semester": 1, "full_name": "Thanmay DR", "email_verified": false, "phone_verified": false}	email	2026-05-26 17:07:56.993138+00	2026-05-26 17:07:56.993191+00	2026-05-26 17:07:56.993191+00	b5bddeb6-37cf-4168-8b26-4458d108a6aa
44010cff-1b62-4c8a-abab-f43160ecd001	44010cff-1b62-4c8a-abab-f43160ecd001	{"sub": "44010cff-1b62-4c8a-abab-f43160ecd001", "role": "student", "email": "dambekodirajesh30511@gmail.com", "branch": "CSE(AIML)", "semester": 1, "full_name": "John Becker", "email_verified": true, "phone_verified": false}	email	2026-05-26 17:08:38.874224+00	2026-05-26 17:08:38.874278+00	2026-05-26 17:08:38.874278+00	ccbf9624-15a3-40ba-905b-e44e345d9910
5dde9013-8b74-4b6b-ad20-21285dafbf66	5dde9013-8b74-4b6b-ad20-21285dafbf66	{"sub": "5dde9013-8b74-4b6b-ad20-21285dafbf66", "role": "student", "email": "cgpranav796@gmail.com", "branch": "CSE-AIML", "semester": 4, "full_name": "..", "email_verified": true, "phone_verified": false}	email	2026-05-28 06:48:59.511506+00	2026-05-28 06:48:59.511562+00	2026-05-28 06:48:59.511562+00	1856bfc5-2292-403e-9449-9fadb3b42e29
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_clients (id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at, client_type, token_endpoint_auth_method) FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag, oauth_client_id, refresh_token_hmac_key, refresh_token_counter, scopes) FROM stdin;
1484b354-a133-4e2d-9c4a-181bdcedfe6b	5dde9013-8b74-4b6b-ad20-21285dafbf66	2026-05-28 06:49:37.227294+00	2026-05-28 06:49:37.227294+00	\N	aal1	\N	\N	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36	122.168.66.148	\N	\N	\N	\N	\N
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
1484b354-a133-4e2d-9c4a-181bdcedfe6b	2026-05-28 06:49:37.257075+00	2026-05-28 06:49:37.257075+00	otp	dda89c95-89c2-42f6-961e-705cebff07a8
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid, last_webauthn_challenge_data) FROM stdin;
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_authorizations (id, authorization_id, client_id, user_id, redirect_uri, scope, state, resource, code_challenge, code_challenge_method, response_type, status, authorization_code, created_at, expires_at, approved_at, nonce) FROM stdin;
\.


--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_client_states (id, provider_type, code_verifier, created_at) FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_consents (id, user_id, client_id, scopes, granted_at, revoked_at) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
28480699-aecd-4982-aaa3-8367c8f6ef0c	29dfd21e-5b74-420b-bb49-48143f8e2b6c	confirmation_token	49d4067f887b4118e014026a458959ae85fd6be78f431ac3cb24d10d	dgchb@smail.com	2026-05-24 11:14:30.617017	2026-05-24 11:14:30.617017
8d84005b-647e-4085-8dfb-e82b584b4c8e	1ba77db0-84e2-405d-883e-7de7ddf34bfb	confirmation_token	98dfad871d5b1e541861853c19c52d10faa539ffd20b7524ca6ca64c	thanmaydr777+2@gmail.com	2026-05-26 17:07:59.76301	2026-05-26 17:07:59.76301
9918e0be-3148-42a3-ae1f-f67db6130631	49a03840-db37-4a6f-bf88-1553a0cb2950	recovery_token	fa5fe8c81d4ac996431ff25fc0054d1b15890e0cffcdee79f9f1ccab	tammisettyanandkumar1@gmail.com	2026-05-30 16:13:40.735025	2026-05-30 16:13:40.735025
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
00000000-0000-0000-0000-000000000000	262	hbp4stkv762x	5dde9013-8b74-4b6b-ad20-21285dafbf66	f	2026-05-28 06:49:37.245189+00	2026-05-28 06:49:37.245189+00	\N	1484b354-a133-4e2d-9c4a-181bdcedfe6b
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
20250717082212
20250731150234
20250804100000
20250901200500
20250903112500
20250904133000
20250925093508
20251007112900
20251104100000
20251111201300
20251201000000
20260115000000
20260121000000
20260219120000
20260302000000
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.webauthn_challenges (id, user_id, challenge_type, session_data, created_at, expires_at) FROM stdin;
\.


--
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.webauthn_credentials (id, user_id, credential_id, public_key, attestation_type, aaguid, sign_count, transports, backup_eligible, backed_up, friendly_name, created_at, updated_at, last_used_at) FROM stdin;
\.


--
-- Data for Name: academic_deadlines; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.academic_deadlines (id, title, date, type, status, amount, description, created_at) FROM stdin;
b2493442-8c33-45e4-a9b1-c2437ad7e7ce	Even Semester Tuition Fee	2026-06-10	fee	urgent	₹85,000	Final deadline to clear all tuition dues for the upcoming semester to avoid late penalties.	2026-05-26 18:19:16.265553+00
9306632c-92de-4851-8b5a-caae01d05302	VTU Exam Registration Form	2026-06-23	exam	upcoming	\N	Student must submit the official exam form through the VTU web portal.	2026-05-26 18:19:16.265553+00
761bb03d-a52f-42c0-bbcd-2eabb77bc54b	State Scholarship Application	2026-07-05	scholarship	upcoming	\N	Portal opens for the Vidyasiri State Scholarship scheme. Requires income certificate.	2026-05-26 18:19:16.265553+00
e194a6be-3cff-4e4f-8538-1090fb1f37d2	Even Semester Tuition Fee	2026-06-10	fee	urgent	₹85,000	Final deadline to clear all tuition dues for the upcoming semester to avoid late penalties.	2026-05-26 18:25:09.030958+00
1869b275-27b7-4307-aaa1-16e4ec00939b	VTU Exam Registration Form	2026-06-23	exam	upcoming	\N	Student must submit the official exam form through the VTU web portal.	2026-05-26 18:25:09.030958+00
debf3275-7544-4b74-ae58-77183d943a16	State Scholarship Application	2026-07-05	scholarship	upcoming	\N	Portal opens for the Vidyasiri State Scholarship scheme. Requires income certificate.	2026-05-26 18:25:09.030958+00
\.


--
-- Data for Name: achievements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.achievements (id, student_id, title, category, event_date, event_time, cert_url, attendance_claimed, notes, created_at) FROM stdin;
5892e98f-c8c5-4e0f-9e74-844a489aa6ba	c544629d-bb02-4c51-9c23-dc743e51a9b1	Hackathon	hackathon	2026-05-28	3pm	https://xjfpksstjolmfhaaajtt.supabase.co/storage/v1/object/public/certificates/c544629d-bb02-4c51-9c23-dc743e51a9b1/1779855048993.pdf	f	\N	2026-05-27 04:12:49.487608+00
dd0b295d-2918-47cc-bdf5-bd32991e3fce	c544629d-bb02-4c51-9c23-dc743e51a9b1	dare to dream	hackathon	\N	67	https://xjfpksstjolmfhaaajtt.supabase.co/storage/v1/object/public/certificates/c544629d-bb02-4c51-9c23-dc743e51a9b1/1779861666004.jpg	f	\N	2026-05-27 06:01:25.681922+00
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profiles (id, full_name, role, branch, semester, mentor_id, avatar_url, updated_at, created_at, parent_email, parent_phone) FROM stdin;
1ba77db0-84e2-405d-883e-7de7ddf34bfb	Thanmay DR	student	CSE(AIML)	1	\N	\N	2026-05-26 17:08:00.234754+00	2026-05-26 17:08:00.234754+00	\N	\N
44010cff-1b62-4c8a-abab-f43160ecd001	John Becker	student	CSE(AIML)	1	d35f1354-038a-4273-a177-0c07105cd9d6	\N	2026-05-26 17:09:58.542051+00	2026-05-26 17:08:41.90277+00	\N	\N
c544629d-bb02-4c51-9c23-dc743e51a9b1	Sejal Kumari	student	Computer Science	6	d35f1354-038a-4273-a177-0c07105cd9d6	\N	2026-05-27 08:19:31.163655+00	2026-05-12 19:23:35.79817+00	sejalkumari1987@gmail.com	+917075580733
5dde9013-8b74-4b6b-ad20-21285dafbf66	..	student	CSE-AIML	4	\N	\N	2026-05-28 06:49:02.654191+00	2026-05-28 06:49:02.654191+00	\N	\N
d35f1354-038a-4273-a177-0c07105cd9d6	Neha Pandey	mentor	Cse aiml	4	\N	\N	2026-05-13 13:30:22.100454+00	2026-05-13 13:30:22.100454+00	\N	\N
14aad89b-3a0a-46c6-9297-56b4ce8f8280	Neha	mentor	CSE(AIML)	4	\N	\N	2026-05-13 13:36:22.743924+00	2026-05-12 15:08:46.856745+00	\N	\N
299efed3-47cc-4a52-a203-96f8ed2f50c0	Student 1	student	Computer Science	6	d35f1354-038a-4273-a177-0c07105cd9d6	\N	2026-05-13 13:47:26.760008+00	2026-05-12 15:11:10.943022+00	parent_dummy@example.com	+910000000000
a0dee1a9-0426-4878-9726-cb5b880dd961	Student 2	student	Computer Science	6	d35f1354-038a-4273-a177-0c07105cd9d6	\N	2026-05-13 13:47:26.760008+00	2026-05-12 15:11:10.943022+00	parent_dummy@example.com	+910000000000
31e328af-0472-4281-a2f9-8db26e83f2bb	Student 3	student	Computer Science	6	d35f1354-038a-4273-a177-0c07105cd9d6	\N	2026-05-13 13:47:26.760008+00	2026-05-12 15:11:10.943022+00	parent_dummy@example.com	+910000000000
502755cd-0595-4ac7-8dba-eb20ac1f69a6	Student 4	student	Computer Science	6	d35f1354-038a-4273-a177-0c07105cd9d6	\N	2026-05-13 13:47:26.760008+00	2026-05-12 15:11:10.943022+00	parent_dummy@example.com	+910000000000
f65d5767-5fed-4aa5-9a94-739006d87bb2	Student 5	student	Computer Science	6	d35f1354-038a-4273-a177-0c07105cd9d6	\N	2026-05-13 13:47:26.760008+00	2026-05-12 15:11:10.943022+00	parent_dummy@example.com	+910000000000
bc8f862e-ec2c-4c37-b924-c34864013f1c	Student 6	student	Computer Science	6	d35f1354-038a-4273-a177-0c07105cd9d6	\N	2026-05-13 13:47:26.760008+00	2026-05-12 15:11:10.943022+00	parent_dummy@example.com	+910000000000
380e4e1d-f169-474c-812b-d9a157b98930	Student 7	student	Computer Science	6	d35f1354-038a-4273-a177-0c07105cd9d6	\N	2026-05-13 13:47:26.760008+00	2026-05-12 15:11:10.943022+00	parent_dummy@example.com	+910000000000
39259dfa-72e0-4568-b6ae-7beb2b01b10f	Student 8	student	Computer Science	6	d35f1354-038a-4273-a177-0c07105cd9d6	\N	2026-05-13 13:47:26.760008+00	2026-05-12 15:11:10.943022+00	parent_dummy@example.com	+910000000000
c2ad89fd-2583-4f46-ad0d-8232f6269718	Student 9	student	Computer Science	6	d35f1354-038a-4273-a177-0c07105cd9d6	\N	2026-05-13 13:47:26.760008+00	2026-05-12 15:11:10.943022+00	parent_dummy@example.com	+910000000000
b0000000-0000-0000-0000-000000000002	Amogh Sai Ykuntam	student	AIML	3	d35f1354-038a-4273-a177-0c07105cd9d6	\N	2026-05-20 20:53:05.728364+00	2026-05-20 20:48:06.980007+00	\N	\N
8c20d36c-6246-4026-9938-65eac0eb0ca3	lalith kishore M	student	CSEAIML	4	\N	\N	2026-05-23 10:40:41.432857+00	2026-05-23 10:40:41.432857+00	\N	\N
49a03840-db37-4a6f-bf88-1553a0cb2950	Anand	student	Computer science	4	\N	\N	2026-05-23 15:30:29.692726+00	2026-05-23 15:30:29.692726+00	\N	\N
29dfd21e-5b74-420b-bb49-48143f8e2b6c	Skgv	student	Fcgv	1	\N	\N	2026-05-24 11:14:31.112011+00	2026-05-24 11:14:31.112011+00	\N	\N
5fd7dc38-f545-4e42-9597-4d981ea55f9e	parent	parent	N/A	1	\N	\N	2026-05-25 13:31:23.12323+00	2026-05-24 11:52:40.193211+00	\N	\N
\.


--
-- Data for Name: telegram_sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.telegram_sessions (id, telegram_chat_id, user_id, role, linked_student_id, state, created_at) FROM stdin;
1889324b-de38-4cd7-9fe0-40dd19c7c11e	2068576819	d35f1354-038a-4273-a177-0c07105cd9d6	mentor	\N	logged_in	2026-05-21 09:22:37.392994+00
b13766d0-f094-423f-b172-ceaa3728c8f2	1060713423	d35f1354-038a-4273-a177-0c07105cd9d6	mentor	\N	logged_in	2026-05-26 20:22:39.499575+00
\.


--
-- Data for Name: ai_chat_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ai_chat_history (id, session_id, role, content, tool_calls, tool_call_id, name, created_at) FROM stdin;
04363cbe-221b-4ecc-8fe3-734484796998	b13766d0-f094-423f-b172-ceaa3728c8f2	user	i wanna know attendance of sejal	\N	\N	\N	2026-05-26 20:23:33.897664+00
f2d87e06-510f-4a5d-8942-a8ca4263b28a	b13766d0-f094-423f-b172-ceaa3728c8f2	assistant	\N	[{"id": "call_o3f4PzmUkp0KyWjYz5hf1O7c", "type": "function", "function": {"name": "search_student", "arguments": "{\\"name_query\\":\\"sejal\\"}"}}]	\N	\N	2026-05-26 20:23:34.899186+00
752de175-3af3-475f-95a2-3cc899a00b46	b13766d0-f094-423f-b172-ceaa3728c8f2	tool	[{"id":"c544629d-bb02-4c51-9c23-dc743e51a9b1","full_name":"Sejal Kumari","branch":"Computer Science","semester":6}]	\N	call_o3f4PzmUkp0KyWjYz5hf1O7c	search_student	2026-05-26 20:23:35.185858+00
bbbd4a47-e35c-46ba-8371-7488c8b01cf3	b13766d0-f094-423f-b172-ceaa3728c8f2	assistant	\N	[{"id": "call_4P81CTbLp2aeNJKZ1gehRpfQ", "type": "function", "function": {"name": "get_attendance", "arguments": "{\\"student_id\\":\\"c544629d-bb02-4c51-9c23-dc743e51a9b1\\"}"}}]	\N	\N	2026-05-26 20:23:36.81225+00
c7f6a900-fa7c-41f0-9794-d43c4cb24bb7	b13766d0-f094-423f-b172-ceaa3728c8f2	tool	[{"class_id":"1313044d-8c1e-4a62-b601-fa076ae77985","subject_name":"Discrete Mathematical Structures","present_count":0,"total_count":0,"percentage":null},{"class_id":"00411f60-5efc-4770-89b3-9db597b5cff4","subject_name":"Algorithm Design and Analysis","present_count":0,"total_count":0,"percentage":null},{"class_id":"65221f54-0a44-4bd1-991d-e08256571e38","subject_name":"Machine Learning","present_count":17,"total_count":23,"percentage":73.91},{"class_id":"cc86eed0-2573-4a68-a478-76a8e8c5c03e","subject_name":"Artificial Intelligence","present_count":1,"total_count":1,"percentage":100},{"class_id":"931e073f-d654-4f85-88c7-3e48c60a0349","subject_name":"Database Management","present_count":16,"total_count":22,"percentage":72.73},{"class_id":"c7221a8c-09bc-4545-84df-058f73f7b11e","subject_name":"Data Structures","present_count":15,"total_count":22,"percentage":68.18},{"class_id":"4bb87678-40bf-479d-a97f-662e63cd652f","subject_name":"Operating Systems","present_count":16,"total_count":22,"percentage":72.73}]	\N	call_4P81CTbLp2aeNJKZ1gehRpfQ	get_attendance	2026-05-26 20:23:37.112566+00
29b45a07-9d6b-4e9a-909c-aa70c86cf3b9	b13766d0-f094-423f-b172-ceaa3728c8f2	assistant	Here is the attendance summary for <b>Sejal Kumari</b> in her current semester:\n\n<ul>\n  <li><b>Discrete Mathematical Structures:</b> <i>Present: 0, Total: 0, Percentage: N/A</i></li>\n  <li><b>Algorithm Design and Analysis:</b> <i>Present: 0, Total: 0, Percentage: N/A</i></li>\n  <li><b>Machine Learning:</b> <i>Present: 17, Total: 23, Percentage: 73.91%</i></li>\n  <li><b>Artificial Intelligence:</b> <i>Present: 1, Total: 1, Percentage: 100%</i></li>\n  <li><b>Database Management:</b> <i>Present: 16, Total: 22, Percentage: 72.73%</i></li>\n  <li><b>Data Structures:</b> <i>Present: 15, Total: 22, Percentage: 68.18%</i></li>\n  <li><b>Operating Systems:</b> <i>Present: 16, Total: 22, Percentage: 72.73%</i></li>\n</ul>\n\nIf you need further information or assistance, feel free to ask!	\N	\N	\N	2026-05-26 20:23:41.859352+00
3037d4dd-3f1a-43ba-8430-cbf17339e338	b13766d0-f094-423f-b172-ceaa3728c8f2	user	hello?	\N	\N	\N	2026-05-26 20:23:57.936206+00
db1f1360-f8c3-4319-9cad-597a8d709a70	b13766d0-f094-423f-b172-ceaa3728c8f2	assistant	Hello, Neha! How can I assist you today? If you have any questions or need help with something specific, feel free to let me know!	\N	\N	\N	2026-05-26 20:24:00.27262+00
ede0b905-0d0d-44ab-81a2-ac2f27d819a0	b13766d0-f094-423f-b172-ceaa3728c8f2	user	sejal	\N	\N	\N	2026-05-26 20:24:04.866423+00
7794976e-483f-4fc0-b972-9e1f4f6c4143	b13766d0-f094-423f-b172-ceaa3728c8f2	assistant	It seems like you're interested in Sejal again. How can I assist you regarding her? Would you like to know more about her attendance, grades, or something else?	\N	\N	\N	2026-05-26 20:24:06.274676+00
416d25f1-532b-4cae-9da7-4bfbedae0915	b13766d0-f094-423f-b172-ceaa3728c8f2	user	attendance	\N	\N	\N	2026-05-26 20:24:15.456574+00
18352356-e075-460a-827f-519fe5ab1371	b13766d0-f094-423f-b172-ceaa3728c8f2	assistant	\N	[{"id": "call_WlrYZynmWbsd9FZaTi1umTUZ", "type": "function", "function": {"name": "get_attendance", "arguments": "{\\"student_id\\":\\"c544629d-bb02-4c51-9c23-dc743e51a9b1\\"}"}}]	\N	\N	2026-05-26 20:24:17.929974+00
e0f27653-1a09-4fbe-a57e-127759e87f3e	b13766d0-f094-423f-b172-ceaa3728c8f2	tool	[{"class_id":"1313044d-8c1e-4a62-b601-fa076ae77985","subject_name":"Discrete Mathematical Structures","present_count":0,"total_count":0,"percentage":null},{"class_id":"00411f60-5efc-4770-89b3-9db597b5cff4","subject_name":"Algorithm Design and Analysis","present_count":0,"total_count":0,"percentage":null},{"class_id":"65221f54-0a44-4bd1-991d-e08256571e38","subject_name":"Machine Learning","present_count":17,"total_count":23,"percentage":73.91},{"class_id":"cc86eed0-2573-4a68-a478-76a8e8c5c03e","subject_name":"Artificial Intelligence","present_count":1,"total_count":1,"percentage":100},{"class_id":"931e073f-d654-4f85-88c7-3e48c60a0349","subject_name":"Database Management","present_count":16,"total_count":22,"percentage":72.73},{"class_id":"c7221a8c-09bc-4545-84df-058f73f7b11e","subject_name":"Data Structures","present_count":15,"total_count":22,"percentage":68.18},{"class_id":"4bb87678-40bf-479d-a97f-662e63cd652f","subject_name":"Operating Systems","present_count":16,"total_count":22,"percentage":72.73}]	\N	call_WlrYZynmWbsd9FZaTi1umTUZ	get_attendance	2026-05-26 20:24:18.220622+00
900d5dac-0dae-48b0-9501-b3b17942c995	b13766d0-f094-423f-b172-ceaa3728c8f2	assistant	Here is the attendance summary for <b>Sejal Kumari</b>:\n\n<ul>\n  <li><b>Discrete Mathematical Structures:</b> <i>Present: 0, Total: 0, Percentage: N/A</i></li>\n  <li><b>Algorithm Design and Analysis:</b> <i>Present: 0, Total: 0, Percentage: N/A</i></li>\n  <li><b>Machine Learning:</b> <i>Present: 17, Total: 23, Percentage: 73.91%</i></li>\n  <li><b>Artificial Intelligence:</b> <i>Present: 1, Total: 1, Percentage: 100%</i></li>\n  <li><b>Database Management:</b> <i>Present: 16, Total: 22, Percentage: 72.73%</i></li>\n  <li><b>Data Structures:</b> <i>Present: 15, Total: 22, Percentage: 68.18%</i></li>\n  <li><b>Operating Systems:</b> <i>Present: 16, Total: 22, Percentage: 72.73%</i></li>\n</ul>\n\nIf you need any further details or assistance, just let me know!	\N	\N	\N	2026-05-26 20:24:23.709663+00
a85178b6-e11b-4e25-82e9-99f752fba8c8	b13766d0-f094-423f-b172-ceaa3728c8f2	user	Yo	\N	\N	\N	2026-05-28 14:08:26.124753+00
5c09b83c-870f-4504-995e-e8c78afc5ae3	b13766d0-f094-423f-b172-ceaa3728c8f2	assistant	Hey there! How can I help you today? If you have any questions or need assistance, feel free to ask!	\N	\N	\N	2026-05-28 14:08:28.65375+00
cacc8a33-a657-4957-a65f-4652215e861b	b13766d0-f094-423f-b172-ceaa3728c8f2	user	Yo	\N	\N	\N	2026-05-28 14:09:24.656925+00
e8ec283f-2bb1-4eaa-86d6-22f5dc348db7	b13766d0-f094-423f-b172-ceaa3728c8f2	assistant	Yo! What's up? If there's anything specific you'd like to discuss or ask about, just let me know!	\N	\N	\N	2026-05-28 14:09:27.69026+00
93e7550f-dfa9-44c9-9662-4b2cb90c849c	b13766d0-f094-423f-b172-ceaa3728c8f2	user	Hi	\N	\N	\N	2026-05-28 14:09:29.478768+00
aa00d6c5-bd2c-498f-bdb2-ed1cd561ebe4	b13766d0-f094-423f-b172-ceaa3728c8f2	assistant	Hi there! How can I assist you today? If you have any questions or need help, feel free to ask!	\N	\N	\N	2026-05-28 14:09:33.222453+00
\.


--
-- Data for Name: subjects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subjects (id, name, code, description, created_at) FROM stdin;
558b6278-5f64-45b0-a669-61c5f4e2976c	Data Structures	CS301	Core DSA concepts	2026-05-12 15:10:52.640559+00
7a08999d-32a4-4cbf-ba6c-03c132de5f6a	Machine Learning	CS405	Intro to ML and Neural Networks	2026-05-12 15:10:52.640559+00
b367048d-106a-40ec-85cf-c797c416a24b	Operating Systems	CS302	System kernels and memory management	2026-05-12 15:10:52.640559+00
8e17464e-63d9-4f9b-b6ef-d5e30b03d6aa	Database Management	CS303	SQL and NoSQL architecture	2026-05-12 15:10:52.640559+00
02cbbdf5-ca1f-4550-a6a4-1b8038efc0cc	Artificial Intelligence	BCS301	Core AI concepts	2026-05-20 20:19:00.86134+00
6313106b-3d29-4364-80aa-fd7cc07a93cb	Discrete Mathematical Structures	BCS302	DMS concepts	2026-05-20 20:19:00.86134+00
092edf47-b671-4521-b234-4127dd743d20	Algorithm Design and Analysis	BCS303	ADA concepts	2026-05-20 20:19:00.86134+00
\.


--
-- Data for Name: classes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.classes (id, subject_id, mentor_id, academic_year, semester, created_at) FROM stdin;
68a2f603-7b91-4404-8fc0-79e611113f89	558b6278-5f64-45b0-a669-61c5f4e2976c	d35f1354-038a-4273-a177-0c07105cd9d6	2023-2024	6	2026-05-12 15:10:52.640559+00
265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	7a08999d-32a4-4cbf-ba6c-03c132de5f6a	d35f1354-038a-4273-a177-0c07105cd9d6	2023-2024	6	2026-05-12 15:10:52.640559+00
a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	b367048d-106a-40ec-85cf-c797c416a24b	d35f1354-038a-4273-a177-0c07105cd9d6	2023-2024	6	2026-05-12 15:10:52.640559+00
14f3b3f5-a555-4dcd-a269-b7132f014a38	8e17464e-63d9-4f9b-b6ef-d5e30b03d6aa	d35f1354-038a-4273-a177-0c07105cd9d6	2023-2024	6	2026-05-12 15:10:52.640559+00
c7221a8c-09bc-4545-84df-058f73f7b11e	558b6278-5f64-45b0-a669-61c5f4e2976c	d35f1354-038a-4273-a177-0c07105cd9d6	2025-2026	6	2026-05-12 19:29:20.777049+00
65221f54-0a44-4bd1-991d-e08256571e38	7a08999d-32a4-4cbf-ba6c-03c132de5f6a	d35f1354-038a-4273-a177-0c07105cd9d6	2025-2026	6	2026-05-12 19:29:20.777049+00
4bb87678-40bf-479d-a97f-662e63cd652f	b367048d-106a-40ec-85cf-c797c416a24b	d35f1354-038a-4273-a177-0c07105cd9d6	2025-2026	6	2026-05-12 19:29:20.777049+00
931e073f-d654-4f85-88c7-3e48c60a0349	8e17464e-63d9-4f9b-b6ef-d5e30b03d6aa	d35f1354-038a-4273-a177-0c07105cd9d6	2025-2026	6	2026-05-12 19:29:20.777049+00
cc86eed0-2573-4a68-a478-76a8e8c5c03e	02cbbdf5-ca1f-4550-a6a4-1b8038efc0cc	d35f1354-038a-4273-a177-0c07105cd9d6	2024-25	3	2026-05-20 20:19:00.86134+00
1313044d-8c1e-4a62-b601-fa076ae77985	6313106b-3d29-4364-80aa-fd7cc07a93cb	d35f1354-038a-4273-a177-0c07105cd9d6	2024-25	3	2026-05-20 20:19:00.86134+00
00411f60-5efc-4770-89b3-9db597b5cff4	092edf47-b671-4521-b234-4127dd743d20	d35f1354-038a-4273-a177-0c07105cd9d6	2024-25	3	2026-05-20 20:19:00.86134+00
\.


--
-- Data for Name: attendance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attendance (id, student_id, class_id, status, date, created_at, mentor_id) FROM stdin;
85ac4c3a-f048-492a-a926-91b008653f84	299efed3-47cc-4a52-a203-96f8ed2f50c0	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a5decec5-a380-4c1c-953d-5e87e66f124c	299efed3-47cc-4a52-a203-96f8ed2f50c0	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a0f06c3a-5967-4140-ba31-0c4d7f306c91	299efed3-47cc-4a52-a203-96f8ed2f50c0	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
32c31324-bef3-47c9-b33e-f3ae7cd4cc08	299efed3-47cc-4a52-a203-96f8ed2f50c0	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
091db3b6-c99f-46fd-9e5e-76fb3eec9373	299efed3-47cc-4a52-a203-96f8ed2f50c0	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
840f32e4-2446-44c9-9ff3-2ec3bbb8b50d	299efed3-47cc-4a52-a203-96f8ed2f50c0	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
d7b2e820-cd94-4fc0-87cf-2da0c304ca64	299efed3-47cc-4a52-a203-96f8ed2f50c0	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
54319f9a-ede8-4ba7-ad89-11ea1c3dd840	299efed3-47cc-4a52-a203-96f8ed2f50c0	14f3b3f5-a555-4dcd-a269-b7132f014a38	Absent	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f81dea33-e2e8-4f48-81ab-98f93f04a597	299efed3-47cc-4a52-a203-96f8ed2f50c0	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e9d94e7e-141f-4652-9d91-58609d4d11d2	299efed3-47cc-4a52-a203-96f8ed2f50c0	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
80a4aab6-29e0-4f32-b900-6ff8bdf827d6	299efed3-47cc-4a52-a203-96f8ed2f50c0	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
750fd479-2a2e-460b-bd36-ce484ff21751	299efed3-47cc-4a52-a203-96f8ed2f50c0	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
cbf1ae22-d389-411b-95ef-7fe709b0879d	299efed3-47cc-4a52-a203-96f8ed2f50c0	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
1209c204-cf53-45b8-b2a5-dfac47c124b1	299efed3-47cc-4a52-a203-96f8ed2f50c0	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
dd1d8585-4439-4e02-a430-d4aeab20d34e	299efed3-47cc-4a52-a203-96f8ed2f50c0	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
266573b3-63e4-407d-a608-93a237e4b8d4	299efed3-47cc-4a52-a203-96f8ed2f50c0	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
28573f15-a2ba-4b74-ae53-832ce52abfda	299efed3-47cc-4a52-a203-96f8ed2f50c0	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a5c189bb-00cc-4d6a-9eb0-20e61f3d5d5f	299efed3-47cc-4a52-a203-96f8ed2f50c0	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
dee740e7-8bb3-4f4d-b91c-b2ab4f800ed6	299efed3-47cc-4a52-a203-96f8ed2f50c0	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
43df4376-e0a3-431d-9114-c49337a7591e	299efed3-47cc-4a52-a203-96f8ed2f50c0	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
d437f3e4-3d43-42f1-a9a8-1faa8b69fc54	299efed3-47cc-4a52-a203-96f8ed2f50c0	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
38121207-2a42-4fac-b5f7-ba18bb4a0904	299efed3-47cc-4a52-a203-96f8ed2f50c0	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
2a465807-33bc-4533-a7b5-dfdcb9b33c2e	299efed3-47cc-4a52-a203-96f8ed2f50c0	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
3331d834-f694-4694-8cd7-df0fee7f708a	299efed3-47cc-4a52-a203-96f8ed2f50c0	14f3b3f5-a555-4dcd-a269-b7132f014a38	Absent	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
652ec5c4-6680-4378-ad08-da6a9eefa898	299efed3-47cc-4a52-a203-96f8ed2f50c0	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
5275e647-91b8-4ad9-b73e-c8384c1dd16a	299efed3-47cc-4a52-a203-96f8ed2f50c0	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
8baa1dba-e000-45de-9eeb-f4ca20758db3	299efed3-47cc-4a52-a203-96f8ed2f50c0	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
619191dd-7940-4ea8-a677-87126e9eb348	299efed3-47cc-4a52-a203-96f8ed2f50c0	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
4e26c0c4-2f36-43aa-9526-39859416b949	299efed3-47cc-4a52-a203-96f8ed2f50c0	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
47bf257a-72e4-4a54-8766-cdaf6ddb19f7	299efed3-47cc-4a52-a203-96f8ed2f50c0	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
5b97cfe8-6c58-4bdb-b59f-a25d8571a4d9	299efed3-47cc-4a52-a203-96f8ed2f50c0	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
6301aaef-a245-424f-88b9-617baee8932e	299efed3-47cc-4a52-a203-96f8ed2f50c0	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e3933b07-b4fc-4959-aa40-31aaa5bb4f30	299efed3-47cc-4a52-a203-96f8ed2f50c0	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
cfbeb6f8-1c17-4033-903d-9993f1566ffe	299efed3-47cc-4a52-a203-96f8ed2f50c0	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e96a8807-559c-464a-9803-8064b0d3e03c	299efed3-47cc-4a52-a203-96f8ed2f50c0	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f5c723b4-777c-42b9-a1ec-77d31203cb7e	299efed3-47cc-4a52-a203-96f8ed2f50c0	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
474208e4-b4cf-401b-a3a1-8712b530d524	299efed3-47cc-4a52-a203-96f8ed2f50c0	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
7857fa24-7c7e-4c83-acc4-2beefd9ffc0a	299efed3-47cc-4a52-a203-96f8ed2f50c0	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f2ceb020-2174-4305-809d-96866987d725	299efed3-47cc-4a52-a203-96f8ed2f50c0	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
7e6a032e-a806-4aee-882f-ba5dc4824435	299efed3-47cc-4a52-a203-96f8ed2f50c0	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
6f1b25a4-26ad-4ab2-9994-0c531e07565c	299efed3-47cc-4a52-a203-96f8ed2f50c0	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
36dac62d-3a6c-4b38-9bd5-50c5d11e1225	299efed3-47cc-4a52-a203-96f8ed2f50c0	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b835c64c-d03c-4943-a64d-15746f8ac269	299efed3-47cc-4a52-a203-96f8ed2f50c0	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
d5652cce-f059-4aaa-9147-69cf63d64ee4	299efed3-47cc-4a52-a203-96f8ed2f50c0	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
77ceb67a-9e0c-41e5-93c9-cc9a09867a33	299efed3-47cc-4a52-a203-96f8ed2f50c0	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
898eab86-4206-4932-bed6-2d27ef2e4d91	299efed3-47cc-4a52-a203-96f8ed2f50c0	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
eccea86e-a037-41c9-83eb-2786f7859f46	299efed3-47cc-4a52-a203-96f8ed2f50c0	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
7ba3721a-0829-4dff-8049-79e301814170	299efed3-47cc-4a52-a203-96f8ed2f50c0	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
3cb41271-6ec7-4883-aa4e-734ae991b2b9	299efed3-47cc-4a52-a203-96f8ed2f50c0	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
32b2a220-16ae-434e-aad5-9ff7211e0043	299efed3-47cc-4a52-a203-96f8ed2f50c0	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
458e25a8-7bbb-471b-b585-42d8d1055687	299efed3-47cc-4a52-a203-96f8ed2f50c0	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
8aaafd46-24fb-4f53-bed8-c8c9393873cb	a0dee1a9-0426-4878-9726-cb5b880dd961	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f3b79e4d-7ad2-45e4-8a95-57a7b676d9f1	a0dee1a9-0426-4878-9726-cb5b880dd961	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
fe01b9de-832c-4296-b644-26ba0afbf338	a0dee1a9-0426-4878-9726-cb5b880dd961	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
feebe646-a7b9-49a1-af26-31e56bdc39dc	a0dee1a9-0426-4878-9726-cb5b880dd961	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ced48d2b-f52b-425c-afa6-9053b49c995b	a0dee1a9-0426-4878-9726-cb5b880dd961	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
47fb2896-e9c9-4044-8dc2-f47a575895a3	a0dee1a9-0426-4878-9726-cb5b880dd961	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b2e1ef1a-512c-4e2a-9d43-cfc6b2c241d3	a0dee1a9-0426-4878-9726-cb5b880dd961	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
99cd05fc-398d-4839-b03a-19d821df72a7	a0dee1a9-0426-4878-9726-cb5b880dd961	14f3b3f5-a555-4dcd-a269-b7132f014a38	Absent	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
6191d0a7-bef2-457b-a9eb-d5c4f7451912	a0dee1a9-0426-4878-9726-cb5b880dd961	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
1e9d104e-8fa5-4c29-9e17-04c7818b3bea	a0dee1a9-0426-4878-9726-cb5b880dd961	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
0ba234af-6489-4fdd-94f5-9b983a0044b0	a0dee1a9-0426-4878-9726-cb5b880dd961	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
39342828-a110-4d7a-a563-46a2ac074e1e	a0dee1a9-0426-4878-9726-cb5b880dd961	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
335c14c2-63e3-465f-a299-86254a957454	a0dee1a9-0426-4878-9726-cb5b880dd961	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
28cd5ed0-d8c5-442f-a18a-03f6fcb7592f	a0dee1a9-0426-4878-9726-cb5b880dd961	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e208bb16-5dca-4b06-b5ab-6a6a9f7ff94d	a0dee1a9-0426-4878-9726-cb5b880dd961	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
9c3fa571-aebc-4e05-93cb-90229e01be9b	a0dee1a9-0426-4878-9726-cb5b880dd961	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
8977af5e-63b1-4e7c-86e0-602bc59828ff	a0dee1a9-0426-4878-9726-cb5b880dd961	68a2f603-7b91-4404-8fc0-79e611113f89	Absent	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
32c6e8b4-c9da-455e-9fd7-84957c31769e	a0dee1a9-0426-4878-9726-cb5b880dd961	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a10cef4f-0683-4ed5-a30a-e0d96c190611	a0dee1a9-0426-4878-9726-cb5b880dd961	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
03ff2e53-d3b5-4945-b785-51506d411251	a0dee1a9-0426-4878-9726-cb5b880dd961	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
03ca4b27-7d2a-4166-90b5-e0456592c3e1	a0dee1a9-0426-4878-9726-cb5b880dd961	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ec5a536e-efd6-40a1-9351-33d3215c648b	a0dee1a9-0426-4878-9726-cb5b880dd961	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a3c1087f-1a1d-4e30-8389-2397aeacdf44	a0dee1a9-0426-4878-9726-cb5b880dd961	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
53c04748-98af-4469-9305-1b545bc4407b	a0dee1a9-0426-4878-9726-cb5b880dd961	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
bb229d3c-3cc7-48fa-9e2e-e0ad2cf08db4	a0dee1a9-0426-4878-9726-cb5b880dd961	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
5d389522-5c1c-4a4d-8b18-cb0dde057503	a0dee1a9-0426-4878-9726-cb5b880dd961	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
86163cd1-c3fb-422b-8bdd-bff4e5422866	a0dee1a9-0426-4878-9726-cb5b880dd961	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
3c239661-01e7-44ba-962a-3c18fe898e7e	a0dee1a9-0426-4878-9726-cb5b880dd961	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
2f3b9456-ecde-4a49-9adf-cca02b93bc44	a0dee1a9-0426-4878-9726-cb5b880dd961	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
2f3b7d1f-21d0-43da-8b1c-cf1754572689	a0dee1a9-0426-4878-9726-cb5b880dd961	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
361dc647-e1c8-46c6-9668-1928fdac8dd0	a0dee1a9-0426-4878-9726-cb5b880dd961	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
30f77b18-95d1-46b1-9119-e2d2664d28e9	a0dee1a9-0426-4878-9726-cb5b880dd961	14f3b3f5-a555-4dcd-a269-b7132f014a38	Absent	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
8f301bd3-188d-4e48-9c6c-776ae94daaab	a0dee1a9-0426-4878-9726-cb5b880dd961	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
9706b233-ae6a-4346-b11e-aff4faabc7d0	a0dee1a9-0426-4878-9726-cb5b880dd961	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
9f678c56-e1c8-4945-a349-f0e04c7a773b	a0dee1a9-0426-4878-9726-cb5b880dd961	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
34c51ebc-a4af-43bd-b70a-d813d4b0074c	a0dee1a9-0426-4878-9726-cb5b880dd961	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
974aeed9-a982-4a48-aeb2-a33dac0e5633	a0dee1a9-0426-4878-9726-cb5b880dd961	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b9ca6e3b-fd7d-407e-91e1-1c50cfe5eb8e	a0dee1a9-0426-4878-9726-cb5b880dd961	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
9a3325e3-cfd8-4f83-a9c4-a10978ad0004	a0dee1a9-0426-4878-9726-cb5b880dd961	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
463efafb-58f2-49a1-9b45-7043d2c1169a	a0dee1a9-0426-4878-9726-cb5b880dd961	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
9063a97b-c3cb-48a3-9628-961f38d71347	a0dee1a9-0426-4878-9726-cb5b880dd961	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
cbba8604-f7ac-4582-9cf0-5b693ba40410	a0dee1a9-0426-4878-9726-cb5b880dd961	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
751f245a-6038-489d-8b1e-95d5ffa71a55	a0dee1a9-0426-4878-9726-cb5b880dd961	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
091c7081-a0dd-4bf2-be0a-5893bb3f072b	a0dee1a9-0426-4878-9726-cb5b880dd961	14f3b3f5-a555-4dcd-a269-b7132f014a38	Absent	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
30bf4230-d95e-43ee-ab8d-03de643b6e67	a0dee1a9-0426-4878-9726-cb5b880dd961	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e2ee2d3e-3695-45ed-b179-37f18d313468	a0dee1a9-0426-4878-9726-cb5b880dd961	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a62610ac-c079-4f85-83e9-33b109030c7b	a0dee1a9-0426-4878-9726-cb5b880dd961	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b55f10ff-5c83-4cab-94e0-8af6082371bc	a0dee1a9-0426-4878-9726-cb5b880dd961	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
2bee37d4-2b25-4a1f-9f7b-3ec221e37fac	a0dee1a9-0426-4878-9726-cb5b880dd961	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
2e18f853-c973-4b33-a287-2ba53c2d5fc2	a0dee1a9-0426-4878-9726-cb5b880dd961	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
15066a88-79f5-4372-b3d3-496fd327aec3	a0dee1a9-0426-4878-9726-cb5b880dd961	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
9b7c19b3-d941-4258-80c6-8764250849e7	a0dee1a9-0426-4878-9726-cb5b880dd961	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
959213ee-65f6-4b6c-8558-a9ec31c2d5e9	a0dee1a9-0426-4878-9726-cb5b880dd961	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
2261628b-b707-430e-9133-b6ed8091bb44	a0dee1a9-0426-4878-9726-cb5b880dd961	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
409b7399-47b9-4402-a63a-bd810355cde5	a0dee1a9-0426-4878-9726-cb5b880dd961	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
08c0edc9-3b9f-4c18-b754-a60a1deb1ad8	a0dee1a9-0426-4878-9726-cb5b880dd961	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
d6c3738d-f4fd-4631-8ad5-22983545f2fa	a0dee1a9-0426-4878-9726-cb5b880dd961	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
013408c1-52d8-457b-b706-5265a27a6ec1	a0dee1a9-0426-4878-9726-cb5b880dd961	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a69d74dc-8fef-4fec-96a7-8932588e2160	a0dee1a9-0426-4878-9726-cb5b880dd961	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
c53c00cc-1435-4b61-a90f-0059362c8968	a0dee1a9-0426-4878-9726-cb5b880dd961	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
9b3ff6f8-b8d8-4089-a4d8-d09c55f6f03d	a0dee1a9-0426-4878-9726-cb5b880dd961	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e9a4922f-4d62-4b03-9ff0-4d22ac365ad0	a0dee1a9-0426-4878-9726-cb5b880dd961	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
10b9d511-9867-4ed4-9a7f-f4d1494ae670	a0dee1a9-0426-4878-9726-cb5b880dd961	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
d4face1d-6d97-4635-b59b-3fedcd310899	a0dee1a9-0426-4878-9726-cb5b880dd961	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
2c18d2ba-361e-435d-85a0-12c5314f9998	a0dee1a9-0426-4878-9726-cb5b880dd961	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a46b8e3e-e3f3-454e-9f77-4dc9a73d176f	a0dee1a9-0426-4878-9726-cb5b880dd961	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
bf1033ff-ad1f-4b2a-931e-895872a981eb	a0dee1a9-0426-4878-9726-cb5b880dd961	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Absent	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
0bd9a0d5-2168-425b-8462-1d216bca3748	a0dee1a9-0426-4878-9726-cb5b880dd961	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
6fbd0b04-de5e-40f6-a953-ab8a0713b956	a0dee1a9-0426-4878-9726-cb5b880dd961	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
c71d6bd2-36af-4a7f-88f4-631b5467c0f3	a0dee1a9-0426-4878-9726-cb5b880dd961	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b4cfc047-fecb-4ab1-9633-1bb09b6846fc	a0dee1a9-0426-4878-9726-cb5b880dd961	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
05cd2c22-4794-40e5-9164-b4fcbd65dc64	a0dee1a9-0426-4878-9726-cb5b880dd961	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
fc9bd26a-d6fc-4573-adf5-fbe435ab532d	a0dee1a9-0426-4878-9726-cb5b880dd961	68a2f603-7b91-4404-8fc0-79e611113f89	Absent	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
161fb9d7-11cc-4895-b34a-6312df08efda	a0dee1a9-0426-4878-9726-cb5b880dd961	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
3017b377-19a9-4b18-acff-caca1c297a68	a0dee1a9-0426-4878-9726-cb5b880dd961	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
d0d1e725-67f5-4551-8630-487a98ca7d4b	a0dee1a9-0426-4878-9726-cb5b880dd961	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
387e1e9b-5678-45b8-af6e-bcfd184d057e	a0dee1a9-0426-4878-9726-cb5b880dd961	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
43d0c9a2-8184-4cd9-8e87-834d37272d11	a0dee1a9-0426-4878-9726-cb5b880dd961	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
55690e14-4048-453a-93b9-a3c0d3b6fc6f	a0dee1a9-0426-4878-9726-cb5b880dd961	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b3732b7d-5a45-4f72-8b60-f49042e1d778	a0dee1a9-0426-4878-9726-cb5b880dd961	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
1395a5ed-c8e3-40da-862e-2ba206bb8803	a0dee1a9-0426-4878-9726-cb5b880dd961	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
4980d45f-945b-4d62-896d-f052fb23af33	a0dee1a9-0426-4878-9726-cb5b880dd961	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
c208e739-241f-4d89-b20d-d5308cc12b72	a0dee1a9-0426-4878-9726-cb5b880dd961	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f9f1832e-7086-43be-8b01-a293e675616d	a0dee1a9-0426-4878-9726-cb5b880dd961	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
185cc056-1e2c-4252-a517-762c9d7f04e0	31e328af-0472-4281-a2f9-8db26e83f2bb	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
d1cad601-07ad-4451-a2d8-2bbf50353db5	31e328af-0472-4281-a2f9-8db26e83f2bb	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ee0bd387-48b8-45b0-88f4-bc2f0e53be70	31e328af-0472-4281-a2f9-8db26e83f2bb	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
70ecd76e-9b68-41d8-b172-3497434d24b9	31e328af-0472-4281-a2f9-8db26e83f2bb	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
d23e01e8-39ee-45b2-8786-16076d5c8942	31e328af-0472-4281-a2f9-8db26e83f2bb	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b39bfb16-5f5c-4b0a-9a66-cfb2ffada054	31e328af-0472-4281-a2f9-8db26e83f2bb	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f3428ea3-e489-4549-991c-31da9bfd2878	31e328af-0472-4281-a2f9-8db26e83f2bb	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
9d5cddb3-52a0-4080-b193-b14ce57ffe8c	31e328af-0472-4281-a2f9-8db26e83f2bb	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
dc7d2470-25cf-499b-8647-ba470e56025d	31e328af-0472-4281-a2f9-8db26e83f2bb	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a21856e2-dea5-4545-a587-81efe8e72fac	31e328af-0472-4281-a2f9-8db26e83f2bb	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
403a8494-ce8d-4e7e-8f74-2b843a92d0b5	31e328af-0472-4281-a2f9-8db26e83f2bb	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
afa05a1d-12d0-4c8e-b0eb-9897841e3b42	31e328af-0472-4281-a2f9-8db26e83f2bb	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
1bdf78bc-058e-458d-b2be-e2e093570c64	31e328af-0472-4281-a2f9-8db26e83f2bb	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
2241b0ae-bf12-49fc-a9c5-17009cc48d6d	31e328af-0472-4281-a2f9-8db26e83f2bb	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ff6b6e15-5ed2-462d-b388-f85166607f90	31e328af-0472-4281-a2f9-8db26e83f2bb	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
05cad465-70f2-4891-9837-b0e31fd03967	31e328af-0472-4281-a2f9-8db26e83f2bb	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e8ae15ed-e8fb-41b6-8fa1-3c71297a5753	31e328af-0472-4281-a2f9-8db26e83f2bb	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
7e3ca9a1-f394-456b-90b6-514c857d9c7a	31e328af-0472-4281-a2f9-8db26e83f2bb	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
5c4fc750-b8b6-4152-88a8-2e93d943715f	31e328af-0472-4281-a2f9-8db26e83f2bb	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
85443c4b-9c03-40c8-acc0-a0847dbe41d8	31e328af-0472-4281-a2f9-8db26e83f2bb	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
55b26601-56e3-43a0-9d73-0138f820b776	31e328af-0472-4281-a2f9-8db26e83f2bb	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
bdc2cdab-c30d-4077-b6e7-a5dd19d0125d	31e328af-0472-4281-a2f9-8db26e83f2bb	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
194b377f-1606-404f-83af-4f2310a48e3c	31e328af-0472-4281-a2f9-8db26e83f2bb	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
00cf0843-25df-4809-a71f-d0e91577dfbe	31e328af-0472-4281-a2f9-8db26e83f2bb	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
770c6767-6f04-4ab6-9db1-eb73de894c28	31e328af-0472-4281-a2f9-8db26e83f2bb	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
932b69b2-78d7-4899-8c05-c9fdbcaa142b	31e328af-0472-4281-a2f9-8db26e83f2bb	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f82f9633-767a-44d3-b708-ce0c96b926f1	31e328af-0472-4281-a2f9-8db26e83f2bb	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
5703b037-b855-4967-aa0a-e7428ca7a54f	31e328af-0472-4281-a2f9-8db26e83f2bb	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b0f777c2-7b86-45df-833b-93d666d69ac5	31e328af-0472-4281-a2f9-8db26e83f2bb	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
1fa778d0-c888-45ad-b0ca-b0ed67ca1f32	31e328af-0472-4281-a2f9-8db26e83f2bb	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e277fe79-0d96-44cf-91ec-33227507e59b	31e328af-0472-4281-a2f9-8db26e83f2bb	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
74083b50-3610-420a-b753-497b8300224d	31e328af-0472-4281-a2f9-8db26e83f2bb	14f3b3f5-a555-4dcd-a269-b7132f014a38	Absent	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
c5958efe-161e-4768-a5e7-e96d03f817b8	31e328af-0472-4281-a2f9-8db26e83f2bb	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
efb00138-2eb3-4b8f-be6e-63d7af3e00d1	31e328af-0472-4281-a2f9-8db26e83f2bb	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
03c42363-8170-4ff8-b082-6ceded6af30e	31e328af-0472-4281-a2f9-8db26e83f2bb	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
2acbd63e-755a-4115-a222-eb81c38d7c1d	31e328af-0472-4281-a2f9-8db26e83f2bb	14f3b3f5-a555-4dcd-a269-b7132f014a38	Absent	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
3d0db6a3-3ea1-495d-9c61-b1882d7aa93f	31e328af-0472-4281-a2f9-8db26e83f2bb	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
158b7a22-a1be-4d75-b2ef-bcbe7a202155	31e328af-0472-4281-a2f9-8db26e83f2bb	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
9935dcfb-0b67-48b7-bfa6-8a95373f1a44	31e328af-0472-4281-a2f9-8db26e83f2bb	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
5772bfc3-29d7-4984-914f-4c5c3625c236	31e328af-0472-4281-a2f9-8db26e83f2bb	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
169ce168-01d8-40d1-b8fc-2c616b73740d	31e328af-0472-4281-a2f9-8db26e83f2bb	68a2f603-7b91-4404-8fc0-79e611113f89	Absent	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f8b54cc3-458d-4830-9ba5-42799f679503	31e328af-0472-4281-a2f9-8db26e83f2bb	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a9790833-0945-46e1-92ee-4733b7038baf	31e328af-0472-4281-a2f9-8db26e83f2bb	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Absent	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
65f65fda-1f04-47c3-a649-9e058da5cafc	31e328af-0472-4281-a2f9-8db26e83f2bb	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b6347f48-4877-4a02-9410-c52a39afe564	31e328af-0472-4281-a2f9-8db26e83f2bb	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b7a7bccc-f704-4309-ae80-5abe56c3b37a	31e328af-0472-4281-a2f9-8db26e83f2bb	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
8a8700ae-8cbc-4355-9a9e-dc4f9ccbb55e	31e328af-0472-4281-a2f9-8db26e83f2bb	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Absent	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
d1df069c-acf6-48bb-abc4-0f68ab2afcff	31e328af-0472-4281-a2f9-8db26e83f2bb	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
99613e5f-c927-4ef5-bff9-b2b59c4ee699	31e328af-0472-4281-a2f9-8db26e83f2bb	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
6dd6b603-ed66-418d-947c-ae29dfe00b6e	31e328af-0472-4281-a2f9-8db26e83f2bb	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
4b7dcc6b-0cad-4925-a184-2643106e5ed6	31e328af-0472-4281-a2f9-8db26e83f2bb	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
72e07a4b-2a9a-4b19-897c-f4648d6efbb2	31e328af-0472-4281-a2f9-8db26e83f2bb	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
6391345c-3f59-45ef-b57e-d95b08cdf832	31e328af-0472-4281-a2f9-8db26e83f2bb	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
7121119a-666d-4d1d-883b-c40dbd5cd665	31e328af-0472-4281-a2f9-8db26e83f2bb	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
aba06db8-24ef-4c21-9560-c259558ebc67	31e328af-0472-4281-a2f9-8db26e83f2bb	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
dcff4abe-07d8-4425-ba23-dbb3bc08c54b	31e328af-0472-4281-a2f9-8db26e83f2bb	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
3a842501-7185-421b-82b9-0e7b652d262b	31e328af-0472-4281-a2f9-8db26e83f2bb	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
46c2d5ca-db33-4554-bfc2-8fc546ebd51a	31e328af-0472-4281-a2f9-8db26e83f2bb	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
c3a797eb-b640-443c-aa57-60e25cefb737	31e328af-0472-4281-a2f9-8db26e83f2bb	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
6d4765f9-1db0-45af-976b-431b518c5477	31e328af-0472-4281-a2f9-8db26e83f2bb	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
821962f9-4d4b-4b9c-947b-1dbcd9f94bc6	31e328af-0472-4281-a2f9-8db26e83f2bb	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a5392972-f9cb-4ea6-8a98-36d0c2988a94	31e328af-0472-4281-a2f9-8db26e83f2bb	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a62a9a2e-2497-45d5-98e1-a92fcba5a529	31e328af-0472-4281-a2f9-8db26e83f2bb	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
8e63e710-76d3-46c7-b957-6eb98228f732	31e328af-0472-4281-a2f9-8db26e83f2bb	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
cb83f11a-1ff9-4b69-ba49-dbb208d85cf3	31e328af-0472-4281-a2f9-8db26e83f2bb	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
1b3ddf5e-1ffe-48c9-bdb7-aca9954143ae	31e328af-0472-4281-a2f9-8db26e83f2bb	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
5bbd8bcf-be78-494d-96c0-ed26492413e7	31e328af-0472-4281-a2f9-8db26e83f2bb	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
d710bca4-9ce7-456f-b1ba-22b00e2d446d	31e328af-0472-4281-a2f9-8db26e83f2bb	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
3d34644a-f02a-4a3d-937a-58f7e0244cb7	31e328af-0472-4281-a2f9-8db26e83f2bb	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
35d658fa-31df-4f00-9dd4-3bbaf6cb0500	31e328af-0472-4281-a2f9-8db26e83f2bb	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
35ba57c0-1ce8-4c9c-a29b-705e3072d6ff	31e328af-0472-4281-a2f9-8db26e83f2bb	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
94fa9c17-52da-4e04-8449-1e4c71df4232	31e328af-0472-4281-a2f9-8db26e83f2bb	14f3b3f5-a555-4dcd-a269-b7132f014a38	Absent	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ad6d4f22-373a-4412-ab43-8ecb971f4e0b	31e328af-0472-4281-a2f9-8db26e83f2bb	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ba74cf32-5694-4455-9075-57ff2f7bf976	31e328af-0472-4281-a2f9-8db26e83f2bb	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
303f3a84-12df-416e-9b45-b0e7d7551efb	31e328af-0472-4281-a2f9-8db26e83f2bb	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
3ab3705e-e933-4a5b-994d-54f304a7dc1b	31e328af-0472-4281-a2f9-8db26e83f2bb	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
4a62c1c7-db90-490f-b295-b3d36c1e3fc8	31e328af-0472-4281-a2f9-8db26e83f2bb	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
0ad78ecf-e7d1-4dc9-aafd-f4958b72c7e3	31e328af-0472-4281-a2f9-8db26e83f2bb	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
0ca45cac-35f8-48c3-82e7-f334dba4ae4d	31e328af-0472-4281-a2f9-8db26e83f2bb	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
51ed3da0-4c88-4f94-a0c5-2ba46379002a	31e328af-0472-4281-a2f9-8db26e83f2bb	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
9a74deb6-22a3-44d2-8e1a-c4df46b18954	31e328af-0472-4281-a2f9-8db26e83f2bb	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
72c4f51f-7686-4755-b49b-c899e24d4018	31e328af-0472-4281-a2f9-8db26e83f2bb	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
59571819-3048-4dd4-84a4-7dd0c7a52e9b	31e328af-0472-4281-a2f9-8db26e83f2bb	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Absent	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a065b4ca-1939-44f9-ae33-3f6e3fb5748c	31e328af-0472-4281-a2f9-8db26e83f2bb	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
1a77303e-fed2-4484-a4b4-3265ca47a66f	502755cd-0595-4ac7-8dba-eb20ac1f69a6	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
5e087483-3704-4dc6-84b8-e5a89f52fed3	502755cd-0595-4ac7-8dba-eb20ac1f69a6	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
daba3af5-ee1e-406d-bdd2-6686299192a5	502755cd-0595-4ac7-8dba-eb20ac1f69a6	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
4a1b4f02-8c56-45e8-bc8f-fc5b090ec80a	502755cd-0595-4ac7-8dba-eb20ac1f69a6	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a42ee9dd-b6a3-4eb6-8f4c-c996cc047876	502755cd-0595-4ac7-8dba-eb20ac1f69a6	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
2d456b1b-82ac-4aac-97ea-7d921dd3f8f4	502755cd-0595-4ac7-8dba-eb20ac1f69a6	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ac231783-0341-484d-8732-834416f79567	502755cd-0595-4ac7-8dba-eb20ac1f69a6	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
4b520506-2ffd-4114-9d5c-33656549865e	502755cd-0595-4ac7-8dba-eb20ac1f69a6	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
9cb200fe-d48b-41c8-83e2-20195a02b923	502755cd-0595-4ac7-8dba-eb20ac1f69a6	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
3d2fdc4e-4d89-4921-ba91-97f7ad330fa0	502755cd-0595-4ac7-8dba-eb20ac1f69a6	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
5faa1d6d-77a5-4bf4-b17e-d8010d9e710a	502755cd-0595-4ac7-8dba-eb20ac1f69a6	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ded33e2e-333e-435d-9159-f572091bc153	502755cd-0595-4ac7-8dba-eb20ac1f69a6	14f3b3f5-a555-4dcd-a269-b7132f014a38	Absent	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
62bd0534-38a1-4740-9e7a-83cb98a35f10	502755cd-0595-4ac7-8dba-eb20ac1f69a6	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
5b92b578-100b-4081-9f9e-b8e879377928	502755cd-0595-4ac7-8dba-eb20ac1f69a6	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a86577e3-b36e-4582-95ee-40c7086e5493	502755cd-0595-4ac7-8dba-eb20ac1f69a6	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
703e0c1a-58a8-4aeb-aa6c-9a29d3d9c733	502755cd-0595-4ac7-8dba-eb20ac1f69a6	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
bea9a70f-ac48-413c-811a-55516fbd2b91	502755cd-0595-4ac7-8dba-eb20ac1f69a6	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
94fa085d-0149-4f48-9ecb-2e6d6e40b65f	502755cd-0595-4ac7-8dba-eb20ac1f69a6	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
120a1945-01c9-4d50-8c66-dba9f4b3aa01	502755cd-0595-4ac7-8dba-eb20ac1f69a6	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Absent	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
7926c514-394a-4984-9cb7-d884f6eba7b8	502755cd-0595-4ac7-8dba-eb20ac1f69a6	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
5542920f-7e06-45eb-a6a1-c7e57f143bc0	502755cd-0595-4ac7-8dba-eb20ac1f69a6	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a211fbfd-2d43-4d49-a972-06674158f9f4	502755cd-0595-4ac7-8dba-eb20ac1f69a6	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ef5a11f2-9ae3-457c-87f0-86c6f903c8a4	502755cd-0595-4ac7-8dba-eb20ac1f69a6	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
6948f100-a25b-4916-a919-a7d9855f5e35	502755cd-0595-4ac7-8dba-eb20ac1f69a6	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
22a20362-7212-4041-9e9e-7b037a0b06c6	502755cd-0595-4ac7-8dba-eb20ac1f69a6	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
7b0995e6-eddc-46a0-b6f9-08187e9dab12	502755cd-0595-4ac7-8dba-eb20ac1f69a6	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
186c0f59-eaf7-42b1-a8e0-6296451c11c4	502755cd-0595-4ac7-8dba-eb20ac1f69a6	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
840bef41-5e1d-4886-9512-77aa94574b9a	502755cd-0595-4ac7-8dba-eb20ac1f69a6	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
94f61252-941f-4291-9501-4f867e75c9c8	502755cd-0595-4ac7-8dba-eb20ac1f69a6	68a2f603-7b91-4404-8fc0-79e611113f89	Absent	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
6d5ef270-e360-40c8-9935-8e181e3281cf	502755cd-0595-4ac7-8dba-eb20ac1f69a6	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a6df8276-25e6-419a-a863-6f6fd5460e10	502755cd-0595-4ac7-8dba-eb20ac1f69a6	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b6239c76-25f4-4f77-ad32-ce0dd5cf9402	502755cd-0595-4ac7-8dba-eb20ac1f69a6	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
c261d530-45ce-4d45-b16b-63caa9833e04	502755cd-0595-4ac7-8dba-eb20ac1f69a6	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
11bd5975-531e-4ccb-83d5-ae4f5ae01771	502755cd-0595-4ac7-8dba-eb20ac1f69a6	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ef60f8d9-32d6-4d5b-86af-c26a15ebc8a2	502755cd-0595-4ac7-8dba-eb20ac1f69a6	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
58c07b07-9ec4-477d-8954-2fe10fa5a047	502755cd-0595-4ac7-8dba-eb20ac1f69a6	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
19a77a2c-cd07-49c6-b279-70336914f002	502755cd-0595-4ac7-8dba-eb20ac1f69a6	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a8e2c9bf-5afd-431e-afbd-80c3f7a7518b	502755cd-0595-4ac7-8dba-eb20ac1f69a6	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f342a371-f406-425e-8f3d-22029f346396	502755cd-0595-4ac7-8dba-eb20ac1f69a6	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
7972fba3-6d09-47eb-af74-6d32a955e1e1	502755cd-0595-4ac7-8dba-eb20ac1f69a6	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b42a7192-1f75-4dbf-a91e-cecf8363e5ba	502755cd-0595-4ac7-8dba-eb20ac1f69a6	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
fc5c2878-45b5-494d-a5a4-772838a44f70	502755cd-0595-4ac7-8dba-eb20ac1f69a6	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
7c564d6c-fd9e-4c91-88fb-8ef620b9abc8	502755cd-0595-4ac7-8dba-eb20ac1f69a6	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
0206ea10-d8e2-4387-b3d9-d264bef1db75	502755cd-0595-4ac7-8dba-eb20ac1f69a6	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f7c202f5-d83a-4bfc-9d14-a6028176a558	502755cd-0595-4ac7-8dba-eb20ac1f69a6	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a76af655-bcf3-425d-901e-a455bd4e9d82	502755cd-0595-4ac7-8dba-eb20ac1f69a6	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
953b9721-87aa-47fb-ba35-02422b67e1a5	502755cd-0595-4ac7-8dba-eb20ac1f69a6	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Absent	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
8e854f28-38d0-45fd-b3b8-052e3d1f6347	502755cd-0595-4ac7-8dba-eb20ac1f69a6	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
2cd21830-12bf-49d0-a16a-ec11c9643411	502755cd-0595-4ac7-8dba-eb20ac1f69a6	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
eb9bd79d-3e98-4481-ac70-e73615755c9a	502755cd-0595-4ac7-8dba-eb20ac1f69a6	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
3a817f22-12b1-4a21-80f7-2a146c08523c	502755cd-0595-4ac7-8dba-eb20ac1f69a6	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Absent	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
149a65c8-1c0f-4247-a86b-b37895b0568e	502755cd-0595-4ac7-8dba-eb20ac1f69a6	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
10424f93-a184-431b-b65c-109b47e37a83	502755cd-0595-4ac7-8dba-eb20ac1f69a6	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
9c37e004-249e-4cb7-85f8-d57010055429	502755cd-0595-4ac7-8dba-eb20ac1f69a6	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
1432b078-119f-4891-899f-5389fd080794	502755cd-0595-4ac7-8dba-eb20ac1f69a6	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ab3c4149-9aad-464b-ac5f-be74ec2a364c	502755cd-0595-4ac7-8dba-eb20ac1f69a6	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b7877291-7757-4280-8757-58f290b7a27e	502755cd-0595-4ac7-8dba-eb20ac1f69a6	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
541a76ce-515d-4215-ace5-09e7a2da98f7	502755cd-0595-4ac7-8dba-eb20ac1f69a6	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
6a348c89-9eeb-43b9-ab34-107d777dc0ea	502755cd-0595-4ac7-8dba-eb20ac1f69a6	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
2b02fa1b-1089-4250-b54e-b8235b7526cb	502755cd-0595-4ac7-8dba-eb20ac1f69a6	14f3b3f5-a555-4dcd-a269-b7132f014a38	Absent	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
71324d34-c7c6-42fc-9963-2f303af6d293	502755cd-0595-4ac7-8dba-eb20ac1f69a6	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
82d50346-b380-4f53-bc7a-b6c03dae7d05	502755cd-0595-4ac7-8dba-eb20ac1f69a6	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
3f5f3599-1b3d-491f-8ac3-78009874bc18	502755cd-0595-4ac7-8dba-eb20ac1f69a6	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
6f01934b-66fd-4418-ac4b-f676babca7f0	502755cd-0595-4ac7-8dba-eb20ac1f69a6	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
88d315f4-be51-4a41-870a-fdbc8abfaa9e	502755cd-0595-4ac7-8dba-eb20ac1f69a6	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f35ba525-ebe3-4b77-a4a8-1d8c05108006	502755cd-0595-4ac7-8dba-eb20ac1f69a6	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
4e0cab0c-4d5a-4cdf-a481-09c53fb22def	502755cd-0595-4ac7-8dba-eb20ac1f69a6	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
73bb8986-d288-4b30-8d97-a449eec7daef	502755cd-0595-4ac7-8dba-eb20ac1f69a6	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
4e99955d-51fc-4273-997e-7efb067b6523	502755cd-0595-4ac7-8dba-eb20ac1f69a6	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
764fb529-38f8-4d9b-b9ad-d6ed4525b943	502755cd-0595-4ac7-8dba-eb20ac1f69a6	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
790f0dee-8377-4177-aa9e-8c09f04b0525	502755cd-0595-4ac7-8dba-eb20ac1f69a6	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
788f47b5-8fcd-4026-8935-b4abb6d4bfff	502755cd-0595-4ac7-8dba-eb20ac1f69a6	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
6cf43b43-a031-485e-86f9-b8d525466c91	502755cd-0595-4ac7-8dba-eb20ac1f69a6	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
d5e10973-216a-4099-8d59-8ce2ad258ae5	502755cd-0595-4ac7-8dba-eb20ac1f69a6	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
1da48066-9a57-4b08-9353-b67a08935913	502755cd-0595-4ac7-8dba-eb20ac1f69a6	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
289eb733-3ba0-444f-9431-566cf77593fd	502755cd-0595-4ac7-8dba-eb20ac1f69a6	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
c7678014-f227-4ea4-aecc-ca0f6b83cf38	502755cd-0595-4ac7-8dba-eb20ac1f69a6	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
aff80b59-d492-4aba-ac10-d20cc7403032	502755cd-0595-4ac7-8dba-eb20ac1f69a6	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
fc28cb3c-8faf-44ea-b16c-714d3af34a6a	502755cd-0595-4ac7-8dba-eb20ac1f69a6	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
4b27a629-2bc3-418e-9010-a5c49bc2d2e9	502755cd-0595-4ac7-8dba-eb20ac1f69a6	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
30dcf934-bbaf-4189-8631-2568aba99b55	502755cd-0595-4ac7-8dba-eb20ac1f69a6	68a2f603-7b91-4404-8fc0-79e611113f89	Absent	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
7d6dbb7c-58d6-4397-8d88-d2f814b19b9c	502755cd-0595-4ac7-8dba-eb20ac1f69a6	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
fd423629-e860-47e2-9958-f4d05b7b5277	502755cd-0595-4ac7-8dba-eb20ac1f69a6	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
d8c062cf-0ecd-4320-a2cc-c8edbee27457	502755cd-0595-4ac7-8dba-eb20ac1f69a6	14f3b3f5-a555-4dcd-a269-b7132f014a38	Absent	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e2f8eba9-79be-454b-8f5d-d80bd5685639	f65d5767-5fed-4aa5-9a94-739006d87bb2	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
c3ea5d7a-b801-4a8a-8908-4e999ddc918e	f65d5767-5fed-4aa5-9a94-739006d87bb2	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
cde17a9d-4fa5-473a-a79a-56d8f307febd	f65d5767-5fed-4aa5-9a94-739006d87bb2	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
0438a6e2-7df2-4a68-8991-87af4112513b	f65d5767-5fed-4aa5-9a94-739006d87bb2	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
50d4d3ce-163c-42bd-b8ea-636224233aa7	f65d5767-5fed-4aa5-9a94-739006d87bb2	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
eeda599f-d591-4691-bb4e-48d35cd3b4a8	f65d5767-5fed-4aa5-9a94-739006d87bb2	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
82ba3ac8-7994-490b-bc29-079ca11da074	f65d5767-5fed-4aa5-9a94-739006d87bb2	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e7147346-b67a-43bb-95e2-f888616a0e64	f65d5767-5fed-4aa5-9a94-739006d87bb2	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
eca0defb-2a1d-44a4-a5d2-d0bd22fcb6bd	f65d5767-5fed-4aa5-9a94-739006d87bb2	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
60b4ce5b-3d9c-475c-8c2f-9e8d368f5da9	f65d5767-5fed-4aa5-9a94-739006d87bb2	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
26623fe6-40d5-4d10-821e-b63bcfa1d845	f65d5767-5fed-4aa5-9a94-739006d87bb2	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
5a794dc6-abff-4e43-afb4-a42b304921fc	f65d5767-5fed-4aa5-9a94-739006d87bb2	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
cbe783d3-d22a-454d-a17d-b09eb65d6a66	f65d5767-5fed-4aa5-9a94-739006d87bb2	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
941e0845-b672-4e1a-99cc-c9ba2e3b6227	f65d5767-5fed-4aa5-9a94-739006d87bb2	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
d3d85d8d-594d-45d3-85e1-d85c10dc1866	f65d5767-5fed-4aa5-9a94-739006d87bb2	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
abb7055b-1d8c-40f3-b248-870412bd8791	f65d5767-5fed-4aa5-9a94-739006d87bb2	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
8fe904f4-ec07-474c-87dd-e830b9ba55ca	f65d5767-5fed-4aa5-9a94-739006d87bb2	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
891f6346-08c8-447c-af34-c8afb645a0f4	f65d5767-5fed-4aa5-9a94-739006d87bb2	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
dadd3454-74bf-4b2a-9b26-43bdd8374345	f65d5767-5fed-4aa5-9a94-739006d87bb2	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
2476b658-2ff0-4413-b4f0-fe11c66b950e	f65d5767-5fed-4aa5-9a94-739006d87bb2	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
7425501f-6cd1-48de-8cd8-be52241967bf	f65d5767-5fed-4aa5-9a94-739006d87bb2	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
6ddadf47-6512-456a-b390-fabf0c2360b3	f65d5767-5fed-4aa5-9a94-739006d87bb2	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
02331c8d-e472-4ddc-be7e-663267a4bfe7	f65d5767-5fed-4aa5-9a94-739006d87bb2	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
0bf4fdef-4216-4700-bd7e-c020ffce107f	f65d5767-5fed-4aa5-9a94-739006d87bb2	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
67accf5f-4adc-442a-8b95-584ee3391168	f65d5767-5fed-4aa5-9a94-739006d87bb2	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f37a9e74-1c3f-4cb7-bf85-9be9270c341d	f65d5767-5fed-4aa5-9a94-739006d87bb2	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e5254904-1c24-4453-96de-48486bc7087d	f65d5767-5fed-4aa5-9a94-739006d87bb2	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
1b30cc0a-3161-4122-b0c6-6fc734091cce	f65d5767-5fed-4aa5-9a94-739006d87bb2	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
35c8f023-3aa7-4a6a-ac30-5c0a08bcc382	f65d5767-5fed-4aa5-9a94-739006d87bb2	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
8a8cc5e5-e43a-42b7-ab9c-662946e5ca05	f65d5767-5fed-4aa5-9a94-739006d87bb2	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
725d2a03-bd0a-4b88-8142-419f2d87366b	f65d5767-5fed-4aa5-9a94-739006d87bb2	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f478d52a-af94-4044-8933-d99bff735654	f65d5767-5fed-4aa5-9a94-739006d87bb2	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
15bcf356-5ded-44cd-b486-90d79022a4e0	f65d5767-5fed-4aa5-9a94-739006d87bb2	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a2b32b9a-afdc-4dc3-b4bc-ca827c3a2d6a	f65d5767-5fed-4aa5-9a94-739006d87bb2	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
2263eb65-221a-4103-a6df-70d5d06f0a8a	f65d5767-5fed-4aa5-9a94-739006d87bb2	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
fb5e5297-d12a-4720-aa8c-21f4d1ee2869	f65d5767-5fed-4aa5-9a94-739006d87bb2	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
4f3f9419-91eb-4193-b8a5-b64660f0148f	f65d5767-5fed-4aa5-9a94-739006d87bb2	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
58c69a9f-e7e2-4704-a10e-00cf19b7e0c7	f65d5767-5fed-4aa5-9a94-739006d87bb2	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
7d5bf877-0811-4687-bd93-908a01937ea3	f65d5767-5fed-4aa5-9a94-739006d87bb2	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
9df94ca4-9234-4090-b2a9-94089807b289	f65d5767-5fed-4aa5-9a94-739006d87bb2	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
30a84fe3-94dc-44ab-b95f-43a2ead98a91	f65d5767-5fed-4aa5-9a94-739006d87bb2	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ebd5ac56-43fa-4c06-8f3d-b565b2bcd88b	f65d5767-5fed-4aa5-9a94-739006d87bb2	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e77a4a02-33a1-4bb7-9d93-e7d9cda99ca3	f65d5767-5fed-4aa5-9a94-739006d87bb2	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
918f0c00-8e52-4ab1-a50c-38556e54dced	f65d5767-5fed-4aa5-9a94-739006d87bb2	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
aa9e69c9-8293-4e75-aa80-419809a0ca1a	f65d5767-5fed-4aa5-9a94-739006d87bb2	68a2f603-7b91-4404-8fc0-79e611113f89	Absent	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
8d77499b-ebcb-402d-bba1-11a2280f9408	f65d5767-5fed-4aa5-9a94-739006d87bb2	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
056cad52-9a25-4669-b03a-c7c49b960f18	f65d5767-5fed-4aa5-9a94-739006d87bb2	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
089c6962-bbb1-43c5-9660-610af0886b27	f65d5767-5fed-4aa5-9a94-739006d87bb2	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
d7d03556-65c7-4017-a695-d37c00bef1c9	f65d5767-5fed-4aa5-9a94-739006d87bb2	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e69188c9-041e-48bc-8713-d45b1890ce94	f65d5767-5fed-4aa5-9a94-739006d87bb2	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
c7a09610-ab85-467f-b58b-b0cff7a80ea4	f65d5767-5fed-4aa5-9a94-739006d87bb2	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Absent	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
8979608d-e139-4af4-92ea-762080726a7d	f65d5767-5fed-4aa5-9a94-739006d87bb2	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b9db9c48-1dc7-4df5-9a41-f48da7e84194	f65d5767-5fed-4aa5-9a94-739006d87bb2	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
978f7428-cc5e-4f6b-82c9-14ba1c552444	f65d5767-5fed-4aa5-9a94-739006d87bb2	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
75065424-90c7-46d4-a870-a36a7adb42a7	f65d5767-5fed-4aa5-9a94-739006d87bb2	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ab5a8d77-fb58-40dd-9ef8-2c506c930478	f65d5767-5fed-4aa5-9a94-739006d87bb2	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
53d265ff-e4c8-4937-8312-f85ba7653179	f65d5767-5fed-4aa5-9a94-739006d87bb2	68a2f603-7b91-4404-8fc0-79e611113f89	Absent	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
c9d04ea7-9ee7-4135-bdcb-7cb6a1c37190	f65d5767-5fed-4aa5-9a94-739006d87bb2	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
1b5a063a-b897-47ea-8a3c-971853e09e24	f65d5767-5fed-4aa5-9a94-739006d87bb2	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
2ed0c56d-f0a3-4eba-bd7f-e8ef16d6a7fe	f65d5767-5fed-4aa5-9a94-739006d87bb2	14f3b3f5-a555-4dcd-a269-b7132f014a38	Absent	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
954a96ca-4db4-4893-966c-16c5bf534dbe	f65d5767-5fed-4aa5-9a94-739006d87bb2	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
cfeafa8b-8920-410e-bec7-c1f5539eeae8	f65d5767-5fed-4aa5-9a94-739006d87bb2	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f5c1a7a3-abc5-4536-b041-74853c097edb	f65d5767-5fed-4aa5-9a94-739006d87bb2	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
45d05df9-671d-44c1-ad71-11e0497f79ed	f65d5767-5fed-4aa5-9a94-739006d87bb2	14f3b3f5-a555-4dcd-a269-b7132f014a38	Absent	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
6de92695-879e-4ffa-bc8c-3e87a044ed13	f65d5767-5fed-4aa5-9a94-739006d87bb2	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e0e70775-464c-4fe5-9f4e-f14f7949c728	f65d5767-5fed-4aa5-9a94-739006d87bb2	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
69902763-96d0-4d90-8139-e638d664790a	f65d5767-5fed-4aa5-9a94-739006d87bb2	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
129c40f1-36e1-4bef-9131-53d9121c0b1c	f65d5767-5fed-4aa5-9a94-739006d87bb2	14f3b3f5-a555-4dcd-a269-b7132f014a38	Absent	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b1bdd108-a5ca-4982-806d-9e17db54d0ae	f65d5767-5fed-4aa5-9a94-739006d87bb2	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
31b01935-765d-45e4-bb69-06b76bd90b64	f65d5767-5fed-4aa5-9a94-739006d87bb2	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b9f040aa-8e54-4e34-9fa7-a1073d967c14	f65d5767-5fed-4aa5-9a94-739006d87bb2	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
9814cd5b-b8f6-4936-80f1-413771d6e76d	f65d5767-5fed-4aa5-9a94-739006d87bb2	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ae9aa439-3381-4707-8f9b-787126b440f9	f65d5767-5fed-4aa5-9a94-739006d87bb2	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e01151e5-faee-456d-8548-db5ddf2c72a4	f65d5767-5fed-4aa5-9a94-739006d87bb2	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ce703136-e2a7-4d98-9dd6-32566aa7b1a6	f65d5767-5fed-4aa5-9a94-739006d87bb2	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
8190e09a-9662-4066-8f99-b2c4a93943e3	f65d5767-5fed-4aa5-9a94-739006d87bb2	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
da0fe41b-a078-4dac-b148-65bd8e9b12aa	f65d5767-5fed-4aa5-9a94-739006d87bb2	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
7523231a-113a-4187-9726-0297b6ea3b31	f65d5767-5fed-4aa5-9a94-739006d87bb2	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
20879f47-ccb4-485b-bc45-229d4e6ba3df	f65d5767-5fed-4aa5-9a94-739006d87bb2	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
95bd4c3e-8738-40b5-b863-b948586fe537	f65d5767-5fed-4aa5-9a94-739006d87bb2	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f02d2c4f-518e-41c6-ace2-aa8d7d6904b7	f65d5767-5fed-4aa5-9a94-739006d87bb2	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ad4f46f6-b25a-48d4-b5a1-1cc9e017d607	f65d5767-5fed-4aa5-9a94-739006d87bb2	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ef118d35-94fa-4e4b-8a23-5b57a11eda21	f65d5767-5fed-4aa5-9a94-739006d87bb2	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ec0f5dd6-42ef-420e-9c73-0f1c9ab135fc	f65d5767-5fed-4aa5-9a94-739006d87bb2	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
6edd21d8-857c-41c6-a474-62750c9c884b	bc8f862e-ec2c-4c37-b924-c34864013f1c	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
66d3fe60-305a-4883-bfa3-cc529ba7efce	bc8f862e-ec2c-4c37-b924-c34864013f1c	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
713474ca-402e-4121-a5ec-11d5d79bd57e	bc8f862e-ec2c-4c37-b924-c34864013f1c	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
1eb70180-9633-472c-9f5b-9c47984a689e	bc8f862e-ec2c-4c37-b924-c34864013f1c	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
2f4ee27d-15c6-46fe-9259-5f484f79ddc6	bc8f862e-ec2c-4c37-b924-c34864013f1c	68a2f603-7b91-4404-8fc0-79e611113f89	Absent	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b98acc9f-04a2-4763-b577-e8dc959cb289	bc8f862e-ec2c-4c37-b924-c34864013f1c	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
3d2fcf04-c4ae-47ad-9082-018790c7e2c5	bc8f862e-ec2c-4c37-b924-c34864013f1c	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
492b88cb-bc5c-40ac-a7d5-18f052f4fca5	bc8f862e-ec2c-4c37-b924-c34864013f1c	14f3b3f5-a555-4dcd-a269-b7132f014a38	Absent	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
2302d7e4-1766-4211-91ed-78dbe9c10231	bc8f862e-ec2c-4c37-b924-c34864013f1c	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
2a56bfc7-5c33-4777-bab4-abfb7672db17	bc8f862e-ec2c-4c37-b924-c34864013f1c	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
720ff28d-fcd1-40b2-ac44-66e093b64ea3	bc8f862e-ec2c-4c37-b924-c34864013f1c	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
6c842ce0-5b90-4df9-8550-b99d256cf0ff	bc8f862e-ec2c-4c37-b924-c34864013f1c	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a2cade25-7798-457a-9780-e0d0cc0dfdfb	bc8f862e-ec2c-4c37-b924-c34864013f1c	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
3a4439e5-a0e0-48b2-9d5e-398befb6ac17	bc8f862e-ec2c-4c37-b924-c34864013f1c	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
53c9e821-0b8c-4781-bb4a-2f9250ed24c4	bc8f862e-ec2c-4c37-b924-c34864013f1c	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b2693ced-061f-4b3b-a211-8973494db946	bc8f862e-ec2c-4c37-b924-c34864013f1c	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
1515de87-bfc2-401a-a936-20e087f548af	bc8f862e-ec2c-4c37-b924-c34864013f1c	68a2f603-7b91-4404-8fc0-79e611113f89	Absent	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
033f41dc-39cc-4a17-8501-1b414d4420c9	bc8f862e-ec2c-4c37-b924-c34864013f1c	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f5956481-5a0f-4ca6-94bc-ec3d1c8f69bb	bc8f862e-ec2c-4c37-b924-c34864013f1c	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
eb273a51-5cda-4914-a6b4-cdaf318e3eec	bc8f862e-ec2c-4c37-b924-c34864013f1c	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
1f37bd83-d60d-43d7-ad9d-050752b23657	bc8f862e-ec2c-4c37-b924-c34864013f1c	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a7dde2a3-4fe1-4537-9475-bc520fd32cd1	bc8f862e-ec2c-4c37-b924-c34864013f1c	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
5d5d78a5-336d-4f8f-9575-a66ca03819db	bc8f862e-ec2c-4c37-b924-c34864013f1c	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f1abccc7-2c25-4d3b-a8da-52136ae75ebf	bc8f862e-ec2c-4c37-b924-c34864013f1c	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
398d113b-c677-4507-b2c6-c8b15feabff4	bc8f862e-ec2c-4c37-b924-c34864013f1c	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b7f546cf-5fbf-4033-9b71-322adfc6eacf	bc8f862e-ec2c-4c37-b924-c34864013f1c	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
c73b975f-d1fe-40cf-b0a7-a9f61532a942	bc8f862e-ec2c-4c37-b924-c34864013f1c	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e67f7ede-1eb1-4526-a4ea-c0338c64a39e	bc8f862e-ec2c-4c37-b924-c34864013f1c	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ec27e256-18f6-4ba5-8518-bbb6d84039d6	bc8f862e-ec2c-4c37-b924-c34864013f1c	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
6f585e70-903b-4772-88da-7520a2442235	bc8f862e-ec2c-4c37-b924-c34864013f1c	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
0b58b53f-60de-480f-9487-ddd63a8dc695	bc8f862e-ec2c-4c37-b924-c34864013f1c	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e6dcf644-534b-4dc5-9848-02fc722e16ad	bc8f862e-ec2c-4c37-b924-c34864013f1c	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ea85f9c5-7f9f-4d41-958c-d2f6e2a33bd2	bc8f862e-ec2c-4c37-b924-c34864013f1c	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
af809135-9407-4e89-a095-d6179624ef3b	bc8f862e-ec2c-4c37-b924-c34864013f1c	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b5b884eb-91b8-4bf3-9939-d16f7ad1f931	bc8f862e-ec2c-4c37-b924-c34864013f1c	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Absent	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
d6a6d9fc-952d-491e-a7cc-e7fc15cdd076	bc8f862e-ec2c-4c37-b924-c34864013f1c	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ca42f363-8706-49fe-9686-5c9a856a0896	bc8f862e-ec2c-4c37-b924-c34864013f1c	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e051eb80-023f-4809-919b-f3a0c7ac47bf	bc8f862e-ec2c-4c37-b924-c34864013f1c	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
23d39134-68ac-4daa-97fb-a8197363d5a6	bc8f862e-ec2c-4c37-b924-c34864013f1c	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
04ca1448-b662-4f79-a00c-fceb5fe76159	bc8f862e-ec2c-4c37-b924-c34864013f1c	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
967409ca-40e5-4cb3-8f59-c0c462b13812	bc8f862e-ec2c-4c37-b924-c34864013f1c	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
25be16ac-d674-4ce1-b114-c9e2bc047178	bc8f862e-ec2c-4c37-b924-c34864013f1c	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
4b82d4d1-25a0-4d3e-80c8-1ff918aa760a	bc8f862e-ec2c-4c37-b924-c34864013f1c	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
4ad1e11f-e02f-4ca4-b198-740f3a22e78b	bc8f862e-ec2c-4c37-b924-c34864013f1c	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
0fb6cf02-a921-48d1-b287-c0d2284f1c68	bc8f862e-ec2c-4c37-b924-c34864013f1c	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
8014f34c-d8de-40e4-8187-c041472f57d2	bc8f862e-ec2c-4c37-b924-c34864013f1c	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
fd4e7576-25e3-4756-a345-f6e6b552b3e3	bc8f862e-ec2c-4c37-b924-c34864013f1c	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
fbdb9c60-ebb7-4e60-a54b-60602319da49	bc8f862e-ec2c-4c37-b924-c34864013f1c	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
92682959-329d-4857-bcea-b1714882c815	bc8f862e-ec2c-4c37-b924-c34864013f1c	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
51a7ddf7-fb46-4019-83d1-21de6beb4c0d	bc8f862e-ec2c-4c37-b924-c34864013f1c	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b105c347-0322-4cef-8f17-92be968bc273	bc8f862e-ec2c-4c37-b924-c34864013f1c	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
6203804b-77eb-4fc6-8d37-297a1650db16	bc8f862e-ec2c-4c37-b924-c34864013f1c	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f955f5b1-86fe-472f-97c2-3924c1e2bea7	bc8f862e-ec2c-4c37-b924-c34864013f1c	68a2f603-7b91-4404-8fc0-79e611113f89	Absent	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
50cab85b-9ba4-49ef-8a8b-bff28dbb1551	bc8f862e-ec2c-4c37-b924-c34864013f1c	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
7e76a2c0-63a0-46b1-8d73-c7592ed4c682	bc8f862e-ec2c-4c37-b924-c34864013f1c	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
4d475888-cacd-4c64-8d0b-eb84b0a0f347	bc8f862e-ec2c-4c37-b924-c34864013f1c	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
bd8a5726-f03d-4011-b370-32482f256f6d	bc8f862e-ec2c-4c37-b924-c34864013f1c	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
2fe7d683-e963-4467-a4da-623fc623ce62	bc8f862e-ec2c-4c37-b924-c34864013f1c	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
0dfee7a9-1636-498d-bdc6-a3d21de8dda4	bc8f862e-ec2c-4c37-b924-c34864013f1c	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
81e7dcec-0a76-4c88-8543-deabda95909c	bc8f862e-ec2c-4c37-b924-c34864013f1c	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
0b1a6fc7-2cec-4410-b78d-9c14dd1f94bf	bc8f862e-ec2c-4c37-b924-c34864013f1c	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
8251dc4b-1847-4861-b70a-4a6d4379fce3	bc8f862e-ec2c-4c37-b924-c34864013f1c	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a60d6679-dbbe-4c66-9f17-f9dc8f3b9285	bc8f862e-ec2c-4c37-b924-c34864013f1c	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b34b6334-978b-4e10-9e6f-d95d1e512fcb	bc8f862e-ec2c-4c37-b924-c34864013f1c	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
9bda44cc-57b7-449b-95c4-45cdc6fbfaa1	bc8f862e-ec2c-4c37-b924-c34864013f1c	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ae63e843-2e09-4593-8b5a-1467cb6d1bc1	bc8f862e-ec2c-4c37-b924-c34864013f1c	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
3e965f98-3e76-4931-9f71-bcba66f535a3	bc8f862e-ec2c-4c37-b924-c34864013f1c	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a434d903-caeb-41fd-9d2c-e7b4ad36762e	bc8f862e-ec2c-4c37-b924-c34864013f1c	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
6bcffcf3-232e-4036-8307-6e3efe9ef483	bc8f862e-ec2c-4c37-b924-c34864013f1c	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
cb235689-00db-4d9d-8366-4ea3e694b63f	bc8f862e-ec2c-4c37-b924-c34864013f1c	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
844dc705-92ad-41e9-98a6-08a6b7ca4c9b	bc8f862e-ec2c-4c37-b924-c34864013f1c	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
3ee3c3bd-1c6c-42e3-9c22-92b320d84d59	bc8f862e-ec2c-4c37-b924-c34864013f1c	14f3b3f5-a555-4dcd-a269-b7132f014a38	Absent	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f62dc3e6-dc88-465d-aa10-5ed2ea9c635a	bc8f862e-ec2c-4c37-b924-c34864013f1c	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f33caf9e-2c39-4246-b828-8e6b45deb05f	bc8f862e-ec2c-4c37-b924-c34864013f1c	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
87792da9-0bb3-4061-83a1-3425af4146f2	bc8f862e-ec2c-4c37-b924-c34864013f1c	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
2f980cbc-1ed4-426f-a1d0-198109ac315a	bc8f862e-ec2c-4c37-b924-c34864013f1c	14f3b3f5-a555-4dcd-a269-b7132f014a38	Absent	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
fb529fb1-f1fe-4749-b382-36ecaab567ec	bc8f862e-ec2c-4c37-b924-c34864013f1c	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
41283ab9-c8e0-48f8-8df6-e68f2da265f0	bc8f862e-ec2c-4c37-b924-c34864013f1c	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
2eea0e08-795e-4f0b-b214-57302cb010d5	bc8f862e-ec2c-4c37-b924-c34864013f1c	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ea12fe44-c0b5-49e1-b985-3fc8e5d7d8e8	bc8f862e-ec2c-4c37-b924-c34864013f1c	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
114e881b-d01b-4c35-b046-0d78eaf417c2	bc8f862e-ec2c-4c37-b924-c34864013f1c	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
707f0998-cf6f-49cc-be5d-d95fd13ff4ac	bc8f862e-ec2c-4c37-b924-c34864013f1c	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
8a56923e-4173-4ef5-8d32-e835ac03c9f1	bc8f862e-ec2c-4c37-b924-c34864013f1c	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
fad7c1cc-d4e1-4dba-8efb-b75dbf9dc60a	bc8f862e-ec2c-4c37-b924-c34864013f1c	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
55f370c9-f458-4449-8043-c24a2c9f34c4	380e4e1d-f169-474c-812b-d9a157b98930	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
31b9f0c9-6ff7-4b97-aca2-06710385693d	380e4e1d-f169-474c-812b-d9a157b98930	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
1a71cb82-04e7-44b6-94d5-1738c0f23b4f	380e4e1d-f169-474c-812b-d9a157b98930	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a278f679-c230-4ffa-9768-ce395ec30316	380e4e1d-f169-474c-812b-d9a157b98930	14f3b3f5-a555-4dcd-a269-b7132f014a38	Absent	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b2652a00-d889-41b4-bc6e-da21420dc9ed	380e4e1d-f169-474c-812b-d9a157b98930	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
c3ddfe63-0655-4e99-9c37-68d459c8c014	380e4e1d-f169-474c-812b-d9a157b98930	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
0ad0e23c-0167-4837-8250-c6e475bbf6e6	380e4e1d-f169-474c-812b-d9a157b98930	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
4b8ce6fc-f4ba-48e5-a41c-159d9ad55667	380e4e1d-f169-474c-812b-d9a157b98930	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e06715ed-e0b4-4450-a3b5-804d03602f4d	380e4e1d-f169-474c-812b-d9a157b98930	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
4bde2d5a-bff7-4232-86b3-0a6d88e0715b	380e4e1d-f169-474c-812b-d9a157b98930	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b37d0bcc-081d-43a6-943f-630d2aaaf99d	380e4e1d-f169-474c-812b-d9a157b98930	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
3952af64-f9cb-4041-8d37-c4c279c573e3	380e4e1d-f169-474c-812b-d9a157b98930	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
97051790-370b-41f4-ba15-e35034375a1f	380e4e1d-f169-474c-812b-d9a157b98930	68a2f603-7b91-4404-8fc0-79e611113f89	Absent	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b6951a24-94d2-48b4-980a-4facaaf7fc13	380e4e1d-f169-474c-812b-d9a157b98930	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
3219db9b-68ff-4c5e-a8db-0828bd64398a	380e4e1d-f169-474c-812b-d9a157b98930	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
4d0e3bf8-4ab4-4ea4-adf2-9e136f92019e	380e4e1d-f169-474c-812b-d9a157b98930	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
eded674b-d170-447b-962b-6178755336ee	380e4e1d-f169-474c-812b-d9a157b98930	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
332beadd-9724-4d39-b3ed-9bc5e3382eee	380e4e1d-f169-474c-812b-d9a157b98930	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
d1199e81-c2f5-4f0d-95c7-f950408fd994	380e4e1d-f169-474c-812b-d9a157b98930	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
809fae03-941c-49ad-9a71-2f8a614d8e91	380e4e1d-f169-474c-812b-d9a157b98930	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
54e6754d-c8a5-478b-bac4-010831cd0745	380e4e1d-f169-474c-812b-d9a157b98930	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
4aa368c7-f0c8-4ad3-9833-e1549b2de816	380e4e1d-f169-474c-812b-d9a157b98930	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
8e60a131-1633-46aa-94da-c2783848d666	380e4e1d-f169-474c-812b-d9a157b98930	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
53172f12-5c20-44c9-8268-a98d46118dc3	380e4e1d-f169-474c-812b-d9a157b98930	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b22fe335-be01-4f88-8c1d-e7bf6d2d285d	380e4e1d-f169-474c-812b-d9a157b98930	68a2f603-7b91-4404-8fc0-79e611113f89	Absent	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
bea074cd-8184-4fe3-a55a-0686cbffafc5	380e4e1d-f169-474c-812b-d9a157b98930	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ccc2017a-4f77-4b9b-93e3-d62ba32a666e	380e4e1d-f169-474c-812b-d9a157b98930	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
c5948be4-b1aa-4aec-99a6-229add13fb1b	380e4e1d-f169-474c-812b-d9a157b98930	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b0aad56a-af1d-4dd8-a78f-45f9a606575d	380e4e1d-f169-474c-812b-d9a157b98930	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
03e30582-3571-45c7-aedb-357794ea7cb3	380e4e1d-f169-474c-812b-d9a157b98930	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
747cf23b-b1ac-495c-b74d-b9aec5cb4297	380e4e1d-f169-474c-812b-d9a157b98930	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
70c7c8d3-2976-4cab-96d7-98a3dcc084c4	380e4e1d-f169-474c-812b-d9a157b98930	14f3b3f5-a555-4dcd-a269-b7132f014a38	Absent	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
76a9ff39-04d1-413e-b984-ab6c80455385	380e4e1d-f169-474c-812b-d9a157b98930	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
76e45dd2-022c-4765-be84-2c98eb231e57	380e4e1d-f169-474c-812b-d9a157b98930	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
4f0cbabb-a967-495b-b77f-a6cb63ce8c34	380e4e1d-f169-474c-812b-d9a157b98930	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
c3d9a9bc-9d14-4c1d-bd77-88fff27f7aca	380e4e1d-f169-474c-812b-d9a157b98930	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
eb4b8969-dddf-4a3b-ae6d-6b2f7d5218a2	380e4e1d-f169-474c-812b-d9a157b98930	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
fb29ab8d-ab55-405e-82b6-fc3907123136	380e4e1d-f169-474c-812b-d9a157b98930	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
99c05525-8882-46ec-8534-4b53b53b1e09	380e4e1d-f169-474c-812b-d9a157b98930	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Absent	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e7bafcde-eb9f-481f-8436-945250e23597	380e4e1d-f169-474c-812b-d9a157b98930	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
78fbae9a-a575-4a8f-a64d-6d69f84b8e6d	380e4e1d-f169-474c-812b-d9a157b98930	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a3199f7b-2298-4f21-9b11-4f516cbd79fb	380e4e1d-f169-474c-812b-d9a157b98930	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
2f08f473-6c35-4e20-8389-69a301c2317b	380e4e1d-f169-474c-812b-d9a157b98930	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
071df634-5f44-477e-8eb6-d72528db249d	380e4e1d-f169-474c-812b-d9a157b98930	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f915f375-b005-4d43-8b11-3bd45a8c5672	380e4e1d-f169-474c-812b-d9a157b98930	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
07bc66b4-78ae-4e51-a32f-04228d8fb512	380e4e1d-f169-474c-812b-d9a157b98930	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
c38df5c8-abd9-4fc5-85a9-2164c3ea41cf	380e4e1d-f169-474c-812b-d9a157b98930	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
44c3d37e-f51c-4002-8d6d-02566c62196c	380e4e1d-f169-474c-812b-d9a157b98930	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
6d344cc9-8a7d-422f-a9fe-83b10bd5af0a	380e4e1d-f169-474c-812b-d9a157b98930	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
3bf73d4e-3fc5-420d-84d9-bb35ab9c76ae	380e4e1d-f169-474c-812b-d9a157b98930	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
1af8819c-86d0-4183-85ba-1fadf67e0f13	380e4e1d-f169-474c-812b-d9a157b98930	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
fa4e1e71-55ad-4b6a-8314-a062aafee9ac	380e4e1d-f169-474c-812b-d9a157b98930	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
829e776f-a4a6-421d-a5b0-d2d5e3750b4e	380e4e1d-f169-474c-812b-d9a157b98930	68a2f603-7b91-4404-8fc0-79e611113f89	Absent	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
0d0b666f-c405-4f83-8c84-ab17c9f44bd7	380e4e1d-f169-474c-812b-d9a157b98930	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
919240c5-a6b2-4b0d-a408-ca293870e076	380e4e1d-f169-474c-812b-d9a157b98930	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e659e484-462a-4611-981e-68cfe89f3102	380e4e1d-f169-474c-812b-d9a157b98930	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e85fc9f7-a8e8-4610-9d85-00c337d640e0	380e4e1d-f169-474c-812b-d9a157b98930	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
d5b43a2e-2be2-4f05-b68e-ffa0443d8d59	380e4e1d-f169-474c-812b-d9a157b98930	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
7f766024-00fd-48d3-ab63-e283349dd1fa	380e4e1d-f169-474c-812b-d9a157b98930	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
5b22823e-5f9d-4ad0-975b-368c550062f4	380e4e1d-f169-474c-812b-d9a157b98930	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ea3b9e92-087e-40af-a16d-b1cb3be19e6c	380e4e1d-f169-474c-812b-d9a157b98930	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
17d5fee8-082d-45bd-a99a-260ea605e0c4	380e4e1d-f169-474c-812b-d9a157b98930	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
7069b54b-d2d7-4f37-91fa-d5baa8ddc0b6	380e4e1d-f169-474c-812b-d9a157b98930	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
732faf50-76e7-4017-9937-f02e0061385b	380e4e1d-f169-474c-812b-d9a157b98930	14f3b3f5-a555-4dcd-a269-b7132f014a38	Absent	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
50bda256-943c-461d-95cb-b812749e519d	380e4e1d-f169-474c-812b-d9a157b98930	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
404e86c6-cff6-43ec-82fa-80c7f78debf3	380e4e1d-f169-474c-812b-d9a157b98930	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a81b4109-0272-47bc-8f25-745c94f114f5	380e4e1d-f169-474c-812b-d9a157b98930	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
443f8c18-fe98-4d1c-965e-5a2a245717be	380e4e1d-f169-474c-812b-d9a157b98930	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e17d4921-cd00-4ba9-a41b-1792af7caeeb	380e4e1d-f169-474c-812b-d9a157b98930	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
294c5689-457f-4979-bfb7-ae954ef97b25	380e4e1d-f169-474c-812b-d9a157b98930	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
d8842bcb-48fe-4e55-bb5b-46bee325b530	380e4e1d-f169-474c-812b-d9a157b98930	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e24c1366-4609-4388-a229-0b518ad5d0ee	380e4e1d-f169-474c-812b-d9a157b98930	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
c4948cb6-21af-4cfd-84b0-710b70774bba	380e4e1d-f169-474c-812b-d9a157b98930	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
90898508-02a2-4766-bfad-2da401ed4f85	380e4e1d-f169-474c-812b-d9a157b98930	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
37eba41a-48a9-4490-9928-d9e5619e1f14	380e4e1d-f169-474c-812b-d9a157b98930	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f03ff902-98d0-433b-9224-80f8084cbcd5	380e4e1d-f169-474c-812b-d9a157b98930	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e936ebbe-ae7c-418e-bf28-f30d4d29751e	380e4e1d-f169-474c-812b-d9a157b98930	68a2f603-7b91-4404-8fc0-79e611113f89	Absent	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
c5ef1099-fb36-471e-90ad-64f3dd095b1a	380e4e1d-f169-474c-812b-d9a157b98930	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
87e09123-cf94-409b-8f58-9e7352eebb7c	380e4e1d-f169-474c-812b-d9a157b98930	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
764bf9ff-70f3-41c3-bd64-40be85d2bd9d	380e4e1d-f169-474c-812b-d9a157b98930	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
6cebf87e-240a-416f-8140-281ec9c77510	380e4e1d-f169-474c-812b-d9a157b98930	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b3994235-517c-4829-bd68-a3f58fd3e434	380e4e1d-f169-474c-812b-d9a157b98930	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f0f5c944-a3e7-45c8-8a7a-f12778be26e7	380e4e1d-f169-474c-812b-d9a157b98930	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
4680cca2-d3df-4fca-a799-13f050b58ce4	380e4e1d-f169-474c-812b-d9a157b98930	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
c9cb695d-292b-4e94-b60c-dcccfb1c0568	39259dfa-72e0-4568-b6ae-7beb2b01b10f	68a2f603-7b91-4404-8fc0-79e611113f89	Absent	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ee3077d9-778a-40c8-af76-3b131e6086b2	39259dfa-72e0-4568-b6ae-7beb2b01b10f	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
4a8d0c3c-1128-4e02-8ee7-10030f26de90	39259dfa-72e0-4568-b6ae-7beb2b01b10f	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
9f480531-262b-4670-9c96-ce3c6a9f9407	39259dfa-72e0-4568-b6ae-7beb2b01b10f	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
c8b12c3f-8de3-4165-bfa5-ebbd9f916183	39259dfa-72e0-4568-b6ae-7beb2b01b10f	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
deff4969-68e0-4e5a-8b4d-6b6f61e20f64	39259dfa-72e0-4568-b6ae-7beb2b01b10f	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e97e3090-17c8-4811-aae3-d02044a9c9c3	39259dfa-72e0-4568-b6ae-7beb2b01b10f	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f25614c6-33b2-460f-abf0-fe25e8b1caff	39259dfa-72e0-4568-b6ae-7beb2b01b10f	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
442dbbc7-0711-4f40-8071-3b391cea9a56	39259dfa-72e0-4568-b6ae-7beb2b01b10f	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
48d4d429-8b00-4e7d-9fae-aee6ea92bb85	39259dfa-72e0-4568-b6ae-7beb2b01b10f	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
7781cbfc-128a-4f25-a4da-10dff2c4b72e	39259dfa-72e0-4568-b6ae-7beb2b01b10f	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
14973bdd-535f-435a-948c-2ce26536039b	39259dfa-72e0-4568-b6ae-7beb2b01b10f	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
09c20573-cf63-4a16-8308-49f64a1dca27	39259dfa-72e0-4568-b6ae-7beb2b01b10f	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
77117de5-9a52-4da2-91da-551bee0fa71f	39259dfa-72e0-4568-b6ae-7beb2b01b10f	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
9a8e576d-dea2-4ae3-b4c5-2c31c1257967	39259dfa-72e0-4568-b6ae-7beb2b01b10f	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e7e9a335-8a40-4042-890b-add2f7163e94	39259dfa-72e0-4568-b6ae-7beb2b01b10f	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
63571bcb-ecd6-4d52-bce8-1e814a163311	39259dfa-72e0-4568-b6ae-7beb2b01b10f	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
de8a06bc-9d99-46ba-b10f-eee7cc3cafd0	39259dfa-72e0-4568-b6ae-7beb2b01b10f	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
8c16974a-a20a-4baf-ba61-26746c57eee0	39259dfa-72e0-4568-b6ae-7beb2b01b10f	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
9220a920-5ddd-46f6-9b6e-a65adc9b8e9d	39259dfa-72e0-4568-b6ae-7beb2b01b10f	14f3b3f5-a555-4dcd-a269-b7132f014a38	Absent	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
51d525ce-7b36-435c-8ff2-ed92e5058d9e	39259dfa-72e0-4568-b6ae-7beb2b01b10f	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e369e6c1-6ce2-4637-bad9-fba87bc78f70	39259dfa-72e0-4568-b6ae-7beb2b01b10f	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b12971e3-b3d3-4288-89c0-27737c5b3f35	39259dfa-72e0-4568-b6ae-7beb2b01b10f	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
512319c2-f9c6-4fbc-89b7-c93e13439190	39259dfa-72e0-4568-b6ae-7beb2b01b10f	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
28ea7b8b-0407-4be5-a3fb-a5edfe4dc667	39259dfa-72e0-4568-b6ae-7beb2b01b10f	68a2f603-7b91-4404-8fc0-79e611113f89	Absent	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
480b95ea-4424-44a2-b43c-2b324395fcb7	39259dfa-72e0-4568-b6ae-7beb2b01b10f	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
fef97714-b8a7-4083-84cc-b8422d49eb74	39259dfa-72e0-4568-b6ae-7beb2b01b10f	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
0017368d-1a72-44fa-ae9a-466fa6d16157	39259dfa-72e0-4568-b6ae-7beb2b01b10f	14f3b3f5-a555-4dcd-a269-b7132f014a38	Absent	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
0a523735-de4b-4f29-8724-9f8558c2f6ec	39259dfa-72e0-4568-b6ae-7beb2b01b10f	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
85fe7577-4e06-4bbb-8726-c964f02afee4	39259dfa-72e0-4568-b6ae-7beb2b01b10f	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a868832e-c0a1-4c4d-ac51-58d57c42494e	39259dfa-72e0-4568-b6ae-7beb2b01b10f	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
d08135b7-fc53-455b-9edc-db5d3035098d	39259dfa-72e0-4568-b6ae-7beb2b01b10f	14f3b3f5-a555-4dcd-a269-b7132f014a38	Absent	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ec691e03-d0f9-403b-855a-e7e1c6fdfbe7	39259dfa-72e0-4568-b6ae-7beb2b01b10f	68a2f603-7b91-4404-8fc0-79e611113f89	Absent	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
79de1123-c972-4142-b749-c7f7b7ee383a	39259dfa-72e0-4568-b6ae-7beb2b01b10f	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
6730d9c6-e28f-4d86-9412-544e0e038239	39259dfa-72e0-4568-b6ae-7beb2b01b10f	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
4aec2db3-09f0-413e-aca6-b9b4dc32b28c	39259dfa-72e0-4568-b6ae-7beb2b01b10f	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f28c2860-7843-4a70-8e97-39c365990ee7	39259dfa-72e0-4568-b6ae-7beb2b01b10f	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a63f0c00-19a2-44e5-9cd5-a40273a6af66	39259dfa-72e0-4568-b6ae-7beb2b01b10f	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
4ab28e35-9ce5-4b50-aa71-1ac73ce0af4f	39259dfa-72e0-4568-b6ae-7beb2b01b10f	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
cd45dd58-d285-469a-94d6-43f4331f09f5	39259dfa-72e0-4568-b6ae-7beb2b01b10f	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
bb172d61-0532-4b9e-9f88-81c62ce90084	39259dfa-72e0-4568-b6ae-7beb2b01b10f	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a47e90be-431f-49ee-b8a6-dc0372b201f0	39259dfa-72e0-4568-b6ae-7beb2b01b10f	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
adef4398-1395-4c29-9604-85e50528dd42	39259dfa-72e0-4568-b6ae-7beb2b01b10f	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
cf0fcfae-ef2d-48aa-9224-bf1dfc92d0c5	39259dfa-72e0-4568-b6ae-7beb2b01b10f	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f1b5d8b3-bf28-4d3d-8b96-475d370927b8	39259dfa-72e0-4568-b6ae-7beb2b01b10f	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
501118a6-26df-43a1-a1dd-2c8bb637c65b	39259dfa-72e0-4568-b6ae-7beb2b01b10f	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
4d9bcd1e-6d66-4f59-a02a-0f4a19e05cc0	39259dfa-72e0-4568-b6ae-7beb2b01b10f	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
80e1e216-975f-453a-83c8-ec0bfbecbe9e	39259dfa-72e0-4568-b6ae-7beb2b01b10f	14f3b3f5-a555-4dcd-a269-b7132f014a38	Absent	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e0585f3c-5c9b-4514-86a0-0426555238d1	39259dfa-72e0-4568-b6ae-7beb2b01b10f	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f5eef11c-da85-4b02-b5c7-bd355e8f3d5c	39259dfa-72e0-4568-b6ae-7beb2b01b10f	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
1014c90b-6415-4e71-af3e-42dd210c9cb0	39259dfa-72e0-4568-b6ae-7beb2b01b10f	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
1a3cbc15-cac6-411a-b2ca-1d1c8739acf0	39259dfa-72e0-4568-b6ae-7beb2b01b10f	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
160449ab-000d-47af-bd5c-2a3f55b0ac28	39259dfa-72e0-4568-b6ae-7beb2b01b10f	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
6dd1d3f0-af77-4341-8987-fd1b5abe7695	39259dfa-72e0-4568-b6ae-7beb2b01b10f	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
276adc6a-7853-44eb-9fea-6de69a7e9748	39259dfa-72e0-4568-b6ae-7beb2b01b10f	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
d8fa4529-9d47-48e4-a45a-07436bb02a1d	39259dfa-72e0-4568-b6ae-7beb2b01b10f	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
d49a0df3-d561-4c4a-a375-c02f2553ee33	39259dfa-72e0-4568-b6ae-7beb2b01b10f	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ed66aa4d-e2d7-4b03-a5a6-1c25f25c7a3e	39259dfa-72e0-4568-b6ae-7beb2b01b10f	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
04ce1e62-642e-4fe1-88e1-e935356f4c0c	39259dfa-72e0-4568-b6ae-7beb2b01b10f	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
92da382c-fa3b-4b41-b328-b4b8ef963ffb	39259dfa-72e0-4568-b6ae-7beb2b01b10f	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ae6ef801-3fe1-4ca0-a9f6-bfa81d9eecd5	39259dfa-72e0-4568-b6ae-7beb2b01b10f	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
3191e2c8-bd99-441f-ad06-97b15e1a1a61	39259dfa-72e0-4568-b6ae-7beb2b01b10f	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
5c670cf3-aae4-46cc-82f4-b155b0b6f8f7	39259dfa-72e0-4568-b6ae-7beb2b01b10f	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
bc4e6c8c-7afb-4c1b-8eb6-4c14e6c08608	39259dfa-72e0-4568-b6ae-7beb2b01b10f	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a7f662b4-d953-4bdc-95eb-4a4fecce97c6	39259dfa-72e0-4568-b6ae-7beb2b01b10f	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
867e27d5-007a-4848-ba3a-59191aa46e3b	39259dfa-72e0-4568-b6ae-7beb2b01b10f	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b0321c0b-8cae-4d70-985a-16c6bd99e0e3	39259dfa-72e0-4568-b6ae-7beb2b01b10f	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
354a0879-a41d-46c1-b676-d340334f0b3f	39259dfa-72e0-4568-b6ae-7beb2b01b10f	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a11c927f-5521-4204-8405-d9749de2e4d8	39259dfa-72e0-4568-b6ae-7beb2b01b10f	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
58d1c0bc-cfe2-4d54-b9df-8ef2e75fe391	39259dfa-72e0-4568-b6ae-7beb2b01b10f	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f25081db-c219-4aad-8c05-bd4c2b1fe673	39259dfa-72e0-4568-b6ae-7beb2b01b10f	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
9597956d-3267-421c-9d50-29eff61dd69f	39259dfa-72e0-4568-b6ae-7beb2b01b10f	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
bb469b4f-c725-4b32-b560-46c16a4a5a5f	39259dfa-72e0-4568-b6ae-7beb2b01b10f	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
fdc8ed00-7757-4180-ac7b-769c14eafb60	39259dfa-72e0-4568-b6ae-7beb2b01b10f	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f087c477-9982-4bc6-9c30-9f26d7e93a43	39259dfa-72e0-4568-b6ae-7beb2b01b10f	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
3f258fc5-4781-49db-9164-a729f9dea270	39259dfa-72e0-4568-b6ae-7beb2b01b10f	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
06689b6d-477a-4b3e-aa8e-5f54d1a8cc0d	39259dfa-72e0-4568-b6ae-7beb2b01b10f	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
bafdd90f-4fe8-42ea-aefb-76a7284963fe	39259dfa-72e0-4568-b6ae-7beb2b01b10f	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
d322bfa1-7f2e-4ad0-8d5b-868e1aa224de	39259dfa-72e0-4568-b6ae-7beb2b01b10f	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Absent	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
67e10558-4dd8-4727-baea-65523572bd5a	39259dfa-72e0-4568-b6ae-7beb2b01b10f	14f3b3f5-a555-4dcd-a269-b7132f014a38	Absent	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
6bd228bc-f613-47f2-bb0b-02a99c23e27f	39259dfa-72e0-4568-b6ae-7beb2b01b10f	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
666d8c38-50eb-4fdb-b3c8-2d892fcfd348	39259dfa-72e0-4568-b6ae-7beb2b01b10f	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
6844ab66-615a-4ac3-9e95-75254529f7df	39259dfa-72e0-4568-b6ae-7beb2b01b10f	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
fef9cb7a-ac7b-45ac-b937-28c4bb421249	39259dfa-72e0-4568-b6ae-7beb2b01b10f	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
4994ce1b-f21d-4b94-bacf-ff1066afed43	c2ad89fd-2583-4f46-ad0d-8232f6269718	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
320616bb-1b1b-4fda-a85c-31f0bc216159	c2ad89fd-2583-4f46-ad0d-8232f6269718	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
fef919af-a6b0-42b4-b022-781d77dd0fc3	c2ad89fd-2583-4f46-ad0d-8232f6269718	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
c2e3f70d-7689-47df-99ee-1cedfa7441ed	c2ad89fd-2583-4f46-ad0d-8232f6269718	14f3b3f5-a555-4dcd-a269-b7132f014a38	Absent	2026-04-22	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b9a22644-4f1b-453b-bba0-6c9f4b2df607	c2ad89fd-2583-4f46-ad0d-8232f6269718	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
91878803-7923-40f8-8c1d-3b9b7ba4e000	c2ad89fd-2583-4f46-ad0d-8232f6269718	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
28a1228b-b09d-4e29-8789-ab641bda47ed	c2ad89fd-2583-4f46-ad0d-8232f6269718	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
7623b562-1199-43d0-b156-496ca0c568a3	c2ad89fd-2583-4f46-ad0d-8232f6269718	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-23	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f3a8a734-c9b4-43b9-a83a-1f29406c3cab	c2ad89fd-2583-4f46-ad0d-8232f6269718	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
8ba14298-2859-42c0-b839-6497a19fd35d	c2ad89fd-2583-4f46-ad0d-8232f6269718	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
3ccb711d-94cc-4cf7-af70-b6953e6b174d	c2ad89fd-2583-4f46-ad0d-8232f6269718	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
083e13b9-5f25-4efa-aa6c-421c9b0a0e03	c2ad89fd-2583-4f46-ad0d-8232f6269718	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a0c00fd4-89c7-4ef6-bccf-d80d0b0356fb	c2ad89fd-2583-4f46-ad0d-8232f6269718	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-24	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a6e157ef-2914-4ee1-879c-49ba4302d8ad	c2ad89fd-2583-4f46-ad0d-8232f6269718	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
56ad0f00-5805-44f9-82d5-f0fc84ed54c0	c2ad89fd-2583-4f46-ad0d-8232f6269718	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
6af9ff56-bb95-4b60-95b4-64fc131c0084	c2ad89fd-2583-4f46-ad0d-8232f6269718	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Absent	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b4e53dc4-3d85-499d-94df-9e3e51d01b62	c2ad89fd-2583-4f46-ad0d-8232f6269718	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-25	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
4430931c-daae-4f0a-9421-7f04a5f88abe	c2ad89fd-2583-4f46-ad0d-8232f6269718	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
29349160-ada0-4a96-999c-7e08276de288	c2ad89fd-2583-4f46-ad0d-8232f6269718	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
34fb46a2-bfa7-4d5f-849e-869802fd2ef5	c2ad89fd-2583-4f46-ad0d-8232f6269718	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
6fedc03a-5e61-4305-a605-a1a804cfdce9	c2ad89fd-2583-4f46-ad0d-8232f6269718	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-26	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
3b268477-75a3-43a8-95f6-153b852f7525	c2ad89fd-2583-4f46-ad0d-8232f6269718	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ae549ee8-e778-41d7-988f-81d429fae1a8	c2ad89fd-2583-4f46-ad0d-8232f6269718	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
c18db112-4f98-4073-9b42-9d8a0d6f1cdd	c2ad89fd-2583-4f46-ad0d-8232f6269718	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
c5f2b5d6-9e3c-4780-9010-7a8b81b9ab11	c2ad89fd-2583-4f46-ad0d-8232f6269718	14f3b3f5-a555-4dcd-a269-b7132f014a38	Absent	2026-04-27	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f2a095d7-cc88-43b1-9295-5c45b048aef4	c2ad89fd-2583-4f46-ad0d-8232f6269718	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
2f0ff99b-1a2a-4b30-8831-e3981a069c44	c2ad89fd-2583-4f46-ad0d-8232f6269718	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
bf4c6b11-cce7-4b64-bb93-fe237185bf5e	c2ad89fd-2583-4f46-ad0d-8232f6269718	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
948c0383-c726-4f95-a082-4ad0814e646d	c2ad89fd-2583-4f46-ad0d-8232f6269718	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
22c61b7f-5604-482f-b03d-0c2997a48941	c2ad89fd-2583-4f46-ad0d-8232f6269718	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
9d3ef3be-0b58-4833-b42e-1551e3aecc49	c2ad89fd-2583-4f46-ad0d-8232f6269718	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
1ea40aa9-edeb-4815-989b-8c5745d9fd8f	c2ad89fd-2583-4f46-ad0d-8232f6269718	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Absent	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
8993c783-f066-4b55-b1af-c1a6d778d0dc	c2ad89fd-2583-4f46-ad0d-8232f6269718	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f0e10b9d-ec6c-4dbd-b16f-6fcc05e0d1ba	c2ad89fd-2583-4f46-ad0d-8232f6269718	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
d96644f4-c035-4a76-a3eb-a6496900f121	c2ad89fd-2583-4f46-ad0d-8232f6269718	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
2a848174-defa-4dea-a02d-c5b43f83cecf	c2ad89fd-2583-4f46-ad0d-8232f6269718	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
c02ab3ab-b579-40ca-9f32-37906ab5a90d	c2ad89fd-2583-4f46-ad0d-8232f6269718	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
90e967c1-9dc3-48af-9002-11cb0f8e6742	c2ad89fd-2583-4f46-ad0d-8232f6269718	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
794b8240-e1f8-4a80-8687-1133958087c8	c2ad89fd-2583-4f46-ad0d-8232f6269718	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a90d05fd-3cb5-4c5e-98af-0746852e4057	c2ad89fd-2583-4f46-ad0d-8232f6269718	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ea09284b-b191-42cb-956b-7b476c27c262	c2ad89fd-2583-4f46-ad0d-8232f6269718	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a0e1b337-a77b-4e94-8233-b22892887790	c2ad89fd-2583-4f46-ad0d-8232f6269718	68a2f603-7b91-4404-8fc0-79e611113f89	Absent	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b4f7cc3b-cffa-47e7-a102-887c58c64ad8	c2ad89fd-2583-4f46-ad0d-8232f6269718	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f532544d-78f8-4cb1-9db5-8ba520310ad2	c2ad89fd-2583-4f46-ad0d-8232f6269718	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
57a269f5-1e39-4bc7-8324-11186dde874b	c2ad89fd-2583-4f46-ad0d-8232f6269718	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
61a429fd-6137-4355-b745-3bcc310dbcea	c2ad89fd-2583-4f46-ad0d-8232f6269718	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e786f865-6ec2-4d27-af03-b4d122a5df1a	c2ad89fd-2583-4f46-ad0d-8232f6269718	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
587c6f9e-470f-48ee-b6db-5be1e21061e3	c2ad89fd-2583-4f46-ad0d-8232f6269718	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
030d8ffc-eb14-49f6-98d8-5a4aa1f9aaf7	c2ad89fd-2583-4f46-ad0d-8232f6269718	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a3e5a350-6927-46a7-b3a0-67ef20b11a1f	c2ad89fd-2583-4f46-ad0d-8232f6269718	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
7471bb34-b0dc-49da-8793-4fa20ac02c04	c2ad89fd-2583-4f46-ad0d-8232f6269718	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
259b0796-fcff-4f0a-b7b6-ebb5b07d872f	c2ad89fd-2583-4f46-ad0d-8232f6269718	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
bae4bd72-54d9-436e-b3f3-efcc92f415a9	c2ad89fd-2583-4f46-ad0d-8232f6269718	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f78f85d8-aba4-416f-9045-7a84a592f63f	c2ad89fd-2583-4f46-ad0d-8232f6269718	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
412839e0-3ab8-4841-9196-d6d511993994	c2ad89fd-2583-4f46-ad0d-8232f6269718	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a9ac8685-d200-495f-864a-ac32eaff92dc	c2ad89fd-2583-4f46-ad0d-8232f6269718	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b2978503-c8e5-4693-a471-1dcfb8fed370	c2ad89fd-2583-4f46-ad0d-8232f6269718	14f3b3f5-a555-4dcd-a269-b7132f014a38	Absent	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ab1e3767-2125-4510-8181-e7224d443301	c2ad89fd-2583-4f46-ad0d-8232f6269718	68a2f603-7b91-4404-8fc0-79e611113f89	Absent	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
cb3c3555-5abf-4ecb-ac56-9a53c377ff46	c2ad89fd-2583-4f46-ad0d-8232f6269718	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e009f55e-ab00-4c17-aea7-3ff9300c10be	c2ad89fd-2583-4f46-ad0d-8232f6269718	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
9f055aa2-aaf9-4515-8e6a-edf52dbae005	c2ad89fd-2583-4f46-ad0d-8232f6269718	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
05d3a920-027e-427f-b3f6-70180c1cb2f1	c2ad89fd-2583-4f46-ad0d-8232f6269718	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
7c5a9ea9-1150-4950-ae06-ec36ec02efbb	c2ad89fd-2583-4f46-ad0d-8232f6269718	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Absent	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
cf4f946d-8985-406f-9ae1-7ba31d9ef224	c2ad89fd-2583-4f46-ad0d-8232f6269718	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-07	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e76c1e5b-188f-44ec-bbe9-f4f9e70b8399	c2ad89fd-2583-4f46-ad0d-8232f6269718	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
7fea981b-1cb1-4135-aad8-0fe8d05c4e23	c2ad89fd-2583-4f46-ad0d-8232f6269718	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
97398699-8fb0-4c53-ad9e-7b8ea9668653	c2ad89fd-2583-4f46-ad0d-8232f6269718	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
7468a0b2-2200-4b16-b195-16b89882e462	c2ad89fd-2583-4f46-ad0d-8232f6269718	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-08	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
bd35855e-81a0-4496-bbd9-b959dde35105	c2ad89fd-2583-4f46-ad0d-8232f6269718	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
91fd2da5-f89e-43f1-8599-b7beb527897a	c2ad89fd-2583-4f46-ad0d-8232f6269718	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
5e5d7c7f-a20c-432f-a076-55ea716f8a2b	c2ad89fd-2583-4f46-ad0d-8232f6269718	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
d6f5aac7-0074-4473-b026-8033d203fa38	c2ad89fd-2583-4f46-ad0d-8232f6269718	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-09	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
6c6a5634-e221-43ce-898e-936b542fc70e	c2ad89fd-2583-4f46-ad0d-8232f6269718	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a8e0d9c5-4059-435f-b7ba-a59c9b8dd0f2	c2ad89fd-2583-4f46-ad0d-8232f6269718	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
36878114-92b7-4877-9eed-30478bea99b4	c2ad89fd-2583-4f46-ad0d-8232f6269718	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
415f4a7d-0ff7-47a9-8418-35b56d0c2a95	c2ad89fd-2583-4f46-ad0d-8232f6269718	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-10	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
b44023d4-0749-4b1f-9219-782ea79ba96d	c2ad89fd-2583-4f46-ad0d-8232f6269718	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
29b1dab9-185b-4482-8b65-db4f6ce48ce2	c2ad89fd-2583-4f46-ad0d-8232f6269718	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
31d96fca-1d2e-434f-aaea-9cc54201da41	c2ad89fd-2583-4f46-ad0d-8232f6269718	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
eaf44aab-d3c2-4996-a4b9-685d1f135378	c2ad89fd-2583-4f46-ad0d-8232f6269718	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-11	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
2c29cee4-85e5-4d36-93f2-d3ebdce7b959	c2ad89fd-2583-4f46-ad0d-8232f6269718	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
47d98d34-32f2-4e1b-9b0d-4a1b46845337	c2ad89fd-2583-4f46-ad0d-8232f6269718	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
1ce793d3-cf64-4f42-b719-2776fa07f6af	c2ad89fd-2583-4f46-ad0d-8232f6269718	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
95ebcabd-74e0-4d12-929c-940f000f0482	c2ad89fd-2583-4f46-ad0d-8232f6269718	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-12	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
012eefb9-9e11-4c7f-9cad-2dbb0f403fd6	c544629d-bb02-4c51-9c23-dc743e51a9b1	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-05-12	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
9d46a498-1096-41f4-925d-874470cfc307	c544629d-bb02-4c51-9c23-dc743e51a9b1	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-05-12	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
2412ba4c-e2b6-4564-b74d-afab90cb1b63	c544629d-bb02-4c51-9c23-dc743e51a9b1	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-05-12	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
c35d1304-ed99-4c59-8530-44f05d827d7b	c544629d-bb02-4c51-9c23-dc743e51a9b1	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-05-11	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
440d7e5a-4d11-402c-b87d-c3bbba0dad87	c544629d-bb02-4c51-9c23-dc743e51a9b1	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-05-11	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
980a7385-b8b1-4ba7-8dbf-20c061850ab5	c544629d-bb02-4c51-9c23-dc743e51a9b1	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-05-11	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
3127a715-f8ed-4f72-9528-b2acc90b2b28	c544629d-bb02-4c51-9c23-dc743e51a9b1	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-05-11	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
c013be90-3d4b-481c-bb6f-00013e3e805a	c544629d-bb02-4c51-9c23-dc743e51a9b1	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-05-08	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
8b540760-b004-4fde-aa25-a55b2c52550d	c544629d-bb02-4c51-9c23-dc743e51a9b1	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-05-08	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
c53f01c5-7f9e-4ac4-aebc-6f145f88746f	c544629d-bb02-4c51-9c23-dc743e51a9b1	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-05-08	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
af1ac381-261c-47a5-8db3-36ba95590e8b	c544629d-bb02-4c51-9c23-dc743e51a9b1	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-05-08	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
0564d1dc-a706-40a5-b952-ad1ad4825242	c544629d-bb02-4c51-9c23-dc743e51a9b1	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-05-07	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
954a4dd0-e7b6-4ec8-b5b4-6b3ebcab4e69	c544629d-bb02-4c51-9c23-dc743e51a9b1	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-05-07	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
327b4a34-ce52-4104-b3ce-80a337e78d62	c544629d-bb02-4c51-9c23-dc743e51a9b1	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-05-07	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
3c8165e9-650a-4721-9b1b-26c3a45848ed	c544629d-bb02-4c51-9c23-dc743e51a9b1	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-05-07	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
71e91395-5ec3-429a-ba33-6d03c63003c8	c544629d-bb02-4c51-9c23-dc743e51a9b1	c7221a8c-09bc-4545-84df-058f73f7b11e	Absent	2026-05-06	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
bf1ab974-1754-4c70-8c8e-57e50215720d	c544629d-bb02-4c51-9c23-dc743e51a9b1	65221f54-0a44-4bd1-991d-e08256571e38	Absent	2026-05-06	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
83072fcc-f754-429c-9013-face34d187d2	c544629d-bb02-4c51-9c23-dc743e51a9b1	4bb87678-40bf-479d-a97f-662e63cd652f	Absent	2026-05-06	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
a0c99294-92d8-4b98-ac1c-c09dae28b4c5	c544629d-bb02-4c51-9c23-dc743e51a9b1	931e073f-d654-4f85-88c7-3e48c60a0349	Absent	2026-05-06	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
28c45870-c9a1-4974-9b86-02ae2636142f	c544629d-bb02-4c51-9c23-dc743e51a9b1	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-05-05	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
f1298f03-9852-4d7c-8d0f-1484ce8bf8d0	c544629d-bb02-4c51-9c23-dc743e51a9b1	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-05-05	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
ec95b194-d8b5-4817-943f-a1cfbc5643c9	c544629d-bb02-4c51-9c23-dc743e51a9b1	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-05-05	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
3e7d252c-d918-49a8-8c70-12767a1a91e5	c544629d-bb02-4c51-9c23-dc743e51a9b1	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-05-05	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
cec8f58b-65f5-4bda-afaa-1b88d2951702	c544629d-bb02-4c51-9c23-dc743e51a9b1	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-05-04	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
07bc1f6e-d0d4-4e90-b412-2f40aec061ca	c544629d-bb02-4c51-9c23-dc743e51a9b1	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-05-04	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
d17dca04-6188-4d49-894d-6cadd5b5ad90	c544629d-bb02-4c51-9c23-dc743e51a9b1	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-05-04	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
1e23ded8-28d5-4d42-a7c0-961cf0fc1dad	c544629d-bb02-4c51-9c23-dc743e51a9b1	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-05-04	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
49fccbbd-8ce9-44f0-9434-1f5cdc161194	c544629d-bb02-4c51-9c23-dc743e51a9b1	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-05-01	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
314f2134-5483-48c9-be57-7ce9f41050b3	c544629d-bb02-4c51-9c23-dc743e51a9b1	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-05-01	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
b60d33c1-aad1-4837-b726-18ec7c81e5a0	c544629d-bb02-4c51-9c23-dc743e51a9b1	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-05-01	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
32b1a395-e86a-48ad-a13c-254d3094c844	c544629d-bb02-4c51-9c23-dc743e51a9b1	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-05-01	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
1e425104-7ecf-4bf6-88ff-23d387af3a01	c544629d-bb02-4c51-9c23-dc743e51a9b1	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-04-30	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
c410b949-9031-48eb-aa66-58a0dcd34d28	c544629d-bb02-4c51-9c23-dc743e51a9b1	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-04-30	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
0357a6b4-c7b2-4ad1-b00e-b2a02eb7be60	c544629d-bb02-4c51-9c23-dc743e51a9b1	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-04-30	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
c04b895d-7a1e-460a-b341-28526b36528b	c544629d-bb02-4c51-9c23-dc743e51a9b1	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-04-30	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
ef7c38d1-467d-464b-88c1-591be6e6c015	c544629d-bb02-4c51-9c23-dc743e51a9b1	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-04-29	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
a2fb7215-2cfc-4eac-bc9c-07b7f4902d22	c544629d-bb02-4c51-9c23-dc743e51a9b1	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-04-29	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
855e7e2f-461c-4464-a847-f9c77df9565d	c544629d-bb02-4c51-9c23-dc743e51a9b1	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-04-29	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
70731991-2444-4f12-8d7d-f27c34c3cf7e	c544629d-bb02-4c51-9c23-dc743e51a9b1	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-04-29	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
ed7d573f-71b4-41a0-be90-fce4f7ee191d	c544629d-bb02-4c51-9c23-dc743e51a9b1	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-04-28	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
da4afbca-7507-4798-b4f9-e318b42d0fdc	c544629d-bb02-4c51-9c23-dc743e51a9b1	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-04-28	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
5bc06bb4-0648-452f-a232-1fc731ba5f36	c544629d-bb02-4c51-9c23-dc743e51a9b1	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-04-28	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
93199743-f256-4f8d-92ab-61284eed04e2	c544629d-bb02-4c51-9c23-dc743e51a9b1	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-04-28	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
9d7cf32d-ce95-4a7a-b922-450f51dab72c	c544629d-bb02-4c51-9c23-dc743e51a9b1	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-04-27	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
02a11bac-8979-4377-a2fc-ee74f2f8f0fe	c544629d-bb02-4c51-9c23-dc743e51a9b1	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-04-27	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
9cc6955c-8317-4528-9272-dc74087255b2	c544629d-bb02-4c51-9c23-dc743e51a9b1	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-04-27	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
d8e4d0fe-bbc8-44ef-8a92-3dcc8ad0c76d	c544629d-bb02-4c51-9c23-dc743e51a9b1	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-04-27	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
4ec308d6-2447-4da4-bbbe-0856c2e00d0e	c544629d-bb02-4c51-9c23-dc743e51a9b1	c7221a8c-09bc-4545-84df-058f73f7b11e	Absent	2026-04-24	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
509aa36a-2a85-42c8-aeac-ea36fbc0e929	c544629d-bb02-4c51-9c23-dc743e51a9b1	65221f54-0a44-4bd1-991d-e08256571e38	Absent	2026-04-24	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
89ce6f6a-7dfd-4040-bb76-3e72e6033d3d	c544629d-bb02-4c51-9c23-dc743e51a9b1	4bb87678-40bf-479d-a97f-662e63cd652f	Absent	2026-04-24	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
1d07a395-384a-4d39-8920-8fa020067c11	c544629d-bb02-4c51-9c23-dc743e51a9b1	931e073f-d654-4f85-88c7-3e48c60a0349	Absent	2026-04-24	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
f6d29101-2b6f-46b2-a612-966e9b1c47d8	c544629d-bb02-4c51-9c23-dc743e51a9b1	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-04-23	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
9738a4d6-eda5-4d12-a913-e0766ad3e592	c544629d-bb02-4c51-9c23-dc743e51a9b1	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-04-23	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
c760a046-cafa-4c84-9bf9-03c26cf73624	c544629d-bb02-4c51-9c23-dc743e51a9b1	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-04-23	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
690bd98f-8983-4cdc-8c7c-ffe8c56ec355	c544629d-bb02-4c51-9c23-dc743e51a9b1	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-04-23	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
ef8901b8-68d8-4824-891b-480fc8f6bc84	c544629d-bb02-4c51-9c23-dc743e51a9b1	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-04-22	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
18527587-364b-47d7-9a0e-b7098b1f0d6e	c544629d-bb02-4c51-9c23-dc743e51a9b1	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-04-22	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
4c517983-f41a-41fa-a110-c9d3987d5bf9	c544629d-bb02-4c51-9c23-dc743e51a9b1	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-04-22	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
ad6edd15-e6de-4348-a3d2-68a098af8b7e	c544629d-bb02-4c51-9c23-dc743e51a9b1	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-04-22	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
d8364cf9-13a9-443b-89aa-416c5cabf540	c544629d-bb02-4c51-9c23-dc743e51a9b1	c7221a8c-09bc-4545-84df-058f73f7b11e	Absent	2026-04-21	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
8c5beb55-1a9c-4850-9d8e-4a83cf9016e7	c544629d-bb02-4c51-9c23-dc743e51a9b1	65221f54-0a44-4bd1-991d-e08256571e38	Absent	2026-04-21	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
405ff0fc-b1f5-45ee-88f3-d6f386ae54af	c544629d-bb02-4c51-9c23-dc743e51a9b1	4bb87678-40bf-479d-a97f-662e63cd652f	Absent	2026-04-21	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
2df74c65-757e-48c9-adac-e0d30c0a480b	c544629d-bb02-4c51-9c23-dc743e51a9b1	931e073f-d654-4f85-88c7-3e48c60a0349	Absent	2026-04-21	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
79e668bb-188f-4127-864a-93de0c6463fd	c544629d-bb02-4c51-9c23-dc743e51a9b1	c7221a8c-09bc-4545-84df-058f73f7b11e	Absent	2026-04-20	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
f2532df5-5117-454e-b3d4-45c14fd296ff	c544629d-bb02-4c51-9c23-dc743e51a9b1	65221f54-0a44-4bd1-991d-e08256571e38	Absent	2026-04-20	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
4ac08924-ecaf-49f2-bd50-633be5c68767	c544629d-bb02-4c51-9c23-dc743e51a9b1	4bb87678-40bf-479d-a97f-662e63cd652f	Absent	2026-04-20	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
07d2f881-4c6e-4dbc-b5b0-38baa2533f8a	c544629d-bb02-4c51-9c23-dc743e51a9b1	931e073f-d654-4f85-88c7-3e48c60a0349	Absent	2026-04-20	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
def15802-689d-4ddc-9c9b-177b0ed07e62	c544629d-bb02-4c51-9c23-dc743e51a9b1	c7221a8c-09bc-4545-84df-058f73f7b11e	Absent	2026-04-17	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
062bdf06-9d3f-4f29-8fa6-cad0fd9fe668	c544629d-bb02-4c51-9c23-dc743e51a9b1	65221f54-0a44-4bd1-991d-e08256571e38	Absent	2026-04-17	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
2d0eb59a-1f31-440d-a579-3562fee25f4d	c544629d-bb02-4c51-9c23-dc743e51a9b1	4bb87678-40bf-479d-a97f-662e63cd652f	Absent	2026-04-17	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
bc6846fc-b248-4a48-a594-aa0e92f9fa8f	c544629d-bb02-4c51-9c23-dc743e51a9b1	931e073f-d654-4f85-88c7-3e48c60a0349	Absent	2026-04-17	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
b8e1052c-4c6f-4c56-8bce-86cb8af8439b	c544629d-bb02-4c51-9c23-dc743e51a9b1	c7221a8c-09bc-4545-84df-058f73f7b11e	Absent	2026-04-16	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
224af220-8b78-4e5f-8f13-7fd943b0ed4a	c544629d-bb02-4c51-9c23-dc743e51a9b1	65221f54-0a44-4bd1-991d-e08256571e38	Absent	2026-04-16	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
e0f781e8-c8ae-459f-8bfc-fb7d4234c510	c544629d-bb02-4c51-9c23-dc743e51a9b1	4bb87678-40bf-479d-a97f-662e63cd652f	Absent	2026-04-16	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
61f2ee4b-d241-4715-ad28-638eb4e3c1de	c544629d-bb02-4c51-9c23-dc743e51a9b1	931e073f-d654-4f85-88c7-3e48c60a0349	Absent	2026-04-16	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
1c8a3483-f56a-4e4d-8611-1634ac50782e	299efed3-47cc-4a52-a203-96f8ed2f50c0	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
913521c9-3511-496d-98b7-36f4feec993f	299efed3-47cc-4a52-a203-96f8ed2f50c0	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ca3d8205-455c-45bb-9745-d2b107ca142f	299efed3-47cc-4a52-a203-96f8ed2f50c0	14f3b3f5-a555-4dcd-a269-b7132f014a38	Absent	2026-04-28	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
775ab64b-3183-41a4-9099-07e2211b3d2f	299efed3-47cc-4a52-a203-96f8ed2f50c0	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
a1335cc2-8779-443e-bff9-c8dcd9450157	299efed3-47cc-4a52-a203-96f8ed2f50c0	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Absent	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
684de782-ab50-4e5b-9433-d077ebfb1e45	299efed3-47cc-4a52-a203-96f8ed2f50c0	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
14ef3a31-ebde-4175-a627-350df92a1b5b	299efed3-47cc-4a52-a203-96f8ed2f50c0	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-29	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
1da18bbf-96c9-4e8b-b001-5001685d558b	299efed3-47cc-4a52-a203-96f8ed2f50c0	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ad422b80-c096-4d87-9890-83117003d6d7	299efed3-47cc-4a52-a203-96f8ed2f50c0	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
9e55cc35-e5f5-4d68-84d1-a2540c567427	299efed3-47cc-4a52-a203-96f8ed2f50c0	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
798776e6-dcc7-4c65-8366-2a6141f71150	299efed3-47cc-4a52-a203-96f8ed2f50c0	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-04-30	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
20f5c405-cb87-47be-b140-5e206789dbe8	299efed3-47cc-4a52-a203-96f8ed2f50c0	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
7d031eec-7bfb-4864-8f99-f2188de9157d	299efed3-47cc-4a52-a203-96f8ed2f50c0	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
44c4d14f-9bcc-409b-a6a9-11d7737e25ea	299efed3-47cc-4a52-a203-96f8ed2f50c0	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Absent	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
34d9e54e-4716-42ca-9bb8-167eb30350d3	299efed3-47cc-4a52-a203-96f8ed2f50c0	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-01	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
46f66ced-d90d-416f-ba5d-90dc75aca249	299efed3-47cc-4a52-a203-96f8ed2f50c0	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
3d1a94aa-2584-4023-9f45-a8185333622b	299efed3-47cc-4a52-a203-96f8ed2f50c0	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
d56674fc-3d34-4e49-b3af-e28bec035511	299efed3-47cc-4a52-a203-96f8ed2f50c0	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
d9f7b338-b157-42d2-b86a-a182fd9b6353	299efed3-47cc-4a52-a203-96f8ed2f50c0	14f3b3f5-a555-4dcd-a269-b7132f014a38	Absent	2026-05-02	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e7847117-f515-4869-bb96-503dd0293ab2	299efed3-47cc-4a52-a203-96f8ed2f50c0	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
9592baed-207b-4dbb-9806-2cad6400ac32	299efed3-47cc-4a52-a203-96f8ed2f50c0	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
2bf9c533-a743-44e6-81be-9017edb4b156	299efed3-47cc-4a52-a203-96f8ed2f50c0	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
4bea39cb-bd00-437b-a0d2-fba27f912e2b	299efed3-47cc-4a52-a203-96f8ed2f50c0	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-03	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
cae9eeb4-993d-44ac-9cf6-90c242ca1e02	299efed3-47cc-4a52-a203-96f8ed2f50c0	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f045192d-88ec-47c1-bee3-d26cf59d0d5d	299efed3-47cc-4a52-a203-96f8ed2f50c0	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
c820313a-0553-4aca-9eb3-f1c553466fa7	299efed3-47cc-4a52-a203-96f8ed2f50c0	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
3a18496b-7799-4ff9-a583-f03afc38f20f	299efed3-47cc-4a52-a203-96f8ed2f50c0	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-04	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
0590fae7-c05f-4a1a-bb0a-cbbf9683fbb3	299efed3-47cc-4a52-a203-96f8ed2f50c0	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
23ec0446-bcc3-439b-8287-f9e675123ca9	299efed3-47cc-4a52-a203-96f8ed2f50c0	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
67ca5290-a44c-4d41-abac-a10f3e593003	299efed3-47cc-4a52-a203-96f8ed2f50c0	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	Present	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
e16653d4-d56a-4f29-8038-cbf401772732	299efed3-47cc-4a52-a203-96f8ed2f50c0	14f3b3f5-a555-4dcd-a269-b7132f014a38	Present	2026-05-05	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
92081e71-b155-4e1f-b98f-4fde94ebbcaf	299efed3-47cc-4a52-a203-96f8ed2f50c0	68a2f603-7b91-4404-8fc0-79e611113f89	Present	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
8caeea09-3fb9-4693-b98d-ff9de83eef7f	299efed3-47cc-4a52-a203-96f8ed2f50c0	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	Present	2026-05-06	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
83064de2-1831-49f6-b7d5-39916dc21f54	44010cff-1b62-4c8a-abab-f43160ecd001	65221f54-0a44-4bd1-991d-e08256571e38	Absent	2026-05-26	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
e9738eaf-cc22-4b27-aea8-14574da53d9a	44010cff-1b62-4c8a-abab-f43160ecd001	4bb87678-40bf-479d-a97f-662e63cd652f	Absent	2026-05-26	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
c290f75b-794b-41ba-90a3-275f91ba4f1a	44010cff-1b62-4c8a-abab-f43160ecd001	931e073f-d654-4f85-88c7-3e48c60a0349	Absent	2026-05-26	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
aaf4898b-2b2d-4f64-913e-f1d4056bbfdc	44010cff-1b62-4c8a-abab-f43160ecd001	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-05-25	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
4f23d477-f8b9-4db0-96df-e3d660baa442	44010cff-1b62-4c8a-abab-f43160ecd001	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-05-25	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
91e12f63-c020-4fcc-b11d-c62ba8984486	44010cff-1b62-4c8a-abab-f43160ecd001	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-05-25	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
507b75a4-fea1-4642-863a-95239aece392	44010cff-1b62-4c8a-abab-f43160ecd001	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-05-25	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
da7ee897-c551-4f5f-a561-0c87f2711b7a	44010cff-1b62-4c8a-abab-f43160ecd001	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-05-22	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
13f9256a-f154-4891-a461-5f5a40756e19	44010cff-1b62-4c8a-abab-f43160ecd001	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-05-22	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
d81ae873-a6ee-4c93-8fb1-f24aa9397225	44010cff-1b62-4c8a-abab-f43160ecd001	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-05-22	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
d6e41d0d-1945-46d0-a5f1-ce1188e3a860	44010cff-1b62-4c8a-abab-f43160ecd001	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-05-22	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
b02451a5-dd0a-4024-ace8-2615fb8a2b40	44010cff-1b62-4c8a-abab-f43160ecd001	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-05-21	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
2d7b7dec-fd35-4186-80ee-4d20a7984c66	44010cff-1b62-4c8a-abab-f43160ecd001	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-05-21	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
f328ad7b-db41-4d97-b873-80765a9eb1d8	44010cff-1b62-4c8a-abab-f43160ecd001	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-05-21	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
81a895f3-a304-4216-92ea-2c7a40c1dabf	44010cff-1b62-4c8a-abab-f43160ecd001	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-05-21	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
9904c653-b354-4794-a1e2-912e7341b82d	44010cff-1b62-4c8a-abab-f43160ecd001	c7221a8c-09bc-4545-84df-058f73f7b11e	Absent	2026-05-20	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
fb56705b-3da4-4cb1-8ed6-5335050099d8	44010cff-1b62-4c8a-abab-f43160ecd001	65221f54-0a44-4bd1-991d-e08256571e38	Absent	2026-05-20	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
50448d34-d923-424c-9ebc-eb06edf78dd7	44010cff-1b62-4c8a-abab-f43160ecd001	4bb87678-40bf-479d-a97f-662e63cd652f	Absent	2026-05-20	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
da3df91e-a567-4157-b196-7219260876e6	44010cff-1b62-4c8a-abab-f43160ecd001	931e073f-d654-4f85-88c7-3e48c60a0349	Absent	2026-05-20	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
caaf399f-0be7-4fef-9ef1-9536a488f9e6	44010cff-1b62-4c8a-abab-f43160ecd001	c7221a8c-09bc-4545-84df-058f73f7b11e	Absent	2026-05-19	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
457f8606-1578-4b6d-8181-0791c0f5830f	44010cff-1b62-4c8a-abab-f43160ecd001	65221f54-0a44-4bd1-991d-e08256571e38	Absent	2026-05-19	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
ab795f80-bf3b-494b-9210-77b99eea20e8	44010cff-1b62-4c8a-abab-f43160ecd001	4bb87678-40bf-479d-a97f-662e63cd652f	Absent	2026-05-19	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
2dbc55b6-d297-4ba2-b480-67efdcac3d63	44010cff-1b62-4c8a-abab-f43160ecd001	931e073f-d654-4f85-88c7-3e48c60a0349	Absent	2026-05-19	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
81a685f6-c9d7-46ea-a122-02c658745bbf	44010cff-1b62-4c8a-abab-f43160ecd001	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-05-18	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
d2af3649-3b99-44e5-9950-43a8456d538d	44010cff-1b62-4c8a-abab-f43160ecd001	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-05-18	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
e557115b-e9a1-4c86-9592-a9540f256a1e	44010cff-1b62-4c8a-abab-f43160ecd001	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-05-18	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
8539fe89-12c4-47b4-8a3b-c7bb02b4835c	44010cff-1b62-4c8a-abab-f43160ecd001	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-05-18	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
4430134b-2175-4128-af52-acedf234bb10	44010cff-1b62-4c8a-abab-f43160ecd001	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-05-15	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
a83beb96-3888-4cc6-812f-014bd29e24f7	44010cff-1b62-4c8a-abab-f43160ecd001	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-05-15	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
522d277f-b987-40c0-a2f1-2a0869d3f188	44010cff-1b62-4c8a-abab-f43160ecd001	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-05-15	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
556c3234-9d33-4fb6-9027-7eff33bde8f5	44010cff-1b62-4c8a-abab-f43160ecd001	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-05-15	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
7b95b09c-ca7a-4d84-b4b6-d08690ef8c9e	44010cff-1b62-4c8a-abab-f43160ecd001	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-05-14	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
d12e40b6-2764-42e0-a746-2dd685bf6dff	44010cff-1b62-4c8a-abab-f43160ecd001	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-05-14	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
ffd281d6-586c-4c47-8230-0179f6b60dae	44010cff-1b62-4c8a-abab-f43160ecd001	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-05-14	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
34105640-da43-437a-972b-9224e762f2fe	44010cff-1b62-4c8a-abab-f43160ecd001	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-05-14	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
d9d1343e-ae85-4733-9ed9-3d60cc926191	44010cff-1b62-4c8a-abab-f43160ecd001	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-05-13	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
51738d4c-4c8d-42cd-b60b-0008f522e2c7	44010cff-1b62-4c8a-abab-f43160ecd001	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-05-13	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
f00e6ebd-a6eb-4949-966b-653cb272a033	44010cff-1b62-4c8a-abab-f43160ecd001	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-05-13	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
a99af920-e021-4168-96a2-cd71f3a90004	44010cff-1b62-4c8a-abab-f43160ecd001	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-05-13	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
06c70472-9a12-4146-b2c5-7423190151ff	44010cff-1b62-4c8a-abab-f43160ecd001	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-05-12	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
64d3483b-09ef-458c-98fe-6b8daa079085	44010cff-1b62-4c8a-abab-f43160ecd001	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-05-12	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
60c7fea5-b335-4440-9d51-2b970d201b0e	44010cff-1b62-4c8a-abab-f43160ecd001	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-05-12	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
ebf37e4c-fe3c-44e1-be8f-9c3d6be223f5	44010cff-1b62-4c8a-abab-f43160ecd001	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-05-12	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
17578e82-a937-4a00-82b4-42b18d4e776e	44010cff-1b62-4c8a-abab-f43160ecd001	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-05-11	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
7b219f66-88e9-4467-957f-8b91e35be2ff	44010cff-1b62-4c8a-abab-f43160ecd001	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-05-11	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
0612a0a9-b77e-4c25-8e1f-1d6293dfb1c5	44010cff-1b62-4c8a-abab-f43160ecd001	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-05-11	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
fc49515f-eb6d-4d59-aa1e-c193df3a68ef	44010cff-1b62-4c8a-abab-f43160ecd001	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-05-11	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
f6da9b36-3b31-484e-9bb3-22eb518ab1a9	44010cff-1b62-4c8a-abab-f43160ecd001	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-05-08	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
70748624-97dc-4250-b148-9df47a00dbf5	44010cff-1b62-4c8a-abab-f43160ecd001	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-05-08	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
5fcd186b-a586-4d2f-a0d5-ffbee86960df	44010cff-1b62-4c8a-abab-f43160ecd001	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-05-08	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
16e6c46f-6762-4088-ac3e-36be12cd8d0a	44010cff-1b62-4c8a-abab-f43160ecd001	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-05-08	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
237f4ba3-4350-43e9-906c-f21534bd01e6	44010cff-1b62-4c8a-abab-f43160ecd001	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-05-07	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
a0533989-093c-476d-a3e6-8e3b937d16d5	44010cff-1b62-4c8a-abab-f43160ecd001	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-05-07	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
7eea7709-62f8-4fc7-9c65-9c18b96bc743	44010cff-1b62-4c8a-abab-f43160ecd001	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-05-07	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
9edebbe4-8837-4411-9134-4f9ed630e36c	44010cff-1b62-4c8a-abab-f43160ecd001	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-05-07	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
ebf9ae23-5261-4965-8bb2-8248d83ebdd5	44010cff-1b62-4c8a-abab-f43160ecd001	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-05-06	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
228632ac-524f-4374-b263-da3c79ea4648	44010cff-1b62-4c8a-abab-f43160ecd001	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-05-06	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
001b378c-1ba8-4f31-b73e-37acdcba9549	44010cff-1b62-4c8a-abab-f43160ecd001	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-05-06	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
1ce61fd1-5b1e-41df-a529-bf4f233e7771	44010cff-1b62-4c8a-abab-f43160ecd001	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-05-06	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
66dfd0f1-6af4-4176-aff5-de7a226a3621	44010cff-1b62-4c8a-abab-f43160ecd001	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-05-05	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
4c7bd1de-4019-4bd8-8ccb-36785073dbbc	44010cff-1b62-4c8a-abab-f43160ecd001	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-05-05	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
1d0e0b3c-b189-4ed3-87f6-97009b86996b	c544629d-bb02-4c51-9c23-dc743e51a9b1	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-04-15	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
7fdb8c5e-5bc0-415f-8711-0758afb2715d	c544629d-bb02-4c51-9c23-dc743e51a9b1	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-04-15	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
e10147ce-1fd1-4aae-81fa-68a53c36d3d3	c544629d-bb02-4c51-9c23-dc743e51a9b1	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-04-15	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
908e51cf-60ca-433a-bbb0-ee9755e23b50	c544629d-bb02-4c51-9c23-dc743e51a9b1	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-04-15	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
659c9950-2f2b-46d7-b5b5-b99a8d34864b	c544629d-bb02-4c51-9c23-dc743e51a9b1	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-04-14	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
d93bb156-41dd-4725-be42-fe2deb1d0403	c544629d-bb02-4c51-9c23-dc743e51a9b1	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-04-14	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
03f76b87-0726-4e0f-b1ab-6b6f59db91f6	c544629d-bb02-4c51-9c23-dc743e51a9b1	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-04-14	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
8594d191-40d6-4689-97fe-ef7a31ca2d2b	c544629d-bb02-4c51-9c23-dc743e51a9b1	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-04-14	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
472857b1-10fb-457c-a55a-9bc0510d24f1	c544629d-bb02-4c51-9c23-dc743e51a9b1	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-04-13	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
7e9bbf15-dd08-4ed9-b60d-53387f202446	c544629d-bb02-4c51-9c23-dc743e51a9b1	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-04-13	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
ce9c6849-3e0e-4e12-94f8-95c82cf3ba2b	c544629d-bb02-4c51-9c23-dc743e51a9b1	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-04-13	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
37ff323a-f519-4305-9de6-bae2444d21b5	c544629d-bb02-4c51-9c23-dc743e51a9b1	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-04-13	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
17e632a5-caf1-404e-ad6f-c65b042c0a58	c544629d-bb02-4c51-9c23-dc743e51a9b1	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-05-14	2026-05-14 03:42:46.004875+00	d35f1354-038a-4273-a177-0c07105cd9d6
1d353b0d-4d95-4c94-9f00-275613165a56	c544629d-bb02-4c51-9c23-dc743e51a9b1	c7221a8c-09bc-4545-84df-058f73f7b11e	Absent	2026-05-12	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
5c6ae4aa-e2fd-4ddd-aad0-15e34a69e91f	299efed3-47cc-4a52-a203-96f8ed2f50c0	cc86eed0-2573-4a68-a478-76a8e8c5c03e	Present	2026-05-20	2026-05-20 20:27:45.358315+00	d35f1354-038a-4273-a177-0c07105cd9d6
9b84978e-5077-44d9-b3cb-7bc468321f7e	a0dee1a9-0426-4878-9726-cb5b880dd961	cc86eed0-2573-4a68-a478-76a8e8c5c03e	Present	2026-05-20	2026-05-20 20:27:45.358315+00	d35f1354-038a-4273-a177-0c07105cd9d6
3b4e1e31-7f21-429f-ab89-219e7c539bad	31e328af-0472-4281-a2f9-8db26e83f2bb	cc86eed0-2573-4a68-a478-76a8e8c5c03e	Present	2026-05-20	2026-05-20 20:27:45.358315+00	d35f1354-038a-4273-a177-0c07105cd9d6
69822114-f41e-4f92-bad0-2ae05f5e3540	502755cd-0595-4ac7-8dba-eb20ac1f69a6	cc86eed0-2573-4a68-a478-76a8e8c5c03e	Present	2026-05-20	2026-05-20 20:27:45.358315+00	d35f1354-038a-4273-a177-0c07105cd9d6
2503bfc0-5f30-4d49-95a3-beb9be5acd2a	f65d5767-5fed-4aa5-9a94-739006d87bb2	cc86eed0-2573-4a68-a478-76a8e8c5c03e	Present	2026-05-20	2026-05-20 20:27:45.358315+00	d35f1354-038a-4273-a177-0c07105cd9d6
e9d5e9b1-e9fc-438c-95ee-7e0ccc3e38d1	bc8f862e-ec2c-4c37-b924-c34864013f1c	cc86eed0-2573-4a68-a478-76a8e8c5c03e	Present	2026-05-20	2026-05-20 20:27:45.358315+00	d35f1354-038a-4273-a177-0c07105cd9d6
bbd4ab09-d5be-46eb-97a0-1a5e7be57f85	380e4e1d-f169-474c-812b-d9a157b98930	cc86eed0-2573-4a68-a478-76a8e8c5c03e	Present	2026-05-20	2026-05-20 20:27:45.358315+00	d35f1354-038a-4273-a177-0c07105cd9d6
08e1d0ad-8e99-45b8-9e03-ca296f81567c	39259dfa-72e0-4568-b6ae-7beb2b01b10f	cc86eed0-2573-4a68-a478-76a8e8c5c03e	Present	2026-05-20	2026-05-20 20:27:45.358315+00	d35f1354-038a-4273-a177-0c07105cd9d6
684ffe6a-81d7-443c-b76b-315238d37fb7	c2ad89fd-2583-4f46-ad0d-8232f6269718	cc86eed0-2573-4a68-a478-76a8e8c5c03e	Present	2026-05-20	2026-05-20 20:27:45.358315+00	d35f1354-038a-4273-a177-0c07105cd9d6
48f3dfb1-ae2f-48a2-b421-07b7ffa84138	c544629d-bb02-4c51-9c23-dc743e51a9b1	cc86eed0-2573-4a68-a478-76a8e8c5c03e	Present	2026-05-20	2026-05-20 20:27:45.358315+00	d35f1354-038a-4273-a177-0c07105cd9d6
89565efb-c9a2-400a-9226-91b452ff8593	44010cff-1b62-4c8a-abab-f43160ecd001	c7221a8c-09bc-4545-84df-058f73f7b11e	Absent	2026-05-26	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
2ed4fdc1-1dd9-4b68-988f-a180f4489051	44010cff-1b62-4c8a-abab-f43160ecd001	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-05-05	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
de7a3037-9a3a-4867-a7b4-3980605bd1b7	44010cff-1b62-4c8a-abab-f43160ecd001	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-05-05	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
b7189e1a-9d84-4c4f-883a-6f49d8a23217	44010cff-1b62-4c8a-abab-f43160ecd001	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-05-04	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
2bc753e4-fc9f-4717-b57a-7f29accb0b23	44010cff-1b62-4c8a-abab-f43160ecd001	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-05-04	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
089ead1e-68ce-4a96-ad76-c734cb1afd66	44010cff-1b62-4c8a-abab-f43160ecd001	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-05-04	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
17140b3c-ee8d-4552-a322-c90b0191c9a0	44010cff-1b62-4c8a-abab-f43160ecd001	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-05-04	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
a7232028-8285-4107-8f6b-dcba9385193e	44010cff-1b62-4c8a-abab-f43160ecd001	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-05-01	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
77f466ca-bec7-408f-bc03-11dd2dbb0999	44010cff-1b62-4c8a-abab-f43160ecd001	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-05-01	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
39f74b6b-432a-4252-9cd8-be721209a375	44010cff-1b62-4c8a-abab-f43160ecd001	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-05-01	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
0eb67c02-3c17-43ef-9654-29f16c067e4d	44010cff-1b62-4c8a-abab-f43160ecd001	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-05-01	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
0a8029e0-6493-45f4-af8a-703035aea405	44010cff-1b62-4c8a-abab-f43160ecd001	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-04-30	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
dfa326c7-a1f7-49df-b984-c29f3c90c52e	44010cff-1b62-4c8a-abab-f43160ecd001	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-04-30	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
0ac34f40-8da0-4d54-b9e3-c1bc60fd1e3d	44010cff-1b62-4c8a-abab-f43160ecd001	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-04-30	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
4efc9056-bf01-4536-a983-c3e06a450903	44010cff-1b62-4c8a-abab-f43160ecd001	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-04-30	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
b08543ed-727b-40bd-b4e4-ed853d740827	44010cff-1b62-4c8a-abab-f43160ecd001	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-04-29	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
134bdc27-5f65-4703-b5d3-d0285b3b47de	44010cff-1b62-4c8a-abab-f43160ecd001	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-04-29	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
47cb5ebf-9071-4207-8629-55f377728393	44010cff-1b62-4c8a-abab-f43160ecd001	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-04-29	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
205f0cfe-59b2-45b6-bdfe-cf19a7a9612d	44010cff-1b62-4c8a-abab-f43160ecd001	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-04-29	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
723ac612-87da-4a04-89a0-341b85886dfc	44010cff-1b62-4c8a-abab-f43160ecd001	c7221a8c-09bc-4545-84df-058f73f7b11e	Absent	2026-04-28	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
bdfc8413-8a8e-4a0e-9a24-75cd67bbb4f5	44010cff-1b62-4c8a-abab-f43160ecd001	65221f54-0a44-4bd1-991d-e08256571e38	Absent	2026-04-28	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
e98643e2-dc58-43cc-b09e-5c3b6421d7fb	44010cff-1b62-4c8a-abab-f43160ecd001	4bb87678-40bf-479d-a97f-662e63cd652f	Absent	2026-04-28	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
320c82e2-ef6b-4b9e-85c5-3637e7867e2b	44010cff-1b62-4c8a-abab-f43160ecd001	931e073f-d654-4f85-88c7-3e48c60a0349	Absent	2026-04-28	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
28884911-142e-4a20-94dc-e70e9b7b5fc2	44010cff-1b62-4c8a-abab-f43160ecd001	c7221a8c-09bc-4545-84df-058f73f7b11e	Present	2026-04-27	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
bd79ade7-1e65-459a-97f9-daf699340e65	44010cff-1b62-4c8a-abab-f43160ecd001	65221f54-0a44-4bd1-991d-e08256571e38	Present	2026-04-27	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
e372fbc5-7b0d-4f95-b87f-91f2df396c41	44010cff-1b62-4c8a-abab-f43160ecd001	4bb87678-40bf-479d-a97f-662e63cd652f	Present	2026-04-27	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
84c79b46-a359-49d4-a2fd-59a53f0944b3	44010cff-1b62-4c8a-abab-f43160ecd001	931e073f-d654-4f85-88c7-3e48c60a0349	Present	2026-04-27	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
\.


--
-- Data for Name: career_metrics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.career_metrics (id, student_id, problem_solving, communication, technical_skills, teamwork, leadership, adaptability, recent_milestones, primary_strength, growth_area, updated_at) FROM stdin;
b54900eb-3421-4ef1-ac18-6056388d577a	1ba77db0-84e2-405d-883e-7de7ddf34bfb	85	65	90	75	60	80	[{"date": "2 days ago", "type": "success", "score": "82%", "title": "Resume ATS Score Improved"}, {"date": "1 week ago", "type": "achievement", "score": null, "title": "Completed AWS Certification"}, {"date": "2 weeks ago", "type": "action", "score": null, "title": "Applied to Google SWE Intern"}]	Technical Skills	Communication	2026-05-26 18:19:16.265553+00
182c75a7-ce54-488f-9435-bd680c542942	44010cff-1b62-4c8a-abab-f43160ecd001	85	65	90	75	60	80	[{"date": "2 days ago", "type": "success", "score": "82%", "title": "Resume ATS Score Improved"}, {"date": "1 week ago", "type": "achievement", "score": null, "title": "Completed AWS Certification"}, {"date": "2 weeks ago", "type": "action", "score": null, "title": "Applied to Google SWE Intern"}]	Technical Skills	Communication	2026-05-26 18:19:16.265553+00
822824b0-d2ab-4f50-919b-8a7885b7c541	299efed3-47cc-4a52-a203-96f8ed2f50c0	85	65	90	75	60	80	[{"date": "2 days ago", "type": "success", "score": "82%", "title": "Resume ATS Score Improved"}, {"date": "1 week ago", "type": "achievement", "score": null, "title": "Completed AWS Certification"}, {"date": "2 weeks ago", "type": "action", "score": null, "title": "Applied to Google SWE Intern"}]	Technical Skills	Communication	2026-05-26 18:19:16.265553+00
e676b643-eb5b-4f45-ae75-83da3ca2dd6f	a0dee1a9-0426-4878-9726-cb5b880dd961	85	65	90	75	60	80	[{"date": "2 days ago", "type": "success", "score": "82%", "title": "Resume ATS Score Improved"}, {"date": "1 week ago", "type": "achievement", "score": null, "title": "Completed AWS Certification"}, {"date": "2 weeks ago", "type": "action", "score": null, "title": "Applied to Google SWE Intern"}]	Technical Skills	Communication	2026-05-26 18:19:16.265553+00
82a4ad31-82b3-4e90-915d-927ea62c1b02	31e328af-0472-4281-a2f9-8db26e83f2bb	85	65	90	75	60	80	[{"date": "2 days ago", "type": "success", "score": "82%", "title": "Resume ATS Score Improved"}, {"date": "1 week ago", "type": "achievement", "score": null, "title": "Completed AWS Certification"}, {"date": "2 weeks ago", "type": "action", "score": null, "title": "Applied to Google SWE Intern"}]	Technical Skills	Communication	2026-05-26 18:19:16.265553+00
cdf18361-a7e7-4025-8fd0-e80e02daf443	502755cd-0595-4ac7-8dba-eb20ac1f69a6	85	65	90	75	60	80	[{"date": "2 days ago", "type": "success", "score": "82%", "title": "Resume ATS Score Improved"}, {"date": "1 week ago", "type": "achievement", "score": null, "title": "Completed AWS Certification"}, {"date": "2 weeks ago", "type": "action", "score": null, "title": "Applied to Google SWE Intern"}]	Technical Skills	Communication	2026-05-26 18:19:16.265553+00
7964753c-dc02-4539-9ce5-621659058d62	f65d5767-5fed-4aa5-9a94-739006d87bb2	85	65	90	75	60	80	[{"date": "2 days ago", "type": "success", "score": "82%", "title": "Resume ATS Score Improved"}, {"date": "1 week ago", "type": "achievement", "score": null, "title": "Completed AWS Certification"}, {"date": "2 weeks ago", "type": "action", "score": null, "title": "Applied to Google SWE Intern"}]	Technical Skills	Communication	2026-05-26 18:19:16.265553+00
e4e369de-95b6-4719-a8ab-b1f869369307	bc8f862e-ec2c-4c37-b924-c34864013f1c	85	65	90	75	60	80	[{"date": "2 days ago", "type": "success", "score": "82%", "title": "Resume ATS Score Improved"}, {"date": "1 week ago", "type": "achievement", "score": null, "title": "Completed AWS Certification"}, {"date": "2 weeks ago", "type": "action", "score": null, "title": "Applied to Google SWE Intern"}]	Technical Skills	Communication	2026-05-26 18:19:16.265553+00
b1cdd799-ad15-4343-ab3b-97b3a81a530b	380e4e1d-f169-474c-812b-d9a157b98930	85	65	90	75	60	80	[{"date": "2 days ago", "type": "success", "score": "82%", "title": "Resume ATS Score Improved"}, {"date": "1 week ago", "type": "achievement", "score": null, "title": "Completed AWS Certification"}, {"date": "2 weeks ago", "type": "action", "score": null, "title": "Applied to Google SWE Intern"}]	Technical Skills	Communication	2026-05-26 18:19:16.265553+00
10a2ddc1-0d23-4886-8e49-425f35b879e7	39259dfa-72e0-4568-b6ae-7beb2b01b10f	85	65	90	75	60	80	[{"date": "2 days ago", "type": "success", "score": "82%", "title": "Resume ATS Score Improved"}, {"date": "1 week ago", "type": "achievement", "score": null, "title": "Completed AWS Certification"}, {"date": "2 weeks ago", "type": "action", "score": null, "title": "Applied to Google SWE Intern"}]	Technical Skills	Communication	2026-05-26 18:19:16.265553+00
edd83f7c-f226-4202-990d-0a985bef92f3	c2ad89fd-2583-4f46-ad0d-8232f6269718	85	65	90	75	60	80	[{"date": "2 days ago", "type": "success", "score": "82%", "title": "Resume ATS Score Improved"}, {"date": "1 week ago", "type": "achievement", "score": null, "title": "Completed AWS Certification"}, {"date": "2 weeks ago", "type": "action", "score": null, "title": "Applied to Google SWE Intern"}]	Technical Skills	Communication	2026-05-26 18:19:16.265553+00
4bf452dc-2961-4878-a298-9d53195e7f33	c544629d-bb02-4c51-9c23-dc743e51a9b1	85	65	90	75	60	80	[{"date": "2 days ago", "type": "success", "score": "82%", "title": "Resume ATS Score Improved"}, {"date": "1 week ago", "type": "achievement", "score": null, "title": "Completed AWS Certification"}, {"date": "2 weeks ago", "type": "action", "score": null, "title": "Applied to Google SWE Intern"}]	Technical Skills	Communication	2026-05-26 18:19:16.265553+00
77b90d93-668f-45cf-b1f7-ae8d86c5e76f	b0000000-0000-0000-0000-000000000002	85	65	90	75	60	80	[{"date": "2 days ago", "type": "success", "score": "82%", "title": "Resume ATS Score Improved"}, {"date": "1 week ago", "type": "achievement", "score": null, "title": "Completed AWS Certification"}, {"date": "2 weeks ago", "type": "action", "score": null, "title": "Applied to Google SWE Intern"}]	Technical Skills	Communication	2026-05-26 18:19:16.265553+00
1d66d171-fc2b-4f12-ac97-f813ad58ec7b	8c20d36c-6246-4026-9938-65eac0eb0ca3	85	65	90	75	60	80	[{"date": "2 days ago", "type": "success", "score": "82%", "title": "Resume ATS Score Improved"}, {"date": "1 week ago", "type": "achievement", "score": null, "title": "Completed AWS Certification"}, {"date": "2 weeks ago", "type": "action", "score": null, "title": "Applied to Google SWE Intern"}]	Technical Skills	Communication	2026-05-26 18:19:16.265553+00
b1314e38-df6c-4abb-a89c-aa30a6aec59a	49a03840-db37-4a6f-bf88-1553a0cb2950	85	65	90	75	60	80	[{"date": "2 days ago", "type": "success", "score": "82%", "title": "Resume ATS Score Improved"}, {"date": "1 week ago", "type": "achievement", "score": null, "title": "Completed AWS Certification"}, {"date": "2 weeks ago", "type": "action", "score": null, "title": "Applied to Google SWE Intern"}]	Technical Skills	Communication	2026-05-26 18:19:16.265553+00
b4e603c0-7a39-417b-83da-78a3dec0d011	29dfd21e-5b74-420b-bb49-48143f8e2b6c	85	65	90	75	60	80	[{"date": "2 days ago", "type": "success", "score": "82%", "title": "Resume ATS Score Improved"}, {"date": "1 week ago", "type": "achievement", "score": null, "title": "Completed AWS Certification"}, {"date": "2 weeks ago", "type": "action", "score": null, "title": "Applied to Google SWE Intern"}]	Technical Skills	Communication	2026-05-26 18:19:16.265553+00
\.


--
-- Data for Name: resumes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resumes (id, student_id, title, resume_data, ats_score, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: job_applications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_applications (id, student_id, company_name, job_title, location, status, salary_range, notes, resume_id, applied_date, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: cover_letters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cover_letters (id, student_id, application_id, content, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: direct_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.direct_messages (id, sender_id, receiver_id, content_type, content_url_or_text, created_at, read_at) FROM stdin;
6777adba-6143-420d-8ad0-0ce7f2e8bb54	d35f1354-038a-4273-a177-0c07105cd9d6	5fd7dc38-f545-4e42-9597-4d981ea55f9e	text	hi	2026-05-24 13:09:50.159109+00	\N
1de9b392-bf3a-47b3-9749-7c845c237853	d35f1354-038a-4273-a177-0c07105cd9d6	5fd7dc38-f545-4e42-9597-4d981ea55f9e	text	hello	2026-05-24 16:50:06.078935+00	\N
ebffa104-b60d-4ed1-888d-a73ddfe8fd5e	5fd7dc38-f545-4e42-9597-4d981ea55f9e	d35f1354-038a-4273-a177-0c07105cd9d6	text	Hello	2026-05-24 16:50:21.296027+00	\N
b8c9e929-890e-4c23-8f20-c8f87801d274	5fd7dc38-f545-4e42-9597-4d981ea55f9e	d35f1354-038a-4273-a177-0c07105cd9d6	text	hello	2026-05-24 17:29:00.191036+00	\N
4fc8028c-c835-4372-a98b-aee15ffadd0d	d35f1354-038a-4273-a177-0c07105cd9d6	5fd7dc38-f545-4e42-9597-4d981ea55f9e	text	Chat is working?	2026-05-24 17:34:00.140827+00	\N
47cf19e5-6c7b-4c69-ab58-a7c44cfae597	d35f1354-038a-4273-a177-0c07105cd9d6	5fd7dc38-f545-4e42-9597-4d981ea55f9e	text	yooooo	2026-05-24 19:08:05.742171+00	\N
ee7d46e1-9bdf-41fa-b6d3-cefaf55a288f	5fd7dc38-f545-4e42-9597-4d981ea55f9e	d35f1354-038a-4273-a177-0c07105cd9d6	text	hii	2026-05-25 11:29:28.016622+00	\N
ada55f3e-c11b-4791-9488-38019750df21	5fd7dc38-f545-4e42-9597-4d981ea55f9e	d35f1354-038a-4273-a177-0c07105cd9d6	text	kill your self	2026-05-25 11:29:37.397965+00	\N
189db45d-5b97-4d58-ac8e-bce28304311b	d35f1354-038a-4273-a177-0c07105cd9d6	5fd7dc38-f545-4e42-9597-4d981ea55f9e	text	hii	2026-05-25 11:34:09.498192+00	\N
cbd4471c-4b5b-4f76-8135-0df6e0cf2680	d35f1354-038a-4273-a177-0c07105cd9d6	5fd7dc38-f545-4e42-9597-4d981ea55f9e	text	yeaa got it	2026-05-25 11:36:30.925766+00	\N
ca07f8f7-c003-4de9-890e-ba6a763f8641	d35f1354-038a-4273-a177-0c07105cd9d6	5fd7dc38-f545-4e42-9597-4d981ea55f9e	text	i will kill myself	2026-05-25 11:36:34.596163+00	\N
8940d42c-2771-4304-89f6-e351cddc0cb4	5fd7dc38-f545-4e42-9597-4d981ea55f9e	d35f1354-038a-4273-a177-0c07105cd9d6	text	hiii	2026-05-25 13:21:15.897236+00	\N
287a11c8-925f-4232-9c73-00ab49f7ab17	5fd7dc38-f545-4e42-9597-4d981ea55f9e	d35f1354-038a-4273-a177-0c07105cd9d6	text	i can't see u	2026-05-25 13:21:21.219395+00	\N
19ab8f29-4103-4450-aafb-55ad328c069f	5fd7dc38-f545-4e42-9597-4d981ea55f9e	d35f1354-038a-4273-a177-0c07105cd9d6	text	screw your self	2026-05-25 15:22:58.466995+00	\N
5a1baa42-ca32-4f70-af47-1c487911288c	5fd7dc38-f545-4e42-9597-4d981ea55f9e	d35f1354-038a-4273-a177-0c07105cd9d6	text	kill your self	2026-05-25 15:23:04.926271+00	\N
b15995e6-635f-4516-812a-5a867d256844	5fd7dc38-f545-4e42-9597-4d981ea55f9e	d35f1354-038a-4273-a177-0c07105cd9d6	text	die	2026-05-25 15:23:10.543455+00	\N
38fd0ae6-8ecf-48a6-8251-5f7b0dd40471	5fd7dc38-f545-4e42-9597-4d981ea55f9e	d35f1354-038a-4273-a177-0c07105cd9d6	text	die	2026-05-25 15:23:12.137378+00	\N
35206edc-59f0-4c75-a8fc-66e6ddcb2fe8	5fd7dc38-f545-4e42-9597-4d981ea55f9e	d35f1354-038a-4273-a177-0c07105cd9d6	text	die	2026-05-25 15:23:13.169153+00	\N
e7ff095c-674d-400d-a3a5-6dca401e42da	5fd7dc38-f545-4e42-9597-4d981ea55f9e	d35f1354-038a-4273-a177-0c07105cd9d6	text	die	2026-05-25 15:23:14.303515+00	\N
25326130-a2ab-4cbd-9a40-fd7fdf5b86f0	5fd7dc38-f545-4e42-9597-4d981ea55f9e	d35f1354-038a-4273-a177-0c07105cd9d6	text	die	2026-05-25 15:23:15.31887+00	\N
19e2a70c-38df-45ad-9622-e0f574644d51	5fd7dc38-f545-4e42-9597-4d981ea55f9e	d35f1354-038a-4273-a177-0c07105cd9d6	text	die	2026-05-25 15:23:16.458434+00	\N
56f94744-0a80-47c2-b8bb-37035312fecc	5fd7dc38-f545-4e42-9597-4d981ea55f9e	d35f1354-038a-4273-a177-0c07105cd9d6	text	die	2026-05-25 15:23:17.838493+00	\N
598f74a3-6a5d-43a0-aefc-38cda6dfbf9c	5fd7dc38-f545-4e42-9597-4d981ea55f9e	d35f1354-038a-4273-a177-0c07105cd9d6	text	can't see	2026-05-25 15:31:31.508943+00	\N
5ba8b215-6954-4d7a-9af9-bf52828c7093	d35f1354-038a-4273-a177-0c07105cd9d6	5fd7dc38-f545-4e42-9597-4d981ea55f9e	text	hello	2026-05-25 15:31:39.929998+00	\N
d7ddafd1-3ee3-4e3d-b34a-ad980ac6e515	5fd7dc38-f545-4e42-9597-4d981ea55f9e	d35f1354-038a-4273-a177-0c07105cd9d6	text	still not workin	2026-05-25 17:08:14.382915+00	\N
d80c44a3-86fa-47cf-817c-169a0f4e299c	5fd7dc38-f545-4e42-9597-4d981ea55f9e	d35f1354-038a-4273-a177-0c07105cd9d6	text	hiii	2026-05-26 12:12:07.762811+00	\N
0c0447ff-2fdc-40b9-8afe-45c05a4bf2c1	5fd7dc38-f545-4e42-9597-4d981ea55f9e	d35f1354-038a-4273-a177-0c07105cd9d6	text	hello	2026-05-26 12:12:11.950238+00	\N
f3442aea-f0c2-4aff-aca3-9f7d633f400c	5fd7dc38-f545-4e42-9597-4d981ea55f9e	d35f1354-038a-4273-a177-0c07105cd9d6	text	hi	2026-05-26 12:20:30.152365+00	\N
faff014b-4478-4e08-a763-99b934ee25e5	d35f1354-038a-4273-a177-0c07105cd9d6	5fd7dc38-f545-4e42-9597-4d981ea55f9e	text	yoo	2026-05-26 12:24:50.05854+00	\N
77d2a924-45a6-4534-a0ed-eb7206adcb9c	d35f1354-038a-4273-a177-0c07105cd9d6	5fd7dc38-f545-4e42-9597-4d981ea55f9e	text	I am doing just audio	2026-05-26 12:24:56.275149+00	\N
ba64462a-c52d-4a65-95f4-93c93c5b6403	5fd7dc38-f545-4e42-9597-4d981ea55f9e	d35f1354-038a-4273-a177-0c07105cd9d6	text	hi	2026-05-26 12:26:27.991394+00	\N
6283c338-f30f-4c1b-8ed9-9b05ee364b1d	d35f1354-038a-4273-a177-0c07105cd9d6	5fd7dc38-f545-4e42-9597-4d981ea55f9e	text	hi	2026-05-26 14:28:30.138248+00	\N
3c0c0bd5-423f-45ef-baad-ef233fa265da	d35f1354-038a-4273-a177-0c07105cd9d6	5fd7dc38-f545-4e42-9597-4d981ea55f9e	text	i can't use audio coz of home	2026-05-26 14:29:06.919803+00	\N
a5d316f8-f26c-4ce4-a606-5fe3b1adab22	5fd7dc38-f545-4e42-9597-4d981ea55f9e	d35f1354-038a-4273-a177-0c07105cd9d6	text	hii	2026-05-26 14:34:30.952223+00	\N
4275e849-f262-40af-8edc-96088caf2324	5fd7dc38-f545-4e42-9597-4d981ea55f9e	d35f1354-038a-4273-a177-0c07105cd9d6	text	....	2026-05-26 14:35:39.606631+00	\N
63b19954-f4f9-4099-8bab-426f5ea6a69a	d35f1354-038a-4273-a177-0c07105cd9d6	5fd7dc38-f545-4e42-9597-4d981ea55f9e	text	hi	2026-05-26 14:35:42.989008+00	\N
a5a609b3-370b-4e08-af8f-9fef59f0ad67	5fd7dc38-f545-4e42-9597-4d981ea55f9e	d35f1354-038a-4273-a177-0c07105cd9d6	text	hello mentor	2026-05-27 06:19:15.58551+00	\N
162b2fde-414a-4d8c-bfe6-7fea313bd094	5fd7dc38-f545-4e42-9597-4d981ea55f9e	d35f1354-038a-4273-a177-0c07105cd9d6	text	my child is sick today	2026-05-27 06:19:25.826578+00	\N
234ec741-ded8-402e-a8c0-4d87d8d99bfb	5fd7dc38-f545-4e42-9597-4d981ea55f9e	d35f1354-038a-4273-a177-0c07105cd9d6	text	so he cannot give todays tyl exam	2026-05-27 06:19:40.932629+00	\N
14689a51-5368-4c96-8130-5de2242b96f9	5fd7dc38-f545-4e42-9597-4d981ea55f9e	d35f1354-038a-4273-a177-0c07105cd9d6	text	can you look into this matter	2026-05-27 06:19:51.259598+00	\N
e4751267-f654-45a6-b15f-694f5a7bdd17	d35f1354-038a-4273-a177-0c07105cd9d6	5fd7dc38-f545-4e42-9597-4d981ea55f9e	text	Ok	2026-05-27 06:21:05.50824+00	\N
b57091f6-c94b-471b-b00a-df37de70a90d	d35f1354-038a-4273-a177-0c07105cd9d6	5fd7dc38-f545-4e42-9597-4d981ea55f9e	text	hii	2026-05-27 09:07:08.4924+00	\N
\.


--
-- Data for Name: enrollments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enrollments (id, student_id, class_id, created_at) FROM stdin;
d409a16c-c17e-46fd-a3ee-259c9dfc3e36	299efed3-47cc-4a52-a203-96f8ed2f50c0	68a2f603-7b91-4404-8fc0-79e611113f89	2026-05-12 15:11:10.943022+00
6c55402e-632d-47b1-b273-fb0ca39b742a	299efed3-47cc-4a52-a203-96f8ed2f50c0	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	2026-05-12 15:11:10.943022+00
61610ca7-e0d4-4898-846a-38cbc98a0fcd	299efed3-47cc-4a52-a203-96f8ed2f50c0	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	2026-05-12 15:11:10.943022+00
c4a31883-a934-4ffa-afc8-863bced05640	299efed3-47cc-4a52-a203-96f8ed2f50c0	14f3b3f5-a555-4dcd-a269-b7132f014a38	2026-05-12 15:11:10.943022+00
cda2813f-341b-46a9-84c7-2344f2a29c0a	a0dee1a9-0426-4878-9726-cb5b880dd961	68a2f603-7b91-4404-8fc0-79e611113f89	2026-05-12 15:11:10.943022+00
9fe5ddb6-3799-4c72-adb9-c8f62d7d1b09	a0dee1a9-0426-4878-9726-cb5b880dd961	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	2026-05-12 15:11:10.943022+00
2f1eb5d5-6748-488b-af9e-aef1dda54d1c	a0dee1a9-0426-4878-9726-cb5b880dd961	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	2026-05-12 15:11:10.943022+00
e9a923bf-e3f8-41be-9615-d2c6c60c2f6f	a0dee1a9-0426-4878-9726-cb5b880dd961	14f3b3f5-a555-4dcd-a269-b7132f014a38	2026-05-12 15:11:10.943022+00
5ca25fc2-917a-4003-9913-7b13c783ee2d	31e328af-0472-4281-a2f9-8db26e83f2bb	68a2f603-7b91-4404-8fc0-79e611113f89	2026-05-12 15:11:10.943022+00
b895195c-5bf2-4069-aa53-1f567720fad6	31e328af-0472-4281-a2f9-8db26e83f2bb	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	2026-05-12 15:11:10.943022+00
58d2ae9f-7f1e-49f0-8d36-2c2959388ffb	31e328af-0472-4281-a2f9-8db26e83f2bb	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	2026-05-12 15:11:10.943022+00
3f82affd-83c1-48cc-bae2-5d2e90616995	31e328af-0472-4281-a2f9-8db26e83f2bb	14f3b3f5-a555-4dcd-a269-b7132f014a38	2026-05-12 15:11:10.943022+00
fb8968aa-dc05-499c-9fa5-871bcd419e67	502755cd-0595-4ac7-8dba-eb20ac1f69a6	68a2f603-7b91-4404-8fc0-79e611113f89	2026-05-12 15:11:10.943022+00
f7db4ebc-420f-40bd-9f76-cefcdf92259f	502755cd-0595-4ac7-8dba-eb20ac1f69a6	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	2026-05-12 15:11:10.943022+00
6d25c669-639b-43db-ab48-8c2b1a664651	502755cd-0595-4ac7-8dba-eb20ac1f69a6	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	2026-05-12 15:11:10.943022+00
58de5d0b-78b4-497c-ba93-491d796d9c03	502755cd-0595-4ac7-8dba-eb20ac1f69a6	14f3b3f5-a555-4dcd-a269-b7132f014a38	2026-05-12 15:11:10.943022+00
ea226357-73c2-4843-9165-72792c5d08e5	f65d5767-5fed-4aa5-9a94-739006d87bb2	68a2f603-7b91-4404-8fc0-79e611113f89	2026-05-12 15:11:10.943022+00
14bccb5f-62fe-4b89-991c-7dd35ea99a8a	f65d5767-5fed-4aa5-9a94-739006d87bb2	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	2026-05-12 15:11:10.943022+00
3a7b326e-736c-4b1b-a00a-7baebcbc2d10	f65d5767-5fed-4aa5-9a94-739006d87bb2	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	2026-05-12 15:11:10.943022+00
1eacadbb-bbe9-4d5b-b0e8-514a37d5cca9	f65d5767-5fed-4aa5-9a94-739006d87bb2	14f3b3f5-a555-4dcd-a269-b7132f014a38	2026-05-12 15:11:10.943022+00
437bf956-fe81-49e6-af91-fac3e5fd7bb5	bc8f862e-ec2c-4c37-b924-c34864013f1c	68a2f603-7b91-4404-8fc0-79e611113f89	2026-05-12 15:11:10.943022+00
753aefbd-afb7-4138-9855-9467d81bbdba	bc8f862e-ec2c-4c37-b924-c34864013f1c	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	2026-05-12 15:11:10.943022+00
8b6f32ce-d410-4a3c-a849-6f3ebb064292	bc8f862e-ec2c-4c37-b924-c34864013f1c	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	2026-05-12 15:11:10.943022+00
959a1889-38ee-4526-ab62-f5a61ba2de2c	bc8f862e-ec2c-4c37-b924-c34864013f1c	14f3b3f5-a555-4dcd-a269-b7132f014a38	2026-05-12 15:11:10.943022+00
53ccc121-7466-4e25-92a8-1c96761c1556	380e4e1d-f169-474c-812b-d9a157b98930	68a2f603-7b91-4404-8fc0-79e611113f89	2026-05-12 15:11:10.943022+00
17f62268-33cf-4fd4-809b-b9b6aaa1b2dc	380e4e1d-f169-474c-812b-d9a157b98930	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	2026-05-12 15:11:10.943022+00
7d214e0b-bb16-4380-915c-5fbd28412148	380e4e1d-f169-474c-812b-d9a157b98930	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	2026-05-12 15:11:10.943022+00
3b8c0a5f-76e0-4d15-9b3c-3fe6f6ffc923	380e4e1d-f169-474c-812b-d9a157b98930	14f3b3f5-a555-4dcd-a269-b7132f014a38	2026-05-12 15:11:10.943022+00
95e87b5e-ec92-42eb-92ea-927ef262da98	39259dfa-72e0-4568-b6ae-7beb2b01b10f	68a2f603-7b91-4404-8fc0-79e611113f89	2026-05-12 15:11:10.943022+00
6b85b551-9ac8-4f5a-8078-1965eac645f1	39259dfa-72e0-4568-b6ae-7beb2b01b10f	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	2026-05-12 15:11:10.943022+00
c5551c1d-3cc3-4e6d-980b-f2cfc78008d5	39259dfa-72e0-4568-b6ae-7beb2b01b10f	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	2026-05-12 15:11:10.943022+00
d47cf91f-5f4e-4426-83b6-00356a9f12a2	39259dfa-72e0-4568-b6ae-7beb2b01b10f	14f3b3f5-a555-4dcd-a269-b7132f014a38	2026-05-12 15:11:10.943022+00
81212cad-dabf-4a05-ba58-584cbd6796a1	c2ad89fd-2583-4f46-ad0d-8232f6269718	68a2f603-7b91-4404-8fc0-79e611113f89	2026-05-12 15:11:10.943022+00
4fa3dbcf-ba63-494f-991e-9fa57d8dee2c	c2ad89fd-2583-4f46-ad0d-8232f6269718	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	2026-05-12 15:11:10.943022+00
49dc8537-fa81-461a-bad3-10d9327d497c	c2ad89fd-2583-4f46-ad0d-8232f6269718	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	2026-05-12 15:11:10.943022+00
8d7a7ce9-95b7-4b97-ada4-95228287eb00	c2ad89fd-2583-4f46-ad0d-8232f6269718	14f3b3f5-a555-4dcd-a269-b7132f014a38	2026-05-12 15:11:10.943022+00
42b618d2-c621-4fd1-a610-c92e81768d3c	c544629d-bb02-4c51-9c23-dc743e51a9b1	c7221a8c-09bc-4545-84df-058f73f7b11e	2026-05-12 19:29:20.777049+00
5c2b2518-8160-4e22-99b3-5803595f65f2	c544629d-bb02-4c51-9c23-dc743e51a9b1	65221f54-0a44-4bd1-991d-e08256571e38	2026-05-12 19:29:20.777049+00
99a6b717-8e2a-469a-9ad7-58dfd7ea2ff0	c544629d-bb02-4c51-9c23-dc743e51a9b1	4bb87678-40bf-479d-a97f-662e63cd652f	2026-05-12 19:29:20.777049+00
350b76a4-99eb-4a10-b02b-85463fe5d4af	c544629d-bb02-4c51-9c23-dc743e51a9b1	931e073f-d654-4f85-88c7-3e48c60a0349	2026-05-12 19:29:20.777049+00
99d7a140-5443-4d92-93d7-0c92cbab7598	299efed3-47cc-4a52-a203-96f8ed2f50c0	cc86eed0-2573-4a68-a478-76a8e8c5c03e	2026-05-20 20:19:00.86134+00
03a0ddc0-903c-4dea-9b3c-24e7632990e4	299efed3-47cc-4a52-a203-96f8ed2f50c0	1313044d-8c1e-4a62-b601-fa076ae77985	2026-05-20 20:19:00.86134+00
70c66e95-5f67-4a84-b08f-0765afa49d71	299efed3-47cc-4a52-a203-96f8ed2f50c0	00411f60-5efc-4770-89b3-9db597b5cff4	2026-05-20 20:19:00.86134+00
2630f01d-2d5d-4815-ad04-7419857c1141	a0dee1a9-0426-4878-9726-cb5b880dd961	cc86eed0-2573-4a68-a478-76a8e8c5c03e	2026-05-20 20:19:00.86134+00
9857fc0d-457a-484c-9b50-c31686cea108	a0dee1a9-0426-4878-9726-cb5b880dd961	1313044d-8c1e-4a62-b601-fa076ae77985	2026-05-20 20:19:00.86134+00
96d41c61-40d9-4bef-82c4-a91e4e50f6fb	a0dee1a9-0426-4878-9726-cb5b880dd961	00411f60-5efc-4770-89b3-9db597b5cff4	2026-05-20 20:19:00.86134+00
e9e46e4b-d536-47f7-a2e5-7a0a7977cfd1	31e328af-0472-4281-a2f9-8db26e83f2bb	cc86eed0-2573-4a68-a478-76a8e8c5c03e	2026-05-20 20:19:00.86134+00
9974c2cc-9403-4369-b6c1-0080f86c6641	31e328af-0472-4281-a2f9-8db26e83f2bb	1313044d-8c1e-4a62-b601-fa076ae77985	2026-05-20 20:19:00.86134+00
71217e12-01b6-4af6-875d-62771bcee1e1	31e328af-0472-4281-a2f9-8db26e83f2bb	00411f60-5efc-4770-89b3-9db597b5cff4	2026-05-20 20:19:00.86134+00
37266ab5-32f6-4a16-addf-c928eb80b626	502755cd-0595-4ac7-8dba-eb20ac1f69a6	cc86eed0-2573-4a68-a478-76a8e8c5c03e	2026-05-20 20:19:00.86134+00
ed9dde34-1ad7-4a7a-a4bb-703eab8f0345	502755cd-0595-4ac7-8dba-eb20ac1f69a6	1313044d-8c1e-4a62-b601-fa076ae77985	2026-05-20 20:19:00.86134+00
9852db2f-f6c1-41ea-bb34-4b5754ab9910	502755cd-0595-4ac7-8dba-eb20ac1f69a6	00411f60-5efc-4770-89b3-9db597b5cff4	2026-05-20 20:19:00.86134+00
80d2c731-8e83-41ec-9ae9-b2eaf89e5844	f65d5767-5fed-4aa5-9a94-739006d87bb2	cc86eed0-2573-4a68-a478-76a8e8c5c03e	2026-05-20 20:19:00.86134+00
ccb1721e-8e65-4db9-8b4a-76e8bbe297ae	f65d5767-5fed-4aa5-9a94-739006d87bb2	1313044d-8c1e-4a62-b601-fa076ae77985	2026-05-20 20:19:00.86134+00
8cdace53-0a80-47fb-ab40-8f665abd5087	f65d5767-5fed-4aa5-9a94-739006d87bb2	00411f60-5efc-4770-89b3-9db597b5cff4	2026-05-20 20:19:00.86134+00
70f8a6b5-e16d-493a-978c-3859b5df349a	bc8f862e-ec2c-4c37-b924-c34864013f1c	cc86eed0-2573-4a68-a478-76a8e8c5c03e	2026-05-20 20:19:00.86134+00
1cb83253-7b7a-4f56-849b-b65cb62be30d	bc8f862e-ec2c-4c37-b924-c34864013f1c	1313044d-8c1e-4a62-b601-fa076ae77985	2026-05-20 20:19:00.86134+00
22ac0c04-ff5b-4fc1-8c34-a2403ccdb2aa	bc8f862e-ec2c-4c37-b924-c34864013f1c	00411f60-5efc-4770-89b3-9db597b5cff4	2026-05-20 20:19:00.86134+00
f117a5bb-037b-4ccb-9648-89c7cd884bf9	380e4e1d-f169-474c-812b-d9a157b98930	cc86eed0-2573-4a68-a478-76a8e8c5c03e	2026-05-20 20:19:00.86134+00
57add670-86f2-41dd-9b2e-857524c7985e	380e4e1d-f169-474c-812b-d9a157b98930	1313044d-8c1e-4a62-b601-fa076ae77985	2026-05-20 20:19:00.86134+00
bb87a5c9-edaa-4c06-8af2-41fef15d9b25	380e4e1d-f169-474c-812b-d9a157b98930	00411f60-5efc-4770-89b3-9db597b5cff4	2026-05-20 20:19:00.86134+00
1b99f4c6-2324-459a-b536-bad0373c2b50	39259dfa-72e0-4568-b6ae-7beb2b01b10f	cc86eed0-2573-4a68-a478-76a8e8c5c03e	2026-05-20 20:19:00.86134+00
c60fd2af-4d03-4d57-a2f4-3503479c539c	39259dfa-72e0-4568-b6ae-7beb2b01b10f	1313044d-8c1e-4a62-b601-fa076ae77985	2026-05-20 20:19:00.86134+00
2e10ee93-f8f5-43fd-9f3f-ce0c5630435b	39259dfa-72e0-4568-b6ae-7beb2b01b10f	00411f60-5efc-4770-89b3-9db597b5cff4	2026-05-20 20:19:00.86134+00
2c581fa6-3521-4f47-b896-80b697259196	c2ad89fd-2583-4f46-ad0d-8232f6269718	cc86eed0-2573-4a68-a478-76a8e8c5c03e	2026-05-20 20:19:00.86134+00
4571b92e-af2e-4cba-a56a-d4c0fea8be23	c2ad89fd-2583-4f46-ad0d-8232f6269718	1313044d-8c1e-4a62-b601-fa076ae77985	2026-05-20 20:19:00.86134+00
850d3afe-c546-44ff-828a-75ceeebc37e3	c2ad89fd-2583-4f46-ad0d-8232f6269718	00411f60-5efc-4770-89b3-9db597b5cff4	2026-05-20 20:19:00.86134+00
39e72248-f50a-46a0-9837-7c303b8a743d	c544629d-bb02-4c51-9c23-dc743e51a9b1	cc86eed0-2573-4a68-a478-76a8e8c5c03e	2026-05-20 20:19:00.86134+00
49302a38-de6a-4089-aa1c-322d8d42880d	c544629d-bb02-4c51-9c23-dc743e51a9b1	1313044d-8c1e-4a62-b601-fa076ae77985	2026-05-20 20:19:00.86134+00
009998d7-9ea8-49cd-b998-bec904de7bda	c544629d-bb02-4c51-9c23-dc743e51a9b1	00411f60-5efc-4770-89b3-9db597b5cff4	2026-05-20 20:19:00.86134+00
e53cf619-fc8f-4b55-bb92-129e34500d3a	b0000000-0000-0000-0000-000000000002	68a2f603-7b91-4404-8fc0-79e611113f89	2026-05-20 20:53:05.728364+00
92806e65-4042-4d98-b238-73665824e9e5	b0000000-0000-0000-0000-000000000002	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	2026-05-20 20:53:05.728364+00
44775dcb-9f87-4333-a527-8687b04e0152	b0000000-0000-0000-0000-000000000002	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	2026-05-20 20:53:05.728364+00
687b994e-09de-463a-84f4-5ac45c3bb24f	b0000000-0000-0000-0000-000000000002	14f3b3f5-a555-4dcd-a269-b7132f014a38	2026-05-20 20:53:05.728364+00
8b71d8a3-4354-436d-a275-54ee6fccc31a	b0000000-0000-0000-0000-000000000002	c7221a8c-09bc-4545-84df-058f73f7b11e	2026-05-20 20:53:05.728364+00
a0113b3e-9efb-48b8-956b-8e14cfdfc581	b0000000-0000-0000-0000-000000000002	65221f54-0a44-4bd1-991d-e08256571e38	2026-05-20 20:53:05.728364+00
5061ce59-b90e-40a9-a155-8ce80f1e53e8	b0000000-0000-0000-0000-000000000002	4bb87678-40bf-479d-a97f-662e63cd652f	2026-05-20 20:53:05.728364+00
a174efca-6fa5-4cc9-b6e8-074247bd936e	b0000000-0000-0000-0000-000000000002	931e073f-d654-4f85-88c7-3e48c60a0349	2026-05-20 20:53:05.728364+00
2359d238-870c-4aad-9856-abe3bb07e3f6	b0000000-0000-0000-0000-000000000002	cc86eed0-2573-4a68-a478-76a8e8c5c03e	2026-05-20 20:53:05.728364+00
32823531-f62a-4c49-9316-2f9cf11b7dfa	b0000000-0000-0000-0000-000000000002	1313044d-8c1e-4a62-b601-fa076ae77985	2026-05-20 20:53:05.728364+00
d3419f7b-8a9c-4440-9670-7469560ef955	b0000000-0000-0000-0000-000000000002	00411f60-5efc-4770-89b3-9db597b5cff4	2026-05-20 20:53:05.728364+00
0f425800-6cc2-4da3-bf5e-033db2ccd620	44010cff-1b62-4c8a-abab-f43160ecd001	c7221a8c-09bc-4545-84df-058f73f7b11e	2026-05-26 17:09:58.542051+00
d19df4e0-654f-44be-8bbe-bed658097a26	44010cff-1b62-4c8a-abab-f43160ecd001	65221f54-0a44-4bd1-991d-e08256571e38	2026-05-26 17:09:58.542051+00
7d0e55a5-482a-4101-a9ac-5eece1606778	44010cff-1b62-4c8a-abab-f43160ecd001	4bb87678-40bf-479d-a97f-662e63cd652f	2026-05-26 17:09:58.542051+00
ce744f84-d815-442e-a3fe-58cbd5a1d1ac	44010cff-1b62-4c8a-abab-f43160ecd001	931e073f-d654-4f85-88c7-3e48c60a0349	2026-05-26 17:09:58.542051+00
\.


--
-- Data for Name: erp_attendance_summary; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.erp_attendance_summary (id, student_id, class_id, theory_held, theory_attended, theory_percentage, lab_held, lab_attended, lab_percentage, updated_at) FROM stdin;
0ec00ae6-3547-43b1-bd28-9f7dec8fbacc	b0000000-0000-0000-0000-000000000002	931e073f-d654-4f85-88c7-3e48c60a0349	42	40	95.24	11	8	72.73	2026-05-31 07:27:30.691+00
c23bdc58-9a3b-4c21-b179-fc0e561b223b	b0000000-0000-0000-0000-000000000002	cc86eed0-2573-4a68-a478-76a8e8c5c03e	43	34	79.07	11	5	45.45	2026-05-31 07:27:30.74+00
8edda838-5e1e-4d48-93ac-bd371e7a83db	b0000000-0000-0000-0000-000000000002	1313044d-8c1e-4a62-b601-fa076ae77985	39	34	87.18	0	0	0	2026-05-31 07:27:30.769+00
6b96a45a-cd1e-4222-9787-9f7d65cc30cc	b0000000-0000-0000-0000-000000000002	00411f60-5efc-4770-89b3-9db597b5cff4	41	34	82.93	9	3	33.33	2026-05-31 07:27:30.793+00
\.


--
-- Data for Name: erp_credentials; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.erp_credentials (student_id, username, updated_at, password_encrypted) FROM stdin;
b0000000-0000-0000-0000-000000000002	amogh.cseaiml24@cmrit.ac.in	2026-05-20 20:48:06.980007+00	\\xc30d0407030241e84e04ba77a4c36bd237010c8130bc87c4c647a04dd5ae4d6aa8a92bf7e687b21cb448a30b457720d30e3ac8c744fd9ea2145728ca1f0843b047f8fe79167e6ba7
\.


--
-- Data for Name: fee_payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fee_payments (id, student_id, payment_type, amount, status, razorpay_order_id, razorpay_payment_id, receipt_url, subjects, created_at, updated_at) FROM stdin;
31038299-f381-48b5-b142-e336cc6b3888	c544629d-bb02-4c51-9c23-dc743e51a9b1	revaluation	500.00	completed	sim_order_1779823081994	sim_pay_1779823081994	\N	\N	2026-05-26 19:18:02.841043+00	2026-05-26 19:18:02.841043+00
e15990b4-0830-4439-b0aa-1b84c84d3c9c	c544629d-bb02-4c51-9c23-dc743e51a9b1	revaluation	500.00	completed	order_Su6fRrMBzQq6RX	pay_Su6fuCFLJgVGRY	\N	\N	2026-05-26 19:23:22.960416+00	2026-05-26 19:23:22.960416+00
a7385dff-b8e9-4dbd-a657-df6b3985beb0	c544629d-bb02-4c51-9c23-dc743e51a9b1	revaluation	500.00	completed	order_Su6jw2GPy5eiIn	pay_Su6k6uMYDoz5rC	\N	\N	2026-05-26 19:27:18.433562+00	2026-05-26 19:27:18.433562+00
ac540846-da8f-46e0-bcb6-09f640a34d54	c544629d-bb02-4c51-9c23-dc743e51a9b1	revaluation	500.00	completed	order_Su6qkZ0iu8UYGP	pay_Su6rKHUX5YRIUd	\N	\N	2026-05-26 19:34:12.446326+00	2026-05-26 19:34:12.446326+00
ce0f5f5e-2a8c-4b34-9e6d-85e911c317e9	c544629d-bb02-4c51-9c23-dc743e51a9b1	revaluation	500.00	completed	order_SuGeBfD3b69eq6	pay_SuGeYWiA8iHwX9	\N	\N	2026-05-27 05:09:37.039737+00	2026-05-27 05:09:37.039737+00
\.


--
-- Data for Name: grades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.grades (id, student_id, class_id, internal_marks, external_marks, updated_at, created_at, mentor_id) FROM stdin;
2858590d-91d2-4db1-ab2e-826424b7d686	299efed3-47cc-4a52-a203-96f8ed2f50c0	68a2f603-7b91-4404-8fc0-79e611113f89	32.00	41.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
5afb1c38-c628-4a88-bed9-ef304334ac8c	299efed3-47cc-4a52-a203-96f8ed2f50c0	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	17.00	23.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
4f196cce-5d39-4c31-aad4-4e116b5ae81e	299efed3-47cc-4a52-a203-96f8ed2f50c0	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	38.00	35.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
ea7b76a9-638f-4826-90cb-d32dc3a38af2	299efed3-47cc-4a52-a203-96f8ed2f50c0	14f3b3f5-a555-4dcd-a269-b7132f014a38	34.00	29.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
37bab0f8-0bb8-4109-8386-84e20d9cd515	a0dee1a9-0426-4878-9726-cb5b880dd961	68a2f603-7b91-4404-8fc0-79e611113f89	33.00	32.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f6c3232d-888e-4b90-8d62-25727a6c3abc	a0dee1a9-0426-4878-9726-cb5b880dd961	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	11.00	29.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
964b2f2f-0950-4878-ae6f-fe4e1225138a	a0dee1a9-0426-4878-9726-cb5b880dd961	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	27.00	35.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
c6732c5c-84f7-4a2b-bdcb-e8e335b3fee2	a0dee1a9-0426-4878-9726-cb5b880dd961	14f3b3f5-a555-4dcd-a269-b7132f014a38	34.00	35.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
96a484b3-6106-4710-8eb4-3eb230fcf626	31e328af-0472-4281-a2f9-8db26e83f2bb	68a2f603-7b91-4404-8fc0-79e611113f89	34.00	41.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
59aeb829-ceac-4c8c-8de1-9e1b2babd809	31e328af-0472-4281-a2f9-8db26e83f2bb	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	25.00	18.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
132ccefc-302f-421c-910f-dd1cd65f73a5	31e328af-0472-4281-a2f9-8db26e83f2bb	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	33.00	32.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
5832de1d-273a-4308-9558-0d07dc25f2c9	31e328af-0472-4281-a2f9-8db26e83f2bb	14f3b3f5-a555-4dcd-a269-b7132f014a38	30.00	29.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
88da13f4-ee73-4756-b22d-37e6864feb80	502755cd-0595-4ac7-8dba-eb20ac1f69a6	68a2f603-7b91-4404-8fc0-79e611113f89	44.00	40.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
110c41b4-25c6-483e-8c20-51c9296f7289	502755cd-0595-4ac7-8dba-eb20ac1f69a6	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	19.00	18.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
c32c84a9-171f-4eb8-a65e-ec177956e124	502755cd-0595-4ac7-8dba-eb20ac1f69a6	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	28.00	29.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
fa9ad83c-0ae3-459e-93d6-c9a01b0d104b	502755cd-0595-4ac7-8dba-eb20ac1f69a6	14f3b3f5-a555-4dcd-a269-b7132f014a38	26.00	21.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
9436f30f-a9ad-4e2b-805c-400e0ce12a9c	f65d5767-5fed-4aa5-9a94-739006d87bb2	68a2f603-7b91-4404-8fc0-79e611113f89	36.00	31.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
6c205bff-4f76-4ae1-8a9f-c4a7ee5a48ca	f65d5767-5fed-4aa5-9a94-739006d87bb2	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	31.00	29.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
3b03d0ac-7ee1-444c-a108-af94337ffd6b	f65d5767-5fed-4aa5-9a94-739006d87bb2	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	33.00	34.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
c7171c80-b4f2-469f-8fac-0b3574a2c7a7	f65d5767-5fed-4aa5-9a94-739006d87bb2	14f3b3f5-a555-4dcd-a269-b7132f014a38	28.00	27.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
9a562308-b5eb-47f7-b89a-a48007dabec4	bc8f862e-ec2c-4c37-b924-c34864013f1c	68a2f603-7b91-4404-8fc0-79e611113f89	44.00	31.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
7189610b-46e9-4295-8d80-eb57ee2562e1	bc8f862e-ec2c-4c37-b924-c34864013f1c	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	11.00	25.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
5baad4ed-4870-4bf8-8c10-5fdfb13668f0	bc8f862e-ec2c-4c37-b924-c34864013f1c	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	34.00	31.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
92b39afc-b077-433f-a566-f17c490e62ff	bc8f862e-ec2c-4c37-b924-c34864013f1c	14f3b3f5-a555-4dcd-a269-b7132f014a38	29.00	26.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
dc291e8d-b499-4e86-b1bc-6a4bca7094c0	380e4e1d-f169-474c-812b-d9a157b98930	68a2f603-7b91-4404-8fc0-79e611113f89	32.00	43.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
d86fc2fa-e0de-4a68-aa15-b4d68fb41c55	380e4e1d-f169-474c-812b-d9a157b98930	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	19.00	25.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
05687f4a-be13-47aa-86b6-677fc452d4cb	380e4e1d-f169-474c-812b-d9a157b98930	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	26.00	27.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
8cade6ab-fac8-4780-bc1b-176e3ca51835	380e4e1d-f169-474c-812b-d9a157b98930	14f3b3f5-a555-4dcd-a269-b7132f014a38	22.00	38.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
da100804-42c4-46d2-9f5f-b93bdaf44ff3	39259dfa-72e0-4568-b6ae-7beb2b01b10f	68a2f603-7b91-4404-8fc0-79e611113f89	44.00	36.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
c921953a-aabb-4f14-9270-6ce7b4779557	39259dfa-72e0-4568-b6ae-7beb2b01b10f	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	16.00	34.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
5e539598-32e5-46fd-a784-d0c7da2c7869	39259dfa-72e0-4568-b6ae-7beb2b01b10f	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	39.00	39.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
21c61f5b-b308-43d4-8625-5169bd02c294	39259dfa-72e0-4568-b6ae-7beb2b01b10f	14f3b3f5-a555-4dcd-a269-b7132f014a38	21.00	36.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
109085c9-7cb1-422e-bce4-455c18343979	c2ad89fd-2583-4f46-ad0d-8232f6269718	68a2f603-7b91-4404-8fc0-79e611113f89	35.00	34.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f5e0d9c6-8572-4035-b4ba-a75e773af05c	c2ad89fd-2583-4f46-ad0d-8232f6269718	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	31.00	34.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
19178c88-2327-48b0-b621-1f5121212d8c	c2ad89fd-2583-4f46-ad0d-8232f6269718	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	25.00	36.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
3e58f9e9-d71a-448b-b6c8-a62b2e096c8a	c2ad89fd-2583-4f46-ad0d-8232f6269718	14f3b3f5-a555-4dcd-a269-b7132f014a38	17.00	26.00	2026-05-31 15:44:03.395608+00	2026-05-12 15:11:10.943022+00	d35f1354-038a-4273-a177-0c07105cd9d6
f98bf99c-34a6-4c1d-b903-20511a2dc1d6	c544629d-bb02-4c51-9c23-dc743e51a9b1	c7221a8c-09bc-4545-84df-058f73f7b11e	42.00	38.00	2026-05-31 15:44:03.395608+00	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
de7dafda-ca30-4e9e-b0fa-8cd039a513a5	c544629d-bb02-4c51-9c23-dc743e51a9b1	65221f54-0a44-4bd1-991d-e08256571e38	48.00	45.00	2026-05-31 15:44:03.395608+00	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
3364f40b-4116-4ff7-b1d7-1a6725bec209	c544629d-bb02-4c51-9c23-dc743e51a9b1	4bb87678-40bf-479d-a97f-662e63cd652f	35.00	30.00	2026-05-31 15:44:03.395608+00	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
37608a2a-0849-447b-bd90-392635a470db	c544629d-bb02-4c51-9c23-dc743e51a9b1	931e073f-d654-4f85-88c7-3e48c60a0349	45.00	42.00	2026-05-31 15:44:03.395608+00	2026-05-12 19:29:20.777049+00	d35f1354-038a-4273-a177-0c07105cd9d6
76a2bb9b-222b-4fff-bc12-29a60539baea	44010cff-1b62-4c8a-abab-f43160ecd001	c7221a8c-09bc-4545-84df-058f73f7b11e	42.00	38.00	2026-05-31 15:44:03.395608+00	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
fe588d8d-556f-4d2d-9996-ddc3b8f586bc	44010cff-1b62-4c8a-abab-f43160ecd001	65221f54-0a44-4bd1-991d-e08256571e38	48.00	45.00	2026-05-31 15:44:03.395608+00	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
219a3e1a-7269-4221-8903-faa0923198f6	44010cff-1b62-4c8a-abab-f43160ecd001	4bb87678-40bf-479d-a97f-662e63cd652f	35.00	30.00	2026-05-31 15:44:03.395608+00	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
6838a80a-7af6-45d8-a02f-73877d2edd05	44010cff-1b62-4c8a-abab-f43160ecd001	931e073f-d654-4f85-88c7-3e48c60a0349	45.00	42.00	2026-05-31 15:44:03.395608+00	2026-05-26 17:09:58.542051+00	d35f1354-038a-4273-a177-0c07105cd9d6
\.


--
-- Data for Name: iat_marks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.iat_marks (id, student_id, class_id, remarks, updated_at, created_at, iat1, iat2, lab_iat1, lab_iat2, assignment1, assignment2) FROM stdin;
c9ccfa39-4158-490a-837b-89c9fe73595e	299efed3-47cc-4a52-a203-96f8ed2f50c0	68a2f603-7b91-4404-8fc0-79e611113f89	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
42e14843-fb54-4ce9-b78c-418d39cb7eae	299efed3-47cc-4a52-a203-96f8ed2f50c0	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
f3ffecd2-192e-4a7a-a154-3dfe873a2be6	299efed3-47cc-4a52-a203-96f8ed2f50c0	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
9af9a047-814b-4871-ae03-e6e05c45cbc9	299efed3-47cc-4a52-a203-96f8ed2f50c0	14f3b3f5-a555-4dcd-a269-b7132f014a38	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
6d981a48-bdd1-45f1-9c43-86bb02453b38	a0dee1a9-0426-4878-9726-cb5b880dd961	68a2f603-7b91-4404-8fc0-79e611113f89	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
6c72a911-0433-49a3-bbfc-5817265ad04e	a0dee1a9-0426-4878-9726-cb5b880dd961	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
fab6d2b4-983c-4f1c-941b-a4d572139bad	a0dee1a9-0426-4878-9726-cb5b880dd961	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
b09acbdc-081a-4496-85f1-ee3700488862	a0dee1a9-0426-4878-9726-cb5b880dd961	14f3b3f5-a555-4dcd-a269-b7132f014a38	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
91945cfe-2dd7-4c8e-8586-1da15af1eb4b	31e328af-0472-4281-a2f9-8db26e83f2bb	68a2f603-7b91-4404-8fc0-79e611113f89	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
16678ef6-eb71-4112-bc7d-6a1dbc7cefc0	31e328af-0472-4281-a2f9-8db26e83f2bb	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
b1765a08-ec71-4853-ac25-9befb7c72cae	31e328af-0472-4281-a2f9-8db26e83f2bb	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
9f61c06c-f145-4411-aebe-68b3af45eed2	31e328af-0472-4281-a2f9-8db26e83f2bb	14f3b3f5-a555-4dcd-a269-b7132f014a38	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
06362dbc-2433-47fd-a981-7eec847b531c	502755cd-0595-4ac7-8dba-eb20ac1f69a6	68a2f603-7b91-4404-8fc0-79e611113f89	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
09768215-0b2c-4326-8c8a-77d9f8ec98d2	502755cd-0595-4ac7-8dba-eb20ac1f69a6	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
21860543-dc1c-48cf-b72f-10812d032145	502755cd-0595-4ac7-8dba-eb20ac1f69a6	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
979e05de-d84b-4c70-bfd2-b57f15d2bd62	502755cd-0595-4ac7-8dba-eb20ac1f69a6	14f3b3f5-a555-4dcd-a269-b7132f014a38	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
6048cff7-af9b-4c99-8b3b-a1a14d0db00e	f65d5767-5fed-4aa5-9a94-739006d87bb2	68a2f603-7b91-4404-8fc0-79e611113f89	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
24d5d8f3-1ed4-41c3-945c-618fa71a19b8	f65d5767-5fed-4aa5-9a94-739006d87bb2	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
ce02bbc0-8c99-4746-8183-138377ca383d	f65d5767-5fed-4aa5-9a94-739006d87bb2	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
9759b079-4c08-457c-93b3-b0ea03a1d327	f65d5767-5fed-4aa5-9a94-739006d87bb2	14f3b3f5-a555-4dcd-a269-b7132f014a38	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
508cf7e7-c577-436e-ba72-bdd81bd43729	bc8f862e-ec2c-4c37-b924-c34864013f1c	68a2f603-7b91-4404-8fc0-79e611113f89	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
e7a3ed9f-e225-4b8f-8ad9-4b9f9f7f6b48	bc8f862e-ec2c-4c37-b924-c34864013f1c	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
d0370de9-b201-4435-ad5b-4d0ed87cbe2c	bc8f862e-ec2c-4c37-b924-c34864013f1c	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
52f6f0bd-521d-402d-afe4-fd16045692a3	bc8f862e-ec2c-4c37-b924-c34864013f1c	14f3b3f5-a555-4dcd-a269-b7132f014a38	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
73849f2f-d770-4ce1-940b-503522f723a8	380e4e1d-f169-474c-812b-d9a157b98930	68a2f603-7b91-4404-8fc0-79e611113f89	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
59d95b52-da11-40b5-bcb0-67e0fa8b6698	380e4e1d-f169-474c-812b-d9a157b98930	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
f0492c52-ab8d-4ad1-aea3-0807f10ad421	380e4e1d-f169-474c-812b-d9a157b98930	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
89851e87-a8a5-46f0-aa27-a8bc19c7572b	380e4e1d-f169-474c-812b-d9a157b98930	14f3b3f5-a555-4dcd-a269-b7132f014a38	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
b84d4a23-c540-4402-941b-8fa20f340dca	39259dfa-72e0-4568-b6ae-7beb2b01b10f	68a2f603-7b91-4404-8fc0-79e611113f89	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
03e08026-eed3-4c58-aaf7-223824041aee	39259dfa-72e0-4568-b6ae-7beb2b01b10f	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
6783d1c8-472f-4b5e-be6f-27eab4219875	39259dfa-72e0-4568-b6ae-7beb2b01b10f	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
ee98f32c-1766-430b-b812-0bd48cf5430c	39259dfa-72e0-4568-b6ae-7beb2b01b10f	14f3b3f5-a555-4dcd-a269-b7132f014a38	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
2cccacb5-5901-4c63-ab64-6ce760808e90	c2ad89fd-2583-4f46-ad0d-8232f6269718	68a2f603-7b91-4404-8fc0-79e611113f89	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
23c427c3-9d1c-46a0-a08a-98824236f092	c2ad89fd-2583-4f46-ad0d-8232f6269718	265e5f6a-4e4d-482f-b1b4-d1b6c5ac20aa	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
e39bf238-9cc6-4a2e-b5b2-316998996485	c2ad89fd-2583-4f46-ad0d-8232f6269718	a71c17ce-0e85-40dc-8d1c-ba0a0fe67bc7	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
270c0bc8-090c-4fbc-8d20-7053bed59725	c2ad89fd-2583-4f46-ad0d-8232f6269718	14f3b3f5-a555-4dcd-a269-b7132f014a38	IAT 1 conducted on 12 Apr 2026	2026-05-12 15:11:29.177265+00	2026-05-12 15:11:29.177265+00	\N	\N	\N	\N	\N	\N
7d6d479a-13cc-4491-aae8-8b0881348579	c544629d-bb02-4c51-9c23-dc743e51a9b1	931e073f-d654-4f85-88c7-3e48c60a0349	\N	2026-05-20 20:05:38.853183+00	2026-05-20 20:00:40.831025+00	45.00	45.00	45.00	42.00	10.00	9.00
7ff20364-29f0-4442-866f-59180e485c72	c544629d-bb02-4c51-9c23-dc743e51a9b1	cc86eed0-2573-4a68-a478-76a8e8c5c03e	\N	2026-05-20 20:23:57.429808+00	2026-05-20 20:21:38.999212+00	45.00	45.00	45.00	42.00	10.00	9.00
e22cc5e0-afe7-45a7-b8a1-3e82b44b254e	299efed3-47cc-4a52-a203-96f8ed2f50c0	cc86eed0-2573-4a68-a478-76a8e8c5c03e	\N	2026-05-20 20:23:57.429808+00	2026-05-20 20:22:17.112264+00	32.00	24.00	50.00	23.00	3.00	3.00
73072dc5-babd-43cc-8a57-08c88eecf757	b0000000-0000-0000-0000-000000000002	14f3b3f5-a555-4dcd-a269-b7132f014a38	\N	2026-05-21 12:43:50.460206+00	2026-05-21 08:33:22.138656+00	45.00	12.00	42.00	32.00	9.00	9.00
\.


--
-- Data for Name: interventions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.interventions (id, mentor_id, student_id, type, notes, date, created_at) FROM stdin;
2336a0a7-6c63-452a-961b-879e899f226f	d35f1354-038a-4273-a177-0c07105cd9d6	299efed3-47cc-4a52-a203-96f8ed2f50c0	Message	AI Composed [email]:\nhello	2026-05-20	2026-05-20 23:46:41.672299+00
18797644-6013-4365-a32d-731d743a883c	d35f1354-038a-4273-a177-0c07105cd9d6	a0dee1a9-0426-4878-9726-cb5b880dd961	Message	AI Composed [email]:\nhello	2026-05-20	2026-05-20 23:46:41.82493+00
b96c9ab1-3146-4dc0-b438-db81483e6be4	d35f1354-038a-4273-a177-0c07105cd9d6	31e328af-0472-4281-a2f9-8db26e83f2bb	Message	AI Composed [email]:\nhello	2026-05-20	2026-05-20 23:46:41.962293+00
6995a66c-139c-473a-81d2-b6fa27b7dc9c	d35f1354-038a-4273-a177-0c07105cd9d6	502755cd-0595-4ac7-8dba-eb20ac1f69a6	Message	AI Composed [email]:\nhello	2026-05-20	2026-05-20 23:46:42.103256+00
1345aa6d-e5ca-4c63-86fc-13f2a83d8372	d35f1354-038a-4273-a177-0c07105cd9d6	f65d5767-5fed-4aa5-9a94-739006d87bb2	Message	AI Composed [email]:\nhello	2026-05-20	2026-05-20 23:46:42.24235+00
05833aea-72d9-4cca-a9d1-03a3f662d025	d35f1354-038a-4273-a177-0c07105cd9d6	bc8f862e-ec2c-4c37-b924-c34864013f1c	Message	AI Composed [email]:\nhello	2026-05-20	2026-05-20 23:46:42.381608+00
616d087e-8080-47a7-a13f-fad4f9af43aa	d35f1354-038a-4273-a177-0c07105cd9d6	380e4e1d-f169-474c-812b-d9a157b98930	Message	AI Composed [email]:\nhello	2026-05-20	2026-05-20 23:46:42.518866+00
6290d854-c6cf-4b4e-872a-bdd6fc4a5624	d35f1354-038a-4273-a177-0c07105cd9d6	39259dfa-72e0-4568-b6ae-7beb2b01b10f	Message	AI Composed [email]:\nhello	2026-05-20	2026-05-20 23:46:42.659862+00
a261278e-4cd2-4ee5-b895-79c5b26e7617	d35f1354-038a-4273-a177-0c07105cd9d6	c2ad89fd-2583-4f46-ad0d-8232f6269718	Message	AI Composed [email]:\nhello	2026-05-20	2026-05-20 23:46:42.797044+00
2a62a289-cbfe-4d9a-afbd-9f32d424c785	d35f1354-038a-4273-a177-0c07105cd9d6	c544629d-bb02-4c51-9c23-dc743e51a9b1	Message	AI Composed [email]:\nhello	2026-05-20	2026-05-20 23:46:42.9367+00
f3649dd8-8990-49aa-810d-7eb96cd1e531	d35f1354-038a-4273-a177-0c07105cd9d6	b0000000-0000-0000-0000-000000000002	Message	AI Composed [email]:\nhello	2026-05-20	2026-05-20 23:46:43.075948+00
453b0a1c-04da-44c3-94ee-4ad3e6394886	d35f1354-038a-4273-a177-0c07105cd9d6	299efed3-47cc-4a52-a203-96f8ed2f50c0	Message	AI Composed [email]:\nhelloo this is a test message	2026-05-20	2026-05-20 23:47:06.428977+00
706b17e0-d93b-45a8-b1c4-69f77b30832c	d35f1354-038a-4273-a177-0c07105cd9d6	a0dee1a9-0426-4878-9726-cb5b880dd961	Message	AI Composed [email]:\nhelloo this is a test message	2026-05-20	2026-05-20 23:47:06.578794+00
923e529a-c7f1-4568-af88-9b215706b62c	d35f1354-038a-4273-a177-0c07105cd9d6	31e328af-0472-4281-a2f9-8db26e83f2bb	Message	AI Composed [email]:\nhelloo this is a test message	2026-05-20	2026-05-20 23:47:06.721252+00
1cf8d557-14e0-4a63-85ed-de38f138ed76	d35f1354-038a-4273-a177-0c07105cd9d6	502755cd-0595-4ac7-8dba-eb20ac1f69a6	Message	AI Composed [email]:\nhelloo this is a test message	2026-05-20	2026-05-20 23:47:06.865531+00
bffb0ded-a0b8-4fff-83ed-b065c6dcf8de	d35f1354-038a-4273-a177-0c07105cd9d6	f65d5767-5fed-4aa5-9a94-739006d87bb2	Message	AI Composed [email]:\nhelloo this is a test message	2026-05-20	2026-05-20 23:47:07.268787+00
542cd4d1-3a7a-4838-812f-db7b590b3c26	d35f1354-038a-4273-a177-0c07105cd9d6	bc8f862e-ec2c-4c37-b924-c34864013f1c	Message	AI Composed [email]:\nhelloo this is a test message	2026-05-20	2026-05-20 23:47:07.411603+00
e681d30d-181d-41ef-a6d1-8e1c7250ac8f	d35f1354-038a-4273-a177-0c07105cd9d6	380e4e1d-f169-474c-812b-d9a157b98930	Message	AI Composed [email]:\nhelloo this is a test message	2026-05-20	2026-05-20 23:47:07.553816+00
c35eae5e-3e5f-4634-8ccd-a469ef7154d2	d35f1354-038a-4273-a177-0c07105cd9d6	39259dfa-72e0-4568-b6ae-7beb2b01b10f	Message	AI Composed [email]:\nhelloo this is a test message	2026-05-20	2026-05-20 23:47:07.69614+00
41a73b9b-9563-4b36-a544-33bf51f62337	d35f1354-038a-4273-a177-0c07105cd9d6	c2ad89fd-2583-4f46-ad0d-8232f6269718	Message	AI Composed [email]:\nhelloo this is a test message	2026-05-20	2026-05-20 23:47:07.837615+00
3b281863-24a5-4277-b5d3-a867f73c212b	d35f1354-038a-4273-a177-0c07105cd9d6	c544629d-bb02-4c51-9c23-dc743e51a9b1	Message	AI Composed [email]:\nhelloo this is a test message	2026-05-20	2026-05-20 23:47:07.985186+00
a9b80d96-1e17-4b07-ae64-157c62870f3b	d35f1354-038a-4273-a177-0c07105cd9d6	b0000000-0000-0000-0000-000000000002	Message	AI Composed [email]:\nhelloo this is a test message	2026-05-20	2026-05-20 23:47:08.126821+00
d5850bb0-fc84-4603-861c-add5cc5262a7	d35f1354-038a-4273-a177-0c07105cd9d6	299efed3-47cc-4a52-a203-96f8ed2f50c0	Message	AI Composed [sms]:\nhii	2026-05-21	2026-05-21 09:23:59.787934+00
750c78a5-640c-4357-87d5-ab6bd285f745	d35f1354-038a-4273-a177-0c07105cd9d6	a0dee1a9-0426-4878-9726-cb5b880dd961	Message	AI Composed [sms]:\nhii	2026-05-21	2026-05-21 09:23:59.967019+00
0320e24c-58e6-4556-8da9-cf77a522c11f	d35f1354-038a-4273-a177-0c07105cd9d6	31e328af-0472-4281-a2f9-8db26e83f2bb	Message	AI Composed [sms]:\nhii	2026-05-21	2026-05-21 09:24:00.152497+00
75a88e12-bcfd-436e-8135-45097a17364b	d35f1354-038a-4273-a177-0c07105cd9d6	502755cd-0595-4ac7-8dba-eb20ac1f69a6	Message	AI Composed [sms]:\nhii	2026-05-21	2026-05-21 09:24:00.317501+00
12062f9b-e1e3-4e3e-9662-2f5c8198e536	d35f1354-038a-4273-a177-0c07105cd9d6	f65d5767-5fed-4aa5-9a94-739006d87bb2	Message	AI Composed [sms]:\nhii	2026-05-21	2026-05-21 09:24:00.474508+00
337b1274-37c3-49c1-bb26-fad89a34e58d	d35f1354-038a-4273-a177-0c07105cd9d6	bc8f862e-ec2c-4c37-b924-c34864013f1c	Message	AI Composed [sms]:\nhii	2026-05-21	2026-05-21 09:24:00.62805+00
f429a5fb-fda5-4bd1-b068-938176594438	d35f1354-038a-4273-a177-0c07105cd9d6	380e4e1d-f169-474c-812b-d9a157b98930	Message	AI Composed [sms]:\nhii	2026-05-21	2026-05-21 09:24:00.782844+00
8a7d2433-8ab3-4312-8672-3b5cdd536038	d35f1354-038a-4273-a177-0c07105cd9d6	39259dfa-72e0-4568-b6ae-7beb2b01b10f	Message	AI Composed [sms]:\nhii	2026-05-21	2026-05-21 09:24:00.937294+00
e419f3ab-f51f-460d-81ab-3ced884ef74f	d35f1354-038a-4273-a177-0c07105cd9d6	c2ad89fd-2583-4f46-ad0d-8232f6269718	Message	AI Composed [sms]:\nhii	2026-05-21	2026-05-21 09:24:01.090327+00
05518e45-f0fa-4053-bfc4-0ddb18ba29db	d35f1354-038a-4273-a177-0c07105cd9d6	c544629d-bb02-4c51-9c23-dc743e51a9b1	Message	AI Composed [sms]:\nhii	2026-05-21	2026-05-21 09:24:01.240646+00
c1a2bbe8-63a4-4a28-89db-46d190af8f6f	d35f1354-038a-4273-a177-0c07105cd9d6	b0000000-0000-0000-0000-000000000002	Message	AI Composed [sms]:\nhii	2026-05-21	2026-05-21 09:24:01.397301+00
9a1a8296-f5a3-4e07-8254-d65edcc29530	d35f1354-038a-4273-a177-0c07105cd9d6	299efed3-47cc-4a52-a203-96f8ed2f50c0	Message	AI Composed [email]:\nhello	2026-05-21	2026-05-21 09:25:52.403236+00
5045fb22-d77c-496f-a279-31d5d15a38d7	d35f1354-038a-4273-a177-0c07105cd9d6	a0dee1a9-0426-4878-9726-cb5b880dd961	Message	AI Composed [email]:\nhello	2026-05-21	2026-05-21 09:25:52.565082+00
87e91419-04fe-4c51-b163-7144ef3f402c	d35f1354-038a-4273-a177-0c07105cd9d6	31e328af-0472-4281-a2f9-8db26e83f2bb	Message	AI Composed [email]:\nhello	2026-05-21	2026-05-21 09:25:52.723521+00
3852df75-1ce5-4365-8ccf-dd74bb4bac7e	d35f1354-038a-4273-a177-0c07105cd9d6	502755cd-0595-4ac7-8dba-eb20ac1f69a6	Message	AI Composed [email]:\nhello	2026-05-21	2026-05-21 09:25:52.866+00
10aec02b-e0bf-499a-a174-6830de60e8c3	d35f1354-038a-4273-a177-0c07105cd9d6	f65d5767-5fed-4aa5-9a94-739006d87bb2	Message	AI Composed [email]:\nhello	2026-05-21	2026-05-21 09:25:53.011728+00
33aa2c04-6d50-43a4-bfa0-39f20d645684	d35f1354-038a-4273-a177-0c07105cd9d6	bc8f862e-ec2c-4c37-b924-c34864013f1c	Message	AI Composed [email]:\nhello	2026-05-21	2026-05-21 09:25:53.152331+00
d78c4ee6-c48e-49ad-a1bf-b54410c69d72	d35f1354-038a-4273-a177-0c07105cd9d6	380e4e1d-f169-474c-812b-d9a157b98930	Message	AI Composed [email]:\nhello	2026-05-21	2026-05-21 09:25:53.296529+00
69b332cf-74f5-4dc7-91af-04990ff5b9bf	d35f1354-038a-4273-a177-0c07105cd9d6	39259dfa-72e0-4568-b6ae-7beb2b01b10f	Message	AI Composed [email]:\nhello	2026-05-21	2026-05-21 09:25:53.435761+00
7d5e1c7c-7d38-42ed-9b7e-0e4cf2a422e1	d35f1354-038a-4273-a177-0c07105cd9d6	c2ad89fd-2583-4f46-ad0d-8232f6269718	Message	AI Composed [email]:\nhello	2026-05-21	2026-05-21 09:25:53.580041+00
1a184cea-aff5-4e6c-81f2-2e8372dd6daa	d35f1354-038a-4273-a177-0c07105cd9d6	c544629d-bb02-4c51-9c23-dc743e51a9b1	Message	AI Composed [email]:\nhello	2026-05-21	2026-05-21 09:25:53.720674+00
29106f31-a3e1-4cff-94ff-5505520afcb5	d35f1354-038a-4273-a177-0c07105cd9d6	b0000000-0000-0000-0000-000000000002	Message	AI Composed [email]:\nhello	2026-05-21	2026-05-21 09:25:53.864613+00
9063f9d5-acfd-4ae2-aadf-9862058b8b37	d35f1354-038a-4273-a177-0c07105cd9d6	c544629d-bb02-4c51-9c23-dc743e51a9b1	Message	Broadcast via [email, whatsapp, sms]:\n\n\n[Attached: Attendance, IAT Marks]	2026-05-27	2026-05-27 07:30:57.450917+00
6deda59f-42ad-4d9f-9dfb-a7f1d4733c17	d35f1354-038a-4273-a177-0c07105cd9d6	c544629d-bb02-4c51-9c23-dc743e51a9b1	Message	Broadcast via [email, whatsapp, sms]:\n\n\n[Attached: Attendance, IAT Marks]	2026-05-27	2026-05-27 07:40:47.557534+00
8268b477-d649-46e1-a7a8-90b714cee78c	d35f1354-038a-4273-a177-0c07105cd9d6	c544629d-bb02-4c51-9c23-dc743e51a9b1	Message	Broadcast via [email, whatsapp, sms]:\n\n\n[Attached: Attendance]	2026-05-27	2026-05-27 07:44:49.769287+00
cc57d85f-4e0d-483f-a0c8-41526e126570	d35f1354-038a-4273-a177-0c07105cd9d6	c544629d-bb02-4c51-9c23-dc743e51a9b1	Message	Broadcast via [email, whatsapp, sms]:\n\n\n[Attached: AI Summary]\nSGPA: 9.18	2026-05-27	2026-05-27 07:45:49.517044+00
ca9a057e-2a58-4ca5-84f5-d9eabd8607f3	d35f1354-038a-4273-a177-0c07105cd9d6	c544629d-bb02-4c51-9c23-dc743e51a9b1	Message	Broadcast via [email, whatsapp]:\n\n\n[Attached: Attendance]	2026-05-27	2026-05-27 07:53:24.420391+00
97955d62-b5f1-4375-82c3-cdfdafbba977	d35f1354-038a-4273-a177-0c07105cd9d6	c544629d-bb02-4c51-9c23-dc743e51a9b1	Message	Broadcast via [email, whatsapp]:\n\n\n[Attached: Attendance]	2026-05-27	2026-05-27 07:56:43.704129+00
2f692111-9466-4daf-92be-f09b97af93e4	d35f1354-038a-4273-a177-0c07105cd9d6	c544629d-bb02-4c51-9c23-dc743e51a9b1	Message	Broadcast via [email, whatsapp]:\nhi	2026-05-27	2026-05-27 07:58:28.569853+00
a99a73c2-7918-41bd-aad6-de9076c0fee8	d35f1354-038a-4273-a177-0c07105cd9d6	c544629d-bb02-4c51-9c23-dc743e51a9b1	Message	Broadcast via [email, whatsapp]:\n\n\n[Attached: Attendance]	2026-05-27	2026-05-27 08:00:27.143562+00
169ab922-cc39-4885-b06e-c179812ba36a	d35f1354-038a-4273-a177-0c07105cd9d6	c544629d-bb02-4c51-9c23-dc743e51a9b1	Message	Broadcast via [email]:\n\n\n[Attached: Attendance]	2026-05-27	2026-05-27 08:02:31.485162+00
39911511-002d-499c-a8f7-9d096a134b77	d35f1354-038a-4273-a177-0c07105cd9d6	c544629d-bb02-4c51-9c23-dc743e51a9b1	Message	Broadcast via [email]:\n\n\n[Attached: IAT Marks]	2026-05-27	2026-05-27 08:04:17.291285+00
93cc5614-d239-4aa5-92fa-2a550f203fef	d35f1354-038a-4273-a177-0c07105cd9d6	c544629d-bb02-4c51-9c23-dc743e51a9b1	Message	Broadcast via [email]:\n\n\n📊 ATTENDANCE SUMMARY:\n- Discrete Mathematical Structures: null% (0/0)\n- Algorithm Design and Analysis: null% (0/0)\n- Machine Learning: 73.91% (17/23)\n- Artificial Intelligence: 100% (1/1)\n- Database Management: 72.73% (16/22)\n- Data Structures: 68.18% (15/22)\n- Operating Systems: 72.73% (16/22)\n\n📝 IAT / INTERNAL MARKS:\n- Data Structures: 42 / 50\n- Machine Learning: 48 / 50\n- Operating Systems: 35 / 50\n- Database Management: 45 / 50	2026-05-27	2026-05-27 08:08:03.003667+00
6088f450-e713-4352-b9ec-d8c257116799	d35f1354-038a-4273-a177-0c07105cd9d6	c544629d-bb02-4c51-9c23-dc743e51a9b1	Message	Broadcast via [email]:\n\n\n📊 ATTENDANCE SUMMARY:\n- Discrete Mathematical Structures: null% (0/0)\n- Algorithm Design and Analysis: null% (0/0)\n- Machine Learning: 73.91% (17/23)\n- Artificial Intelligence: 100% (1/1)\n- Database Management: 72.73% (16/22)\n- Data Structures: 68.18% (15/22)\n- Operating Systems: 72.73% (16/22)	2026-05-27	2026-05-27 08:25:06.532348+00
886c725d-aa39-4d02-8403-280bd5e63da2	d35f1354-038a-4273-a177-0c07105cd9d6	c544629d-bb02-4c51-9c23-dc743e51a9b1	Message	Broadcast via [email, whatsapp, sms]:\n\n\n📊 ATTENDANCE SUMMARY:\n- Discrete Mathematical Structures: null% (0/0)\n- Algorithm Design and Analysis: null% (0/0)\n- Machine Learning: 73.91% (17/23)\n- Artificial Intelligence: 100% (1/1)\n- Database Management: 72.73% (16/22)\n- Data Structures: 68.18% (15/22)\n- Operating Systems: 72.73% (16/22)	2026-05-27	2026-05-27 08:25:22.108833+00
d0d7a192-bf56-4333-8292-03384b2d29b3	d35f1354-038a-4273-a177-0c07105cd9d6	c544629d-bb02-4c51-9c23-dc743e51a9b1	Message	Broadcast via [email, whatsapp, sms]:\n\n\n📊 ATTENDANCE SUMMARY:\n- Discrete Mathematical Structures: null% (0/0)\n- Algorithm Design and Analysis: null% (0/0)\n- Machine Learning: 73.91% (17/23)\n- Artificial Intelligence: 100% (1/1)\n- Database Management: 72.73% (16/22)\n- Data Structures: 68.18% (15/22)\n- Operating Systems: 72.73% (16/22)	2026-05-27	2026-05-27 08:26:06.33519+00
6d232227-4ecc-46cc-8e12-5fb41a2cc3a1	d35f1354-038a-4273-a177-0c07105cd9d6	c544629d-bb02-4c51-9c23-dc743e51a9b1	Message	Broadcast via [email, whatsapp, sms]:\n\n\n📊 ATTENDANCE SUMMARY:\n- Discrete Mathematical Structures: null% (0/0)\n- Algorithm Design and Analysis: null% (0/0)\n- Machine Learning: 73.91% (17/23)\n- Artificial Intelligence: 100% (1/1)\n- Database Management: 72.73% (16/22)\n- Data Structures: 68.18% (15/22)\n- Operating Systems: 72.73% (16/22)	2026-05-27	2026-05-27 08:26:40.377086+00
d31abb5e-24b8-410e-b06c-8cfbad7a344c	d35f1354-038a-4273-a177-0c07105cd9d6	c544629d-bb02-4c51-9c23-dc743e51a9b1	Message	Broadcast via [email, whatsapp, sms]:\n\n\n📝 IAT / INTERNAL MARKS:\n- Data Structures: 42 / 50\n- Machine Learning: 48 / 50\n- Operating Systems: 35 / 50\n- Database Management: 45 / 50	2026-05-27	2026-05-27 08:28:55.520152+00
85fce603-6ede-497f-b57b-89cdc6037d02	d35f1354-038a-4273-a177-0c07105cd9d6	c544629d-bb02-4c51-9c23-dc743e51a9b1	Message	Broadcast via [email, whatsapp]:\nhii\n\n📊 ATTENDANCE SUMMARY:\n- Discrete Mathematical Structures: null% (0/0)\n- Algorithm Design and Analysis: null% (0/0)\n- Machine Learning: 73.91% (17/23)\n- Artificial Intelligence: 100% (1/1)\n- Database Management: 72.73% (16/22)\n- Data Structures: 68.18% (15/22)\n- Operating Systems: 72.73% (16/22)\n\n📝 IAT / INTERNAL MARKS:\n- Data Structures: 42 / 50\n- Machine Learning: 48 / 50\n- Operating Systems: 35 / 50\n- Database Management: 45 / 50	2026-05-27	2026-05-27 09:05:02.766643+00
2ac20408-68d8-4291-aef1-fa68a35823f8	d35f1354-038a-4273-a177-0c07105cd9d6	c544629d-bb02-4c51-9c23-dc743e51a9b1	Message	Broadcast via [email, whatsapp]:\nhii\n\n📊 ATTENDANCE SUMMARY:\n- Discrete Mathematical Structures: null% (0/0)\n- Algorithm Design and Analysis: null% (0/0)\n- Machine Learning: 73.91% (17/23)\n- Artificial Intelligence: 100% (1/1)\n- Database Management: 72.73% (16/22)\n- Data Structures: 68.18% (15/22)\n- Operating Systems: 72.73% (16/22)\n\n📝 IAT / INTERNAL MARKS:\n- Data Structures: 42 / 50\n- Machine Learning: 48 / 50\n- Operating Systems: 35 / 50\n- Database Management: 45 / 50	2026-05-27	2026-05-27 09:38:03.238436+00
\.


--
-- Data for Name: notification_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notification_messages (id, title, body, type, deep_link, created_at) FROM stdin;
51b6f141-a619-471b-9e86-a748bd281ed4	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 0.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:10:52.640559+00
a2714f3b-b584-478d-a587-b12b2b4d3aca	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 50.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:10:52.640559+00
c495d9c5-45ea-444d-b447-e3e098987622	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:10:52.640559+00
9ae58f45-1570-4030-a6e2-f0c30767de33	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 50.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:10:52.640559+00
738adb01-42d7-4a9c-b410-b09aefb79a62	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 60.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:10:52.640559+00
c58457b7-d997-413e-874b-11cee3bcb92b	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:10:52.640559+00
e97a75ac-111b-424d-985f-86d28a6d236b	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:10:52.640559+00
66da4b72-3654-46eb-88b1-8b2e03cc96c6	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 62.5%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:10:52.640559+00
09057aff-c2ba-4427-a7b9-bad24a9e293b	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:10:52.640559+00
d186c04b-e767-48b0-b6ad-312a54720efb	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 70.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:10:52.640559+00
d9e786d5-2ba3-4940-bb67-938a7c0c119b	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:10:52.640559+00
dd018824-f951-40d4-b9e9-3619dfb37e3d	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 69.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:10:52.640559+00
7599eba5-4b19-45ff-87d7-effa6739efd9	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:10:52.640559+00
c97db116-76b7-493d-a8bd-a76ac6b44f69	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:10:52.640559+00
d5b0133f-87f0-4db0-83b0-fac035f511e6	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.8%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:10:52.640559+00
b959eb1f-dbbb-4849-982f-dc2942bf60e9	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 70.6%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:10:52.640559+00
4d82f371-615e-485b-a4a7-6f7d11fd1a8b	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 72.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:10:52.640559+00
4ff1124e-33ed-4751-8321-87322c496a4b	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 73.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:10:52.640559+00
3f02dfc8-fb26-48af-8da5-bfdd6246bb62	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:10:52.640559+00
c75c4b8b-e5bc-44f4-b6ba-0500588fba75	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 70.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:10:52.640559+00
100a60e0-933b-474a-a0c3-ede624c472be	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:10:52.640559+00
965fcabb-31d0-4c50-b859-790d44debea7	Urgent: High Absenteeism	Student has missed 5 consecutive Machine Learning classes.	attendance_risk	/mentor/student/eadd0fa7-7e16-4f75-9ed8-47b3fb6a30f5	2026-05-12 15:10:52.640559+00
16486eca-bb7e-4953-973f-b37b88fc2c56	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 0.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
cb21ab3f-ee61-4399-af44-e5f608bedca7	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 50.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
e2f628bc-a390-4277-b7ad-038eda8d13e1	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 50.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
713d0aa5-6669-44ac-b471-2ffcf2ce3350	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
584cd771-3816-4a72-af22-880a846b8062	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
21f22659-7188-41d7-ba30-15d7d7500eb3	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
5aba49c1-842b-4638-a226-c0f91e2e6370	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 57.1%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
2ffd012d-0ba5-46f0-aa12-7b63fbc228f6	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 62.5%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
8d6e5af9-2835-45e1-93b7-1ef5b066ee67	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
a4618c00-b152-417b-91f3-193a03c0e722	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 70.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
457fd191-b8de-4ae1-9eff-67418e81a99d	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 63.6%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
c755ed28-d1a0-4682-8012-0a5d65a6036e	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
77f55553-527d-4e61-b5d5-d1073f8e88e4	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 69.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
193c7d97-bf9b-40c5-b5ae-8af47a613a23	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
96199dc7-4341-44bd-8a2b-33ae6a42eec6	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 73.3%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
a2ff628b-3ec0-4bf3-9f6f-7961baf63868	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 50.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
c7d2b71b-4e0f-4a8a-8201-555ba5aef853	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
8ad00afe-3733-453b-84f9-f830db06af49	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
3c3a5a1d-68f9-4665-af8b-7da948e66d96	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
c0ac35f0-e1fe-4c5c-8dc6-8585b3611108	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 70.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
c328ad88-cf70-4b46-a3dc-b08635639279	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
c20f8b3e-618c-4177-8210-ae345304cbaa	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
628f4870-7d85-4064-a2a6-8465ea6cadb0	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 50.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
b42661f8-82e3-423a-b751-8ccb21ddb749	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
fa2639ba-8b89-4edc-b351-f716fa71f5f1	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
04588ee1-ff5b-4d9a-86ac-17f4e8095291	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
a6ea9894-44f4-46b0-8f70-a493a5d48710	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 0.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
e498d66a-45c9-48b6-b175-a4bde91a145f	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 50.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
78929124-f27f-4d55-bcbe-5dc35b5ed33d	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 33.3%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
692ac12f-96fc-438f-8c78-015401ab56a7	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
b9b5b2c7-01f8-411e-bd23-f66a242d4935	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 50.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
f4315ae9-5e40-46dd-82ae-d45708d20ac8	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 60.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
842d4f96-0139-41f6-a379-9ea727dd3a06	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
6c4feedb-dcb9-43c9-b73d-e6888fbde8e4	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
3415f59f-a6d4-429c-b3b2-7cb868386de7	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 70.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
558a1971-9141-4dec-9f57-17768d2c9a2d	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
3714b531-5b17-40d7-a438-a8830f4f9dd7	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.3%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
7c2d5b0d-4450-47d3-a4fc-b8dc87db6a19	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 72.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
a497cac7-9f89-4170-948f-1bc5b99f97cb	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
af1221f8-17b6-4c05-9895-9226ad9212b1	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 50.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
a57a8e2e-1d10-4f73-b493-f86f88485a78	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 50.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
84abcf29-0823-47d7-8c95-569232dc719c	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
4154cade-1742-43d7-9ee4-a2695f6fa470	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
3054e794-59dd-4bac-b852-c3bad19d87f9	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 60.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
22ad347e-0a53-4e38-a88b-3348c4f8ee9b	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
80ca2457-318c-4564-b0f4-2b3924e39112	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
6bdbeed7-b6d2-454c-a5bf-5a823ecf35bd	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
fe7c1a76-56dc-4f6e-a00d-8c432681ff55	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 57.1%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
bef5ebed-e9d9-45eb-883d-c35e712bd0f2	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 62.5%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
3efd0bcf-3b62-445c-82d4-67a713005e70	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 55.6%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
8590420a-373b-4959-9865-80134d5c662c	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 60.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
cb6fdb62-66ac-4b08-b2cf-d5088fca253d	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 63.6%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
ffb2cbca-9669-4c65-9497-e9145dc38ce3	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
66450513-8827-42a8-bc59-65f6f0e639ae	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 69.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
24c48a1a-717c-419f-9c35-a1a38a0f29e5	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
8d54e672-7497-4aa9-8701-d2f4c7d9457d	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
dd13bda9-dd08-4236-a04d-fdce2e0d6d42	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 68.8%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
f9c71306-bb24-49ac-83f9-0df97b4630d7	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 64.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
e04eb409-3ece-4ad0-af3e-c6145abed865	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
05adaf0a-99e7-48f1-864a-60329c3fd15d	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 68.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
2bc5ac62-b107-46ad-aa08-0be9d489a89d	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 70.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
7e22b3ba-c680-4f75-8a99-0282967c8efb	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
b3ea4275-1fee-4e09-a831-154391ab672a	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 0.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
a0db8dbf-5e40-4399-9e43-782526bc0125	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 50.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
085c0685-6e45-49a3-8203-a6285fb98acb	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
3d810db4-7b81-4cae-8c53-be2cf4870a5c	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
49ffe57f-58bb-42fd-88e9-4bac4454e6b9	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 60.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
fe843144-258e-4497-aa87-c0653064d71a	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
661776e8-4d05-4cf0-a4de-1c546ec0dd2d	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
bf4fff8f-70af-48be-8af8-daaa140193d8	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
30d1b6fd-3d2c-4c0e-87bf-25e6574197e3	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 0.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
fa472839-f106-45d9-acac-3b892898a5f2	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 50.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
f0f9a4db-3f0d-4d9a-9c89-99723bb0af8f	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
67aed75c-e815-4d56-8811-eca495c17ebd	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
7b9b05f0-6574-43e8-8890-ed7bc05400dd	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
bfb78218-04fb-4f5a-9711-af1ee23abe67	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 62.5%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
38e8ed12-d88b-4325-b3c6-d003769af5d8	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
d982e317-1236-4ac9-becf-3995c143de0e	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
5233f774-c5a0-429e-8652-7a921a74f8ab	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 70.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
0e5a4618-9c41-4072-a1eb-2386b324842b	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 70.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
0a46811e-80c9-4439-81b5-775bec9e05a3	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
7dc3dc97-87f7-47ec-a5b9-a76919f5965d	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
6fff85b9-e6de-4c04-a8b5-2b8c5c3cefca	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
cc4230e8-4f9a-4712-8bd1-a8f399eb20b5	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 69.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
0187f1b3-dda0-46e1-a705-6559b62ec2ee	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
bd194a31-1d81-4b3b-b9c4-438dd3211d23	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 73.3%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
be039806-29b4-49ae-858a-9ceee831fd00	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 0.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
a9e0d6e4-f103-4bb2-b95f-babe41c19442	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 50.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
497597f1-90ca-44a7-a620-dbbc12187897	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
df5a8aa8-e1d1-4394-9d8b-acef63085038	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
245ea02c-46cb-450d-a5d9-efe88e4c9eb6	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
53a7a5b6-6072-497f-ab4c-53d3854d6416	Announcement from Mentor	hello\n\n[Attached: Attendance]	info	/student/notifications	2026-05-27 05:36:09.968825+00
c095df37-8812-47f4-81ca-220c48b89c47	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
c3b15620-a19b-4d2e-900b-4902f1374d5e	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
a1a9a028-d7cb-4fa6-8873-53c424e7caad	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.5%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
61833c3e-0f26-4ae6-bf30-7d322d6af8b5	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 64.3%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
5fb9541a-6b6c-42c9-b6c3-3e01324b0bdc	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 60.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
638589c0-28c1-4397-8673-679724df3dc4	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 56.3%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
787cb865-e1b5-4b15-8d5f-15763d0b12b5	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 58.8%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
d72d8cda-e98d-4335-afaa-60c58031a1a7	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.1%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
8925022f-bfd1-434d-90da-22225689c3f0	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 63.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
b8e341c1-772d-46dd-8867-e7602927a4b5	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 65.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
8d0ea5a0-b5c0-4ac6-b322-3d0852c1052d	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 15:11:10.943022+00
5c443886-f88f-48d1-b8d3-ea07fc9dea9f	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 72.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 19:29:20.777049+00
6b790be3-dd44-4972-8e1c-c1ddfc7e0b66	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 72.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 19:29:20.777049+00
690951ec-8107-465e-9698-9eb267f2e42c	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 19:29:20.777049+00
4a2a000a-b476-4981-8413-78cfd2d53abe	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 19:29:20.777049+00
8e13f6ce-3e08-4f05-8ccd-b3bed036ef7b	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 19:29:20.777049+00
c736645a-0ea9-4277-a73b-048ee66eb48a	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 68.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 19:29:20.777049+00
b2f47c38-921e-46a4-be3c-e8fdec03b9a4	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 68.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 19:29:20.777049+00
cad68fd0-b048-4c0a-a5ff-11c0e284d794	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 68.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 19:29:20.777049+00
641a3d73-b4e9-42e1-b7bf-162fe9096954	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 70.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 19:29:20.777049+00
df257eec-ff23-46f8-99a8-d92ce4b888aa	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 70.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 19:29:20.777049+00
ab9e6f4f-164c-41ce-b21c-929a353f5e58	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 70.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 19:29:20.777049+00
58392b3a-8e24-46ce-970b-601da52ad017	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 70.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 19:29:20.777049+00
7dedaf88-3ddc-4134-a742-455408f875bf	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 19:29:20.777049+00
bafedf68-fc29-40be-a3f1-de6d59772a65	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 19:29:20.777049+00
60165ac4-05f9-49b8-baff-7afb400c350a	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 19:29:20.777049+00
37359db5-c1d6-4d27-a48a-e8cebc9c5b29	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 19:29:20.777049+00
4a9f1a7e-6f84-460a-b69a-65a2ec859e49	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 19:29:20.777049+00
b0e3ebb8-0726-4ab9-b968-9546303fbefe	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 19:29:20.777049+00
6bfbb5ac-49f5-4e64-9b50-0d3dcd82867f	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 19:29:20.777049+00
58d05755-730d-4878-a30b-966381a6d8a5	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-12 19:29:20.777049+00
e80d1704-17d3-40d3-bb53-dacc5eb4035e	🎉 Demo Setup Complete	Your account is now populated with subjects, grades, timetables, and 30 days of attendance records.	info	/student/timetable	2026-05-12 19:29:20.777049+00
2e307d8a-53b1-4bfc-a30a-f148f8b6b851	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-14 03:42:46.004875+00
81c97800-6147-4a43-bafd-ca72b699529c	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-14 03:43:41.735675+00
4f398c3f-a490-41c6-baae-e1105549b145	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 0.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
e7da78a0-6c12-4855-9427-7d80f595f2f3	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 0.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
6f2792b8-423b-4ad2-9c9b-a11d133bfcee	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 0.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
2f2e4bfb-c947-4e8d-beca-23e2fecf86dc	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 0.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
d53a348d-2a63-4187-b29a-90dbe8395571	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 50.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
5b6882cf-b4dc-4a71-a445-0aab2610bfa1	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 50.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
3d5821a0-3b1b-4e6c-a6ff-4c600592d5ce	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 50.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
f18ae1ce-46d4-4b81-a337-a598d0ccf4e0	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 50.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
d31c52c9-8c20-43db-8d12-a7e3f9d86b04	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
283f8577-b2fd-42bf-b00f-5bdf53fd6775	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
0915556e-7514-429d-8044-52b25cd29d50	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
2862c87d-8b0f-440b-9afc-1ffd5b5b6036	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
9532691c-bdab-4e5e-afc0-be128a14ba3c	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 60.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
4b9e983c-599f-4766-a71a-12460f229149	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 60.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
16bbb9ec-dc4c-4626-bec9-40e9f0f2b82b	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 60.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
b6b35541-b6df-4d6f-86c2-05223f176335	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 60.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
09655df1-a982-44bb-9e4f-c9c8df53a126	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 50.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
674b7bf1-45b5-4d46-9b4e-b4c05d530f25	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 50.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
ac6bacb4-0bce-420c-9780-466615e45d53	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 50.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
e873bb89-e633-449d-849b-17a881dfd526	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 50.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
72384dfd-360a-468d-b429-3f80c363f501	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 57.1%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
d24c50a3-9f2b-4d72-b52c-59955a2f1b9e	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 57.1%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
883674c3-12d8-4574-8e7e-a140c78c3f09	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 57.1%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
30c867b8-1ae7-4c88-bad3-148767d983c1	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 57.1%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
af5141f8-1498-405b-bc3b-60d114fdd242	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 62.5%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
5d688533-3a13-4f9c-90a6-e06f4f43be46	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 62.5%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
3bc74ff7-a619-4817-912d-08185ac9f5c5	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 62.5%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
99ce754c-facf-4ffa-bc18-1684c72c1d63	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 62.5%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
8fc6fe4f-08a8-48b9-81ec-61ee8907a1e2	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
049013cd-cb2c-4a16-bfb3-550c7172fdfd	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
59a18042-431e-43ae-8bf6-732ef18c83cb	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
17cfcf4e-465a-4425-8f29-035c8625a654	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 66.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
f0936a48-d35e-427b-9ce1-ee934be6e343	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 70.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
30cbb026-817e-4af5-9eba-6b97813ab01c	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 70.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
ed563bfe-904a-4d66-ad2f-9db325be24ed	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 70.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
4aa93779-0cf9-43da-8c57-82b5c1f4859e	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 70.0%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
3997e3fd-91e2-4dec-83b9-b7268def2070	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
8c64829e-7bb9-4243-a9ab-dcce96b0e309	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
f79083e3-b421-459b-802c-9db60a508e64	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
4079bcbe-7a34-408c-a2bb-5b9202ec9c42	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-26 17:09:58.542051+00
d75e9e92-4ba8-4ced-9ec7-12153f69276c	🎉 Demo Setup Complete	Your account is now populated with subjects, grades, timetables, and 30 days of attendance records.	info	/student/timetable	2026-05-26 17:09:58.542051+00
a7a0e5fd-ad24-4bbb-a7f3-bd041a6f96e9	Announcement from Mentor	\n\n[Attached: IAT Marks]	info	/student/notifications	2026-05-26 17:28:09.621224+00
06946dd6-48ea-454a-b9dc-7c92a557f2ac	Announcement from Mentor	hii\n\n[Attached: Attendance]	info	/student/notifications	2026-05-27 05:40:31.051017+00
ad11e60d-9e7e-46c2-a66d-ae62b695aa02	Announcement from Mentor	\n\n[Attached: Attendance]	info	/student/notifications	2026-05-27 05:41:03.604725+00
f1c7013e-3701-4d27-97b8-606d7e4e811c	Announcement from Mentor	\n\n[Attached: VTU Results, AI Summary, Attendance, IAT Marks]\nSGPA: 9.18	info	/student/notifications	2026-05-27 05:45:11.754885+00
b92d7fc6-3a08-4763-befd-3b0f93a9db61	Announcement from Mentor	\n\n[Attached: VTU Results, AI Summary, Attendance, IAT Marks]\nSGPA: 9.18	info	/student/notifications	2026-05-27 05:47:02.161737+00
b129b1fb-ecc7-4fa9-9f2b-e86601a85300	Announcement from Mentor	\n\n[Attached: Attendance, IAT Marks]	info	/student/notifications	2026-05-27 07:30:57.353464+00
8ffee082-3b1c-4ed0-a00d-643d7e9cdee9	Announcement from Mentor	\n\n[Attached: Attendance, IAT Marks]	info	/student/notifications	2026-05-27 07:40:47.465451+00
9a867845-57ba-4fda-b953-ab8d3cb6f856	Announcement from Mentor	\n\n[Attached: Attendance]	info	/student/notifications	2026-05-27 07:44:49.698563+00
4811e92d-8c28-48de-9dd0-88268b421422	Announcement from Mentor	\n\n[Attached: AI Summary]\nSGPA: 9.18	info	/student/notifications	2026-05-27 07:45:49.422062+00
033d826a-e71c-4e81-8ade-66861f25d9c8	Announcement from Mentor	\n\n[Attached: Attendance]	info	/student/notifications	2026-05-27 07:53:24.310834+00
76a2ba8b-d049-481b-8b36-d5a3e4d1341b	Announcement from Mentor	\n\n[Attached: Attendance]	info	/student/notifications	2026-05-27 07:56:43.589775+00
46ca9833-63b1-41c4-bc06-9fa6dfedc524	Announcement from Mentor	hi	info	/student/notifications	2026-05-27 07:58:28.47339+00
b25c4a39-f7a9-48b9-bf81-b3ec02a11a2a	Announcement from Mentor	\n\n[Attached: Attendance]	info	/student/notifications	2026-05-27 08:00:27.061834+00
db3c13a2-acfe-4227-9b52-b0cef8d9b8b5	Announcement from Mentor	\n\n[Attached: Attendance]	info	/student/notifications	2026-05-27 08:02:31.393732+00
9cbdf3db-0737-494e-b6ad-b0c684d6334e	Announcement from Mentor	\n\n[Attached: IAT Marks]	info	/student/notifications	2026-05-27 08:04:17.173362+00
8d292f39-6276-4ce0-bdf6-54beeafa499b	Announcement from Mentor	\n\n[Attached: Attendance, IAT Marks]	info	/student/notifications	2026-05-27 08:08:02.848009+00
c0c49653-d343-4a4b-a97f-a9e56db8e6a2	Announcement from Mentor	\n\n[Attached: Attendance]	info	/student/notifications	2026-05-27 08:25:06.401831+00
d99964cd-e222-4cba-a4ec-00edebd0b76e	Announcement from Mentor	\n\n[Attached: Attendance]	info	/student/notifications	2026-05-27 08:25:21.98357+00
a9424455-227a-4c13-8d46-810ee6d08fcd	Announcement from Mentor	\n\n[Attached: Attendance]	info	/student/notifications	2026-05-27 08:26:06.235492+00
d58fe96b-db6c-48a0-94ee-f4f17db1598b	Announcement from Mentor	\n\n[Attached: Attendance]	info	/student/notifications	2026-05-27 08:26:40.275687+00
a999428e-c0a3-4e90-bf56-27b79148dfc8	Announcement from Mentor	\n\n[Attached: IAT Marks]	info	/student/notifications	2026-05-27 08:28:55.370254+00
bb07654f-a537-4c46-9ff4-506d56f247d6	Announcement from Mentor	hii\n\n[Attached: Attendance, IAT Marks]	info	/student/notifications	2026-05-27 09:05:02.526343+00
2d4f9965-dd05-454c-81ca-44f2c040b730	Announcement from Mentor	hii\n\n[Attached: Attendance, IAT Marks]	info	/student/notifications	2026-05-27 09:38:03.07236+00
134c89d7-39ed-48ff-89c2-708f1f08b560	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
9f655b1f-cf19-4197-be28-a49e3ebd917c	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
6ee23633-bf6b-46a6-af1a-3c647eb1de3c	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
7525f8e0-12e3-4dc7-81a2-28d77ad3df77	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
846b52ec-555b-433d-8093-b45bec6c168c	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
cfac1359-8625-457f-96dd-f36c07b5b27b	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
cceb4b23-7bd4-412c-bc6a-2cc2d2edbbf3	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
1657d66e-62ff-4c5d-9e79-fd875ddd029e	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
6161c448-a4e6-4f02-ab4c-55bd24d94b76	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
f5a30c8f-e04c-4f07-aff1-d33d836c7735	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
10a853ea-5a1d-4650-b242-142f82d9a171	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
2f0528d8-1d9d-4094-8557-fcd446c6ed04	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
b5c99341-ece3-42fa-8ec9-4302ef7c54bc	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
a13de502-e9c0-4b11-bb97-d46ab3a79a71	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
c5a1e9a8-5b4f-4028-b53b-6547fb44ec0b	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
ad8bb533-5d24-457d-8043-96963f484433	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
5c10db6a-91a8-4d4d-b165-a8883c8c6d8d	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
34ee8053-29a2-440b-a706-c6b57584485d	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
89d3936a-bebb-461a-b8fe-c693deb85e36	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
c45f3292-a379-4507-9111-53b3c8069187	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
99f7d834-f1e4-47b8-a5a6-947fc40f849d	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
ea534091-f64d-4087-90b7-d42f3427ae32	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
dfa736e1-4ef9-43f4-9cf9-b23d3902ea8d	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
a6267478-6b24-4168-96d8-3b63c8a16974	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
18410aef-103a-4a9c-b5f7-78d333b70566	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
48c4fec1-40e6-4a8b-bb19-9fd093b646ad	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
6e9d80a3-fe94-4638-86fa-1e250180ffa4	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
be1b992e-6ef5-41cb-ba04-4758c2fd0100	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
d28e4359-7fea-42db-8de2-282febfad75f	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
6788ecb2-03e3-45a4-b7bf-a008d98fcc77	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
4c82ac01-9229-4776-abe3-b2d02b9caa87	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
e6002f22-d69b-43e4-a6b5-12b004da57ab	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
3b313264-1bbe-4286-9b10-b707a3a640e7	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
527e55bb-f93a-4498-aff1-ce557bbc8316	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
dbf8ad4f-f1a8-48da-8ed0-2627315a5b1d	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
9b1e0979-70df-44a6-b01d-ca6cb821f69f	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
ea5ba4a9-092c-47b6-884f-52864df7424b	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
87787d81-c5ea-43ea-99f6-022029ce35e5	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
b4d9df38-e3f7-47eb-99d3-d827a2943f07	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
9ef103be-02fa-482f-b0f1-8d207ec363b8	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
61fafd71-209d-4d48-8a37-03b2b4fae112	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
c08e37d9-847a-4584-af32-9a7651cd7233	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
acdc6476-e1d7-4244-8d8e-276e1f262436	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
41f3b99d-cfcc-4e01-bfb8-bbe333f02b91	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
00c1c097-bd78-4448-b4c1-eb2c466110ee	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
fa118f1f-f230-4205-90ac-50684b5c2b2d	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
98ded6f1-d2c5-4284-8d00-62cd06640145	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
6b7f90e7-a85d-4359-b374-98ef45c778b1	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
196d4c5f-a114-47ac-a741-fc925e2d81cf	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
3b3b9639-a89b-4e3c-a39f-b935bb193e28	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
1c900462-178c-4ba2-8378-540bf445f9fb	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
5c1814d5-aa74-420e-9cef-1803b477bd42	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
2324b198-334d-40b0-9ae1-a7266bdfe08a	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
2bf0e0ec-318d-4a08-8683-cf7d6bc9132e	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
bc9ff944-4aea-4447-ab55-90b53aa3a3f4	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
e15dd7a3-d19f-4a18-ab05-391a409c6514	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
c104973d-5618-4531-8810-c7d1249e7406	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
280bc4a9-6eb5-4154-a6f1-5c45fa44c0df	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
22c277c7-f319-4494-afd3-0f4d9630f452	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
4a8c7fef-d847-4bb4-a3b0-de32bba5d7cb	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
0f4bebf0-dede-45ba-bebb-12afcd5f7d2e	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
420a8abe-957c-476c-8a39-b6ec8a196505	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
73489fb1-c758-459f-8218-680f34947488	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
fab3bacd-73a3-477e-b51f-9323528c39d6	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
2a3bc01f-e8cf-42f5-a192-d012645efb83	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
8c49186c-2194-420d-9c59-5589b7dcad48	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
098ba9f4-ce19-485e-9f63-9bb16d4dab2b	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
b7e7cc91-9294-4079-b5ce-3ab3bd0e8334	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
3280a0f1-53c6-40ae-9bc4-f4491301626f	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
31ee18ba-b796-4890-a599-51d6b0bba58f	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
f01892d0-f467-45c4-840a-e52293611502	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
185b428e-39b6-4fcf-a096-dfdf5ec8f9d3	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
040a9d64-2736-4446-a886-86ec9fe21a9e	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
58d4979c-68a5-4a06-bbe3-2a00278e1c8c	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
5510eedb-cc78-46f3-aa7b-a2bb785127f8	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
ca2cf484-e4d1-4cff-8a38-3d40e8609e09	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
8b2a1f4b-6033-4d83-8e87-2aac6b55fa89	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
46d8d439-5c65-4344-91a7-cb802ddaa445	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
27cfde60-8cda-4316-a3ce-a4ea192439dc	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
63403e30-716e-4e00-83db-120df7c44c6f	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
b14c6325-c939-464d-9ef8-33ee9f286bc9	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
549b625c-11f6-46a2-86af-5a1dcbc3068c	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
3a20235d-2d16-4c00-8f9d-822c6d755b6c	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
6ba15ad4-500c-4799-b6da-8d1c53797844	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
8d648068-2dad-4da9-95d9-fa06c10f8d73	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
1a7ed78a-5c01-45ff-953a-f3730c2299fd	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
6a087138-0320-4268-997d-0ee8437ac928	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
73bf4037-76f9-41f1-9ee0-46b85efc7c12	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
2c775924-9c93-4085-ade0-8114a012bec9	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
c099ca9d-d667-40ea-9b74-b321dd058abd	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
aabb3def-2650-4306-b391-820f20329e29	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
ed57155e-1299-468f-8579-bbd6bc74d5e9	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
82e4f111-08f5-40a3-905b-319c7419259f	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
f05bd460-9c20-4a3b-8d73-b3b7efe82d19	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
371db369-b17e-4ec0-a671-a872d197f9a7	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
917550f5-1879-413f-9904-53417b46c97c	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
9e0270b7-169c-4c93-80a8-366c62dbcd50	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
02f445a2-5481-476f-9d64-b624a5a789b4	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
07621c6c-cb07-4d91-9301-0f5b13906bae	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
c1ab669c-2d96-4b53-82fb-251ae80d314e	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
11675b9c-9e46-4c24-8a03-6b170b56105e	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
6f61eec9-78c3-4bb7-ba2f-11bd7c17a982	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
7e70c966-65a9-42f4-8cba-4544853264ad	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
5e04efb3-53d8-4c89-90fd-57d52bae105a	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
c913ed6a-9659-4514-8608-30ff8e4e01e7	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
96fa7432-baa9-49cf-aaec-7746f7c984cc	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
9d8e02ea-5a4e-462d-ba71-c2295ad48e10	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
533481a3-1da5-4f17-944c-28ab126d6624	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
1148903a-b629-4a84-b363-b022d1bbb1d0	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
a4f2e6ee-0042-4232-a557-6f94c0f5215a	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
2c6b79ec-9f2e-4d0e-8bec-0b1211e1fd44	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
f429f45f-3143-4702-bceb-c54778ef5c39	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
418a1b5e-99af-4132-bbb1-37f96848ed50	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
0ad138dd-d60c-4788-b1d6-8c4816da53b3	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
d49b7b2d-318b-4267-b54b-205f985b2b9d	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
e380d9a4-4298-4051-8039-5c6b65d8eb56	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
cb88e39d-3fa6-49bb-914e-73b9653b75fb	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
0bee8d12-710d-479d-8981-55a7e38ebbf0	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
c9ebd3e7-1d49-4934-86b1-47afae30cc5e	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
c18082b3-9a01-4dee-af5f-7b71e2c1a559	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
71bf8239-6c25-4eca-80ef-97e17c29eca9	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
46a742ca-a003-49dc-800c-8bc68b309fce	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
53fe7a39-0c53-4b5c-a532-c27424fa004c	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
d0f6ff93-3e03-4fe9-af7f-af8b78bb56f3	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
f37ad150-41cb-404f-94aa-95391c9b91cb	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
1fc6edaf-9fcf-49eb-bd16-d89975a36f2c	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
496d934a-4043-4134-895f-6eaea72169ea	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
de1fd4c0-7b55-4dac-ac72-f44a8af408c2	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
5c82b756-e7d9-41fc-92ee-863cdad65070	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
b953800e-b842-4d1b-ac85-6bc64fd0aecd	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
b51b42cb-2b06-4565-aeb5-09740cf44487	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:17:56.735507+00
39666c15-e11d-495d-948f-714fabe6e4a7	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
de08970f-5524-4891-bf1a-f5039e77c8de	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
b9fd4375-1c0d-4978-8a60-1d6875a92645	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
6c94ad9a-1e05-4a9b-af1d-0621b3de66c7	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
9f8d971f-b234-491d-86d9-80a2cc8270fb	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
1c46a76b-35ed-4303-9ef4-0b3543263357	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
bf0763f5-2a56-4bbb-9776-bc5934e4737d	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
0ae6611f-de3e-483c-9bec-1bdb09d22819	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
1aacb3c8-b1cd-4300-bfb6-d25b3f781162	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
12b369fc-063b-4ce5-bb03-00c66d5ad720	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
1abe6e2e-109d-4c37-b3ab-88aed12299cb	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
05ac3099-8e5f-445a-abbb-c2e1a7b4184f	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
b1edb27b-b760-4917-80fd-2c88c5bb574b	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
344a3d5f-57ef-4044-9585-e1550ec2a752	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
ca607622-0882-458a-86e4-07972377dbf5	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
c04bac69-7d0d-4981-9b53-423f314e8ce7	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
ba9f859c-7eb1-493d-8deb-2576267129e2	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
13df08f1-9e40-40be-a6ba-1d30faf3fedf	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
1f6490ab-60eb-43dd-8cb8-8cf072be9016	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
8da6ab2c-7ae7-454c-a259-4e533cfe1c79	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
5fc83fdd-1867-45ea-ae53-7d59ec13c4ca	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
52d73905-9f13-4602-b32b-460e66fe7aa2	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
4b73e4cc-4893-46b3-8f3d-bcb717984c72	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
c03cec75-9770-4fdd-afcd-405e86151fcf	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
e39438bd-5d31-4866-ae46-809d533e39f1	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
35309cfc-d835-4e00-89be-172c1378d786	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
c149881a-abce-4811-a448-e7963db681c6	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
1e598626-954f-405c-8842-4ca1ca4563aa	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
aadd010e-61e7-4c5d-ab70-acde33e458be	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
bfa13be4-86d7-476f-af24-9513f23c8035	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
a6ef1718-5a90-4fa6-890a-4d3ffb0de0cd	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
5f9608c8-8cbc-4d3c-829b-21c5faa2ab49	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
c9214d3a-8c18-41dc-9009-3521118d340f	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
67ba90b7-3413-4580-b4a9-1d2cc6abed51	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
ced46030-5f33-4a0f-93c7-1c73798c550d	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
661bab42-5454-48b9-8399-43525a94fd9f	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
4698c7ef-115b-4ec4-b050-a1bf14fee4dd	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
9e847a22-7582-4fa3-831d-4524b549b3c5	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
0ad2533d-779e-47c2-8b6b-943a92fe3dac	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
49bd66d3-6c57-4833-a6ee-ab2fbc1c8f2e	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
ad709f0c-bf05-446f-ba95-f39f90d94713	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
f07eb32e-102b-4a25-9cba-e5c254b947df	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
3e042cb0-1e7d-4de5-8dac-d18350e76069	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
45491958-3847-40dc-a67c-9bea82297bb9	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
71f02655-cc71-4be5-ab47-840dd7ea967f	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
ad1c4737-cbec-42b8-9d14-d704c501494d	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
90f9af2e-8cc0-41ab-89c5-eb810d43a5ef	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
4a374f79-0d9b-4af5-b5ac-e6e5565dca5e	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
3c2a4b82-324d-466f-a750-2d133ad948fb	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
fbbc7966-8989-496a-8263-bd0985b7030f	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
0bf9edb2-b466-48c4-8467-31c2d819aabf	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
2d1b9b73-94b6-4e1c-8c5d-4d4d90d2d46f	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
c1207e38-2643-4fe9-8454-ed6507dfe3e5	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
65b17186-a227-4f98-b98a-3e809d0ea69b	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
ba143867-01a0-4baa-a8b2-ca34d04d8f23	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
ce61b472-fc0c-410c-9e38-b37ab1dca2a3	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
aea6316b-000f-436b-8895-0b8348df532d	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
6615fade-3c56-4dff-9d4c-a2411c5bd54f	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
12635264-7a9b-47dd-be8e-362afbb185cf	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
87ee4e33-1df7-4e32-89a8-38c27a36fb95	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
93f85a7f-63b4-4d63-ac4a-331970c462dd	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
b10e0957-4b79-4213-9d9e-13923471a312	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
f5e5bbdc-c4eb-4c62-921c-8d4dcae8c007	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
bf8099e4-71f8-4888-abcf-4d0c5960f093	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
69158192-4bb6-4131-8e00-602ccb20c353	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
690d28c8-c920-48a8-a3dd-69f0d12f7661	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
4f4c023c-50f5-49b9-ab72-8349bbec929e	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
d07fc600-8010-4266-88db-d44f5a837717	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
2020020f-9301-4fa7-b31d-7ba1632bc9d7	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
13f5a5f6-401d-4a0f-93e6-116d6331cfba	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
336f07fe-1cbb-4869-8121-da52d6447ad8	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
79114712-63ac-4d8d-9a0b-a8fb1be3d6a1	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
5ce0d381-497e-4438-95a6-9fe17af36938	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
6cded270-6081-4780-b6c4-76b1a0b2223a	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
7efe6360-7e1a-49bb-bbf6-f73a8bdd7c55	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
288cf7f4-12d3-411b-a2be-1cdd35328af3	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
319ca44f-332a-4a2b-916d-6fbd123d14bc	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
d7b9deb6-f154-4f9b-9005-3ead16e10c7b	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
4329ee5b-7abe-4bdc-8d98-7ca0672b33b3	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
5f2d9cba-be3c-46bb-86de-9e36df8d52d2	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
93f1c769-6c1d-4bf3-bf2f-631b0e5c0659	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
e8a4c6d6-d8fb-4d61-a819-37d89a709c53	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
0161c21c-14ac-4f0b-92a4-4f108ff85dfe	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
4563b2d3-c23b-42ce-bcf6-1c7251561a01	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
e2947294-ea53-4e69-8f34-7977a5de2451	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
672f422e-06ef-42e2-b05b-e5e6d06bc28c	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
49580f4c-752a-4b39-8ad1-88902065aeec	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
33118bf3-0046-4c29-b193-95d0bfc9c146	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
34d2402a-ae00-4c7c-8e43-a0fdf29f759d	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
cf7f3960-b952-4bf2-816b-5caddf6efa34	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
106d9fa9-7475-4214-b9db-d6cb880b3022	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
e4a7e217-4cd4-4dda-8509-c0bbaed435cf	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
c0955f11-11cc-4ff5-bfab-b61a14b02898	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
8555b093-758b-4abe-94af-4c379d6117ed	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
6ff655a2-7086-4c1b-bb73-45d2d23b3c73	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
848062a0-3532-475d-9f44-00aba3cb679b	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
03e7dcbd-6c9c-4373-9098-39ddac850f21	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
cc971d51-967d-46c2-9ec4-62b2d1f1eede	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
12db6f8c-13a4-43c5-bace-dd972514d3d5	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
20d5dfd5-3cc4-4a8e-8815-3b9402af8d5a	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
d26088f8-4c5b-4f09-adaf-3e8e172cf5ac	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
62f35b5c-53db-4622-8954-d061c3e06c71	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
fcc424b6-8761-4b2c-882e-9ac358538d4a	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
31d45d63-23c6-4584-a5d8-01c7b4253dd2	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
623e9f07-b64d-494c-a668-dca9301da1f6	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
25aa59d3-1b54-48cb-97bc-2970e2014288	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
1ff88a34-f972-43b8-b9ef-bcb6bfc139a4	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
88db8df0-e07b-4c6a-ab39-11606f88055c	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
15536a88-cfba-4cac-a8e5-b533abe2ab54	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
65f4b618-10d7-4c92-be41-c4d9bd053263	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
24f025c4-be47-4644-b241-a0bff5fd0869	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
fa630ffe-1fc1-4d34-a86d-9b0a6512c03f	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
889daf94-e144-4911-a1ec-af8ca528c727	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
69abca1b-8546-47c4-b357-16127ab36e52	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
2ddd2256-243a-4050-91a4-d561d2731612	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
ce6a0bf9-ca6a-4139-973c-ba756270a116	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
7567d355-527a-4571-ac6b-4eac76a0f654	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
d79baaa9-1a64-4855-91f2-ebb86e01d862	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
6ef32379-2a82-48ec-8ff8-c30424de55da	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
7f119e1d-e898-4fd2-9760-79a440443716	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
2458e585-5a76-4baa-bd30-23ef40324ad7	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
b08b361a-1e55-4ace-9f9d-34bf2e5e315e	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
76c4a01f-0d8e-496c-a341-9122a0fbabd0	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
c9a9e8cb-8154-46f4-a2b2-cd49a418ec53	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
6e6463ef-d154-4202-bb43-c0314e616abb	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
0dd6f9fb-7a20-4c20-99e7-9f6a4572d1f5	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
e22997a8-f518-4b80-9317-cceae9234d22	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
22e9b674-af7d-41c8-bf99-182a290e8c6f	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
79d65ff8-5818-4f76-93f5-5bbcafc4030d	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
25c71b96-8565-4f26-a6b2-2473829dd1ca	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
32706ea9-2844-4dec-bf40-832331a66cfe	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:22:33.234133+00
df1b5e88-c3c1-4c81-beee-01ec1dd9db5d	Grade Alert: Machine Learning	Your grade in Machine Learning has dropped to D (Total: 40.0/100). Please consult your mentor.	grade_risk	/dashboard/grades	2026-05-31 15:22:33.234133+00
ac5b4735-8870-4ba7-8fe5-aca2ea4f9c12	Grade Alert: Machine Learning	Your grade in Machine Learning has dropped to D (Total: 40.0/100). Please consult your mentor.	grade_risk	/dashboard/grades	2026-05-31 15:22:33.234133+00
d03633d8-d6ca-4aed-be49-fcfffc0a6561	Grade Alert: Machine Learning	Your grade in Machine Learning has dropped to D (Total: 43.0/100). Please consult your mentor.	grade_risk	/dashboard/grades	2026-05-31 15:22:33.234133+00
51191d5b-a3dd-42ba-8088-39e165fd8ccd	Grade Alert: Machine Learning	Your grade in Machine Learning has dropped to F (Total: 37.0/100). Please consult your mentor.	grade_risk	/dashboard/grades	2026-05-31 15:22:33.234133+00
4eda1da1-14e5-4755-8f8c-09731ac9a477	Grade Alert: Database Management	Your grade in Database Management has dropped to D (Total: 47.0/100). Please consult your mentor.	grade_risk	/dashboard/grades	2026-05-31 15:22:33.234133+00
8ce99e02-60d1-4783-b66c-d1bb19c478ed	Grade Alert: Machine Learning	Your grade in Machine Learning has dropped to F (Total: 36.0/100). Please consult your mentor.	grade_risk	/dashboard/grades	2026-05-31 15:22:33.234133+00
7fec4ad9-fdda-481a-953a-9b2802e87a35	Grade Alert: Machine Learning	Your grade in Machine Learning has dropped to D (Total: 44.0/100). Please consult your mentor.	grade_risk	/dashboard/grades	2026-05-31 15:22:33.234133+00
1b21478d-4cec-45b9-a63f-d20df9806bd4	Grade Alert: Operating Systems	Your grade in Operating Systems has dropped to D (Total: 53.0/100). Please consult your mentor.	grade_risk	/dashboard/grades	2026-05-31 15:22:33.234133+00
bb214b76-dc32-43b2-9eec-9847c49b7e14	Grade Alert: Machine Learning	Your grade in Machine Learning has dropped to D (Total: 50.0/100). Please consult your mentor.	grade_risk	/dashboard/grades	2026-05-31 15:22:33.234133+00
89961323-d7f7-4117-9604-4ab28c61e15a	Grade Alert: Database Management	Your grade in Database Management has dropped to D (Total: 43.0/100). Please consult your mentor.	grade_risk	/dashboard/grades	2026-05-31 15:22:33.234133+00
a251736d-dc57-4c7e-8bce-1ec288c9ffc5	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
0320561f-f558-4d9f-850e-1ee4b7d4a63b	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
d334e491-e29a-4b3e-850b-791354aecc0c	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
2e199a41-8ac8-4310-b471-ff3b76e9624e	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
3f81935f-86b6-4345-a20f-e5f2fc739674	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
a81459da-20b0-46f8-b445-690baec154b1	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
e69811d3-6553-46e4-8d93-01d6f7b7ef64	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
96a5622d-e9fa-44e8-8f11-6076078ec9eb	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
f63fea2b-54c3-4e5e-8766-a42953196e13	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
330d4ed2-23e0-4b8c-8ca5-7b076e9387dc	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
00cbcd44-20d4-437b-b63d-87a4bd8f5525	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
94e5fb09-e6e2-4913-9d25-4beab67e1d76	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
65582089-8ad0-4f1d-b938-8403729aecd2	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
b7fac81b-7e1a-4a90-99fb-3baa4b85c8ae	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
8e41fbb0-ec8a-433b-8ac2-e15afd98f635	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
777fc485-c6fe-4bc6-9c5e-d45f18350a7b	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
bc998c4f-0999-4be8-a1b4-b42e39650582	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
3a9ef16f-226d-487e-9186-f3347242cff3	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
ae379af0-84a0-46d0-a30b-f253300bf82e	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
44082a58-8820-489a-968c-1b533ffd6f09	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
f5bf316c-4138-44aa-bdfb-92053d8c4865	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 71.4%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
47dcb8bb-e2ec-40a4-8bbe-c29d36aa460a	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
3fa6dea1-a2ed-4f06-99ef-43b155fb83ac	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
637a6837-54e3-4899-9426-6d9784584a95	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
be790842-7bcf-4b98-97b1-5b7263a06d27	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
e92a8687-47e0-4435-ba0d-46e65c6ff1bd	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
0659a7a5-4106-4195-ba92-46618b2b927c	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
3fad0fe1-1a21-4a1b-a2a5-be5164d726c7	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
d77158c1-028e-4a4b-a9ec-c8063768aa94	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
5b7a381b-6d28-4d5b-af32-e321d6746087	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
dd626130-85b4-42a1-8a0e-1d18ed6affec	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
9c7a5a00-313c-482f-89c3-29ab3a62ea9b	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
82524a7c-95b2-4b9a-a302-a4213da7df10	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
5f692a8b-3181-4c00-9e08-2f114908257b	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
bae876b1-3865-42cf-9dfc-ec8582add3fd	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
c5aeab56-84c5-4536-ba3e-6fdc1e755ad1	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
bb5a414a-b921-4b03-9611-2f315b856597	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
0824d194-45b4-4edb-8b81-412a016890e7	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
465c8e95-941b-49ba-a13b-aa033bea66ff	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
f4fd2272-f06e-47b4-bb28-9a71b30fd1b5	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
9ca4b34a-cc77-4e08-ab4d-0d6682dfc330	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
e2ff67c4-bb77-40e5-830c-0e07ee60e5e4	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 61.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
7d299491-1c05-41a1-b760-752a11df0a81	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
89fe7b4f-c40b-4640-9d70-1d6f051284fb	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
47693ee8-2fa7-451b-963a-ef74ce3b50a8	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
9801b3ea-aac1-4317-ad78-2202e777ccd5	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
c376ebc6-5f30-4ca3-ac2e-9029e81068c6	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
d3a50159-c16b-4c56-84ba-c11ffe722b70	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
f8fdadcb-0677-48a9-801e-dd91e3f315d0	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
95fceb2a-7f1b-493e-a6c2-17e43801090d	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
7f001610-1095-4764-9c94-9c13b2346130	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
b8b57b1f-3706-4b26-a02f-0a0206ace9fc	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
366c8de9-4899-4c21-95ce-e9c9726cf211	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
de206a73-448e-41ed-924f-97963160f240	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
29e7e5c7-6c9b-4254-9658-1d3ab765b868	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
aa1e43e3-d4c7-4816-8fb3-8c746ba51ec6	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
53e2a32f-ccb6-49dc-8c69-dcb6dfd1cf40	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
6a3972a8-f062-4291-9f1c-4e7a017114fe	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
8e57ef93-6169-4c53-8896-f5b17fe36615	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
127e804f-e81e-4963-9b0a-2f3aefa52869	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
bca5e204-5236-45ac-86e1-f096e77f9712	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
264b87e1-0354-4b00-bc20-a3b465f02bb6	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
fcfcc1c6-445e-42cb-98c4-4856c05a7459	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
c8c3c9f6-6d0e-4817-bfc4-fde77f961ab0	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
77894843-a542-421e-8d8b-b8cf04c94d22	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
e19e19d2-7c37-49fe-a409-85b837942a83	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
2bb755d4-cfef-4f2a-844c-f257768b3b9b	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
54d14dd4-a8ae-4726-814c-65cfa9b6ac0a	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
8eb1f381-f9ec-48a0-8950-bbea6340d3de	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
3433460d-c1b5-40d6-a1ab-b14d0f2995d6	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
64758f88-b054-4a27-be9e-691cfac92fc1	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
50b8b690-5746-4640-9af0-62ad0752eeae	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
63929869-4a90-4d8b-bc29-9d8d396e0495	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
a7920c36-86e5-4243-8fd4-867c816c68d4	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
6b28afd3-636b-4105-9233-1f9073313d4b	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
ae075b30-5308-4e5c-ab4f-6fab46c98bcb	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
64a6524c-e487-42f5-a956-140e0803a6d9	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
6a469bd1-f971-4914-a318-b9a9a7d54ea0	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
66de3010-e0ba-4837-ad4e-80c7d40a5de1	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
ae7426c9-901b-4630-bcd5-4c7413e0eff1	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
f687a0f4-05b3-4183-bbb6-04537986f04b	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
ced81cb4-01ef-47f0-82e2-de55722bb376	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
bb279ee8-ecae-42bc-9137-18428938aa3b	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
778aad83-227e-4e00-af0a-295748bc3180	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
d4de2227-2093-48ee-8275-4dbe3d8dfa25	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
5f6fd092-78a9-48ea-84c0-f242ee84a724	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
3462728b-b66d-40af-b069-0a29362474b4	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
fcbd9a6f-4d44-4f36-a019-d515c3ef9fb8	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
ea794e0f-0bd8-4edc-8088-aa046e4c6878	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
a0c09f33-d246-42d6-897b-899c4dcbccbd	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
0d9b303f-f2fa-4b1b-af5d-fee12ea9fc1c	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
386afda7-e86b-4aef-829d-01439e73530f	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
b50e6af3-893d-4a52-b71c-2a23d1f74e14	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
faa5fb8e-1edc-4d59-8cf2-6c3b9b74b614	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
4ab922c2-2ed7-4850-8009-963f2a0f74be	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
66eef75f-2ccd-4a3c-b6db-71bdfa385152	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
adb65a41-a98d-4e14-8f59-a2fedd261ae3	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
3c78077e-c51c-43fa-ace0-2e7a9950682a	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
10e27418-61fa-49df-b90c-c243e75d4b0f	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
4199fea8-ae64-4933-9cbd-6c2b6ad66e40	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
fad6faec-99e6-48cb-80b0-6dd2623a4855	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
ee3c7083-56bb-4b32-9133-7f3fd5c76d4f	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
181d677b-8aa0-4fb4-ac8a-88d98a6e60d5	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
a2fe4a26-42a0-4c91-8f19-7ee78dcd3008	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
e21ef3d1-c737-4d0d-807c-5351b85f764e	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
e03c0c01-0fc0-477a-8243-e1f99d72b0c8	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
194bb00b-cab6-4f4e-8bcf-6b1a4953a577	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
56058e47-d48f-4435-9865-0cf44b505606	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
a16eadb0-691e-422d-a5fe-9eec7c0b1e59	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
f28c1b55-4f1e-43d0-b76b-268216334fcd	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
8855f9a3-1573-4ca9-ae70-7a5485f158d6	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
f4fec7da-6e25-447a-9b85-4a6a968fe6d1	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
75cdaf2c-21a5-435c-9b1c-6925852cc75b	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
3202045d-331c-4bb2-ab82-06c923d461e8	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
c24c7d50-4de0-40ca-ba7e-4ab33d0c27e1	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
738b211d-7d79-4bb5-a4bf-4bd58007487c	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
61982bdb-3a49-4089-b431-7d9abf241733	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
a73af113-f364-4429-bc5f-bec5cd9923b1	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
efbe74ea-ddb5-41b0-b4f8-d32b160750e5	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
7008d5f6-41f6-4602-8c93-cdb0f24203d0	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
93fb967a-c2af-4f58-b4e8-88a52acd488a	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
d2475854-a1b9-422b-962e-8ff89dd093cf	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
a46bb0e4-0c57-49ba-a5d8-5849e24a3296	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
abcf723a-9922-441c-95ed-3233fe680b51	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
f991bc2f-89e9-4684-9a2f-793e4809fffc	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
473bdccd-3e3a-477d-8c99-8eb00ad0c351	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
fb95156b-86a9-4f40-ba29-472a310d563f	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
699503cb-dad8-41d3-bb8f-a8e0d176b90c	Attendance Alert: Operating Systems	Your attendance in Operating Systems has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
0066a484-3f48-4faf-b39c-d0862bf60f95	Attendance Alert: Database Management	Your attendance in Database Management has dropped to 72.7%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
0c5bf7db-aa56-441b-905c-d0dfdb389907	Attendance Alert: Machine Learning	Your attendance in Machine Learning has dropped to 73.9%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
7d0cd048-ca29-4a09-bb75-7570254d089c	Attendance Alert: Data Structures	Your attendance in Data Structures has dropped to 68.2%. Minimum required is 75%.	attendance_risk	/dashboard/attendance	2026-05-31 15:44:03.395608+00
3d6b8ba4-2306-4c1d-be72-e4a7599fd7e1	Grade Alert: Machine Learning	Your grade in Machine Learning has dropped to D (Total: 40.0/100). Please consult your mentor.	grade_risk	/dashboard/grades	2026-05-31 15:44:03.395608+00
1227b23f-b10d-4e77-b471-ee28502c3dad	Grade Alert: Machine Learning	Your grade in Machine Learning has dropped to D (Total: 40.0/100). Please consult your mentor.	grade_risk	/dashboard/grades	2026-05-31 15:44:03.395608+00
ebef4297-d34f-4a88-9a4e-f6c9999cd529	Grade Alert: Machine Learning	Your grade in Machine Learning has dropped to D (Total: 43.0/100). Please consult your mentor.	grade_risk	/dashboard/grades	2026-05-31 15:44:03.395608+00
f9aa57b7-d95f-453d-be1f-967f02990fb7	Grade Alert: Machine Learning	Your grade in Machine Learning has dropped to F (Total: 37.0/100). Please consult your mentor.	grade_risk	/dashboard/grades	2026-05-31 15:44:03.395608+00
a5239636-98ba-44f2-abf0-2858402be971	Grade Alert: Database Management	Your grade in Database Management has dropped to D (Total: 47.0/100). Please consult your mentor.	grade_risk	/dashboard/grades	2026-05-31 15:44:03.395608+00
6c462cbf-ee0d-4557-898f-9e987b1ee47b	Grade Alert: Machine Learning	Your grade in Machine Learning has dropped to F (Total: 36.0/100). Please consult your mentor.	grade_risk	/dashboard/grades	2026-05-31 15:44:03.395608+00
29d5d46c-8ec3-44c1-8683-14fd2c3d6cf2	Grade Alert: Machine Learning	Your grade in Machine Learning has dropped to D (Total: 44.0/100). Please consult your mentor.	grade_risk	/dashboard/grades	2026-05-31 15:44:03.395608+00
a0196808-d6aa-4de7-aad3-e6be2651520d	Grade Alert: Operating Systems	Your grade in Operating Systems has dropped to D (Total: 53.0/100). Please consult your mentor.	grade_risk	/dashboard/grades	2026-05-31 15:44:03.395608+00
3c9554db-7ea9-47e5-bb15-7ab8d31872b6	Grade Alert: Machine Learning	Your grade in Machine Learning has dropped to D (Total: 50.0/100). Please consult your mentor.	grade_risk	/dashboard/grades	2026-05-31 15:44:03.395608+00
4f458501-d7f8-400c-a24c-62125c0273cd	Grade Alert: Database Management	Your grade in Database Management has dropped to D (Total: 43.0/100). Please consult your mentor.	grade_risk	/dashboard/grades	2026-05-31 15:44:03.395608+00
\.


--
-- Data for Name: parent_access_codes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.parent_access_codes (id, code, student_id, mentor_id, used, used_by_chat_id, expires_at, created_at) FROM stdin;
84dc8378-55a4-40e0-84c1-08ea7b0ca37e	FAB93C	b0000000-0000-0000-0000-000000000002	d35f1354-038a-4273-a177-0c07105cd9d6	f	\N	2026-05-28 05:56:19.672675+00	2026-05-21 05:56:19.672675+00
1762113b-8f88-4484-b661-bad274406dcc	5332BD	b0000000-0000-0000-0000-000000000002	d35f1354-038a-4273-a177-0c07105cd9d6	f	\N	2026-05-28 05:56:31.125508+00	2026-05-21 05:56:31.125508+00
1595ab09-3f76-4b76-8609-e8edd8d0d681	48AF2A	c544629d-bb02-4c51-9c23-dc743e51a9b1	d35f1354-038a-4273-a177-0c07105cd9d6	t	1060713423	2026-05-28 08:42:58.303011+00	2026-05-21 08:42:58.303011+00
52d140ee-6ca4-4f57-9c3f-f2963559ad35	668170	c544629d-bb02-4c51-9c23-dc743e51a9b1	d35f1354-038a-4273-a177-0c07105cd9d6	f	\N	2026-05-28 08:54:12.35113+00	2026-05-21 08:54:12.35113+00
e3e18bb3-b808-4d8f-ae38-c84a8d920708	BE8089	c544629d-bb02-4c51-9c23-dc743e51a9b1	d35f1354-038a-4273-a177-0c07105cd9d6	f	\N	2026-06-01 13:39:32.18741+00	2026-05-25 13:39:32.18741+00
438fc323-ea40-49da-aacd-0cecde185f0a	D1EA0D	31e328af-0472-4281-a2f9-8db26e83f2bb	d35f1354-038a-4273-a177-0c07105cd9d6	f	\N	2026-06-03 00:52:49.995594+00	2026-05-27 00:52:49.995594+00
\.


--
-- Data for Name: parent_student_links; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.parent_student_links (id, parent_id, student_id, created_at) FROM stdin;
68f5e853-9c7a-441d-acb5-a5f40d5aeb31	5fd7dc38-f545-4e42-9597-4d981ea55f9e	c544629d-bb02-4c51-9c23-dc743e51a9b1	2026-05-24 11:52:40.193211+00
\.


--
-- Data for Name: reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reports (id, student_id, mentor_id, report_type, content, created_at) FROM stdin;
86f96326-4eec-433b-85d6-8880cad34359	299efed3-47cc-4a52-a203-96f8ed2f50c0	14aad89b-3a0a-46c6-9297-56b4ce8f8280	summary	{"report": {"sections": [{"title": "Attendance Overview", "content": "Student 1 has demonstrated strong attendance across all subjects, which is a positive indicator of their commitment to their studies.", "data_points": ["Database Management: 80.95% (17/21 classes)", "Machine Learning: 85.71% (18/21 classes)", "Data Structures: 100% (21/21 classes)", "Operating Systems: 95.24% (20/21 classes)"]}, {"title": "Grade Performance", "content": "The grades reflect a mixed performance, with notable strengths in Data Structures and Operating Systems, but significant weaknesses in Machine Learning.", "data_points": ["Data Structures: Total=73/100, Grade=B", "Machine Learning: Total=40/100, Grade=D", "Operating Systems: Total=73/100, Grade=B", "Database Management: Total=63/100, Grade=C"]}], "mentor_name": "Academic Advisor", "report_title": "Academic Performance Summary for Student 1", "student_name": "Student 1", "generated_date": "2023-10-01T00:00:00Z", "overall_status": "At Risk", "academic_period": "Semester 6", "recommendations": ["Seek additional help or tutoring in Machine Learning to improve understanding and performance.", "Engage with professors during office hours for clarification on challenging topics.", "Consider forming study groups with peers to enhance collaborative learning.", "Regularly review course materials and practice problems to reinforce learning."], "closing_statement": "With focused effort and support, improvement is achievable.", "executive_summary": "Student 1 is currently facing challenges in their academic performance during Semester 6, particularly in Machine Learning where they received a grade of D. While attendance is commendable across all subjects, the grades indicate a need for improvement, especially in subjects critical to their Computer Science curriculum."}}	2026-05-12 15:12:49.709969+00
43c31c87-4396-4a55-9980-66ecf2a036b7	39259dfa-72e0-4568-b6ae-7beb2b01b10f	14aad89b-3a0a-46c6-9297-56b4ce8f8280	detailed	{"report": {"sections": [{"title": "Attendance Overview", "content": "The attendance record for Student 8 shows a commendable commitment to attending classes, particularly in Operating Systems. However, there is room for improvement in Database Management.", "data_points": ["Database Management: 76.19% (16/21 classes)", "Machine Learning: 85.71% (18/21 classes)", "Data Structures: 85.71% (18/21 classes)", "Operating Systems: 95.24% (20/21 classes)"]}, {"title": "Grade Analysis", "content": "The grades achieved by Student 8 indicate a mixed performance across different subjects. Notably, the grades in Machine Learning and Database Management are below expectations, which is concerning.", "data_points": ["Data Structures: Total=80/100, Grade=B", "Machine Learning: Total=50/100, Grade=D", "Operating Systems: Total=78/100, Grade=B", "Database Management: Total=57/100, Grade=C"]}], "mentor_name": "Academic Advisor", "report_title": "Academic Performance Report for Student 8", "student_name": "Student 8", "generated_date": "2023-10-01T00:00:00Z", "overall_status": "At Risk", "academic_period": "Semester 6", "recommendations": ["Engage in tutoring sessions for Machine Learning and Database Management to strengthen understanding of key concepts.", "Attend office hours for additional support from instructors in challenging subjects.", "Form study groups with peers to enhance collaborative learning and retention of material.", "Develop a structured study schedule to allocate sufficient time for revision and practice in weaker subjects."], "closing_statement": "Timely intervention and dedicated effort can significantly enhance academic performance.", "executive_summary": "Student 8 is currently facing challenges in their academic performance during Semester 6 of the Computer Science program. While attendance in courses is generally satisfactory, particularly in Operating Systems, the grades reflect significant areas of concern, especially in Machine Learning and Database Management. Immediate attention and strategic interventions are recommended to improve overall academic standing."}}	2026-05-12 17:00:03.789373+00
d2e01788-6a36-4908-a4d8-3e12d0de88d1	31e328af-0472-4281-a2f9-8db26e83f2bb	14aad89b-3a0a-46c6-9297-56b4ce8f8280	summary	{"report": {"sections": [{"title": "Attendance Overview", "content": "The attendance rates for the courses are generally good, with Data Structures showing the highest attendance. However, the attendance in Machine Learning is notably lower.", "data_points": ["Database Management: 85.71% (18/21 classes)", "Machine Learning: 76.19% (16/21 classes)", "Data Structures: 95.24% (20/21 classes)", "Operating Systems: 85.71% (18/21 classes)"]}, {"title": "Grade Performance", "content": "The grades reflect significant challenges in key subjects. The performance in Machine Learning is particularly concerning, with a grade of D, which requires urgent attention.", "data_points": ["Data Structures: Total=75/100, Grade=B", "Machine Learning: Total=43/100, Grade=D", "Operating Systems: Total=65/100, Grade=C", "Database Management: Total=59/100, Grade=C"]}], "mentor_name": "Academic Advisor", "report_title": "Academic Performance Summary for Student 3", "student_name": "Student 3", "generated_date": "2023-10-05T00:00:00Z", "overall_status": "At Risk", "academic_period": "Semester 6", "recommendations": ["Seek additional tutoring support for Machine Learning and Database Management.", "Engage with professors during office hours to clarify difficult concepts.", "Consider forming study groups with peers to enhance understanding of course material.", "Monitor attendance closely and aim to improve participation in all classes."], "closing_statement": "Immediate action is necessary to improve academic standing.", "executive_summary": "Student 3 is currently facing challenges in their academic performance during Semester 6 of the Computer Science program. While attendance is generally satisfactory, particularly in Data Structures, the grades in key subjects such as Machine Learning and Database Management indicate a need for immediate improvement. The overall performance suggests that the student is at risk of not meeting the academic requirements for progression."}}	2026-05-12 19:12:27.82213+00
6eaaa4f7-832c-4898-a984-31ef9d569bb9	c544629d-bb02-4c51-9c23-dc743e51a9b1	d35f1354-038a-4273-a177-0c07105cd9d6	parent	{"report": {"sections": [{"title": "Attendance Overview", "content": "Sejal's attendance varies significantly across her subjects, with some classes not attended at all. This inconsistency may hinder her ability to grasp essential concepts.", "data_points": ["Algorithm Design and Analysis: 0%", "Discrete Mathematical Structures: 0%", "Machine Learning: 73.91%", "Artificial Intelligence: 100%", "Database Management: 72.73%", "Operating Systems: 72.73%", "Data Structures: 68.18%"]}, {"title": "Grades Summary", "content": "Sejal has achieved commendable grades in some subjects, particularly in Machine Learning and Database Management. However, her performance in Operating Systems and Data Structures indicates areas that require improvement.", "data_points": ["Data Structures: 80/100 (Grade B)", "Machine Learning: 93/100 (Grade A)", "Operating Systems: 65/100 (Grade C)", "Database Management: 87/100 (Grade A)"]}], "mentor_name": "Mr. Rajesh Kumar", "report_title": "Sejal Kumari's Academic Performance Report", "student_name": "Sejal Kumari", "generated_date": "2023-10-01T00:00:00Z", "overall_status": "At Risk", "academic_period": "Semester 6", "recommendations": ["Encourage Sejal to attend all classes regularly to improve her understanding of the material.", "Suggest additional tutoring or study groups for subjects where her grades are lower.", "Monitor her progress closely and provide support in areas where she struggles."], "closing_statement": "With focused effort and support, Sejal can turn her academic performance around.", "executive_summary": "Sejal Kumari is currently facing challenges in her academic performance during Semester 6 of her Computer Science program. While she has demonstrated strong capabilities in Machine Learning and Database Management, her attendance in several key subjects is concerning, which may impact her overall understanding and performance. It is crucial for Sejal to improve her attendance and focus on her weaker subjects to ensure a successful semester."}}	2026-05-25 13:39:03.915495+00
4028ca99-228e-4e7f-878c-37f537761b3c	c544629d-bb02-4c51-9c23-dc743e51a9b1	d35f1354-038a-4273-a177-0c07105cd9d6	summary	{"report": {"sections": [{"title": "Attendance Overview", "content": "Sejal's attendance varies significantly across her courses, with some subjects showing no recorded attendance.", "data_points": ["Algorithm Design and Analysis: null% (0/0 classes)", "Discrete Mathematical Structures: null% (0/0 classes)", "Machine Learning: 73.91% (17/23 classes)", "Artificial Intelligence: 100% (1/1 classes)", "Database Management: 72.73% (16/22 classes)", "Operating Systems: 72.73% (16/22 classes)", "Data Structures: 68.18% (15/22 classes)"]}, {"title": "Grades Performance", "content": "Sejal has achieved varying grades across her subjects, with notable strengths in Machine Learning and Database Management.", "data_points": ["Data Structures: Total=80/100, Grade=B", "Machine Learning: Total=93/100, Grade=A", "Operating Systems: Total=65/100, Grade=C", "Database Management: Total=87/100, Grade=A"]}], "mentor_name": "Dr. Anjali Verma", "report_title": "Academic Performance Summary for Sejal Kumari", "student_name": "Sejal Kumari", "generated_date": "2023-10-01T00:00:00Z", "overall_status": "At Risk", "academic_period": "Semester 6", "recommendations": ["Improve attendance in all courses, especially those with null attendance.", "Focus on enhancing understanding in Operating Systems and Data Structures to raise grades.", "Consider seeking additional help or tutoring for subjects where performance is lacking."], "closing_statement": "Taking proactive steps now will greatly benefit your academic journey.", "executive_summary": "Sejal Kumari is currently facing challenges in maintaining consistent attendance and performance across her courses in the Computer Science program. While she has excelled in Machine Learning and Database Management, her attendance in several key subjects is lacking, which may impact her overall academic success. Immediate attention to attendance and improvement in grades in certain subjects is recommended to enhance her academic standing."}}	2026-05-26 13:50:15.978125+00
\.


--
-- Data for Name: resume_examples; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resume_examples (id, industry, title, resume_data, created_at) FROM stdin;
\.


--
-- Data for Name: semester_results; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.semester_results (id, student_id, usn, semester, sgpa, total_credits, earned_credits, status, raw_data, created_at) FROM stdin;
8d83ada3-b170-445d-9ff5-4b9f34c1d059	c544629d-bb02-4c51-9c23-dc743e51a9b1	1CR24CI055	3	9.27	22	22	PASS	[{"code": "BCS301", "name": "MATHEMATICS FOR COMPUTER SCIENCE", "total": 98, "passed": true, "result": "P", "credits": 4, "external": 48, "internal": 50, "gradePoints": 10}, {"code": "BCS302", "name": "DIGITAL DESIGN & COMPUTER ORGANIZATION", "total": 88, "passed": true, "result": "P", "credits": 4, "external": 39, "internal": 49, "gradePoints": 9}, {"code": "BCS303", "name": "OPERATING SYSTEMS", "total": 79, "passed": true, "result": "P", "credits": 4, "external": 29, "internal": 50, "gradePoints": 8}, {"code": "BCS304", "name": "DATA STRUCTURES AND APPLICATIONS", "total": 87, "passed": true, "result": "P", "credits": 3, "external": 42, "internal": 45, "gradePoints": 9}, {"code": "BCSL305", "name": "DATA STRUCTURES LAB", "total": 98, "passed": true, "result": "P", "credits": 1, "external": 49, "internal": 49, "gradePoints": 10}, {"code": "BSCK307", "name": "SOCIAL CONNECT AND RESPONSIBILITY", "total": 97, "passed": true, "result": "P", "credits": 1, "external": 0, "internal": 97, "gradePoints": 10}, {"code": "BPEK359", "name": "PHYSICAL EDUCATION", "total": 98, "passed": true, "result": "P", "credits": 3, "external": 0, "internal": 98, "gradePoints": 10}, {"code": "BCS358A", "name": "DATA ANALYTICS WITH EXCEL", "total": 99, "passed": true, "result": "P", "credits": 1, "external": 50, "internal": 49, "gradePoints": 10}, {"code": "BCS306A", "name": "OBJECT ORIENTED PROGRAMMING WITH JAVA", "total": 81, "passed": true, "result": "P", "credits": 1, "external": 33, "internal": 48, "gradePoints": 9}]	2026-05-12 19:26:25.19661+00
3b019614-1bfc-4ea3-b63d-0ba560a2079e	d35f1354-038a-4273-a177-0c07105cd9d6	1CR24CI030	3	9.27	22	22	PASS	[{"code": "BCS301", "name": "MATHEMATICS FOR COMPUTER SCIENCE", "total": 98, "passed": true, "result": "P", "credits": 4, "external": 48, "internal": 50, "gradePoints": 10}, {"code": "BCS302", "name": "DIGITAL DESIGN & COMPUTER ORGANIZATION", "total": 87, "passed": true, "result": "P", "credits": 4, "external": 37, "internal": 50, "gradePoints": 9}, {"code": "BCS303", "name": "OPERATING SYSTEMS", "total": 74, "passed": true, "result": "P", "credits": 4, "external": 24, "internal": 50, "gradePoints": 8}, {"code": "BCS304", "name": "DATA STRUCTURES AND APPLICATIONS", "total": 90, "passed": true, "result": "P", "credits": 3, "external": 40, "internal": 50, "gradePoints": 10}, {"code": "BCSL305", "name": "DATA STRUCTURES LAB", "total": 95, "passed": true, "result": "P", "credits": 1, "external": 46, "internal": 49, "gradePoints": 10}, {"code": "BSCK307", "name": "SOCIAL CONNECT AND RESPONSIBILITY", "total": 97, "passed": true, "result": "P", "credits": 1, "external": 0, "internal": 97, "gradePoints": 10}, {"code": "BPEK359", "name": "PHYSICAL EDUCATION", "total": 82, "passed": true, "result": "P", "credits": 3, "external": 0, "internal": 82, "gradePoints": 9}, {"code": "BCS306A", "name": "OBJECT ORIENTED PROGRAMMING WITH JAVA", "total": 85, "passed": true, "result": "P", "credits": 1, "external": 35, "internal": 50, "gradePoints": 9}, {"code": "BCS358A", "name": "DATA ANALYTICS WITH EXCEL", "total": 100, "passed": true, "result": "P", "credits": 1, "external": 50, "internal": 50, "gradePoints": 10}]	2026-05-13 14:00:37.739774+00
\.


--
-- Data for Name: timetables; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.timetables (id, class_id, day_of_week, start_time, end_time, location, created_at) FROM stdin;
1680af0d-51b6-48de-a36e-eee53e7d82e4	c7221a8c-09bc-4545-84df-058f73f7b11e	1	09:00:00	10:30:00	Room 304	2026-05-26 17:09:58.542051+00
c5750470-6efb-4f0d-9713-25f41bb3510f	65221f54-0a44-4bd1-991d-e08256571e38	1	11:00:00	12:30:00	Lab A	2026-05-26 17:09:58.542051+00
3bebc5d7-2d1b-40e4-8b7e-8d757eb58c85	4bb87678-40bf-479d-a97f-662e63cd652f	2	10:00:00	11:30:00	Room 201	2026-05-26 17:09:58.542051+00
7f1b5760-9a58-410e-9c17-aadc4c90ba97	931e073f-d654-4f85-88c7-3e48c60a0349	2	14:00:00	15:30:00	Lab B	2026-05-26 17:09:58.542051+00
34e680eb-2692-4409-bb51-2271be3b1fb6	c7221a8c-09bc-4545-84df-058f73f7b11e	3	09:00:00	10:30:00	Room 304	2026-05-26 17:09:58.542051+00
4972532a-3506-4bae-b34a-9f016249ecd4	65221f54-0a44-4bd1-991d-e08256571e38	3	13:00:00	15:00:00	Lab A	2026-05-26 17:09:58.542051+00
5af53393-669b-4490-b528-eb33239b31cd	4bb87678-40bf-479d-a97f-662e63cd652f	4	09:00:00	11:00:00	Room 201	2026-05-26 17:09:58.542051+00
91213cde-538b-429b-b129-ee943d1d45cf	931e073f-d654-4f85-88c7-3e48c60a0349	4	11:30:00	13:00:00	Lab B	2026-05-26 17:09:58.542051+00
a9ec843b-8623-448f-921a-7ba5c9d52014	65221f54-0a44-4bd1-991d-e08256571e38	5	10:00:00	12:00:00	Lab A	2026-05-26 17:09:58.542051+00
\.


--
-- Data for Name: user_notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_notifications (id, user_id, message_id, is_read, created_at) FROM stdin;
d412b7a0-34db-462a-bbde-f59f06705aa0	c544629d-bb02-4c51-9c23-dc743e51a9b1	a7a0e5fd-ad24-4bbb-a7f3-bd041a6f96e9	t	2026-05-26 17:28:09.660187+00
070625f0-ac44-4a07-9ffd-3201bf629e57	c544629d-bb02-4c51-9c23-dc743e51a9b1	ad11e60d-9e7e-46c2-a66d-ae62b695aa02	t	2026-05-27 05:41:03.655652+00
e4f79158-ece4-4a76-8066-09428978e052	c544629d-bb02-4c51-9c23-dc743e51a9b1	b129b1fb-ecc7-4fa9-9f2b-e86601a85300	t	2026-05-27 07:30:57.41681+00
0bf49254-ac23-4c91-a807-f3d7cec2d1f3	c544629d-bb02-4c51-9c23-dc743e51a9b1	4811e92d-8c28-48de-9dd0-88268b421422	t	2026-05-27 07:45:49.48649+00
8079f022-a177-46cf-9d50-e90e2972566f	c544629d-bb02-4c51-9c23-dc743e51a9b1	46ca9833-63b1-41c4-bc06-9fa6dfedc524	t	2026-05-27 07:58:28.512339+00
d527dc61-f541-4927-8ab7-03bab8056d4f	c544629d-bb02-4c51-9c23-dc743e51a9b1	9cbdf3db-0737-494e-b6ad-b0c684d6334e	t	2026-05-27 08:04:17.222406+00
6120dd73-37e9-4e90-9e5f-a9634945f1b4	c544629d-bb02-4c51-9c23-dc743e51a9b1	a9424455-227a-4c13-8d46-810ee6d08fcd	t	2026-05-27 08:26:06.261462+00
92611117-142e-4830-9bdb-fcb86321aad6	c544629d-bb02-4c51-9c23-dc743e51a9b1	bb07654f-a537-4c46-9ff4-506d56f247d6	t	2026-05-27 09:05:02.594993+00
64a47dd8-4efd-4f47-bc8d-2c9eaef63ae7	c2ad89fd-2583-4f46-ad0d-8232f6269718	e6002f22-d69b-43e4-a6b5-12b004da57ab	f	2026-05-31 15:17:56.735507+00
456043ba-ce86-47c3-9c9a-b88d908aead5	c2ad89fd-2583-4f46-ad0d-8232f6269718	3b313264-1bbe-4286-9b10-b707a3a640e7	f	2026-05-31 15:17:56.735507+00
bb2a8114-afc0-4aa8-8dbe-9e784f693960	c2ad89fd-2583-4f46-ad0d-8232f6269718	527e55bb-f93a-4498-aff1-ce557bbc8316	f	2026-05-31 15:17:56.735507+00
a2f189d0-a41a-4780-ae5a-b1be52cd82df	c2ad89fd-2583-4f46-ad0d-8232f6269718	dbf8ad4f-f1a8-48da-8ed0-2627315a5b1d	f	2026-05-31 15:17:56.735507+00
4075e305-3956-4765-b7c9-e4f0bfffb2f7	c2ad89fd-2583-4f46-ad0d-8232f6269718	9b1e0979-70df-44a6-b01d-ca6cb821f69f	f	2026-05-31 15:17:56.735507+00
02fed13c-eefe-4610-9961-5c79b814371d	14aad89b-3a0a-46c6-9297-56b4ce8f8280	965fcabb-31d0-4c50-b859-790d44debea7	f	2026-05-12 15:10:52.640559+00
0ff50ee7-3e84-4289-be7b-34e75851da0a	299efed3-47cc-4a52-a203-96f8ed2f50c0	16486eca-bb7e-4953-973f-b37b88fc2c56	f	2026-05-12 15:11:10.943022+00
6bb79701-39c3-4ced-a7b5-13d286c8719d	299efed3-47cc-4a52-a203-96f8ed2f50c0	cb21ab3f-ee61-4399-af44-e5f608bedca7	f	2026-05-12 15:11:10.943022+00
cab7882c-b453-4a18-8b71-305dd50f3baa	299efed3-47cc-4a52-a203-96f8ed2f50c0	e2f628bc-a390-4277-b7ad-038eda8d13e1	f	2026-05-12 15:11:10.943022+00
5c60aa48-d832-4125-86e2-e7db54bac6fd	299efed3-47cc-4a52-a203-96f8ed2f50c0	713d0aa5-6669-44ac-b471-2ffcf2ce3350	f	2026-05-12 15:11:10.943022+00
8473e836-1a39-4ab4-a26d-dc1b17ff3bb7	299efed3-47cc-4a52-a203-96f8ed2f50c0	584cd771-3816-4a72-af22-880a846b8062	f	2026-05-12 15:11:10.943022+00
0fae2618-1948-468d-a943-de37f6bbb4ea	299efed3-47cc-4a52-a203-96f8ed2f50c0	21f22659-7188-41d7-ba30-15d7d7500eb3	f	2026-05-12 15:11:10.943022+00
624385a4-14da-42e0-a956-3391ee84c13b	299efed3-47cc-4a52-a203-96f8ed2f50c0	5aba49c1-842b-4638-a226-c0f91e2e6370	f	2026-05-12 15:11:10.943022+00
c462526c-2721-4889-a48c-b7a2228218e5	299efed3-47cc-4a52-a203-96f8ed2f50c0	2ffd012d-0ba5-46f0-aa12-7b63fbc228f6	f	2026-05-12 15:11:10.943022+00
bcd3de91-1d3a-44c3-ac6e-9b6a23740024	299efed3-47cc-4a52-a203-96f8ed2f50c0	8d6e5af9-2835-45e1-93b7-1ef5b066ee67	f	2026-05-12 15:11:10.943022+00
566f0deb-17da-4f40-a9e6-fed12f24bd88	299efed3-47cc-4a52-a203-96f8ed2f50c0	a4618c00-b152-417b-91f3-193a03c0e722	f	2026-05-12 15:11:10.943022+00
388682b6-e235-43e5-81f9-6eceb2f0a93c	299efed3-47cc-4a52-a203-96f8ed2f50c0	457fd191-b8de-4ae1-9eff-67418e81a99d	f	2026-05-12 15:11:10.943022+00
63c12caa-8f52-4773-a7ae-77ce45efb3d8	299efed3-47cc-4a52-a203-96f8ed2f50c0	c755ed28-d1a0-4682-8012-0a5d65a6036e	f	2026-05-12 15:11:10.943022+00
8eb3ad66-5d6a-4f87-8b01-aa4799ba20dc	299efed3-47cc-4a52-a203-96f8ed2f50c0	77f55553-527d-4e61-b5d5-d1073f8e88e4	f	2026-05-12 15:11:10.943022+00
9be029f0-1b43-485a-9f09-ef884db3e258	299efed3-47cc-4a52-a203-96f8ed2f50c0	193c7d97-bf9b-40c5-b5ae-8af47a613a23	f	2026-05-12 15:11:10.943022+00
d7babd4f-17d9-41dd-aff8-d4672d20a100	299efed3-47cc-4a52-a203-96f8ed2f50c0	96199dc7-4341-44bd-8a2b-33ae6a42eec6	f	2026-05-12 15:11:10.943022+00
f6738826-0aac-441a-90ce-60ed3f2ab327	a0dee1a9-0426-4878-9726-cb5b880dd961	a2ff628b-3ec0-4bf3-9f6f-7961baf63868	f	2026-05-12 15:11:10.943022+00
3c37db5b-8da9-4eaf-93de-8fe953e435ac	a0dee1a9-0426-4878-9726-cb5b880dd961	c7d2b71b-4e0f-4a8a-8201-555ba5aef853	f	2026-05-12 15:11:10.943022+00
c51429f6-cc26-45a1-9417-0696bbe59ba7	a0dee1a9-0426-4878-9726-cb5b880dd961	8ad00afe-3733-453b-84f9-f830db06af49	f	2026-05-12 15:11:10.943022+00
e558b804-fe62-42c6-bf82-d72723385438	a0dee1a9-0426-4878-9726-cb5b880dd961	3c3a5a1d-68f9-4665-af8b-7da948e66d96	f	2026-05-12 15:11:10.943022+00
4fdd7cb8-8415-48c6-9174-9e152fea17fd	a0dee1a9-0426-4878-9726-cb5b880dd961	c0ac35f0-e1fe-4c5c-8dc6-8585b3611108	f	2026-05-12 15:11:10.943022+00
580ac750-7a21-4e50-8b18-29eac797778e	a0dee1a9-0426-4878-9726-cb5b880dd961	c328ad88-cf70-4b46-a3dc-b08635639279	f	2026-05-12 15:11:10.943022+00
f15cdf02-ac4e-433a-ad16-2fe4e9415a7e	a0dee1a9-0426-4878-9726-cb5b880dd961	c20f8b3e-618c-4177-8210-ae345304cbaa	f	2026-05-12 15:11:10.943022+00
f0fcf03c-7b63-41f0-9d7d-0701925cb33d	31e328af-0472-4281-a2f9-8db26e83f2bb	628f4870-7d85-4064-a2a6-8465ea6cadb0	f	2026-05-12 15:11:10.943022+00
7783cef2-9d65-4ec7-8efc-1641fd7a51fc	31e328af-0472-4281-a2f9-8db26e83f2bb	b42661f8-82e3-423a-b751-8ccb21ddb749	f	2026-05-12 15:11:10.943022+00
6ae08ce4-04b0-4f43-91dc-3e1efe9dadbc	31e328af-0472-4281-a2f9-8db26e83f2bb	fa2639ba-8b89-4edc-b351-f716fa71f5f1	f	2026-05-12 15:11:10.943022+00
40967df9-5213-4487-b2e0-131c33ada0fe	31e328af-0472-4281-a2f9-8db26e83f2bb	04588ee1-ff5b-4d9a-86ac-17f4e8095291	f	2026-05-12 15:11:10.943022+00
1cea6227-9ad7-42a4-bdbd-62df114ba975	502755cd-0595-4ac7-8dba-eb20ac1f69a6	a6ea9894-44f4-46b0-8f70-a493a5d48710	f	2026-05-12 15:11:10.943022+00
a7fc65e5-f162-4155-af72-19bbe95d7fd7	502755cd-0595-4ac7-8dba-eb20ac1f69a6	e498d66a-45c9-48b6-b175-a4bde91a145f	f	2026-05-12 15:11:10.943022+00
00571856-a46e-4c58-b60b-b3d0c3a22e10	502755cd-0595-4ac7-8dba-eb20ac1f69a6	78929124-f27f-4d55-bcbe-5dc35b5ed33d	f	2026-05-12 15:11:10.943022+00
9d3209f5-5440-485e-a270-1b1d396ba503	502755cd-0595-4ac7-8dba-eb20ac1f69a6	692ac12f-96fc-438f-8c78-015401ab56a7	f	2026-05-12 15:11:10.943022+00
bb7f134e-6e8d-4a4b-9883-558876577a8c	502755cd-0595-4ac7-8dba-eb20ac1f69a6	b9b5b2c7-01f8-411e-bd23-f66a242d4935	f	2026-05-12 15:11:10.943022+00
f6e6758d-929b-4292-b42d-a8ccc116e495	502755cd-0595-4ac7-8dba-eb20ac1f69a6	f4315ae9-5e40-46dd-82ae-d45708d20ac8	f	2026-05-12 15:11:10.943022+00
dd0e15be-d023-4e02-a6cc-658f82f5f5c0	502755cd-0595-4ac7-8dba-eb20ac1f69a6	842d4f96-0139-41f6-a379-9ea727dd3a06	f	2026-05-12 15:11:10.943022+00
2ee9ca80-bb54-487a-bd3d-f0b3f27484c9	502755cd-0595-4ac7-8dba-eb20ac1f69a6	6c4feedb-dcb9-43c9-b73d-e6888fbde8e4	f	2026-05-12 15:11:10.943022+00
8d503e9b-30d6-4bd1-bafc-3c314264095b	502755cd-0595-4ac7-8dba-eb20ac1f69a6	3415f59f-a6d4-429c-b3b2-7cb868386de7	f	2026-05-12 15:11:10.943022+00
f8abf7bc-443c-4630-82df-8222f91431d1	502755cd-0595-4ac7-8dba-eb20ac1f69a6	558a1971-9141-4dec-9f57-17768d2c9a2d	f	2026-05-12 15:11:10.943022+00
78ccf74e-bd61-49c0-94f4-ad884471b9c7	502755cd-0595-4ac7-8dba-eb20ac1f69a6	3714b531-5b17-40d7-a438-a8830f4f9dd7	f	2026-05-12 15:11:10.943022+00
ad46df90-32ac-436e-b4f6-4959ed55a005	502755cd-0595-4ac7-8dba-eb20ac1f69a6	7c2d5b0d-4450-47d3-a4fc-b8dc87db6a19	f	2026-05-12 15:11:10.943022+00
4ee4ff9a-c847-4e33-8d56-f9688157565b	502755cd-0595-4ac7-8dba-eb20ac1f69a6	a497cac7-9f89-4170-948f-1bc5b99f97cb	f	2026-05-12 15:11:10.943022+00
612ec31e-1675-4182-81c4-01df42e83522	bc8f862e-ec2c-4c37-b924-c34864013f1c	af1221f8-17b6-4c05-9895-9226ad9212b1	f	2026-05-12 15:11:10.943022+00
964d32ac-2141-47bb-a11a-8d1a814b65cf	bc8f862e-ec2c-4c37-b924-c34864013f1c	a57a8e2e-1d10-4f73-b493-f86f88485a78	f	2026-05-12 15:11:10.943022+00
fe1f38fa-d671-47d2-92f5-ce66e01d818e	bc8f862e-ec2c-4c37-b924-c34864013f1c	84abcf29-0823-47d7-8c95-569232dc719c	f	2026-05-12 15:11:10.943022+00
81e04da0-2e93-4d02-a57b-c8f773fe9537	bc8f862e-ec2c-4c37-b924-c34864013f1c	4154cade-1742-43d7-9ee4-a2695f6fa470	f	2026-05-12 15:11:10.943022+00
246d3ba7-13d4-4adb-a8f8-2c604095afdb	bc8f862e-ec2c-4c37-b924-c34864013f1c	3054e794-59dd-4bac-b852-c3bad19d87f9	f	2026-05-12 15:11:10.943022+00
edd3965e-4e41-42bf-bf5c-7e00c30f2a01	bc8f862e-ec2c-4c37-b924-c34864013f1c	22ad347e-0a53-4e38-a88b-3348c4f8ee9b	f	2026-05-12 15:11:10.943022+00
07283f4c-9791-4552-9e8a-0b66c9c335d2	bc8f862e-ec2c-4c37-b924-c34864013f1c	80ca2457-318c-4564-b0f4-2b3924e39112	f	2026-05-12 15:11:10.943022+00
bc4ab6b3-18bd-44e0-b2d4-016e910c00b9	bc8f862e-ec2c-4c37-b924-c34864013f1c	6bdbeed7-b6d2-454c-a5bf-5a823ecf35bd	f	2026-05-12 15:11:10.943022+00
0aaff8ad-b70a-4333-98f2-291edade7367	bc8f862e-ec2c-4c37-b924-c34864013f1c	fe7c1a76-56dc-4f6e-a00d-8c432681ff55	f	2026-05-12 15:11:10.943022+00
0b675431-8b2b-4a7c-8be1-7a36494302e9	bc8f862e-ec2c-4c37-b924-c34864013f1c	bef5ebed-e9d9-45eb-883d-c35e712bd0f2	f	2026-05-12 15:11:10.943022+00
9d735542-343e-48ca-b55e-92ebf8eda5d9	bc8f862e-ec2c-4c37-b924-c34864013f1c	3efd0bcf-3b62-445c-82d4-67a713005e70	f	2026-05-12 15:11:10.943022+00
d18e542b-04a1-4000-a1e3-eeadddfdeee0	bc8f862e-ec2c-4c37-b924-c34864013f1c	8590420a-373b-4959-9865-80134d5c662c	f	2026-05-12 15:11:10.943022+00
5aed18e9-6ae4-4252-820d-03a91268ec8a	bc8f862e-ec2c-4c37-b924-c34864013f1c	cb6fdb62-66ac-4b08-b2cf-d5088fca253d	f	2026-05-12 15:11:10.943022+00
df05fdf5-c14a-434c-91bb-c77a1f322b2a	bc8f862e-ec2c-4c37-b924-c34864013f1c	ffb2cbca-9669-4c65-9497-e9145dc38ce3	f	2026-05-12 15:11:10.943022+00
6e76a12f-4a02-4879-95cc-0ddefdd073f9	bc8f862e-ec2c-4c37-b924-c34864013f1c	66450513-8827-42a8-bc59-65f6f0e639ae	f	2026-05-12 15:11:10.943022+00
1bf9f773-45fc-4e4b-b231-b97188a0308e	bc8f862e-ec2c-4c37-b924-c34864013f1c	24c48a1a-717c-419f-9c35-a1a38a0f29e5	f	2026-05-12 15:11:10.943022+00
c6b75872-7f66-4d93-b7b4-1deb1a790a40	bc8f862e-ec2c-4c37-b924-c34864013f1c	8d54e672-7497-4aa9-8701-d2f4c7d9457d	f	2026-05-12 15:11:10.943022+00
5ba3a50e-7ceb-4503-8721-d44f2a103b7c	bc8f862e-ec2c-4c37-b924-c34864013f1c	dd13bda9-dd08-4236-a04d-fdce2e0d6d42	f	2026-05-12 15:11:10.943022+00
d49ff774-294a-4816-b44a-b2fd79f89371	bc8f862e-ec2c-4c37-b924-c34864013f1c	f9c71306-bb24-49ac-83f9-0df97b4630d7	f	2026-05-12 15:11:10.943022+00
4cd9dac6-11cf-47b5-89c3-b96e727a6994	bc8f862e-ec2c-4c37-b924-c34864013f1c	e04eb409-3ece-4ad0-af3e-c6145abed865	f	2026-05-12 15:11:10.943022+00
0fc34509-fa25-485c-980f-e67c4c67ed42	bc8f862e-ec2c-4c37-b924-c34864013f1c	05adaf0a-99e7-48f1-864a-60329c3fd15d	f	2026-05-12 15:11:10.943022+00
3d848fa3-9b2c-4ffc-ad36-3275b43d7133	bc8f862e-ec2c-4c37-b924-c34864013f1c	2bc5ac62-b107-46ad-aa08-0be9d489a89d	f	2026-05-12 15:11:10.943022+00
26be7408-2557-4285-b762-e1032fe155d1	bc8f862e-ec2c-4c37-b924-c34864013f1c	7e22b3ba-c680-4f75-8a99-0282967c8efb	f	2026-05-12 15:11:10.943022+00
f50ba25e-aaa7-4dc6-8ac1-6f165c128dc8	380e4e1d-f169-474c-812b-d9a157b98930	b3ea4275-1fee-4e09-a831-154391ab672a	f	2026-05-12 15:11:10.943022+00
e487339e-0976-40ff-82a2-a79c0cd02df3	380e4e1d-f169-474c-812b-d9a157b98930	a0db8dbf-5e40-4399-9e43-782526bc0125	f	2026-05-12 15:11:10.943022+00
663134bc-bcc6-462a-a796-9e9ad978068b	380e4e1d-f169-474c-812b-d9a157b98930	085c0685-6e45-49a3-8203-a6285fb98acb	f	2026-05-12 15:11:10.943022+00
1573c474-89aa-422e-8ed3-69434889cf40	380e4e1d-f169-474c-812b-d9a157b98930	3d810db4-7b81-4cae-8c53-be2cf4870a5c	f	2026-05-12 15:11:10.943022+00
b053df27-7741-4c42-bd92-fa27bbcc2eaa	c2ad89fd-2583-4f46-ad0d-8232f6269718	ea5ba4a9-092c-47b6-884f-52864df7424b	f	2026-05-31 15:17:56.735507+00
3f78960b-1a71-4b5b-af00-2c278b7acb4c	c2ad89fd-2583-4f46-ad0d-8232f6269718	87787d81-c5ea-43ea-99f6-022029ce35e5	f	2026-05-31 15:17:56.735507+00
2e6278e8-72d7-43eb-a207-feb65f6fd172	c2ad89fd-2583-4f46-ad0d-8232f6269718	b4d9df38-e3f7-47eb-99d3-d827a2943f07	f	2026-05-31 15:17:56.735507+00
0e5fbe1a-64aa-40ab-9952-57b9b0d090a1	c2ad89fd-2583-4f46-ad0d-8232f6269718	9ef103be-02fa-482f-b0f1-8d207ec363b8	f	2026-05-31 15:17:56.735507+00
b24a7eb5-a4c8-412d-ab30-5355f4a39412	c2ad89fd-2583-4f46-ad0d-8232f6269718	61fafd71-209d-4d48-8a37-03b2b4fae112	f	2026-05-31 15:17:56.735507+00
16373d68-25a9-420d-9c64-c284aada8b43	c2ad89fd-2583-4f46-ad0d-8232f6269718	c08e37d9-847a-4584-af32-9a7651cd7233	f	2026-05-31 15:17:56.735507+00
3c455dba-a5a1-4799-a2f9-3f97ee7f795e	380e4e1d-f169-474c-812b-d9a157b98930	49ffe57f-58bb-42fd-88e9-4bac4454e6b9	f	2026-05-12 15:11:10.943022+00
2ca58708-0d56-44c7-a2b6-341f699373ca	380e4e1d-f169-474c-812b-d9a157b98930	fe843144-258e-4497-aa87-c0653064d71a	f	2026-05-12 15:11:10.943022+00
31ca5338-b517-4421-9d1c-7a5b25ed5951	380e4e1d-f169-474c-812b-d9a157b98930	661776e8-4d05-4cf0-a4de-1c546ec0dd2d	f	2026-05-12 15:11:10.943022+00
7d738877-4a3f-429c-bd35-d69618ec9495	380e4e1d-f169-474c-812b-d9a157b98930	bf4fff8f-70af-48be-8af8-daaa140193d8	f	2026-05-12 15:11:10.943022+00
88a8eba8-6f84-4a9d-94ec-30dd4d0594ba	39259dfa-72e0-4568-b6ae-7beb2b01b10f	30d1b6fd-3d2c-4c0e-87bf-25e6574197e3	f	2026-05-12 15:11:10.943022+00
693e476a-72bd-49c2-b0a3-863b44a2d117	39259dfa-72e0-4568-b6ae-7beb2b01b10f	fa472839-f106-45d9-acac-3b892898a5f2	f	2026-05-12 15:11:10.943022+00
90285f0a-63b1-4c4b-89f1-6a50e7929ffa	39259dfa-72e0-4568-b6ae-7beb2b01b10f	f0f9a4db-3f0d-4d9a-9c89-99723bb0af8f	f	2026-05-12 15:11:10.943022+00
6381cfc8-db58-4518-96d8-8c9735c5b819	39259dfa-72e0-4568-b6ae-7beb2b01b10f	67aed75c-e815-4d56-8811-eca495c17ebd	f	2026-05-12 15:11:10.943022+00
e49b9923-18df-4399-af9e-791db07f8681	39259dfa-72e0-4568-b6ae-7beb2b01b10f	7b9b05f0-6574-43e8-8890-ed7bc05400dd	f	2026-05-12 15:11:10.943022+00
02b968f3-d9a5-4e70-962c-d84fbb61a65c	39259dfa-72e0-4568-b6ae-7beb2b01b10f	bfb78218-04fb-4f5a-9711-af1ee23abe67	f	2026-05-12 15:11:10.943022+00
862c2ec9-553b-4910-9893-e80169a5f33d	39259dfa-72e0-4568-b6ae-7beb2b01b10f	38e8ed12-d88b-4325-b3c6-d003769af5d8	f	2026-05-12 15:11:10.943022+00
9c3566d0-32cc-475d-8ba4-12026dc7f110	39259dfa-72e0-4568-b6ae-7beb2b01b10f	d982e317-1236-4ac9-becf-3995c143de0e	f	2026-05-12 15:11:10.943022+00
effeb144-db9a-4ecf-bf50-c78cbcde188b	39259dfa-72e0-4568-b6ae-7beb2b01b10f	5233f774-c5a0-429e-8652-7a921a74f8ab	f	2026-05-12 15:11:10.943022+00
c9001294-bcc2-4d80-b62a-28742e3faa5a	39259dfa-72e0-4568-b6ae-7beb2b01b10f	0e5a4618-9c41-4072-a1eb-2386b324842b	f	2026-05-12 15:11:10.943022+00
b24e7498-7991-4f6b-ab0b-634c9c563efc	39259dfa-72e0-4568-b6ae-7beb2b01b10f	0a46811e-80c9-4439-81b5-775bec9e05a3	f	2026-05-12 15:11:10.943022+00
8707df2e-49a3-4523-bf55-1590d3c9e1a8	39259dfa-72e0-4568-b6ae-7beb2b01b10f	7dc3dc97-87f7-47ec-a5b9-a76919f5965d	f	2026-05-12 15:11:10.943022+00
af1bf279-f6cd-4fa5-9008-5c3c9279be7f	39259dfa-72e0-4568-b6ae-7beb2b01b10f	6fff85b9-e6de-4c04-a8b5-2b8c5c3cefca	f	2026-05-12 15:11:10.943022+00
611892f0-bc4d-4506-a2f9-e0221d8e3317	39259dfa-72e0-4568-b6ae-7beb2b01b10f	cc4230e8-4f9a-4712-8bd1-a8f399eb20b5	f	2026-05-12 15:11:10.943022+00
be0cb5eb-3db2-4be5-b31e-db5085d46036	39259dfa-72e0-4568-b6ae-7beb2b01b10f	0187f1b3-dda0-46e1-a705-6559b62ec2ee	f	2026-05-12 15:11:10.943022+00
7aaacccf-9dc6-467f-a8ab-e7d081e0973c	39259dfa-72e0-4568-b6ae-7beb2b01b10f	bd194a31-1d81-4b3b-b9c4-438dd3211d23	f	2026-05-12 15:11:10.943022+00
e407c2a0-b41a-40d5-860f-0e82c6479b65	c2ad89fd-2583-4f46-ad0d-8232f6269718	be039806-29b4-49ae-858a-9ceee831fd00	f	2026-05-12 15:11:10.943022+00
2abb0d2e-0d4d-46cb-8235-5e6bb8e88d9f	c2ad89fd-2583-4f46-ad0d-8232f6269718	a9e0d6e4-f103-4bb2-b95f-babe41c19442	f	2026-05-12 15:11:10.943022+00
b916786d-b9da-44ff-8e89-b27f6286c0b1	c2ad89fd-2583-4f46-ad0d-8232f6269718	497597f1-90ca-44a7-a620-dbbc12187897	f	2026-05-12 15:11:10.943022+00
25c4be52-2fa4-4699-9c56-4343e5666a76	c2ad89fd-2583-4f46-ad0d-8232f6269718	df5a8aa8-e1d1-4394-9d8b-acef63085038	f	2026-05-12 15:11:10.943022+00
6b54728f-297c-4311-8f99-1aa9f94e4444	c2ad89fd-2583-4f46-ad0d-8232f6269718	245ea02c-46cb-450d-a5d9-efe88e4c9eb6	f	2026-05-12 15:11:10.943022+00
51a661d0-dea0-4378-8ae5-454318f0f76c	c2ad89fd-2583-4f46-ad0d-8232f6269718	c095df37-8812-47f4-81ca-220c48b89c47	f	2026-05-12 15:11:10.943022+00
23f7c017-c17a-4ea9-aecd-de11640fefc1	c2ad89fd-2583-4f46-ad0d-8232f6269718	c3b15620-a19b-4d2e-900b-4902f1374d5e	f	2026-05-12 15:11:10.943022+00
815ba3f3-f8d0-47df-aef7-8a7112f84131	c2ad89fd-2583-4f46-ad0d-8232f6269718	a1a9a028-d7cb-4fa6-8873-53c424e7caad	f	2026-05-12 15:11:10.943022+00
d134d18e-efa2-4113-88e0-6a15d6f833de	c2ad89fd-2583-4f46-ad0d-8232f6269718	61833c3e-0f26-4ae6-bf30-7d322d6af8b5	f	2026-05-12 15:11:10.943022+00
2d43ba3e-5d35-4387-a925-d710f077c932	c2ad89fd-2583-4f46-ad0d-8232f6269718	5fb9541a-6b6c-42c9-b6c3-3e01324b0bdc	f	2026-05-12 15:11:10.943022+00
e1381975-46d7-47b9-b345-9de2e16f992b	c2ad89fd-2583-4f46-ad0d-8232f6269718	638589c0-28c1-4397-8673-679724df3dc4	f	2026-05-12 15:11:10.943022+00
c5b22663-d80a-485d-82e1-a3bd9fb924cf	c2ad89fd-2583-4f46-ad0d-8232f6269718	787cb865-e1b5-4b15-8d5f-15763d0b12b5	f	2026-05-12 15:11:10.943022+00
c1c8fb46-e140-4f66-a519-84b5c512fb94	c2ad89fd-2583-4f46-ad0d-8232f6269718	d72d8cda-e98d-4335-afaa-60c58031a1a7	f	2026-05-12 15:11:10.943022+00
6420323c-e9f2-43dc-a65a-59170bae1ec3	c2ad89fd-2583-4f46-ad0d-8232f6269718	8925022f-bfd1-434d-90da-22225689c3f0	f	2026-05-12 15:11:10.943022+00
c87a5db4-991d-4304-ad34-3ec92318aabd	c2ad89fd-2583-4f46-ad0d-8232f6269718	b8e341c1-772d-46dd-8867-e7602927a4b5	f	2026-05-12 15:11:10.943022+00
430129da-8df5-430f-8bc8-8a3ac46bd1bf	c2ad89fd-2583-4f46-ad0d-8232f6269718	8d0ea5a0-b5c0-4ac6-b322-3d0852c1052d	f	2026-05-12 15:11:10.943022+00
16a3a97d-52a4-419d-8ea5-2cc1290948b6	c544629d-bb02-4c51-9c23-dc743e51a9b1	53a7a5b6-6072-497f-ab4c-53d3854d6416	t	2026-05-27 05:36:10.03433+00
22e1c174-fad1-4d2e-bc21-6ae81b613095	c544629d-bb02-4c51-9c23-dc743e51a9b1	f1c7013e-3701-4d27-97b8-606d7e4e811c	t	2026-05-27 05:45:11.795067+00
9a33434b-0d4a-4867-b216-eff6795bf0f1	c544629d-bb02-4c51-9c23-dc743e51a9b1	8ffee082-3b1c-4ed0-a00d-643d7e9cdee9	t	2026-05-27 07:40:47.519448+00
6f8b9957-6785-49f4-8467-40b47ef88d6c	c544629d-bb02-4c51-9c23-dc743e51a9b1	033d826a-e71c-4e81-8ade-66861f25d9c8	t	2026-05-27 07:53:24.357481+00
8e65e2b9-3c97-48b1-af90-9fc9b3ae23fd	c544629d-bb02-4c51-9c23-dc743e51a9b1	b25c4a39-f7a9-48b9-bf81-b3ec02a11a2a	t	2026-05-27 08:00:27.100191+00
412b3607-30a6-4aa8-93b9-f83bc8c0a985	c544629d-bb02-4c51-9c23-dc743e51a9b1	8d292f39-6276-4ce0-bdf6-54beeafa499b	t	2026-05-27 08:08:02.88861+00
e8407c64-25e2-4131-a925-39d6a552c295	c544629d-bb02-4c51-9c23-dc743e51a9b1	d58fe96b-db6c-48a0-94ee-f4f17db1598b	t	2026-05-27 08:26:40.311567+00
0c49abc1-0478-4142-b660-3e573ccd7686	c544629d-bb02-4c51-9c23-dc743e51a9b1	2d4f9965-dd05-454c-81ca-44f2c040b730	t	2026-05-27 09:38:03.126092+00
f8758f82-a5d5-4f04-a33e-d52e7c992752	c544629d-bb02-4c51-9c23-dc743e51a9b1	acdc6476-e1d7-4244-8d8e-276e1f262436	f	2026-05-31 15:17:56.735507+00
d8fb809a-a422-4601-9f1c-69c73c337e8d	c544629d-bb02-4c51-9c23-dc743e51a9b1	41f3b99d-cfcc-4e01-bfb8-bbe333f02b91	f	2026-05-31 15:17:56.735507+00
38d931f7-8367-412b-be7d-8cd1f060492d	c544629d-bb02-4c51-9c23-dc743e51a9b1	00c1c097-bd78-4448-b4c1-eb2c466110ee	f	2026-05-31 15:17:56.735507+00
eaa9fc4e-80ed-4569-97d5-e70874bd85c5	c544629d-bb02-4c51-9c23-dc743e51a9b1	fa118f1f-f230-4205-90ac-50684b5c2b2d	f	2026-05-31 15:17:56.735507+00
5211b218-7945-40ff-a80f-8b72cdd4f23e	c544629d-bb02-4c51-9c23-dc743e51a9b1	98ded6f1-d2c5-4284-8d00-62cd06640145	f	2026-05-31 15:17:56.735507+00
fbf2574f-e283-41fc-b404-7c279dae3f2e	c544629d-bb02-4c51-9c23-dc743e51a9b1	6b7f90e7-a85d-4359-b374-98ef45c778b1	f	2026-05-31 15:17:56.735507+00
0916f39d-588a-467c-9c5a-549d734fc1fa	c544629d-bb02-4c51-9c23-dc743e51a9b1	196d4c5f-a114-47ac-a741-fc925e2d81cf	f	2026-05-31 15:17:56.735507+00
e322dbd7-36b3-4877-b5bd-8f6ae3fcbbb4	c544629d-bb02-4c51-9c23-dc743e51a9b1	3b3b9639-a89b-4e3c-a39f-b935bb193e28	f	2026-05-31 15:17:56.735507+00
bfea3968-be95-4e5c-84b0-13695bf7b7ba	c544629d-bb02-4c51-9c23-dc743e51a9b1	1c900462-178c-4ba2-8378-540bf445f9fb	f	2026-05-31 15:17:56.735507+00
3ad020ee-10fd-4776-9839-a3e930634246	c544629d-bb02-4c51-9c23-dc743e51a9b1	5c1814d5-aa74-420e-9cef-1803b477bd42	f	2026-05-31 15:17:56.735507+00
eccc6133-e7cb-4b1e-b301-ff3a0d9f8b29	c544629d-bb02-4c51-9c23-dc743e51a9b1	2324b198-334d-40b0-9ae1-a7266bdfe08a	f	2026-05-31 15:17:56.735507+00
37861dc2-c45d-441c-b89d-7ba1dc7b97a7	c544629d-bb02-4c51-9c23-dc743e51a9b1	2bf0e0ec-318d-4a08-8683-cf7d6bc9132e	f	2026-05-31 15:17:56.735507+00
6ad628f9-9389-4cf4-a81f-5bb8b5a1a414	c544629d-bb02-4c51-9c23-dc743e51a9b1	bc9ff944-4aea-4447-ab55-90b53aa3a3f4	f	2026-05-31 15:17:56.735507+00
ac093fd4-2341-486b-9230-331dbbfb58cd	c544629d-bb02-4c51-9c23-dc743e51a9b1	2e307d8a-53b1-4bfc-a30a-f148f8b6b851	t	2026-05-14 03:42:46.004875+00
4e2932b6-6a43-4def-9524-b2c27b92c2bd	c544629d-bb02-4c51-9c23-dc743e51a9b1	37359db5-c1d6-4d27-a48a-e8cebc9c5b29	t	2026-05-12 19:29:20.777049+00
a5dba5b9-1082-465e-bd3e-fb0743ed1c04	c544629d-bb02-4c51-9c23-dc743e51a9b1	4a2a000a-b476-4981-8413-78cfd2d53abe	t	2026-05-12 19:29:20.777049+00
423d4010-b45a-4064-9206-2bd0ea87fdcd	c544629d-bb02-4c51-9c23-dc743e51a9b1	4a9f1a7e-6f84-460a-b69a-65a2ec859e49	t	2026-05-12 19:29:20.777049+00
09b7a495-4856-40ea-a8a2-0f76f52b0488	c544629d-bb02-4c51-9c23-dc743e51a9b1	58392b3a-8e24-46ce-970b-601da52ad017	t	2026-05-12 19:29:20.777049+00
bf0c2b32-29e3-478a-b1b8-97c80e585edc	c544629d-bb02-4c51-9c23-dc743e51a9b1	58d05755-730d-4878-a30b-966381a6d8a5	t	2026-05-12 19:29:20.777049+00
c234b559-941c-411d-8054-2f47d0db1846	c544629d-bb02-4c51-9c23-dc743e51a9b1	5c443886-f88f-48d1-b8d3-ea07fc9dea9f	t	2026-05-12 19:29:20.777049+00
f61e98ea-62af-4ddc-881b-83e9d83c2224	c544629d-bb02-4c51-9c23-dc743e51a9b1	60165ac4-05f9-49b8-baff-7afb400c350a	t	2026-05-12 19:29:20.777049+00
799d9ebc-1d1d-4f39-b082-03f72140571c	c544629d-bb02-4c51-9c23-dc743e51a9b1	641a3d73-b4e9-42e1-b7bf-162fe9096954	t	2026-05-12 19:29:20.777049+00
6e4af9a5-fede-42e6-8788-e32125bb90c0	c544629d-bb02-4c51-9c23-dc743e51a9b1	690951ec-8107-465e-9698-9eb267f2e42c	t	2026-05-12 19:29:20.777049+00
b695bdc1-59ce-4a75-a735-1e0a271d0c63	c544629d-bb02-4c51-9c23-dc743e51a9b1	6b790be3-dd44-4972-8e1c-c1ddfc7e0b66	t	2026-05-12 19:29:20.777049+00
a94fa938-5ef8-48c4-b6ca-7f4e5ab8a10d	c544629d-bb02-4c51-9c23-dc743e51a9b1	6bfbb5ac-49f5-4e64-9b50-0d3dcd82867f	t	2026-05-12 19:29:20.777049+00
e5ddf730-b8a9-493f-a2ca-2bf8b1cf9976	c544629d-bb02-4c51-9c23-dc743e51a9b1	7dedaf88-3ddc-4134-a742-455408f875bf	t	2026-05-12 19:29:20.777049+00
6f7e74fd-5be1-4e13-8d8a-1cf7216f1f5a	c544629d-bb02-4c51-9c23-dc743e51a9b1	81c97800-6147-4a43-bafd-ca72b699529c	t	2026-05-14 03:43:41.735675+00
7401eea1-a278-4190-85c1-545d03ac5093	c544629d-bb02-4c51-9c23-dc743e51a9b1	8e13f6ce-3e08-4f05-8ccd-b3bed036ef7b	t	2026-05-12 19:29:20.777049+00
54bc1569-83a5-4329-ad9e-daeb7a6cca3b	c544629d-bb02-4c51-9c23-dc743e51a9b1	ab9e6f4f-164c-41ce-b21c-929a353f5e58	t	2026-05-12 19:29:20.777049+00
b210113e-6b0e-4b31-a54b-f53421b3de8c	c544629d-bb02-4c51-9c23-dc743e51a9b1	b0e3ebb8-0726-4ab9-b968-9546303fbefe	t	2026-05-12 19:29:20.777049+00
bc50342f-745c-40b0-aa71-82314bc3294a	c544629d-bb02-4c51-9c23-dc743e51a9b1	b2f47c38-921e-46a4-be3c-e8fdec03b9a4	t	2026-05-12 19:29:20.777049+00
9b137349-415f-462e-b49b-bb7709586e5e	c544629d-bb02-4c51-9c23-dc743e51a9b1	bafedf68-fc29-40be-a3f1-de6d59772a65	t	2026-05-12 19:29:20.777049+00
1b9c77e0-9c56-4c00-9388-ab5fb5cb1318	c544629d-bb02-4c51-9c23-dc743e51a9b1	c736645a-0ea9-4277-a73b-048ee66eb48a	t	2026-05-12 19:29:20.777049+00
766003db-b1b8-4103-8452-9c32c448e783	c544629d-bb02-4c51-9c23-dc743e51a9b1	cad68fd0-b048-4c0a-a5ff-11c0e284d794	t	2026-05-12 19:29:20.777049+00
a9a46ced-3b5f-4a1c-9100-4277eb0a7830	c544629d-bb02-4c51-9c23-dc743e51a9b1	df257eec-ff23-46f8-99a8-d92ce4b888aa	t	2026-05-12 19:29:20.777049+00
892026c6-a3ff-425b-8aed-e32bcae52a25	c544629d-bb02-4c51-9c23-dc743e51a9b1	e80d1704-17d3-40d3-bb53-dacc5eb4035e	t	2026-05-12 19:29:20.777049+00
e642b0c5-b558-42fc-b125-ad8bba6702a0	c544629d-bb02-4c51-9c23-dc743e51a9b1	06946dd6-48ea-454a-b9dc-7c92a557f2ac	t	2026-05-27 05:40:31.095119+00
886b7d2a-6ab0-4ffa-854e-fc68e64ec920	c544629d-bb02-4c51-9c23-dc743e51a9b1	b92d7fc6-3a08-4763-befd-3b0f93a9db61	t	2026-05-27 05:47:02.217077+00
80e271ba-f242-4ebc-8578-3803948b4643	c544629d-bb02-4c51-9c23-dc743e51a9b1	9a867845-57ba-4fda-b953-ab8d3cb6f856	t	2026-05-27 07:44:49.739502+00
adf81a9c-77f1-4d64-b481-a0e85f658e40	c544629d-bb02-4c51-9c23-dc743e51a9b1	76a2ba8b-d049-481b-8b36-d5a3e4d1341b	t	2026-05-27 07:56:43.636308+00
7db4f02d-769c-41e7-b3a8-876cc772e9d6	c544629d-bb02-4c51-9c23-dc743e51a9b1	db3c13a2-acfe-4227-9b52-b0cef8d9b8b5	t	2026-05-27 08:02:31.431905+00
a66decdb-62fc-4a3b-9834-d9c61e1d9a87	c544629d-bb02-4c51-9c23-dc743e51a9b1	c0c49653-d343-4a4b-a97f-a9e56db8e6a2	t	2026-05-27 08:25:06.446067+00
2c647816-c335-4ff2-b7c5-074c90e308d6	44010cff-1b62-4c8a-abab-f43160ecd001	4f398c3f-a490-41c6-baae-e1105549b145	t	2026-05-26 17:09:58.542051+00
45219cef-ca62-42c1-9f09-8b384838ab9a	44010cff-1b62-4c8a-abab-f43160ecd001	e7da78a0-6c12-4855-9427-7d80f595f2f3	t	2026-05-26 17:09:58.542051+00
ba1d04c1-1a27-4067-9965-893b6b7105b1	44010cff-1b62-4c8a-abab-f43160ecd001	6f2792b8-423b-4ad2-9c9b-a11d133bfcee	t	2026-05-26 17:09:58.542051+00
b564a6d9-4462-441a-9308-3f145b3ac2b2	44010cff-1b62-4c8a-abab-f43160ecd001	2f2e4bfb-c947-4e8d-beca-23e2fecf86dc	t	2026-05-26 17:09:58.542051+00
c6507062-94bd-48af-8e36-d5d4750a70e2	44010cff-1b62-4c8a-abab-f43160ecd001	d53a348d-2a63-4187-b29a-90dbe8395571	t	2026-05-26 17:09:58.542051+00
6ca744cb-4817-4251-9583-4d883c75371b	44010cff-1b62-4c8a-abab-f43160ecd001	5b6882cf-b4dc-4a71-a445-0aab2610bfa1	t	2026-05-26 17:09:58.542051+00
8fb2e146-116f-48c5-9ac8-efb6a4301018	44010cff-1b62-4c8a-abab-f43160ecd001	3d5821a0-3b1b-4e6c-a6ff-4c600592d5ce	t	2026-05-26 17:09:58.542051+00
031e85a4-7ee2-4dbe-b9c0-95eda804dff1	44010cff-1b62-4c8a-abab-f43160ecd001	f18ae1ce-46d4-4b81-a337-a598d0ccf4e0	t	2026-05-26 17:09:58.542051+00
afc6c49b-6639-41b2-a84a-59d21806fc60	44010cff-1b62-4c8a-abab-f43160ecd001	d31c52c9-8c20-43db-8d12-a7e3f9d86b04	t	2026-05-26 17:09:58.542051+00
f5551f4d-82dc-4be2-bb20-19c0d76abd75	44010cff-1b62-4c8a-abab-f43160ecd001	283f8577-b2fd-42bf-b00f-5bdf53fd6775	t	2026-05-26 17:09:58.542051+00
13439618-7c41-462d-92ff-0a2c4e37bbf8	44010cff-1b62-4c8a-abab-f43160ecd001	0915556e-7514-429d-8044-52b25cd29d50	t	2026-05-26 17:09:58.542051+00
25d01049-d610-407f-8cd7-fad490771812	44010cff-1b62-4c8a-abab-f43160ecd001	2862c87d-8b0f-440b-9afc-1ffd5b5b6036	t	2026-05-26 17:09:58.542051+00
abb62320-5816-4ba8-a41b-262a59b75d8d	44010cff-1b62-4c8a-abab-f43160ecd001	9532691c-bdab-4e5e-afc0-be128a14ba3c	t	2026-05-26 17:09:58.542051+00
985c6b2a-91c1-4178-a72b-40580baec2e7	44010cff-1b62-4c8a-abab-f43160ecd001	4b9e983c-599f-4766-a71a-12460f229149	t	2026-05-26 17:09:58.542051+00
804aa21b-bbb7-4956-8e3d-08f28fcac619	44010cff-1b62-4c8a-abab-f43160ecd001	16bbb9ec-dc4c-4626-bec9-40e9f0f2b82b	t	2026-05-26 17:09:58.542051+00
2cb6b73c-6a03-4920-b680-b70029a34567	44010cff-1b62-4c8a-abab-f43160ecd001	b6b35541-b6df-4d6f-86c2-05223f176335	t	2026-05-26 17:09:58.542051+00
b2ddc8d1-1990-4809-ae5f-fe50a8d108ef	44010cff-1b62-4c8a-abab-f43160ecd001	09655df1-a982-44bb-9e4f-c9c8df53a126	t	2026-05-26 17:09:58.542051+00
42159653-1a5f-4f3d-9180-da94c3875ed2	44010cff-1b62-4c8a-abab-f43160ecd001	674b7bf1-45b5-4d46-9b4e-b4c05d530f25	t	2026-05-26 17:09:58.542051+00
a0fb260b-21d7-48ae-aa68-6281e208a487	44010cff-1b62-4c8a-abab-f43160ecd001	ac6bacb4-0bce-420c-9780-466615e45d53	t	2026-05-26 17:09:58.542051+00
6229183c-0717-4789-9b81-a081253dc07d	44010cff-1b62-4c8a-abab-f43160ecd001	e873bb89-e633-449d-849b-17a881dfd526	t	2026-05-26 17:09:58.542051+00
b02040cb-9f8d-4058-b1fd-66a2a94d7347	44010cff-1b62-4c8a-abab-f43160ecd001	72384dfd-360a-468d-b429-3f80c363f501	t	2026-05-26 17:09:58.542051+00
c1aacc7d-fabf-49ef-9230-0bd9cb870b34	44010cff-1b62-4c8a-abab-f43160ecd001	d24c50a3-9f2b-4d72-b52c-59955a2f1b9e	t	2026-05-26 17:09:58.542051+00
46a3cfa7-4ee6-4f66-aef5-f1dd71e6cc54	44010cff-1b62-4c8a-abab-f43160ecd001	883674c3-12d8-4574-8e7e-a140c78c3f09	t	2026-05-26 17:09:58.542051+00
2686d83c-7ace-44fb-a5c5-d882e83e1e04	44010cff-1b62-4c8a-abab-f43160ecd001	30c867b8-1ae7-4c88-bad3-148767d983c1	t	2026-05-26 17:09:58.542051+00
9f1b0655-3baf-42f9-a4ae-610d99eded90	44010cff-1b62-4c8a-abab-f43160ecd001	af5141f8-1498-405b-bc3b-60d114fdd242	t	2026-05-26 17:09:58.542051+00
683b345f-0623-4637-b2e9-fe8a5269db1f	44010cff-1b62-4c8a-abab-f43160ecd001	5d688533-3a13-4f9c-90a6-e06f4f43be46	t	2026-05-26 17:09:58.542051+00
7686aa96-328a-4d20-822e-865491f9e0f9	44010cff-1b62-4c8a-abab-f43160ecd001	3bc74ff7-a619-4817-912d-08185ac9f5c5	t	2026-05-26 17:09:58.542051+00
0a5afb02-ca74-4126-957f-e853518a562a	44010cff-1b62-4c8a-abab-f43160ecd001	99ce754c-facf-4ffa-bc18-1684c72c1d63	t	2026-05-26 17:09:58.542051+00
0113e069-2a6f-4dea-ba04-e639e3a16087	44010cff-1b62-4c8a-abab-f43160ecd001	8fc6fe4f-08a8-48b9-81ec-61ee8907a1e2	t	2026-05-26 17:09:58.542051+00
5195d219-3ef9-4a93-bea0-162be1f6877c	44010cff-1b62-4c8a-abab-f43160ecd001	049013cd-cb2c-4a16-bfb3-550c7172fdfd	t	2026-05-26 17:09:58.542051+00
8ce761af-778e-449d-b4c3-e09694996278	44010cff-1b62-4c8a-abab-f43160ecd001	59a18042-431e-43ae-8bf6-732ef18c83cb	t	2026-05-26 17:09:58.542051+00
1191169c-f76f-4fa9-a68e-9ad5650a0047	44010cff-1b62-4c8a-abab-f43160ecd001	17cfcf4e-465a-4425-8f29-035c8625a654	t	2026-05-26 17:09:58.542051+00
13cb42a8-8611-4635-a892-2a09fef2b97b	44010cff-1b62-4c8a-abab-f43160ecd001	f0936a48-d35e-427b-9ce1-ee934be6e343	t	2026-05-26 17:09:58.542051+00
e4e6e969-e180-469c-80b3-334a7419159b	44010cff-1b62-4c8a-abab-f43160ecd001	30cbb026-817e-4af5-9eba-6b97813ab01c	t	2026-05-26 17:09:58.542051+00
9a040bcf-8a8e-40a2-b93e-842c42ed104b	44010cff-1b62-4c8a-abab-f43160ecd001	ed563bfe-904a-4d66-ad2f-9db325be24ed	t	2026-05-26 17:09:58.542051+00
dd8d9c0a-f465-4a08-b447-4395fc6137e8	44010cff-1b62-4c8a-abab-f43160ecd001	4aa93779-0cf9-43da-8c57-82b5c1f4859e	t	2026-05-26 17:09:58.542051+00
8403bf4b-8172-4dfd-8216-aaacc5b7d9f1	44010cff-1b62-4c8a-abab-f43160ecd001	3997e3fd-91e2-4dec-83b9-b7268def2070	t	2026-05-26 17:09:58.542051+00
a078b41c-798a-4805-a0f1-98f01f55f23c	44010cff-1b62-4c8a-abab-f43160ecd001	8c64829e-7bb9-4243-a9ab-dcce96b0e309	t	2026-05-26 17:09:58.542051+00
8b41d81c-0f9b-4344-9061-714bd25f722f	44010cff-1b62-4c8a-abab-f43160ecd001	f79083e3-b421-459b-802c-9db60a508e64	t	2026-05-26 17:09:58.542051+00
b61878c7-1d58-4a58-93a5-e194f9feb5c3	44010cff-1b62-4c8a-abab-f43160ecd001	4079bcbe-7a34-408c-a2bb-5b9202ec9c42	t	2026-05-26 17:09:58.542051+00
7aa91736-9002-4f2a-b727-79c0c485ea47	44010cff-1b62-4c8a-abab-f43160ecd001	d75e9e92-4ba8-4ced-9ec7-12153f69276c	t	2026-05-26 17:09:58.542051+00
89e6690c-a6a8-47dd-9bc5-c7184f241500	c544629d-bb02-4c51-9c23-dc743e51a9b1	d99964cd-e222-4cba-a4ec-00edebd0b76e	t	2026-05-27 08:25:22.029035+00
2847c5ba-c3ab-43c9-a036-a72dcb6ae5a3	c544629d-bb02-4c51-9c23-dc743e51a9b1	a999428e-c0a3-4e90-bf56-27b79148dfc8	t	2026-05-27 08:28:55.421286+00
c095b4ed-82ba-4a19-9473-9232957b5cef	bc8f862e-ec2c-4c37-b924-c34864013f1c	134c89d7-39ed-48ff-89c2-708f1f08b560	f	2026-05-31 15:17:56.735507+00
a5beb031-f0ec-4425-943f-eb3934b01a57	bc8f862e-ec2c-4c37-b924-c34864013f1c	9f655b1f-cf19-4197-be28-a49e3ebd917c	f	2026-05-31 15:17:56.735507+00
1cf83d51-3772-4b66-8601-0d2d32282eb4	bc8f862e-ec2c-4c37-b924-c34864013f1c	6ee23633-bf6b-46a6-af1a-3c647eb1de3c	f	2026-05-31 15:17:56.735507+00
9c4956ef-cdda-44f7-9633-2df1220a2403	bc8f862e-ec2c-4c37-b924-c34864013f1c	7525f8e0-12e3-4dc7-81a2-28d77ad3df77	f	2026-05-31 15:17:56.735507+00
fa380ad0-c379-43cc-bb65-855e918348be	bc8f862e-ec2c-4c37-b924-c34864013f1c	846b52ec-555b-433d-8093-b45bec6c168c	f	2026-05-31 15:17:56.735507+00
f9de0f1f-da9c-4ae3-94a8-bbddeb37cec3	bc8f862e-ec2c-4c37-b924-c34864013f1c	cfac1359-8625-457f-96dd-f36c07b5b27b	f	2026-05-31 15:17:56.735507+00
2145786a-6f30-4037-8d71-b3ec46460114	bc8f862e-ec2c-4c37-b924-c34864013f1c	cceb4b23-7bd4-412c-bc6a-2cc2d2edbbf3	f	2026-05-31 15:17:56.735507+00
2edbe19f-3c94-46e4-a7d0-17335df0fcb0	bc8f862e-ec2c-4c37-b924-c34864013f1c	1657d66e-62ff-4c5d-9e79-fd875ddd029e	f	2026-05-31 15:17:56.735507+00
f97deded-2d16-44f8-91ac-a1e817ac5e1f	bc8f862e-ec2c-4c37-b924-c34864013f1c	6161c448-a4e6-4f02-ab4c-55bd24d94b76	f	2026-05-31 15:17:56.735507+00
72cb6a5a-323a-409c-b803-668ac28f97b8	bc8f862e-ec2c-4c37-b924-c34864013f1c	f5a30c8f-e04c-4f07-aff1-d33d836c7735	f	2026-05-31 15:17:56.735507+00
bcb6729a-a855-4a86-93ee-b75366553424	bc8f862e-ec2c-4c37-b924-c34864013f1c	10a853ea-5a1d-4650-b242-142f82d9a171	f	2026-05-31 15:17:56.735507+00
67eb6feb-1e03-4394-966c-294594f36bde	bc8f862e-ec2c-4c37-b924-c34864013f1c	2f0528d8-1d9d-4094-8557-fcd446c6ed04	f	2026-05-31 15:17:56.735507+00
2bb21095-fa65-4b40-b184-f7c7a259323d	bc8f862e-ec2c-4c37-b924-c34864013f1c	b5c99341-ece3-42fa-8ec9-4302ef7c54bc	f	2026-05-31 15:17:56.735507+00
1545daff-21b2-43c5-9ad9-eadd6f882e34	bc8f862e-ec2c-4c37-b924-c34864013f1c	a13de502-e9c0-4b11-bb97-d46ab3a79a71	f	2026-05-31 15:17:56.735507+00
b34296da-844b-4c10-8407-00cd5e2e1e8a	bc8f862e-ec2c-4c37-b924-c34864013f1c	c5a1e9a8-5b4f-4028-b53b-6547fb44ec0b	f	2026-05-31 15:17:56.735507+00
43b4456f-5738-49d5-990a-feac31186814	bc8f862e-ec2c-4c37-b924-c34864013f1c	ad8bb533-5d24-457d-8043-96963f484433	f	2026-05-31 15:17:56.735507+00
0d07c64c-6a5e-47f7-8a5b-365e7e92b2f9	bc8f862e-ec2c-4c37-b924-c34864013f1c	5c10db6a-91a8-4d4d-b165-a8883c8c6d8d	f	2026-05-31 15:17:56.735507+00
97ef3691-9304-4864-aa55-c8801dfb9a7c	bc8f862e-ec2c-4c37-b924-c34864013f1c	34ee8053-29a2-440b-a706-c6b57584485d	f	2026-05-31 15:17:56.735507+00
e63905a7-08a2-4e4f-8ec2-ae592a300dbf	bc8f862e-ec2c-4c37-b924-c34864013f1c	89d3936a-bebb-461a-b8fe-c693deb85e36	f	2026-05-31 15:17:56.735507+00
2d2204cc-863c-4bb9-9b0b-9bdd07133ad8	bc8f862e-ec2c-4c37-b924-c34864013f1c	c45f3292-a379-4507-9111-53b3c8069187	f	2026-05-31 15:17:56.735507+00
f5cf05ef-9106-43f9-99eb-88ddf91218b5	bc8f862e-ec2c-4c37-b924-c34864013f1c	99f7d834-f1e4-47b8-a5a6-947fc40f849d	f	2026-05-31 15:17:56.735507+00
aae230a6-3ba4-4b78-97a8-45b3084b0de9	c2ad89fd-2583-4f46-ad0d-8232f6269718	ea534091-f64d-4087-90b7-d42f3427ae32	f	2026-05-31 15:17:56.735507+00
e11b050f-b894-46af-9cbd-1d763faf60f7	c2ad89fd-2583-4f46-ad0d-8232f6269718	dfa736e1-4ef9-43f4-9cf9-b23d3902ea8d	f	2026-05-31 15:17:56.735507+00
70288d25-785c-4444-9128-e58c41e5c039	c2ad89fd-2583-4f46-ad0d-8232f6269718	a6267478-6b24-4168-96d8-3b63c8a16974	f	2026-05-31 15:17:56.735507+00
2a8e6eb5-0b42-47d3-979e-70432ff056ff	c2ad89fd-2583-4f46-ad0d-8232f6269718	18410aef-103a-4a9c-b5f7-78d333b70566	f	2026-05-31 15:17:56.735507+00
d495a481-dfd0-454c-9055-72f54facc340	c2ad89fd-2583-4f46-ad0d-8232f6269718	48c4fec1-40e6-4a8b-bb19-9fd093b646ad	f	2026-05-31 15:17:56.735507+00
eadd1eab-c068-4f37-8dc9-2c593f61e336	c2ad89fd-2583-4f46-ad0d-8232f6269718	6e9d80a3-fe94-4638-86fa-1e250180ffa4	f	2026-05-31 15:17:56.735507+00
4d797ed3-2e85-49c0-bb12-13bfa21096d2	c2ad89fd-2583-4f46-ad0d-8232f6269718	be1b992e-6ef5-41cb-ba04-4758c2fd0100	f	2026-05-31 15:17:56.735507+00
07404420-9bb8-4ed2-bf31-df61e45e5460	c2ad89fd-2583-4f46-ad0d-8232f6269718	d28e4359-7fea-42db-8de2-282febfad75f	f	2026-05-31 15:17:56.735507+00
60470e55-4567-4fc8-989e-0ab9791a7139	c2ad89fd-2583-4f46-ad0d-8232f6269718	6788ecb2-03e3-45a4-b7bf-a008d98fcc77	f	2026-05-31 15:17:56.735507+00
0c5159ab-a6dc-442f-afca-3d4872b2b0ad	c2ad89fd-2583-4f46-ad0d-8232f6269718	4c82ac01-9229-4776-abe3-b2d02b9caa87	f	2026-05-31 15:17:56.735507+00
98026ce4-374a-4960-8ec4-8323d7ec8bef	c544629d-bb02-4c51-9c23-dc743e51a9b1	e15dd7a3-d19f-4a18-ab05-391a409c6514	f	2026-05-31 15:17:56.735507+00
17996391-f8fc-4a88-a5ea-12d47438d935	c544629d-bb02-4c51-9c23-dc743e51a9b1	c104973d-5618-4531-8810-c7d1249e7406	f	2026-05-31 15:17:56.735507+00
ee841a73-ad7f-41e3-a2e8-2a901961a146	c544629d-bb02-4c51-9c23-dc743e51a9b1	280bc4a9-6eb5-4154-a6f1-5c45fa44c0df	f	2026-05-31 15:17:56.735507+00
4c21dde0-7f43-45aa-a9ca-5a5e4ee79553	c544629d-bb02-4c51-9c23-dc743e51a9b1	22c277c7-f319-4494-afd3-0f4d9630f452	f	2026-05-31 15:17:56.735507+00
807e1fad-0fa9-45ca-a530-b442ca0df7ee	c544629d-bb02-4c51-9c23-dc743e51a9b1	4a8c7fef-d847-4bb4-a3b0-de32bba5d7cb	f	2026-05-31 15:17:56.735507+00
919a4f4c-e19a-412b-b03c-b41e0a9a0274	c544629d-bb02-4c51-9c23-dc743e51a9b1	0f4bebf0-dede-45ba-bebb-12afcd5f7d2e	f	2026-05-31 15:17:56.735507+00
76d3d631-0e06-4125-a028-c8bc1a2db081	c544629d-bb02-4c51-9c23-dc743e51a9b1	420a8abe-957c-476c-8a39-b6ec8a196505	f	2026-05-31 15:17:56.735507+00
7a0bae75-82f5-44dc-be28-06df19cd21d8	c544629d-bb02-4c51-9c23-dc743e51a9b1	73489fb1-c758-459f-8218-680f34947488	f	2026-05-31 15:17:56.735507+00
7b6097aa-38dd-4052-92e3-515555e21ade	c544629d-bb02-4c51-9c23-dc743e51a9b1	fab3bacd-73a3-477e-b51f-9323528c39d6	f	2026-05-31 15:17:56.735507+00
eccccb96-696f-4bcd-ab6b-faeda25fc98c	c544629d-bb02-4c51-9c23-dc743e51a9b1	2a3bc01f-e8cf-42f5-a192-d012645efb83	f	2026-05-31 15:17:56.735507+00
2f2426f3-71f2-478d-9052-d5e06277aa6f	c544629d-bb02-4c51-9c23-dc743e51a9b1	8c49186c-2194-420d-9c59-5589b7dcad48	f	2026-05-31 15:17:56.735507+00
0c061a27-dded-466e-a8e8-963edd28cf6e	c544629d-bb02-4c51-9c23-dc743e51a9b1	098ba9f4-ce19-485e-9f63-9bb16d4dab2b	f	2026-05-31 15:17:56.735507+00
2af9db25-6d90-4f7b-bcdb-eb1760996b40	c544629d-bb02-4c51-9c23-dc743e51a9b1	b7e7cc91-9294-4079-b5ce-3ab3bd0e8334	f	2026-05-31 15:17:56.735507+00
e6269163-cac0-4553-8921-6bd077bc2b9f	c544629d-bb02-4c51-9c23-dc743e51a9b1	3280a0f1-53c6-40ae-9bc4-f4491301626f	f	2026-05-31 15:17:56.735507+00
d0f588e8-3022-4a21-88d6-fff74fdbf83f	c544629d-bb02-4c51-9c23-dc743e51a9b1	31ee18ba-b796-4890-a599-51d6b0bba58f	f	2026-05-31 15:17:56.735507+00
530791fa-8811-461a-8d64-b4538a19db9d	c544629d-bb02-4c51-9c23-dc743e51a9b1	f01892d0-f467-45c4-840a-e52293611502	f	2026-05-31 15:17:56.735507+00
0d8d2202-eb88-4b0c-a548-8dc22d8727d2	c544629d-bb02-4c51-9c23-dc743e51a9b1	185b428e-39b6-4fcf-a096-dfdf5ec8f9d3	f	2026-05-31 15:17:56.735507+00
f1419476-46f4-4c6a-acff-4561b7462761	c544629d-bb02-4c51-9c23-dc743e51a9b1	040a9d64-2736-4446-a886-86ec9fe21a9e	f	2026-05-31 15:17:56.735507+00
d5e3bfba-93ad-4f1d-b6ec-5aed862558fe	c544629d-bb02-4c51-9c23-dc743e51a9b1	58d4979c-68a5-4a06-bbe3-2a00278e1c8c	f	2026-05-31 15:17:56.735507+00
f67fcbe7-e18d-4fb0-9806-03b69447c0c5	c544629d-bb02-4c51-9c23-dc743e51a9b1	5510eedb-cc78-46f3-aa7b-a2bb785127f8	f	2026-05-31 15:17:56.735507+00
f747f133-de26-45f0-8952-ba78ba57a479	c544629d-bb02-4c51-9c23-dc743e51a9b1	ca2cf484-e4d1-4cff-8a38-3d40e8609e09	f	2026-05-31 15:17:56.735507+00
577cf945-a955-4534-9826-328166191ef2	c544629d-bb02-4c51-9c23-dc743e51a9b1	8b2a1f4b-6033-4d83-8e87-2aac6b55fa89	f	2026-05-31 15:17:56.735507+00
9b043747-a104-458c-9aab-7fae4346aee4	c544629d-bb02-4c51-9c23-dc743e51a9b1	46d8d439-5c65-4344-91a7-cb802ddaa445	f	2026-05-31 15:17:56.735507+00
aecc4eb6-093d-4878-877e-a790eb82d41a	c544629d-bb02-4c51-9c23-dc743e51a9b1	27cfde60-8cda-4316-a3ce-a4ea192439dc	f	2026-05-31 15:17:56.735507+00
23ff34d9-6e0e-4ceb-8506-3c2ee773ccce	c544629d-bb02-4c51-9c23-dc743e51a9b1	63403e30-716e-4e00-83db-120df7c44c6f	f	2026-05-31 15:17:56.735507+00
e015c358-ab52-4dd3-8846-1f0269fccaa1	c544629d-bb02-4c51-9c23-dc743e51a9b1	b14c6325-c939-464d-9ef8-33ee9f286bc9	f	2026-05-31 15:17:56.735507+00
f73bc435-aaa5-4a8e-9cc6-c649d353d479	c544629d-bb02-4c51-9c23-dc743e51a9b1	549b625c-11f6-46a2-86af-5a1dcbc3068c	f	2026-05-31 15:17:56.735507+00
cd3b3d2a-322a-491d-a5e5-d4bb7d0a39de	c544629d-bb02-4c51-9c23-dc743e51a9b1	3a20235d-2d16-4c00-8f9d-822c6d755b6c	f	2026-05-31 15:17:56.735507+00
74252179-e228-4a5f-8f2a-b244a5c57204	c544629d-bb02-4c51-9c23-dc743e51a9b1	6ba15ad4-500c-4799-b6da-8d1c53797844	f	2026-05-31 15:17:56.735507+00
5ca50158-8939-49c3-bb19-3860f4529b3d	c544629d-bb02-4c51-9c23-dc743e51a9b1	8d648068-2dad-4da9-95d9-fa06c10f8d73	f	2026-05-31 15:17:56.735507+00
4e06df7d-79f9-44ed-98f9-94bbf34a94b8	c544629d-bb02-4c51-9c23-dc743e51a9b1	1a7ed78a-5c01-45ff-953a-f3730c2299fd	f	2026-05-31 15:17:56.735507+00
135b0c9a-f016-410c-9413-a8741d069aa0	c544629d-bb02-4c51-9c23-dc743e51a9b1	6a087138-0320-4268-997d-0ee8437ac928	f	2026-05-31 15:17:56.735507+00
3066bd54-0849-4dc3-b0cb-5e5aff7114bf	c544629d-bb02-4c51-9c23-dc743e51a9b1	73bf4037-76f9-41f1-9ee0-46b85efc7c12	f	2026-05-31 15:17:56.735507+00
51ce6a25-7ac4-45cc-97cd-4b532247e32e	c544629d-bb02-4c51-9c23-dc743e51a9b1	2c775924-9c93-4085-ade0-8114a012bec9	f	2026-05-31 15:17:56.735507+00
04d49516-fa11-4fd4-add9-928f22e098af	c544629d-bb02-4c51-9c23-dc743e51a9b1	c099ca9d-d667-40ea-9b74-b321dd058abd	f	2026-05-31 15:17:56.735507+00
8dc6765f-50a1-4457-a4fb-4ff09c453ac0	c544629d-bb02-4c51-9c23-dc743e51a9b1	aabb3def-2650-4306-b391-820f20329e29	f	2026-05-31 15:17:56.735507+00
1714b416-42f6-4c52-baf3-55baea8e4cb9	c544629d-bb02-4c51-9c23-dc743e51a9b1	ed57155e-1299-468f-8579-bbd6bc74d5e9	f	2026-05-31 15:17:56.735507+00
8f37ab13-6ec2-421e-a58e-21161358bdcd	c544629d-bb02-4c51-9c23-dc743e51a9b1	82e4f111-08f5-40a3-905b-319c7419259f	f	2026-05-31 15:17:56.735507+00
d3b74741-e3a2-4ab9-94de-0fc2b7878709	c544629d-bb02-4c51-9c23-dc743e51a9b1	f05bd460-9c20-4a3b-8d73-b3b7efe82d19	f	2026-05-31 15:17:56.735507+00
c30c672c-d062-4497-9cea-c8b953afeb4a	c544629d-bb02-4c51-9c23-dc743e51a9b1	371db369-b17e-4ec0-a671-a872d197f9a7	f	2026-05-31 15:17:56.735507+00
68bdd2f8-111b-4a92-9518-bda383c90961	c544629d-bb02-4c51-9c23-dc743e51a9b1	917550f5-1879-413f-9904-53417b46c97c	f	2026-05-31 15:17:56.735507+00
8f44600e-aa07-4add-bc90-a2f2c9d797c5	c544629d-bb02-4c51-9c23-dc743e51a9b1	9e0270b7-169c-4c93-80a8-366c62dbcd50	f	2026-05-31 15:17:56.735507+00
b9920c86-a682-46e6-aa8c-a8c9a9e4c335	c544629d-bb02-4c51-9c23-dc743e51a9b1	02f445a2-5481-476f-9d64-b624a5a789b4	f	2026-05-31 15:17:56.735507+00
d5924944-05ad-49e0-ae57-e1424d1a96cb	c544629d-bb02-4c51-9c23-dc743e51a9b1	07621c6c-cb07-4d91-9301-0f5b13906bae	f	2026-05-31 15:17:56.735507+00
c2a1223f-154f-4c66-b3f9-751ab94c09e2	c544629d-bb02-4c51-9c23-dc743e51a9b1	c1ab669c-2d96-4b53-82fb-251ae80d314e	f	2026-05-31 15:17:56.735507+00
69f1f31d-f9c6-4b0f-87c1-75e4140bf8d3	c544629d-bb02-4c51-9c23-dc743e51a9b1	11675b9c-9e46-4c24-8a03-6b170b56105e	f	2026-05-31 15:17:56.735507+00
ee4ccfd2-c72e-4303-a0f2-31efdb4acc3d	c544629d-bb02-4c51-9c23-dc743e51a9b1	6f61eec9-78c3-4bb7-ba2f-11bd7c17a982	f	2026-05-31 15:17:56.735507+00
3cafc4db-6827-4650-a7db-9a0b793d15c5	c544629d-bb02-4c51-9c23-dc743e51a9b1	7e70c966-65a9-42f4-8cba-4544853264ad	f	2026-05-31 15:17:56.735507+00
ed89a4d0-c693-4220-a815-9c603ee145d6	c544629d-bb02-4c51-9c23-dc743e51a9b1	5e04efb3-53d8-4c89-90fd-57d52bae105a	f	2026-05-31 15:17:56.735507+00
17867e84-4ded-4b70-b276-23338b6732f6	c544629d-bb02-4c51-9c23-dc743e51a9b1	c913ed6a-9659-4514-8608-30ff8e4e01e7	f	2026-05-31 15:17:56.735507+00
16b35532-ada1-4db8-acb1-1ddcc173b0e1	c544629d-bb02-4c51-9c23-dc743e51a9b1	96fa7432-baa9-49cf-aaec-7746f7c984cc	f	2026-05-31 15:17:56.735507+00
13578849-842b-454d-857a-40082e8e34c2	c544629d-bb02-4c51-9c23-dc743e51a9b1	9d8e02ea-5a4e-462d-ba71-c2295ad48e10	f	2026-05-31 15:17:56.735507+00
7ecf7008-caf1-49cf-b59f-4b9d7cb9b70a	c544629d-bb02-4c51-9c23-dc743e51a9b1	533481a3-1da5-4f17-944c-28ab126d6624	f	2026-05-31 15:17:56.735507+00
85253c1f-f1fc-46a8-a6be-b3c1ceae883e	c544629d-bb02-4c51-9c23-dc743e51a9b1	1148903a-b629-4a84-b363-b022d1bbb1d0	f	2026-05-31 15:17:56.735507+00
e35370c0-e979-4f7c-abc4-5bc03747a89a	c544629d-bb02-4c51-9c23-dc743e51a9b1	a4f2e6ee-0042-4232-a557-6f94c0f5215a	f	2026-05-31 15:17:56.735507+00
beab3f34-121f-4c65-8f92-f2297b14a76c	c544629d-bb02-4c51-9c23-dc743e51a9b1	2c6b79ec-9f2e-4d0e-8bec-0b1211e1fd44	f	2026-05-31 15:17:56.735507+00
ef355340-99fa-47eb-b6e1-300373f8404e	c544629d-bb02-4c51-9c23-dc743e51a9b1	f429f45f-3143-4702-bceb-c54778ef5c39	f	2026-05-31 15:17:56.735507+00
5e6d4997-a959-4bf7-a85a-37f2729d0539	c544629d-bb02-4c51-9c23-dc743e51a9b1	418a1b5e-99af-4132-bbb1-37f96848ed50	f	2026-05-31 15:17:56.735507+00
7eeb5fb3-157d-4093-9b56-5d12d6a39324	c544629d-bb02-4c51-9c23-dc743e51a9b1	0ad138dd-d60c-4788-b1d6-8c4816da53b3	f	2026-05-31 15:17:56.735507+00
9ac3bb1e-cba1-47a1-b32d-24b298c240ce	c544629d-bb02-4c51-9c23-dc743e51a9b1	d49b7b2d-318b-4267-b54b-205f985b2b9d	f	2026-05-31 15:17:56.735507+00
a90d73ce-a16c-4248-99a8-47fe5f7ceb52	c544629d-bb02-4c51-9c23-dc743e51a9b1	e380d9a4-4298-4051-8039-5c6b65d8eb56	f	2026-05-31 15:17:56.735507+00
aa9783a5-a904-4b93-9576-0ef84d12aaa4	c544629d-bb02-4c51-9c23-dc743e51a9b1	cb88e39d-3fa6-49bb-914e-73b9653b75fb	f	2026-05-31 15:17:56.735507+00
5e7bb349-e0cb-458d-8183-35f0c2fa361e	c544629d-bb02-4c51-9c23-dc743e51a9b1	0bee8d12-710d-479d-8981-55a7e38ebbf0	f	2026-05-31 15:17:56.735507+00
c9bb4586-e639-44f4-9997-e43b5ae51275	c544629d-bb02-4c51-9c23-dc743e51a9b1	c9ebd3e7-1d49-4934-86b1-47afae30cc5e	f	2026-05-31 15:17:56.735507+00
3464b02f-828b-4369-986a-2d1c6ec97820	c544629d-bb02-4c51-9c23-dc743e51a9b1	c18082b3-9a01-4dee-af5f-7b71e2c1a559	f	2026-05-31 15:17:56.735507+00
6e62b666-6eb6-4999-8617-9abcde71e9b4	c544629d-bb02-4c51-9c23-dc743e51a9b1	71bf8239-6c25-4eca-80ef-97e17c29eca9	f	2026-05-31 15:17:56.735507+00
c1bcee88-8767-41e0-a56a-8bcc308cc908	c544629d-bb02-4c51-9c23-dc743e51a9b1	46a742ca-a003-49dc-800c-8bc68b309fce	f	2026-05-31 15:17:56.735507+00
ac14d859-d68b-4c10-945d-2307ef1a5fae	c544629d-bb02-4c51-9c23-dc743e51a9b1	53fe7a39-0c53-4b5c-a532-c27424fa004c	f	2026-05-31 15:17:56.735507+00
7fe67bc5-3f61-4cc9-b11d-7b21dcd0ea06	c544629d-bb02-4c51-9c23-dc743e51a9b1	d0f6ff93-3e03-4fe9-af7f-af8b78bb56f3	f	2026-05-31 15:17:56.735507+00
e096500f-9c37-4999-a66e-c0083a562e7a	c544629d-bb02-4c51-9c23-dc743e51a9b1	f37ad150-41cb-404f-94aa-95391c9b91cb	f	2026-05-31 15:17:56.735507+00
484f49d1-5d4f-4726-89f3-4c46b008977d	c544629d-bb02-4c51-9c23-dc743e51a9b1	1fc6edaf-9fcf-49eb-bd16-d89975a36f2c	f	2026-05-31 15:17:56.735507+00
5076bdb1-a6a3-46bb-a407-d069ffa9f0e9	c544629d-bb02-4c51-9c23-dc743e51a9b1	496d934a-4043-4134-895f-6eaea72169ea	f	2026-05-31 15:17:56.735507+00
30525821-e9ac-4db3-a31f-261f4ff282b3	c544629d-bb02-4c51-9c23-dc743e51a9b1	de1fd4c0-7b55-4dac-ac72-f44a8af408c2	f	2026-05-31 15:17:56.735507+00
3288c1ed-7853-40de-a433-226407ebd073	c544629d-bb02-4c51-9c23-dc743e51a9b1	5c82b756-e7d9-41fc-92ee-863cdad65070	f	2026-05-31 15:17:56.735507+00
df7b4d15-0c02-4f69-8d16-f355e55a7f70	c544629d-bb02-4c51-9c23-dc743e51a9b1	b953800e-b842-4d1b-ac85-6bc64fd0aecd	f	2026-05-31 15:17:56.735507+00
9f24085d-122e-4b19-846b-23007f596086	c544629d-bb02-4c51-9c23-dc743e51a9b1	b51b42cb-2b06-4565-aeb5-09740cf44487	f	2026-05-31 15:17:56.735507+00
1080fd8b-eca3-4509-b572-be8b7958dea3	c2ad89fd-2583-4f46-ad0d-8232f6269718	39666c15-e11d-495d-948f-714fabe6e4a7	f	2026-05-31 15:22:33.234133+00
e6ebaf95-4387-44a6-894b-1beb79f74586	bc8f862e-ec2c-4c37-b924-c34864013f1c	de08970f-5524-4891-bf1a-f5039e77c8de	f	2026-05-31 15:22:33.234133+00
e0b21d92-d263-44e2-a72f-f1ae29067f3e	bc8f862e-ec2c-4c37-b924-c34864013f1c	b9fd4375-1c0d-4978-8a60-1d6875a92645	f	2026-05-31 15:22:33.234133+00
528e8b0e-ab35-4f5a-b1a7-df8052f2d978	bc8f862e-ec2c-4c37-b924-c34864013f1c	6c94ad9a-1e05-4a9b-af1d-0621b3de66c7	f	2026-05-31 15:22:33.234133+00
06d9d3ce-e7c6-4a1f-8ae5-8f714a793c5d	bc8f862e-ec2c-4c37-b924-c34864013f1c	9f8d971f-b234-491d-86d9-80a2cc8270fb	f	2026-05-31 15:22:33.234133+00
8ca182ea-8142-43ef-9298-7f4599eb810b	bc8f862e-ec2c-4c37-b924-c34864013f1c	1c46a76b-35ed-4303-9ef4-0b3543263357	f	2026-05-31 15:22:33.234133+00
dde1babd-efab-4684-bb2d-4887220ba80e	bc8f862e-ec2c-4c37-b924-c34864013f1c	bf0763f5-2a56-4bbb-9776-bc5934e4737d	f	2026-05-31 15:22:33.234133+00
c903cbdb-8a9f-4248-a405-faa79674dd0a	bc8f862e-ec2c-4c37-b924-c34864013f1c	0ae6611f-de3e-483c-9bec-1bdb09d22819	f	2026-05-31 15:22:33.234133+00
2fb0a0e0-8b66-41a5-9733-2dd0881033da	bc8f862e-ec2c-4c37-b924-c34864013f1c	1aacb3c8-b1cd-4300-bfb6-d25b3f781162	f	2026-05-31 15:22:33.234133+00
57e77a4e-c724-4577-b986-7e828fd95e75	bc8f862e-ec2c-4c37-b924-c34864013f1c	12b369fc-063b-4ce5-bb03-00c66d5ad720	f	2026-05-31 15:22:33.234133+00
be47c51f-6edb-4855-ae89-ffe26e73ebec	bc8f862e-ec2c-4c37-b924-c34864013f1c	1abe6e2e-109d-4c37-b3ab-88aed12299cb	f	2026-05-31 15:22:33.234133+00
2e83c678-2f24-4359-9157-d63a591043bb	bc8f862e-ec2c-4c37-b924-c34864013f1c	05ac3099-8e5f-445a-abbb-c2e1a7b4184f	f	2026-05-31 15:22:33.234133+00
409ae582-6f53-46e6-92f0-54f2b17b2bc3	bc8f862e-ec2c-4c37-b924-c34864013f1c	b1edb27b-b760-4917-80fd-2c88c5bb574b	f	2026-05-31 15:22:33.234133+00
d1ec4762-000b-4c3e-b17c-2b0ddbbd7784	bc8f862e-ec2c-4c37-b924-c34864013f1c	344a3d5f-57ef-4044-9585-e1550ec2a752	f	2026-05-31 15:22:33.234133+00
f867342d-0220-4a02-92ab-4d20d53dde3d	bc8f862e-ec2c-4c37-b924-c34864013f1c	ca607622-0882-458a-86e4-07972377dbf5	f	2026-05-31 15:22:33.234133+00
6ba5759b-9468-41ff-b77f-97b7894e1f83	bc8f862e-ec2c-4c37-b924-c34864013f1c	c04bac69-7d0d-4981-9b53-423f314e8ce7	f	2026-05-31 15:22:33.234133+00
a404d8d7-6689-473f-894e-86dd0fbe1898	bc8f862e-ec2c-4c37-b924-c34864013f1c	ba9f859c-7eb1-493d-8deb-2576267129e2	f	2026-05-31 15:22:33.234133+00
90cc8fdb-e5c9-4405-a326-298e1e8c280a	bc8f862e-ec2c-4c37-b924-c34864013f1c	13df08f1-9e40-40be-a6ba-1d30faf3fedf	f	2026-05-31 15:22:33.234133+00
785177eb-c59a-41f2-b6fa-7e7711770aa7	bc8f862e-ec2c-4c37-b924-c34864013f1c	1f6490ab-60eb-43dd-8cb8-8cf072be9016	f	2026-05-31 15:22:33.234133+00
ebd899ae-c03c-4ac6-b999-0eccd7eee19f	bc8f862e-ec2c-4c37-b924-c34864013f1c	8da6ab2c-7ae7-454c-a259-4e533cfe1c79	f	2026-05-31 15:22:33.234133+00
0529742a-409e-43e7-97fa-fc93fab30600	bc8f862e-ec2c-4c37-b924-c34864013f1c	5fc83fdd-1867-45ea-ae53-7d59ec13c4ca	f	2026-05-31 15:22:33.234133+00
2a12ae1d-de5a-48ad-8342-0db2549516fb	bc8f862e-ec2c-4c37-b924-c34864013f1c	52d73905-9f13-4602-b32b-460e66fe7aa2	f	2026-05-31 15:22:33.234133+00
d1d3f6a8-c944-455f-80df-359ee8d715ab	c2ad89fd-2583-4f46-ad0d-8232f6269718	4b73e4cc-4893-46b3-8f3d-bcb717984c72	f	2026-05-31 15:22:33.234133+00
d459ba54-e407-4548-a9be-d25f2cf59223	c2ad89fd-2583-4f46-ad0d-8232f6269718	c03cec75-9770-4fdd-afcd-405e86151fcf	f	2026-05-31 15:22:33.234133+00
d9c7fe35-c3fe-4adf-b604-aa48bc6780b1	c2ad89fd-2583-4f46-ad0d-8232f6269718	e39438bd-5d31-4866-ae46-809d533e39f1	f	2026-05-31 15:22:33.234133+00
45ccfc7b-8313-495e-803a-8d8e29d6f041	c2ad89fd-2583-4f46-ad0d-8232f6269718	35309cfc-d835-4e00-89be-172c1378d786	f	2026-05-31 15:22:33.234133+00
8f777742-2927-4284-8a40-a79f23f654fd	c2ad89fd-2583-4f46-ad0d-8232f6269718	c149881a-abce-4811-a448-e7963db681c6	f	2026-05-31 15:22:33.234133+00
51bf1e30-f25e-44ed-9bb7-fcb127f3ae03	c2ad89fd-2583-4f46-ad0d-8232f6269718	1e598626-954f-405c-8842-4ca1ca4563aa	f	2026-05-31 15:22:33.234133+00
4550c4d6-46dc-43e7-8009-e5880cea9234	c2ad89fd-2583-4f46-ad0d-8232f6269718	aadd010e-61e7-4c5d-ab70-acde33e458be	f	2026-05-31 15:22:33.234133+00
177b7bfc-a61b-4a03-8d17-42a59413b60f	c2ad89fd-2583-4f46-ad0d-8232f6269718	bfa13be4-86d7-476f-af24-9513f23c8035	f	2026-05-31 15:22:33.234133+00
3f469880-738d-4ed0-ac9c-354086a5a933	c2ad89fd-2583-4f46-ad0d-8232f6269718	a6ef1718-5a90-4fa6-890a-4d3ffb0de0cd	f	2026-05-31 15:22:33.234133+00
af5f1311-37a2-49fb-ad9d-f9bc169c9ec8	c2ad89fd-2583-4f46-ad0d-8232f6269718	5f9608c8-8cbc-4d3c-829b-21c5faa2ab49	f	2026-05-31 15:22:33.234133+00
075ef376-c8b4-4cf8-b0d0-0fd8c583fc1b	c2ad89fd-2583-4f46-ad0d-8232f6269718	c9214d3a-8c18-41dc-9009-3521118d340f	f	2026-05-31 15:22:33.234133+00
434b7ffb-27bf-409e-9a52-e2a0a8e824f7	c2ad89fd-2583-4f46-ad0d-8232f6269718	67ba90b7-3413-4580-b4a9-1d2cc6abed51	f	2026-05-31 15:22:33.234133+00
ee56d30b-0d6a-4e89-a058-7c528e6a6416	c2ad89fd-2583-4f46-ad0d-8232f6269718	ced46030-5f33-4a0f-93c7-1c73798c550d	f	2026-05-31 15:22:33.234133+00
1ae4c1c6-7e7e-46d0-9e1f-3a08676297c3	c2ad89fd-2583-4f46-ad0d-8232f6269718	661bab42-5454-48b9-8399-43525a94fd9f	f	2026-05-31 15:22:33.234133+00
1de9ba87-676b-42dd-bdf6-6ab814f6b4f8	c2ad89fd-2583-4f46-ad0d-8232f6269718	4698c7ef-115b-4ec4-b050-a1bf14fee4dd	f	2026-05-31 15:22:33.234133+00
9a2d86d8-bbac-4ba4-a173-485613626b6e	c2ad89fd-2583-4f46-ad0d-8232f6269718	9e847a22-7582-4fa3-831d-4524b549b3c5	f	2026-05-31 15:22:33.234133+00
1e92aa48-b382-4b69-bc6b-d351ca8579bc	c2ad89fd-2583-4f46-ad0d-8232f6269718	0ad2533d-779e-47c2-8b6b-943a92fe3dac	f	2026-05-31 15:22:33.234133+00
6fac8b90-d306-471d-8347-f51827fa943e	c2ad89fd-2583-4f46-ad0d-8232f6269718	49bd66d3-6c57-4833-a6ee-ab2fbc1c8f2e	f	2026-05-31 15:22:33.234133+00
3d791289-f800-43bd-af6a-01fd97462be4	c2ad89fd-2583-4f46-ad0d-8232f6269718	ad709f0c-bf05-446f-ba95-f39f90d94713	f	2026-05-31 15:22:33.234133+00
c0af8cb4-66c4-4cea-b2b3-c85556b3275c	c2ad89fd-2583-4f46-ad0d-8232f6269718	f07eb32e-102b-4a25-9cba-e5c254b947df	f	2026-05-31 15:22:33.234133+00
0f2e3e0c-f480-4e95-9729-5941a2803598	c544629d-bb02-4c51-9c23-dc743e51a9b1	3e042cb0-1e7d-4de5-8dac-d18350e76069	f	2026-05-31 15:22:33.234133+00
64f9fbba-daaf-4c52-8b84-a86d7a7762ae	c544629d-bb02-4c51-9c23-dc743e51a9b1	45491958-3847-40dc-a67c-9bea82297bb9	f	2026-05-31 15:22:33.234133+00
eaa30e56-510c-442e-8a6b-7e6bb4004f3e	c544629d-bb02-4c51-9c23-dc743e51a9b1	71f02655-cc71-4be5-ab47-840dd7ea967f	f	2026-05-31 15:22:33.234133+00
5b4720f0-321b-4bb0-900e-d9e1c21a8858	c544629d-bb02-4c51-9c23-dc743e51a9b1	ad1c4737-cbec-42b8-9d14-d704c501494d	f	2026-05-31 15:22:33.234133+00
7cbc0cc0-8dae-42df-b239-29f44363f24e	c544629d-bb02-4c51-9c23-dc743e51a9b1	90f9af2e-8cc0-41ab-89c5-eb810d43a5ef	f	2026-05-31 15:22:33.234133+00
524309f8-4f8d-4367-b3c6-782a556382f2	c544629d-bb02-4c51-9c23-dc743e51a9b1	4a374f79-0d9b-4af5-b5ac-e6e5565dca5e	f	2026-05-31 15:22:33.234133+00
d5884a33-fce9-44e8-86cb-82af236db104	c544629d-bb02-4c51-9c23-dc743e51a9b1	3c2a4b82-324d-466f-a750-2d133ad948fb	f	2026-05-31 15:22:33.234133+00
a89e2428-ca9b-40dc-8fa8-b61d807e7ac7	c544629d-bb02-4c51-9c23-dc743e51a9b1	fbbc7966-8989-496a-8263-bd0985b7030f	f	2026-05-31 15:22:33.234133+00
0a911577-e3f1-4be4-93e9-7d443dce6b24	c544629d-bb02-4c51-9c23-dc743e51a9b1	0bf9edb2-b466-48c4-8467-31c2d819aabf	f	2026-05-31 15:22:33.234133+00
eb59c56a-4f69-4cf6-aecd-7a6bd0be42ab	c544629d-bb02-4c51-9c23-dc743e51a9b1	2d1b9b73-94b6-4e1c-8c5d-4d4d90d2d46f	f	2026-05-31 15:22:33.234133+00
a7ee089d-108d-4e36-a92d-ee9146b89598	c544629d-bb02-4c51-9c23-dc743e51a9b1	c1207e38-2643-4fe9-8454-ed6507dfe3e5	f	2026-05-31 15:22:33.234133+00
57d658e3-94e2-433c-b88d-bdc90284a414	c544629d-bb02-4c51-9c23-dc743e51a9b1	65b17186-a227-4f98-b98a-3e809d0ea69b	f	2026-05-31 15:22:33.234133+00
3d36a5b1-dde9-404f-bc47-536f78065bf4	c544629d-bb02-4c51-9c23-dc743e51a9b1	ba143867-01a0-4baa-a8b2-ca34d04d8f23	f	2026-05-31 15:22:33.234133+00
ed02ba7a-a88f-4718-9af9-96bafe17a7c0	c544629d-bb02-4c51-9c23-dc743e51a9b1	ce61b472-fc0c-410c-9e38-b37ab1dca2a3	f	2026-05-31 15:22:33.234133+00
18a9fb6c-794b-413e-8505-b0505c0b9375	c544629d-bb02-4c51-9c23-dc743e51a9b1	aea6316b-000f-436b-8895-0b8348df532d	f	2026-05-31 15:22:33.234133+00
49cda7d8-9e36-4111-a71a-9d4f415c8aec	c544629d-bb02-4c51-9c23-dc743e51a9b1	6615fade-3c56-4dff-9d4c-a2411c5bd54f	f	2026-05-31 15:22:33.234133+00
4d286ffe-78f6-4255-b677-b57270398390	c544629d-bb02-4c51-9c23-dc743e51a9b1	12635264-7a9b-47dd-be8e-362afbb185cf	f	2026-05-31 15:22:33.234133+00
d44c622c-5041-4529-a2fc-1e77b9aec4f2	c544629d-bb02-4c51-9c23-dc743e51a9b1	87ee4e33-1df7-4e32-89a8-38c27a36fb95	f	2026-05-31 15:22:33.234133+00
d5513f53-0126-44e1-a8f3-6ba031fa1047	c544629d-bb02-4c51-9c23-dc743e51a9b1	93f85a7f-63b4-4d63-ac4a-331970c462dd	f	2026-05-31 15:22:33.234133+00
4d473c5d-9533-4b59-a25a-7433e32dfdfb	c544629d-bb02-4c51-9c23-dc743e51a9b1	b10e0957-4b79-4213-9d9e-13923471a312	f	2026-05-31 15:22:33.234133+00
cd9c2653-3c87-4bc1-bf3d-a74fbfff9df4	c544629d-bb02-4c51-9c23-dc743e51a9b1	f5e5bbdc-c4eb-4c62-921c-8d4dcae8c007	f	2026-05-31 15:22:33.234133+00
3f04fd18-c233-4b42-a797-7c237b942f2d	c544629d-bb02-4c51-9c23-dc743e51a9b1	bf8099e4-71f8-4888-abcf-4d0c5960f093	f	2026-05-31 15:22:33.234133+00
90c63ad9-6a12-4831-a0be-9237481b7381	c544629d-bb02-4c51-9c23-dc743e51a9b1	69158192-4bb6-4131-8e00-602ccb20c353	f	2026-05-31 15:22:33.234133+00
2bdfba0c-0e58-496f-8fc7-28333144786b	c544629d-bb02-4c51-9c23-dc743e51a9b1	690d28c8-c920-48a8-a3dd-69f0d12f7661	f	2026-05-31 15:22:33.234133+00
f543610d-6fa7-425b-9fc1-3c3f2e006d57	c544629d-bb02-4c51-9c23-dc743e51a9b1	4f4c023c-50f5-49b9-ab72-8349bbec929e	f	2026-05-31 15:22:33.234133+00
436bb2f1-d37e-4e36-b970-0f8f6a44b872	c544629d-bb02-4c51-9c23-dc743e51a9b1	d07fc600-8010-4266-88db-d44f5a837717	f	2026-05-31 15:22:33.234133+00
c10fdc52-36fc-4fad-af2b-5c6e2087fd4e	c544629d-bb02-4c51-9c23-dc743e51a9b1	2020020f-9301-4fa7-b31d-7ba1632bc9d7	f	2026-05-31 15:22:33.234133+00
a190be14-db7a-4e79-8aac-f841cadb35df	c544629d-bb02-4c51-9c23-dc743e51a9b1	13f5a5f6-401d-4a0f-93e6-116d6331cfba	f	2026-05-31 15:22:33.234133+00
10526ada-e13a-4086-a0c9-e48d4206ebae	c544629d-bb02-4c51-9c23-dc743e51a9b1	336f07fe-1cbb-4869-8121-da52d6447ad8	f	2026-05-31 15:22:33.234133+00
ba5ebdd6-e669-4545-a7a5-9ed0e564256b	c544629d-bb02-4c51-9c23-dc743e51a9b1	79114712-63ac-4d8d-9a0b-a8fb1be3d6a1	f	2026-05-31 15:22:33.234133+00
2299db1b-954e-4115-9ef2-788e84e5dc57	c544629d-bb02-4c51-9c23-dc743e51a9b1	5ce0d381-497e-4438-95a6-9fe17af36938	f	2026-05-31 15:22:33.234133+00
028ba937-a2f6-40c1-9041-3b012c207f58	c544629d-bb02-4c51-9c23-dc743e51a9b1	6cded270-6081-4780-b6c4-76b1a0b2223a	f	2026-05-31 15:22:33.234133+00
1c6ef6ee-cd0d-43cb-b0aa-dd10c6dd2eb6	c544629d-bb02-4c51-9c23-dc743e51a9b1	7efe6360-7e1a-49bb-bbf6-f73a8bdd7c55	f	2026-05-31 15:22:33.234133+00
0cb927cf-2a1a-4c89-8e66-c0a2b69ceaec	c544629d-bb02-4c51-9c23-dc743e51a9b1	288cf7f4-12d3-411b-a2be-1cdd35328af3	f	2026-05-31 15:22:33.234133+00
bd18ed22-3e07-47d4-bc25-90f7fd336e4c	c544629d-bb02-4c51-9c23-dc743e51a9b1	319ca44f-332a-4a2b-916d-6fbd123d14bc	f	2026-05-31 15:22:33.234133+00
1a82a9a9-fee9-4596-8167-a4f7aaa9fab4	c544629d-bb02-4c51-9c23-dc743e51a9b1	d7b9deb6-f154-4f9b-9005-3ead16e10c7b	f	2026-05-31 15:22:33.234133+00
3f25d5c4-ccd5-4432-848d-673858d8294e	c544629d-bb02-4c51-9c23-dc743e51a9b1	4329ee5b-7abe-4bdc-8d98-7ca0672b33b3	f	2026-05-31 15:22:33.234133+00
3ab82e1e-9325-4108-b667-770752409703	c544629d-bb02-4c51-9c23-dc743e51a9b1	5f2d9cba-be3c-46bb-86de-9e36df8d52d2	f	2026-05-31 15:22:33.234133+00
27b38983-f999-4a67-8134-7f9a482a131d	c544629d-bb02-4c51-9c23-dc743e51a9b1	93f1c769-6c1d-4bf3-bf2f-631b0e5c0659	f	2026-05-31 15:22:33.234133+00
0879f8a7-1ffa-41d1-afeb-19615e5cb578	c544629d-bb02-4c51-9c23-dc743e51a9b1	e8a4c6d6-d8fb-4d61-a819-37d89a709c53	f	2026-05-31 15:22:33.234133+00
cd229557-fda3-4d88-bea4-717216188bcb	c544629d-bb02-4c51-9c23-dc743e51a9b1	0161c21c-14ac-4f0b-92a4-4f108ff85dfe	f	2026-05-31 15:22:33.234133+00
fa643705-f657-47e7-ab0c-f848c62111f2	c544629d-bb02-4c51-9c23-dc743e51a9b1	4563b2d3-c23b-42ce-bcf6-1c7251561a01	f	2026-05-31 15:22:33.234133+00
1cb663f8-25c4-4001-987e-34194ab46000	c544629d-bb02-4c51-9c23-dc743e51a9b1	e2947294-ea53-4e69-8f34-7977a5de2451	f	2026-05-31 15:22:33.234133+00
0a2b9938-044b-4095-a2b3-ae0cd0c9f8b0	c544629d-bb02-4c51-9c23-dc743e51a9b1	672f422e-06ef-42e2-b05b-e5e6d06bc28c	f	2026-05-31 15:22:33.234133+00
2c86ece8-bb22-4139-a120-7dc648d699c2	c544629d-bb02-4c51-9c23-dc743e51a9b1	49580f4c-752a-4b39-8ad1-88902065aeec	f	2026-05-31 15:22:33.234133+00
30ec6cf9-c146-496b-8508-66e5c1264a9e	c544629d-bb02-4c51-9c23-dc743e51a9b1	33118bf3-0046-4c29-b193-95d0bfc9c146	f	2026-05-31 15:22:33.234133+00
fab7b665-f6ac-47ff-9d49-bf8195e0d357	c544629d-bb02-4c51-9c23-dc743e51a9b1	34d2402a-ae00-4c7c-8e43-a0fdf29f759d	f	2026-05-31 15:22:33.234133+00
5becb54e-e8b9-4f89-b90d-ca44934a9819	c544629d-bb02-4c51-9c23-dc743e51a9b1	cf7f3960-b952-4bf2-816b-5caddf6efa34	f	2026-05-31 15:22:33.234133+00
d63e2ead-39ca-4d12-bd85-3a7bf6b597c3	c544629d-bb02-4c51-9c23-dc743e51a9b1	106d9fa9-7475-4214-b9db-d6cb880b3022	f	2026-05-31 15:22:33.234133+00
047d8651-4f2f-444a-937e-9829b5d295b8	c544629d-bb02-4c51-9c23-dc743e51a9b1	e4a7e217-4cd4-4dda-8509-c0bbaed435cf	f	2026-05-31 15:22:33.234133+00
391a6cf4-257e-417f-9391-bbe66ebae394	c544629d-bb02-4c51-9c23-dc743e51a9b1	c0955f11-11cc-4ff5-bfab-b61a14b02898	f	2026-05-31 15:22:33.234133+00
2dd50da2-6699-4254-a19d-54a8a2d1d165	c544629d-bb02-4c51-9c23-dc743e51a9b1	8555b093-758b-4abe-94af-4c379d6117ed	f	2026-05-31 15:22:33.234133+00
2c31c3c6-2a87-4d08-890d-2a6db0daa88b	c544629d-bb02-4c51-9c23-dc743e51a9b1	6ff655a2-7086-4c1b-bb73-45d2d23b3c73	f	2026-05-31 15:22:33.234133+00
cde2933f-86f2-46d4-b3c7-bc558fc123f2	c544629d-bb02-4c51-9c23-dc743e51a9b1	848062a0-3532-475d-9f44-00aba3cb679b	f	2026-05-31 15:22:33.234133+00
5e88e754-07c3-45a1-a065-766d925bc356	c544629d-bb02-4c51-9c23-dc743e51a9b1	03e7dcbd-6c9c-4373-9098-39ddac850f21	f	2026-05-31 15:22:33.234133+00
2b4b7e32-9e62-4e62-9b38-fa58b3e03c57	c544629d-bb02-4c51-9c23-dc743e51a9b1	cc971d51-967d-46c2-9ec4-62b2d1f1eede	f	2026-05-31 15:22:33.234133+00
a6eeba48-ec82-4205-918b-9f3b6bb01b44	c544629d-bb02-4c51-9c23-dc743e51a9b1	12db6f8c-13a4-43c5-bace-dd972514d3d5	f	2026-05-31 15:22:33.234133+00
46be55f4-6d01-4c20-99e9-2a21b93d9a9c	c544629d-bb02-4c51-9c23-dc743e51a9b1	20d5dfd5-3cc4-4a8e-8815-3b9402af8d5a	f	2026-05-31 15:22:33.234133+00
0c99a507-a001-4fee-93ad-7095c221833e	c544629d-bb02-4c51-9c23-dc743e51a9b1	d26088f8-4c5b-4f09-adaf-3e8e172cf5ac	f	2026-05-31 15:22:33.234133+00
4fec7e5c-a39f-40fa-a9ce-81b1661df012	c544629d-bb02-4c51-9c23-dc743e51a9b1	62f35b5c-53db-4622-8954-d061c3e06c71	f	2026-05-31 15:22:33.234133+00
353709e4-9755-42bd-91bf-33a9481e3326	c544629d-bb02-4c51-9c23-dc743e51a9b1	fcc424b6-8761-4b2c-882e-9ac358538d4a	f	2026-05-31 15:22:33.234133+00
c70c5691-99cc-4101-b0df-65e83b679f9a	c544629d-bb02-4c51-9c23-dc743e51a9b1	31d45d63-23c6-4584-a5d8-01c7b4253dd2	f	2026-05-31 15:22:33.234133+00
4f5fef23-637d-4b7a-b1b8-bfeb4cd0c4fc	c544629d-bb02-4c51-9c23-dc743e51a9b1	623e9f07-b64d-494c-a668-dca9301da1f6	f	2026-05-31 15:22:33.234133+00
59c8ccb0-e5bf-4810-beba-65d862fd23fc	c544629d-bb02-4c51-9c23-dc743e51a9b1	25aa59d3-1b54-48cb-97bc-2970e2014288	f	2026-05-31 15:22:33.234133+00
c33476ea-1880-432d-8bc1-668ed930a196	c544629d-bb02-4c51-9c23-dc743e51a9b1	1ff88a34-f972-43b8-b9ef-bcb6bfc139a4	f	2026-05-31 15:22:33.234133+00
18d2fd62-c96b-421d-a185-63075955607a	c544629d-bb02-4c51-9c23-dc743e51a9b1	88db8df0-e07b-4c6a-ab39-11606f88055c	f	2026-05-31 15:22:33.234133+00
f5b3264b-670b-4f90-be90-c14a6d12ba67	c544629d-bb02-4c51-9c23-dc743e51a9b1	15536a88-cfba-4cac-a8e5-b533abe2ab54	f	2026-05-31 15:22:33.234133+00
0f5e7596-6926-4d86-b5a0-e75f61889326	c544629d-bb02-4c51-9c23-dc743e51a9b1	65f4b618-10d7-4c92-be41-c4d9bd053263	f	2026-05-31 15:22:33.234133+00
ab32f917-afac-43a9-a7a0-2b5dcc998320	c544629d-bb02-4c51-9c23-dc743e51a9b1	24f025c4-be47-4644-b241-a0bff5fd0869	f	2026-05-31 15:22:33.234133+00
ec05a365-9da1-484e-ac5f-0fdfe2dc310b	c544629d-bb02-4c51-9c23-dc743e51a9b1	fa630ffe-1fc1-4d34-a86d-9b0a6512c03f	f	2026-05-31 15:22:33.234133+00
50970b6b-1b2e-4c4e-9cb3-0dcf5db6b4ca	c544629d-bb02-4c51-9c23-dc743e51a9b1	889daf94-e144-4911-a1ec-af8ca528c727	f	2026-05-31 15:22:33.234133+00
e91f23cf-4f25-4b04-8cba-9dcbb696f45c	c544629d-bb02-4c51-9c23-dc743e51a9b1	69abca1b-8546-47c4-b357-16127ab36e52	f	2026-05-31 15:22:33.234133+00
9a66fc81-3c50-4cf2-9618-2418a8fd2060	c544629d-bb02-4c51-9c23-dc743e51a9b1	2ddd2256-243a-4050-91a4-d561d2731612	f	2026-05-31 15:22:33.234133+00
647f9c03-b620-47c6-a4e1-32c9c2d7e35a	c544629d-bb02-4c51-9c23-dc743e51a9b1	ce6a0bf9-ca6a-4139-973c-ba756270a116	f	2026-05-31 15:22:33.234133+00
66bf979e-cbc0-467a-8258-cfb1f9fce013	c544629d-bb02-4c51-9c23-dc743e51a9b1	7567d355-527a-4571-ac6b-4eac76a0f654	f	2026-05-31 15:22:33.234133+00
863d0fa7-d4c2-4f90-84e1-8fdc206cb263	c544629d-bb02-4c51-9c23-dc743e51a9b1	d79baaa9-1a64-4855-91f2-ebb86e01d862	f	2026-05-31 15:22:33.234133+00
24e51a85-4c20-4271-abd6-2adaf7a03bda	c544629d-bb02-4c51-9c23-dc743e51a9b1	6ef32379-2a82-48ec-8ff8-c30424de55da	f	2026-05-31 15:22:33.234133+00
8f6d8034-0bbb-4c74-8ad2-ab4526fa22de	c544629d-bb02-4c51-9c23-dc743e51a9b1	7f119e1d-e898-4fd2-9760-79a440443716	f	2026-05-31 15:22:33.234133+00
6224234a-e792-4737-8b82-857d3e07d446	c544629d-bb02-4c51-9c23-dc743e51a9b1	2458e585-5a76-4baa-bd30-23ef40324ad7	f	2026-05-31 15:22:33.234133+00
1015dc37-7c98-4f95-9756-ef2ca9d93b2f	c544629d-bb02-4c51-9c23-dc743e51a9b1	b08b361a-1e55-4ace-9f9d-34bf2e5e315e	f	2026-05-31 15:22:33.234133+00
b640082d-c91a-4055-bfc6-d0e50cbc1a15	c544629d-bb02-4c51-9c23-dc743e51a9b1	76c4a01f-0d8e-496c-a341-9122a0fbabd0	f	2026-05-31 15:22:33.234133+00
bef39606-c6ef-4a5c-b051-cfdfdbfd17d3	c544629d-bb02-4c51-9c23-dc743e51a9b1	c9a9e8cb-8154-46f4-a2b2-cd49a418ec53	f	2026-05-31 15:22:33.234133+00
476ef172-05cb-4944-ac96-ec1256c53196	c544629d-bb02-4c51-9c23-dc743e51a9b1	6e6463ef-d154-4202-bb43-c0314e616abb	f	2026-05-31 15:22:33.234133+00
aa1a60bc-68a7-4cb7-9059-1d4ca0a9680e	c544629d-bb02-4c51-9c23-dc743e51a9b1	0dd6f9fb-7a20-4c20-99e7-9f6a4572d1f5	f	2026-05-31 15:22:33.234133+00
b5fb4ea2-a221-446a-88c8-ded02e4f67f6	c544629d-bb02-4c51-9c23-dc743e51a9b1	e22997a8-f518-4b80-9317-cceae9234d22	f	2026-05-31 15:22:33.234133+00
f04824d7-b866-4a0a-a23b-54fbf3c7957f	c544629d-bb02-4c51-9c23-dc743e51a9b1	22e9b674-af7d-41c8-bf99-182a290e8c6f	f	2026-05-31 15:22:33.234133+00
c5ef5295-c199-45e8-8186-01422336dc6c	c544629d-bb02-4c51-9c23-dc743e51a9b1	79d65ff8-5818-4f76-93f5-5bbcafc4030d	f	2026-05-31 15:22:33.234133+00
10b093d9-7593-4430-a80b-30e9a15452a8	c544629d-bb02-4c51-9c23-dc743e51a9b1	25c71b96-8565-4f26-a6b2-2473829dd1ca	f	2026-05-31 15:22:33.234133+00
6ddb502e-f22c-40c3-8ec2-b378837b6daf	c544629d-bb02-4c51-9c23-dc743e51a9b1	32706ea9-2844-4dec-bf40-832331a66cfe	f	2026-05-31 15:22:33.234133+00
afffaacd-cb73-47ff-bfc3-aacdd7def448	299efed3-47cc-4a52-a203-96f8ed2f50c0	df1b5e88-c3c1-4c81-beee-01ec1dd9db5d	f	2026-05-31 15:22:33.234133+00
a2fe7e6c-1863-4c2d-9746-faa8691fd289	a0dee1a9-0426-4878-9726-cb5b880dd961	ac5b4735-8870-4ba7-8fe5-aca2ea4f9c12	f	2026-05-31 15:22:33.234133+00
83ae48bb-b619-4cfe-8f09-0cf821ca9aef	31e328af-0472-4281-a2f9-8db26e83f2bb	d03633d8-d6ca-4aed-be49-fcfffc0a6561	f	2026-05-31 15:22:33.234133+00
32492f1d-1378-435a-8728-38548bf43a1d	502755cd-0595-4ac7-8dba-eb20ac1f69a6	51191d5b-a3dd-42ba-8088-39e165fd8ccd	f	2026-05-31 15:22:33.234133+00
1998a86e-fb32-4a5e-bdab-13bd4701c4db	502755cd-0595-4ac7-8dba-eb20ac1f69a6	4eda1da1-14e5-4755-8f8c-09731ac9a477	f	2026-05-31 15:22:33.234133+00
26ece0cf-8382-4b4f-9e4f-fae4be7fdd4e	bc8f862e-ec2c-4c37-b924-c34864013f1c	8ce99e02-60d1-4783-b66c-d1bb19c478ed	f	2026-05-31 15:22:33.234133+00
ddd4e5ae-c218-4294-a4a3-6f7aa2fdc61a	380e4e1d-f169-474c-812b-d9a157b98930	7fec4ad9-fdda-481a-953a-9b2802e87a35	f	2026-05-31 15:22:33.234133+00
ffe69f2a-d360-4edb-a1f5-3d6bef9635fe	380e4e1d-f169-474c-812b-d9a157b98930	1b21478d-4cec-45b9-a63f-d20df9806bd4	f	2026-05-31 15:22:33.234133+00
6095b8c4-a97c-4e35-ae9f-5e3225fbecd6	39259dfa-72e0-4568-b6ae-7beb2b01b10f	bb214b76-dc32-43b2-9eec-9847c49b7e14	f	2026-05-31 15:22:33.234133+00
b0c65514-acec-4378-9fa4-17f18f1296c6	c2ad89fd-2583-4f46-ad0d-8232f6269718	89961323-d7f7-4117-9604-4ab28c61e15a	f	2026-05-31 15:22:33.234133+00
b196f33f-6b9e-4a65-a2b2-9247f890c044	bc8f862e-ec2c-4c37-b924-c34864013f1c	a251736d-dc57-4c7e-8bce-1ec288c9ffc5	f	2026-05-31 15:44:03.395608+00
2948fdd1-7635-4d09-afa6-6556b7d84d71	bc8f862e-ec2c-4c37-b924-c34864013f1c	0320561f-f558-4d9f-850e-1ee4b7d4a63b	f	2026-05-31 15:44:03.395608+00
a5b22f57-4cc1-4910-b82f-63e83d42ae00	bc8f862e-ec2c-4c37-b924-c34864013f1c	d334e491-e29a-4b3e-850b-791354aecc0c	f	2026-05-31 15:44:03.395608+00
9abc8dc5-0255-4604-82a8-a668ef0c69a7	bc8f862e-ec2c-4c37-b924-c34864013f1c	2e199a41-8ac8-4310-b471-ff3b76e9624e	f	2026-05-31 15:44:03.395608+00
5626e8fb-ca91-4940-83be-992a40c47bed	bc8f862e-ec2c-4c37-b924-c34864013f1c	3f81935f-86b6-4345-a20f-e5f2fc739674	f	2026-05-31 15:44:03.395608+00
181fd9db-dbea-47ee-a159-d4fb1540f387	bc8f862e-ec2c-4c37-b924-c34864013f1c	a81459da-20b0-46f8-b445-690baec154b1	f	2026-05-31 15:44:03.395608+00
fbe5c4fa-40ed-421b-a80f-7ff88241af02	bc8f862e-ec2c-4c37-b924-c34864013f1c	e69811d3-6553-46e4-8d93-01d6f7b7ef64	f	2026-05-31 15:44:03.395608+00
affd3137-cc92-42be-a8a8-2a32ff3081ad	bc8f862e-ec2c-4c37-b924-c34864013f1c	96a5622d-e9fa-44e8-8f11-6076078ec9eb	f	2026-05-31 15:44:03.395608+00
a2c8f3bb-76d2-4a4c-a502-e14dc9b44841	bc8f862e-ec2c-4c37-b924-c34864013f1c	f63fea2b-54c3-4e5e-8766-a42953196e13	f	2026-05-31 15:44:03.395608+00
2ae1317e-4d48-4421-a7ee-d596d18465ea	bc8f862e-ec2c-4c37-b924-c34864013f1c	330d4ed2-23e0-4b8c-8ca5-7b076e9387dc	f	2026-05-31 15:44:03.395608+00
e32926b2-7d1a-427b-ac31-c2a27a555339	bc8f862e-ec2c-4c37-b924-c34864013f1c	00cbcd44-20d4-437b-b63d-87a4bd8f5525	f	2026-05-31 15:44:03.395608+00
84c834fc-b868-4776-b524-8b41ba9a5e99	bc8f862e-ec2c-4c37-b924-c34864013f1c	94e5fb09-e6e2-4913-9d25-4beab67e1d76	f	2026-05-31 15:44:03.395608+00
f265d3c1-7725-4276-a4f0-e0f4c40118f6	bc8f862e-ec2c-4c37-b924-c34864013f1c	65582089-8ad0-4f1d-b938-8403729aecd2	f	2026-05-31 15:44:03.395608+00
284463af-c5b1-4c54-aa89-47f62eefdb7b	bc8f862e-ec2c-4c37-b924-c34864013f1c	b7fac81b-7e1a-4a90-99fb-3baa4b85c8ae	f	2026-05-31 15:44:03.395608+00
34a7315f-1e9f-4d4c-a158-5717c10e0bb9	bc8f862e-ec2c-4c37-b924-c34864013f1c	8e41fbb0-ec8a-433b-8ac2-e15afd98f635	f	2026-05-31 15:44:03.395608+00
9fb7e2ef-ce57-4717-955f-72b18d274609	bc8f862e-ec2c-4c37-b924-c34864013f1c	777fc485-c6fe-4bc6-9c5e-d45f18350a7b	f	2026-05-31 15:44:03.395608+00
604d7b26-c39f-4386-a798-2ce03bbd8a67	bc8f862e-ec2c-4c37-b924-c34864013f1c	bc998c4f-0999-4be8-a1b4-b42e39650582	f	2026-05-31 15:44:03.395608+00
17403515-2a8a-4e51-bb62-3e81e1f85903	bc8f862e-ec2c-4c37-b924-c34864013f1c	3a9ef16f-226d-487e-9186-f3347242cff3	f	2026-05-31 15:44:03.395608+00
bba16115-a459-413a-ab88-29aaaf867654	bc8f862e-ec2c-4c37-b924-c34864013f1c	ae379af0-84a0-46d0-a30b-f253300bf82e	f	2026-05-31 15:44:03.395608+00
68971744-2947-4104-94e2-5873d1c1a6f8	bc8f862e-ec2c-4c37-b924-c34864013f1c	44082a58-8820-489a-968c-1b533ffd6f09	f	2026-05-31 15:44:03.395608+00
63cf61ff-83c0-4d11-a10d-05e254d8dae9	bc8f862e-ec2c-4c37-b924-c34864013f1c	f5bf316c-4138-44aa-bdfb-92053d8c4865	f	2026-05-31 15:44:03.395608+00
d7ec1da3-79e4-4ed4-aa96-645ecfcec978	c2ad89fd-2583-4f46-ad0d-8232f6269718	47dcb8bb-e2ec-40a4-8bbe-c29d36aa460a	f	2026-05-31 15:44:03.395608+00
d598639a-d25e-4650-b525-ab8fec353cce	c2ad89fd-2583-4f46-ad0d-8232f6269718	3fa6dea1-a2ed-4f06-99ef-43b155fb83ac	f	2026-05-31 15:44:03.395608+00
49be8c91-72b9-4de0-81c3-2851ae7901ab	c2ad89fd-2583-4f46-ad0d-8232f6269718	637a6837-54e3-4899-9426-6d9784584a95	f	2026-05-31 15:44:03.395608+00
424862aa-db42-4a28-b753-228132cde4ed	c2ad89fd-2583-4f46-ad0d-8232f6269718	be790842-7bcf-4b98-97b1-5b7263a06d27	f	2026-05-31 15:44:03.395608+00
fb8a5ec0-7f38-4b72-955d-cb5f041ce37f	c2ad89fd-2583-4f46-ad0d-8232f6269718	e92a8687-47e0-4435-ba0d-46e65c6ff1bd	f	2026-05-31 15:44:03.395608+00
5dfaacfc-1506-46b7-8e15-c16263a35358	c2ad89fd-2583-4f46-ad0d-8232f6269718	0659a7a5-4106-4195-ba92-46618b2b927c	f	2026-05-31 15:44:03.395608+00
0e99049d-1a22-45d4-94bb-e78dacab3e2b	c2ad89fd-2583-4f46-ad0d-8232f6269718	3fad0fe1-1a21-4a1b-a2a5-be5164d726c7	f	2026-05-31 15:44:03.395608+00
294d0e98-af96-47af-abb8-2af5d91fdba9	c2ad89fd-2583-4f46-ad0d-8232f6269718	d77158c1-028e-4a4b-a9ec-c8063768aa94	f	2026-05-31 15:44:03.395608+00
9a21a48d-27d6-4678-8f32-670aa242932d	c2ad89fd-2583-4f46-ad0d-8232f6269718	5b7a381b-6d28-4d5b-af32-e321d6746087	f	2026-05-31 15:44:03.395608+00
4235f164-c541-4ae5-8e9d-3cfd64a5079b	c2ad89fd-2583-4f46-ad0d-8232f6269718	dd626130-85b4-42a1-8a0e-1d18ed6affec	f	2026-05-31 15:44:03.395608+00
e7f46c97-6124-4d29-adf8-47c1afd7a5e7	c2ad89fd-2583-4f46-ad0d-8232f6269718	9c7a5a00-313c-482f-89c3-29ab3a62ea9b	f	2026-05-31 15:44:03.395608+00
6493bb57-2631-47de-9cd1-6f7b5c8ef286	c2ad89fd-2583-4f46-ad0d-8232f6269718	82524a7c-95b2-4b9a-a302-a4213da7df10	f	2026-05-31 15:44:03.395608+00
691e4051-6dda-4567-99a4-15b26c34ce6f	c2ad89fd-2583-4f46-ad0d-8232f6269718	5f692a8b-3181-4c00-9e08-2f114908257b	f	2026-05-31 15:44:03.395608+00
9c62c44e-5082-4867-89ea-42d5f5af196c	c2ad89fd-2583-4f46-ad0d-8232f6269718	bae876b1-3865-42cf-9dfc-ec8582add3fd	f	2026-05-31 15:44:03.395608+00
cf0a450c-c8e7-4f88-a69b-be79290b921c	c2ad89fd-2583-4f46-ad0d-8232f6269718	c5aeab56-84c5-4536-ba3e-6fdc1e755ad1	f	2026-05-31 15:44:03.395608+00
98c2633e-61aa-400c-9c25-4e79d3977dc1	c2ad89fd-2583-4f46-ad0d-8232f6269718	bb5a414a-b921-4b03-9611-2f315b856597	f	2026-05-31 15:44:03.395608+00
1d21036d-4316-4623-9c8c-e2184749bb24	c2ad89fd-2583-4f46-ad0d-8232f6269718	0824d194-45b4-4edb-8b81-412a016890e7	f	2026-05-31 15:44:03.395608+00
267d7c71-f86b-401e-9b44-22469cba8b13	c2ad89fd-2583-4f46-ad0d-8232f6269718	465c8e95-941b-49ba-a13b-aa033bea66ff	f	2026-05-31 15:44:03.395608+00
dfd126b4-d60e-4de2-9c8c-bd3c0f56a1e0	c2ad89fd-2583-4f46-ad0d-8232f6269718	f4fd2272-f06e-47b4-bb28-9a71b30fd1b5	f	2026-05-31 15:44:03.395608+00
17064f29-0ad4-4b33-b8cf-3fa4c6d064fa	c2ad89fd-2583-4f46-ad0d-8232f6269718	9ca4b34a-cc77-4e08-ab4d-0d6682dfc330	f	2026-05-31 15:44:03.395608+00
85d28185-97ef-455e-930b-360364d8f44c	c2ad89fd-2583-4f46-ad0d-8232f6269718	e2ff67c4-bb77-40e5-830c-0e07ee60e5e4	f	2026-05-31 15:44:03.395608+00
95ad4aec-ee9d-4a04-9747-2df54b88a5df	c544629d-bb02-4c51-9c23-dc743e51a9b1	7d299491-1c05-41a1-b760-752a11df0a81	f	2026-05-31 15:44:03.395608+00
68338760-dbb0-4d2f-9521-881f6c90af7a	c544629d-bb02-4c51-9c23-dc743e51a9b1	89fe7b4f-c40b-4640-9d70-1d6f051284fb	f	2026-05-31 15:44:03.395608+00
d98cd6ce-5e89-49c0-9578-8532fc16fe81	c544629d-bb02-4c51-9c23-dc743e51a9b1	47693ee8-2fa7-451b-963a-ef74ce3b50a8	f	2026-05-31 15:44:03.395608+00
72725780-d810-4d5f-bd0f-747ed1bc87fa	c544629d-bb02-4c51-9c23-dc743e51a9b1	9801b3ea-aac1-4317-ad78-2202e777ccd5	f	2026-05-31 15:44:03.395608+00
996a0377-314b-46fc-81f7-73582860491c	c544629d-bb02-4c51-9c23-dc743e51a9b1	c376ebc6-5f30-4ca3-ac2e-9029e81068c6	f	2026-05-31 15:44:03.395608+00
a0a87678-2d49-45ac-9c16-4cc49eb1651c	c544629d-bb02-4c51-9c23-dc743e51a9b1	d3a50159-c16b-4c56-84ba-c11ffe722b70	f	2026-05-31 15:44:03.395608+00
c9912a85-1872-4514-8bf9-4293c839d89b	c544629d-bb02-4c51-9c23-dc743e51a9b1	f8fdadcb-0677-48a9-801e-dd91e3f315d0	f	2026-05-31 15:44:03.395608+00
df4bec9e-5241-4cb5-8073-f7f066f4da3f	c544629d-bb02-4c51-9c23-dc743e51a9b1	95fceb2a-7f1b-493e-a6c2-17e43801090d	f	2026-05-31 15:44:03.395608+00
8fe7d543-230d-47f2-a2cd-32345ce031ec	c544629d-bb02-4c51-9c23-dc743e51a9b1	7f001610-1095-4764-9c94-9c13b2346130	f	2026-05-31 15:44:03.395608+00
6f85270f-17bb-4c2f-b141-9775eb207b15	c544629d-bb02-4c51-9c23-dc743e51a9b1	b8b57b1f-3706-4b26-a02f-0a0206ace9fc	f	2026-05-31 15:44:03.395608+00
217c27f7-437f-4bdc-8726-695631b5dbca	c544629d-bb02-4c51-9c23-dc743e51a9b1	366c8de9-4899-4c21-95ce-e9c9726cf211	f	2026-05-31 15:44:03.395608+00
09a0b68a-d944-49d1-8def-85f1e3b63e9b	c544629d-bb02-4c51-9c23-dc743e51a9b1	de206a73-448e-41ed-924f-97963160f240	f	2026-05-31 15:44:03.395608+00
27ef2fdb-b5a6-41d6-8e80-e492c08c6c90	c544629d-bb02-4c51-9c23-dc743e51a9b1	29e7e5c7-6c9b-4254-9658-1d3ab765b868	f	2026-05-31 15:44:03.395608+00
f4475915-1f50-4ba0-abad-cf1c34b1834c	c544629d-bb02-4c51-9c23-dc743e51a9b1	aa1e43e3-d4c7-4816-8fb3-8c746ba51ec6	f	2026-05-31 15:44:03.395608+00
d4349215-8f2c-4a1f-bab8-036d1a938283	c544629d-bb02-4c51-9c23-dc743e51a9b1	53e2a32f-ccb6-49dc-8c69-dcb6dfd1cf40	f	2026-05-31 15:44:03.395608+00
50fa7fe6-3d7a-4a2f-80f6-d2d8227029ac	c544629d-bb02-4c51-9c23-dc743e51a9b1	6a3972a8-f062-4291-9f1c-4e7a017114fe	f	2026-05-31 15:44:03.395608+00
0423e890-7b75-48a5-98da-1d9089e5e2c7	c544629d-bb02-4c51-9c23-dc743e51a9b1	8e57ef93-6169-4c53-8896-f5b17fe36615	f	2026-05-31 15:44:03.395608+00
cdc12127-454e-41e5-a821-00ae9131ac13	c544629d-bb02-4c51-9c23-dc743e51a9b1	127e804f-e81e-4963-9b0a-2f3aefa52869	f	2026-05-31 15:44:03.395608+00
5a3a8906-1e66-44d1-beac-46907d946768	c544629d-bb02-4c51-9c23-dc743e51a9b1	bca5e204-5236-45ac-86e1-f096e77f9712	f	2026-05-31 15:44:03.395608+00
bae6f1b5-4b49-4a1b-b931-90ad51262058	c544629d-bb02-4c51-9c23-dc743e51a9b1	264b87e1-0354-4b00-bc20-a3b465f02bb6	f	2026-05-31 15:44:03.395608+00
924d2b24-5c6c-4e99-bc67-1672ec0c7a08	c544629d-bb02-4c51-9c23-dc743e51a9b1	fcfcc1c6-445e-42cb-98c4-4856c05a7459	f	2026-05-31 15:44:03.395608+00
2ab60927-b130-40af-b718-a0a137cb2a5c	c544629d-bb02-4c51-9c23-dc743e51a9b1	c8c3c9f6-6d0e-4817-bfc4-fde77f961ab0	f	2026-05-31 15:44:03.395608+00
a690b7f5-2840-4743-a06b-8153ba2e94b3	c544629d-bb02-4c51-9c23-dc743e51a9b1	77894843-a542-421e-8d8b-b8cf04c94d22	f	2026-05-31 15:44:03.395608+00
4035e338-7a83-4d13-972c-03311981009f	c544629d-bb02-4c51-9c23-dc743e51a9b1	e19e19d2-7c37-49fe-a409-85b837942a83	f	2026-05-31 15:44:03.395608+00
430c8af3-e664-4ab1-8a76-a5dde16889df	c544629d-bb02-4c51-9c23-dc743e51a9b1	2bb755d4-cfef-4f2a-844c-f257768b3b9b	f	2026-05-31 15:44:03.395608+00
c3d40db1-191b-41c5-83ff-41885426efd3	c544629d-bb02-4c51-9c23-dc743e51a9b1	54d14dd4-a8ae-4726-814c-65cfa9b6ac0a	f	2026-05-31 15:44:03.395608+00
3571deb6-1d9d-4e02-83fd-1939769fb006	c544629d-bb02-4c51-9c23-dc743e51a9b1	8eb1f381-f9ec-48a0-8950-bbea6340d3de	f	2026-05-31 15:44:03.395608+00
423f3d03-8bc7-4a94-83e1-8adb537afbf6	c544629d-bb02-4c51-9c23-dc743e51a9b1	3433460d-c1b5-40d6-a1ab-b14d0f2995d6	f	2026-05-31 15:44:03.395608+00
bea3d608-f90b-4454-b9a6-e2bd8318aa12	c544629d-bb02-4c51-9c23-dc743e51a9b1	64758f88-b054-4a27-be9e-691cfac92fc1	f	2026-05-31 15:44:03.395608+00
847ecf1c-d691-4066-8995-62d2f2e61d17	c544629d-bb02-4c51-9c23-dc743e51a9b1	50b8b690-5746-4640-9af0-62ad0752eeae	f	2026-05-31 15:44:03.395608+00
0d687511-8d36-4e8a-8b23-e0a0b830fbf0	c544629d-bb02-4c51-9c23-dc743e51a9b1	63929869-4a90-4d8b-bc29-9d8d396e0495	f	2026-05-31 15:44:03.395608+00
f3df307a-e03d-4bc5-af30-3ac66b3b2e78	c544629d-bb02-4c51-9c23-dc743e51a9b1	a7920c36-86e5-4243-8fd4-867c816c68d4	f	2026-05-31 15:44:03.395608+00
6c653db9-495d-4c3c-b5fe-439e16b16787	c544629d-bb02-4c51-9c23-dc743e51a9b1	6b28afd3-636b-4105-9233-1f9073313d4b	f	2026-05-31 15:44:03.395608+00
80daf84f-d6f9-49ef-9796-60c326c77a74	c544629d-bb02-4c51-9c23-dc743e51a9b1	ae075b30-5308-4e5c-ab4f-6fab46c98bcb	f	2026-05-31 15:44:03.395608+00
36b7b55d-0315-4bf9-a4a9-a32cd31df1fd	c544629d-bb02-4c51-9c23-dc743e51a9b1	64a6524c-e487-42f5-a956-140e0803a6d9	f	2026-05-31 15:44:03.395608+00
05e0dea0-f70a-4328-8af8-a29ced8d90d1	c544629d-bb02-4c51-9c23-dc743e51a9b1	6a469bd1-f971-4914-a318-b9a9a7d54ea0	f	2026-05-31 15:44:03.395608+00
ef513a88-5582-49ff-bcee-d65df24240e2	c544629d-bb02-4c51-9c23-dc743e51a9b1	66de3010-e0ba-4837-ad4e-80c7d40a5de1	f	2026-05-31 15:44:03.395608+00
dede629f-3f59-4dc7-afc3-b211df56eccf	c544629d-bb02-4c51-9c23-dc743e51a9b1	ae7426c9-901b-4630-bcd5-4c7413e0eff1	f	2026-05-31 15:44:03.395608+00
91d54de1-735d-49ed-9b58-4f8a9ba21c57	c544629d-bb02-4c51-9c23-dc743e51a9b1	f687a0f4-05b3-4183-bbb6-04537986f04b	f	2026-05-31 15:44:03.395608+00
7e80f65d-982b-48f0-984d-e01da172ddd8	c544629d-bb02-4c51-9c23-dc743e51a9b1	ced81cb4-01ef-47f0-82e2-de55722bb376	f	2026-05-31 15:44:03.395608+00
d28f36bb-d40b-4584-9a88-d5a83524d7b6	c544629d-bb02-4c51-9c23-dc743e51a9b1	bb279ee8-ecae-42bc-9137-18428938aa3b	f	2026-05-31 15:44:03.395608+00
dfbd6ad4-9dec-478c-9839-e81cfdac7fa7	c544629d-bb02-4c51-9c23-dc743e51a9b1	778aad83-227e-4e00-af0a-295748bc3180	f	2026-05-31 15:44:03.395608+00
7da7489f-135f-46c3-962e-c58ac21d7e12	c544629d-bb02-4c51-9c23-dc743e51a9b1	d4de2227-2093-48ee-8275-4dbe3d8dfa25	f	2026-05-31 15:44:03.395608+00
09446cfd-7e51-4e90-ac5d-27e3441ad9dc	c544629d-bb02-4c51-9c23-dc743e51a9b1	5f6fd092-78a9-48ea-84c0-f242ee84a724	f	2026-05-31 15:44:03.395608+00
cf03f4a7-b43b-4f9e-b865-ca76c31a6696	c544629d-bb02-4c51-9c23-dc743e51a9b1	3462728b-b66d-40af-b069-0a29362474b4	f	2026-05-31 15:44:03.395608+00
82812e7d-d4e0-434c-bf65-df6005a2fe19	c544629d-bb02-4c51-9c23-dc743e51a9b1	fcbd9a6f-4d44-4f36-a019-d515c3ef9fb8	f	2026-05-31 15:44:03.395608+00
86d37fd5-d8b3-4ab0-a951-09395c3482b2	c544629d-bb02-4c51-9c23-dc743e51a9b1	ea794e0f-0bd8-4edc-8088-aa046e4c6878	f	2026-05-31 15:44:03.395608+00
15d893ce-7bf8-4893-88b2-bf5f4d292659	c544629d-bb02-4c51-9c23-dc743e51a9b1	a0c09f33-d246-42d6-897b-899c4dcbccbd	f	2026-05-31 15:44:03.395608+00
93947abd-787c-4d44-b622-65ff96fbd4f8	c544629d-bb02-4c51-9c23-dc743e51a9b1	0d9b303f-f2fa-4b1b-af5d-fee12ea9fc1c	f	2026-05-31 15:44:03.395608+00
9aec3a8a-a5b0-4c2b-8b6d-db2efd64a36e	c544629d-bb02-4c51-9c23-dc743e51a9b1	386afda7-e86b-4aef-829d-01439e73530f	f	2026-05-31 15:44:03.395608+00
b61ad455-a6b5-4c1f-881f-8ee3f19ad28c	c544629d-bb02-4c51-9c23-dc743e51a9b1	b50e6af3-893d-4a52-b71c-2a23d1f74e14	f	2026-05-31 15:44:03.395608+00
d7ac1dbb-d519-4e52-a301-4a4c3520f339	c544629d-bb02-4c51-9c23-dc743e51a9b1	faa5fb8e-1edc-4d59-8cf2-6c3b9b74b614	f	2026-05-31 15:44:03.395608+00
64443675-896b-48e0-84c9-423342e63bfa	c544629d-bb02-4c51-9c23-dc743e51a9b1	4ab922c2-2ed7-4850-8009-963f2a0f74be	f	2026-05-31 15:44:03.395608+00
226d5c4f-d6b1-4d67-a94b-8aac04b9d3b3	c544629d-bb02-4c51-9c23-dc743e51a9b1	66eef75f-2ccd-4a3c-b6db-71bdfa385152	f	2026-05-31 15:44:03.395608+00
7300d16f-bfff-44b6-aab2-5b327cb84a57	c544629d-bb02-4c51-9c23-dc743e51a9b1	adb65a41-a98d-4e14-8f59-a2fedd261ae3	f	2026-05-31 15:44:03.395608+00
4d2a0a95-c1ae-4b5a-baa9-ba95df640e59	c544629d-bb02-4c51-9c23-dc743e51a9b1	3c78077e-c51c-43fa-ace0-2e7a9950682a	f	2026-05-31 15:44:03.395608+00
24f6a4d8-46cf-4c18-aec3-9e94dc26c458	c544629d-bb02-4c51-9c23-dc743e51a9b1	10e27418-61fa-49df-b90c-c243e75d4b0f	f	2026-05-31 15:44:03.395608+00
1f7419ae-0865-43e6-96a6-b5127627bba0	c544629d-bb02-4c51-9c23-dc743e51a9b1	4199fea8-ae64-4933-9cbd-6c2b6ad66e40	f	2026-05-31 15:44:03.395608+00
3fc19628-5e1f-4bab-8e6f-253bacd9d511	c544629d-bb02-4c51-9c23-dc743e51a9b1	fad6faec-99e6-48cb-80b0-6dd2623a4855	f	2026-05-31 15:44:03.395608+00
d29fd5c4-22ec-4ed2-9263-e4a6ace61b57	c544629d-bb02-4c51-9c23-dc743e51a9b1	ee3c7083-56bb-4b32-9133-7f3fd5c76d4f	f	2026-05-31 15:44:03.395608+00
ebee626d-7777-49ca-aecc-b9b2ee4a8602	c544629d-bb02-4c51-9c23-dc743e51a9b1	181d677b-8aa0-4fb4-ac8a-88d98a6e60d5	f	2026-05-31 15:44:03.395608+00
93d713ab-0da8-4fcc-885c-7afa7590663c	c544629d-bb02-4c51-9c23-dc743e51a9b1	a2fe4a26-42a0-4c91-8f19-7ee78dcd3008	f	2026-05-31 15:44:03.395608+00
61c0dce7-57d2-4535-9322-864d3b991ed2	c544629d-bb02-4c51-9c23-dc743e51a9b1	e21ef3d1-c737-4d0d-807c-5351b85f764e	f	2026-05-31 15:44:03.395608+00
31e2ef8d-0511-4972-bf62-e667d66643c4	c544629d-bb02-4c51-9c23-dc743e51a9b1	e03c0c01-0fc0-477a-8243-e1f99d72b0c8	f	2026-05-31 15:44:03.395608+00
b8b8260d-7582-4d52-baf6-33a21dc33a36	c544629d-bb02-4c51-9c23-dc743e51a9b1	194bb00b-cab6-4f4e-8bcf-6b1a4953a577	f	2026-05-31 15:44:03.395608+00
a5e61d2d-90e2-41d5-860b-758e808e09ef	c544629d-bb02-4c51-9c23-dc743e51a9b1	56058e47-d48f-4435-9865-0cf44b505606	f	2026-05-31 15:44:03.395608+00
6ee3ff4c-1130-48aa-abfd-f96cd40c534e	c544629d-bb02-4c51-9c23-dc743e51a9b1	a16eadb0-691e-422d-a5fe-9eec7c0b1e59	f	2026-05-31 15:44:03.395608+00
6d619b3c-f767-4150-bde6-1e1baac04abb	c544629d-bb02-4c51-9c23-dc743e51a9b1	f28c1b55-4f1e-43d0-b76b-268216334fcd	f	2026-05-31 15:44:03.395608+00
bab34882-e347-4436-ba72-e2a16e7c450d	c544629d-bb02-4c51-9c23-dc743e51a9b1	8855f9a3-1573-4ca9-ae70-7a5485f158d6	f	2026-05-31 15:44:03.395608+00
79dc9e60-9ce5-4520-9a24-e8d09c7eb8eb	c544629d-bb02-4c51-9c23-dc743e51a9b1	f4fec7da-6e25-447a-9b85-4a6a968fe6d1	f	2026-05-31 15:44:03.395608+00
95bdc2d0-11c9-40a1-b122-85e945ab2a7a	c544629d-bb02-4c51-9c23-dc743e51a9b1	75cdaf2c-21a5-435c-9b1c-6925852cc75b	f	2026-05-31 15:44:03.395608+00
86c49d27-4505-42c7-b4ef-8d2459f2fbe8	c544629d-bb02-4c51-9c23-dc743e51a9b1	3202045d-331c-4bb2-ab82-06c923d461e8	f	2026-05-31 15:44:03.395608+00
f1dbff4c-18e3-4ae8-bfcb-d3dd8751639b	c544629d-bb02-4c51-9c23-dc743e51a9b1	c24c7d50-4de0-40ca-ba7e-4ab33d0c27e1	f	2026-05-31 15:44:03.395608+00
e8254328-5448-401a-a3de-f110d2263a88	c544629d-bb02-4c51-9c23-dc743e51a9b1	738b211d-7d79-4bb5-a4bf-4bd58007487c	f	2026-05-31 15:44:03.395608+00
fb11c990-a7cc-40b7-b538-d3fc569d3a85	c544629d-bb02-4c51-9c23-dc743e51a9b1	61982bdb-3a49-4089-b431-7d9abf241733	f	2026-05-31 15:44:03.395608+00
71859a2a-869f-45b9-9a92-e16202f62819	c544629d-bb02-4c51-9c23-dc743e51a9b1	a73af113-f364-4429-bc5f-bec5cd9923b1	f	2026-05-31 15:44:03.395608+00
4a2cf396-13a0-4a08-b13b-7f7eae5432b2	c544629d-bb02-4c51-9c23-dc743e51a9b1	efbe74ea-ddb5-41b0-b4f8-d32b160750e5	f	2026-05-31 15:44:03.395608+00
f7ef51f6-d82e-4c72-9795-0bdbe615a6b1	c544629d-bb02-4c51-9c23-dc743e51a9b1	7008d5f6-41f6-4602-8c93-cdb0f24203d0	f	2026-05-31 15:44:03.395608+00
2d5ebfe0-f805-4686-a97c-1db1b589ff97	c544629d-bb02-4c51-9c23-dc743e51a9b1	93fb967a-c2af-4f58-b4e8-88a52acd488a	f	2026-05-31 15:44:03.395608+00
612d6704-ca31-4e3f-80fc-92e564c75f94	c544629d-bb02-4c51-9c23-dc743e51a9b1	d2475854-a1b9-422b-962e-8ff89dd093cf	f	2026-05-31 15:44:03.395608+00
0b6aaa90-dd75-4c94-9903-f803f7df4a49	c544629d-bb02-4c51-9c23-dc743e51a9b1	a46bb0e4-0c57-49ba-a5d8-5849e24a3296	f	2026-05-31 15:44:03.395608+00
a67cf3b1-7bad-4ea5-97a2-82fec952ae93	c544629d-bb02-4c51-9c23-dc743e51a9b1	abcf723a-9922-441c-95ed-3233fe680b51	f	2026-05-31 15:44:03.395608+00
a9bd59ae-892b-40c6-a69f-7fcb8954778f	c544629d-bb02-4c51-9c23-dc743e51a9b1	f991bc2f-89e9-4684-9a2f-793e4809fffc	f	2026-05-31 15:44:03.395608+00
9e2433a8-575c-4a51-9841-e46570b3bdbe	c544629d-bb02-4c51-9c23-dc743e51a9b1	473bdccd-3e3a-477d-8c99-8eb00ad0c351	f	2026-05-31 15:44:03.395608+00
bc34cc59-63b0-48ed-a81a-642474da0100	c544629d-bb02-4c51-9c23-dc743e51a9b1	fb95156b-86a9-4f40-ba29-472a310d563f	f	2026-05-31 15:44:03.395608+00
786d3b99-0af0-46e5-b74c-4535ee334301	c544629d-bb02-4c51-9c23-dc743e51a9b1	699503cb-dad8-41d3-bb8f-a8e0d176b90c	f	2026-05-31 15:44:03.395608+00
3b404cd1-00d6-4cc5-b0d4-bce07e2e40d8	c544629d-bb02-4c51-9c23-dc743e51a9b1	0066a484-3f48-4faf-b39c-d0862bf60f95	f	2026-05-31 15:44:03.395608+00
d78b3376-5ce0-49c8-930d-92f637e35bc8	c544629d-bb02-4c51-9c23-dc743e51a9b1	0c5bf7db-aa56-441b-905c-d0dfdb389907	f	2026-05-31 15:44:03.395608+00
48dba050-01de-4bca-8a0c-212735e95a29	c544629d-bb02-4c51-9c23-dc743e51a9b1	7d0cd048-ca29-4a09-bb75-7570254d089c	f	2026-05-31 15:44:03.395608+00
2b2bd43b-6177-4a61-8ca5-9e29a87cdddf	299efed3-47cc-4a52-a203-96f8ed2f50c0	3d6b8ba4-2306-4c1d-be72-e4a7599fd7e1	f	2026-05-31 15:44:03.395608+00
14e96bca-3486-470e-8d78-7f979ca1e1c8	a0dee1a9-0426-4878-9726-cb5b880dd961	1227b23f-b10d-4e77-b471-ee28502c3dad	f	2026-05-31 15:44:03.395608+00
96acebf3-037d-44bf-9e4b-dbd36ebd6626	31e328af-0472-4281-a2f9-8db26e83f2bb	ebef4297-d34f-4a88-9a4e-f6c9999cd529	f	2026-05-31 15:44:03.395608+00
07b733c8-aabd-4660-a355-8ffc7e6f263e	502755cd-0595-4ac7-8dba-eb20ac1f69a6	f9aa57b7-d95f-453d-be1f-967f02990fb7	f	2026-05-31 15:44:03.395608+00
5bc4a4a5-115b-4e16-bb11-dce64593a123	502755cd-0595-4ac7-8dba-eb20ac1f69a6	a5239636-98ba-44f2-abf0-2858402be971	f	2026-05-31 15:44:03.395608+00
1a27b714-0209-4362-af0b-05c73d55714d	bc8f862e-ec2c-4c37-b924-c34864013f1c	6c462cbf-ee0d-4557-898f-9e987b1ee47b	f	2026-05-31 15:44:03.395608+00
e95bf113-ea61-43fb-8ec7-0b7a4e6f3b28	380e4e1d-f169-474c-812b-d9a157b98930	29d5d46c-8ec3-44c1-8683-14fd2c3d6cf2	f	2026-05-31 15:44:03.395608+00
a13bf8d8-455d-4b46-ace4-d27064720df1	380e4e1d-f169-474c-812b-d9a157b98930	a0196808-d6aa-4de7-aad3-e6be2651520d	f	2026-05-31 15:44:03.395608+00
d4ac8189-19b7-4533-8ae1-f2e53a1497b4	39259dfa-72e0-4568-b6ae-7beb2b01b10f	3c9554db-7ea9-47e5-bb15-7ab8d31872b6	f	2026-05-31 15:44:03.395608+00
e89e7715-4f82-4542-a066-8168d41d7801	c2ad89fd-2583-4f46-ad0d-8232f6269718	4f458501-d7f8-400c-a24c-62125c0273cd	f	2026-05-31 15:44:03.395608+00
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 283, true);


--
-- PostgreSQL database dump complete
--

\unrestrict 0Tj56uokqg4KiX9X3eP94hVztj6jd1yONasitrngTf6bsLfFOboo43arV70BcO8

