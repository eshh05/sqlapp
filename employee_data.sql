--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

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
-- Name: sync_current_salary(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sync_current_salary() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE Employee
    SET salary = NEW.current_salary
    WHERE empId = NEW.empId;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.sync_current_salary() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department (
    deptid integer NOT NULL,
    deptname character varying(50),
    deptheadid integer
);


ALTER TABLE public.department OWNER TO postgres;

--
-- Name: department_deptid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.department_deptid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.department_deptid_seq OWNER TO postgres;

--
-- Name: department_deptid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.department_deptid_seq OWNED BY public.department.deptid;


--
-- Name: employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee (
    empid integer NOT NULL,
    name character varying(50),
    dob date,
    doj date,
    designation character varying(50),
    contact character varying(10),
    deptid integer,
    managerid integer,
    totalleaves numeric,
    salary integer
);


ALTER TABLE public.employee OWNER TO postgres;

--
-- Name: employee_empid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employee_empid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employee_empid_seq OWNER TO postgres;

--
-- Name: employee_empid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employee_empid_seq OWNED BY public.employee.empid;


--
-- Name: leaves_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.leaves_data (
    leaveid integer NOT NULL,
    empid integer,
    leavetype character varying(20),
    startdate date,
    enddate date,
    reason character varying(100),
    status character varying(20)
);


ALTER TABLE public.leaves_data OWNER TO postgres;

--
-- Name: leaves_data_leaveid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.leaves_data_leaveid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.leaves_data_leaveid_seq OWNER TO postgres;

--
-- Name: leaves_data_leaveid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.leaves_data_leaveid_seq OWNED BY public.leaves_data.leaveid;


--
-- Name: salaryhistory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.salaryhistory (
    salaryid integer NOT NULL,
    empid integer,
    current_salary integer,
    previous_salary integer,
    salary_before_previous integer,
    date_of_change date,
    reason character varying(100)
);


ALTER TABLE public.salaryhistory OWNER TO postgres;

--
-- Name: salaryhistory_salaryid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.salaryhistory_salaryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.salaryhistory_salaryid_seq OWNER TO postgres;

--
-- Name: salaryhistory_salaryid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.salaryhistory_salaryid_seq OWNED BY public.salaryhistory.salaryid;


--
-- Name: department deptid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department ALTER COLUMN deptid SET DEFAULT nextval('public.department_deptid_seq'::regclass);


--
-- Name: employee empid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee ALTER COLUMN empid SET DEFAULT nextval('public.employee_empid_seq'::regclass);


--
-- Name: leaves_data leaveid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leaves_data ALTER COLUMN leaveid SET DEFAULT nextval('public.leaves_data_leaveid_seq'::regclass);


--
-- Name: salaryhistory salaryid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salaryhistory ALTER COLUMN salaryid SET DEFAULT nextval('public.salaryhistory_salaryid_seq'::regclass);


--
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.department (deptid, deptname, deptheadid) FROM stdin;
1	HR	1
2	IT	8
3	Marketing	18
4	Finance	28
5	Executive Board	38
\.


--
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employee (empid, name, dob, doj, designation, contact, deptid, managerid, totalleaves, salary) FROM stdin;
1	Anita Sharma	1980-02-15	2021-07-13	Head	9810000001	1	38	20	95000
2	Ravi Khanna	1985-06-10	2022-03-05	Manager	9810000002	1	1	15	70000
3	Priya Mehta	1990-08-12	2021-05-31	Manager	9810000003	1	1	15	55000
4	Sonal Bhatia	1993-03-22	2024-10-01	Assistant	9810000004	1	2	10	40000
5	Deepak Rao	1992-07-18	2022-10-10	Assistant	9810000005	1	2	10	42000
8	Amit Patel	1981-01-10	2024-12-25	Head	9820000001	2	38	20	120000
9	Vikas Nair	1986-04-18	2022-03-29	Engineer	9820000002	2	8	12	85000
10	Suresh Menon	1988-09-09	2022-11-22	Engineer	9820000003	2	8	12	80000
11	Alok Sinha	1990-06-12	2025-12-16	Engineer	9820000004	2	9	12	65000
12	Nisha Pillai	1992-08-01	2021-03-25	Engineer	9820000005	2	9	12	60000
13	Rohan Gupta	1993-03-10	2021-10-01	Engineer	9820000006	2	10	12	70000
14	Divya Joshi	1994-10-22	2024-02-06	Engineer	9820000007	2	10	12	62000
15	Siddharth Rao	1995-05-16	2022-05-06	Engineer	9820000008	2	10	12	61000
16	Tanya Kapoor	1996-12-12	2021-11-08	Intern	9820000009	2	9	10	30000
17	Rajeev Singh	1997-07-07	2023-11-28	Intern	9820000010	2	10	10	30000
18	Pooja Sethi	1982-03-11	2023-07-22	Head	9830000001	3	38	20	100000
19	Meera Bhatt	1987-07-17	2021-10-15	Executive	9830000002	3	18	12	75000
20	Nikhil Arora	1989-11-11	2022-05-16	Executive	9830000003	3	18	12	72000
21	Riya Sen	1991-09-09	2022-11-26	Executive	9830000004	3	19	12	60000
22	Karan Yadav	1992-10-10	2025-10-03	Executive	9830000005	3	19	12	58000
23	Anjali Rao	1993-12-12	2025-08-23	Executive	9830000006	3	20	12	55000
24	Deepa Malik	1994-06-06	2025-05-15	Executive	9830000007	3	20	12	48000
25	Ashok Pandey	1995-05-05	2024-05-06	Executive	9830000008	3	20	12	30000
26	Vinita Reddy	1996-04-04	2022-03-13	Executive	9830000009	3	19	12	32000
27	Manoj Tiwari	1997-03-03	2024-03-14	Executive	9830000010	3	20	12	30000
28	Ramesh Jain	1983-08-08	2024-10-10	Head	9840000001	4	38	20	110000
29	Sunita Nair	1988-05-05	2024-11-24	Analyst	9840000002	4	28	12	80000
30	Ajay Kumar	1989-10-10	2021-02-27	Analyst	9840000003	4	28	12	75000
31	Bhavna Shah	1990-01-01	2023-05-17	Analyst	9840000004	4	29	12	60000
32	Harish Vyas	1991-02-02	2025-12-16	Analyst	9840000005	4	29	12	58000
33	Seema Chauhan	1992-03-03	2022-02-28	Analyst	9840000006	4	30	12	59000
34	Nitin Goel	1993-04-04	2025-06-24	Analyst	9840000007	4	30	12	52000
35	Ritika Jain	1994-05-05	2023-01-06	Analyst	9840000008	4	30	12	30000
36	Kabir Joshi	1995-06-06	2021-10-02	Analyst	9840000009	4	29	12	30000
37	Neelam Sinha	1996-07-07	2023-12-15	Analyst	9840000010	4	30	12	32000
38	Rajesh Malhotra	1970-01-01	2020-01-01	CEO	9800000000	5	\N	25	200000
6	Meghna Das	1994-11-01	2025-02-10	Trainee	9810000006	1	3	10	35000
7	Kunal Verma	1995-01-20	2021-11-18	Trainee	9810000007	1	3	10	36000
\.


--
-- Data for Name: leaves_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.leaves_data (leaveid, empid, leavetype, startdate, enddate, reason, status) FROM stdin;
80	1	Sick Leave	2024-03-05	2024-03-07	Flu and fever	Approved
81	1	Casual Leave	2025-02-10	2025-02-12	Family function	Approved
82	2	Sick Leave	2022-03-14	2022-03-16	Migraine headaches	Rejected
83	3	Casual Leave	2022-06-18	2022-06-19	Personal work	Approved
84	3	Sick Leave	2025-01-09	2025-01-10	Cold and cough	Approved
85	4	Maternity Leave	2025-10-15	2025-12-15	Childbirth	Approved
86	5	Casual Leave	2025-05-06	2025-05-07	Attending wedding	Pending
87	6	Sick Leave	2025-03-10	2025-03-12	High fever	Approved
88	7	Casual Leave	2022-01-15	2022-01-15	Urgent personal matter	Rejected
89	7	Sick Leave	2023-10-03	2023-10-05	Food poisoning	Approved
90	8	Annual Leave	2025-01-15	2025-01-25	Year-end vacation	Approved
91	9	Casual Leave	2025-03-11	2025-03-13	House moving	Approved
92	10	Sick Leave	2023-04-04	2023-04-05	Flu symptoms	Approved
93	10	Casual Leave	2023-06-14	2023-06-15	Family event	Pending
94	11	Sick Leave	2026-01-20	2026-01-21	Food allergy	Approved
95	12	Casual Leave	2024-03-28	2024-03-29	Attending conference	Approved
96	14	Casual Leave	2024-02-15	2024-02-17	Religious event	Approved
97	15	Sick Leave	2025-02-02	2025-02-04	Flu	Pending
98	16	Sick Leave	2022-04-10	2022-04-11	Cold	Approved
99	17	Casual Leave	2024-06-07	2024-06-08	Wedding	Approved
100	18	Annual Leave	2024-08-01	2024-08-10	Vacation with family	Approved
101	20	Casual Leave	2022-06-20	2022-06-21	Household work	Approved
102	21	Sick Leave	2025-03-10	2025-03-13	Viral infection	Approved
103	22	Annual Leave	2025-11-01	2025-11-06	Holiday trip	Pending
104	23	Casual Leave	2025-09-15	2025-09-17	Personal work	Approved
105	24	Sick Leave	2025-06-04	2025-06-05	Migraine	Approved
106	25	Casual Leave	2024-06-10	2024-06-12	Travel for family	Rejected
107	26	Sick Leave	2022-10-03	2022-10-05	Flu	Approved
108	27	Casual Leave	2024-04-18	2024-04-20	Festival	Approved
109	28	Sick Leave	2025-05-15	2025-05-17	Cold	Approved
110	29	Casual Leave	2025-01-10	2025-01-11	Personal errand	Approved
111	30	Annual Leave	2022-04-05	2022-04-15	Vacation	Approved
112	31	Sick Leave	2024-10-02	2024-10-04	Back pain	Pending
113	32	Casual Leave	2026-01-20	2026-01-21	Family function	Rejected
114	34	Casual Leave	2025-07-20	2025-07-21	Wedding attendance	Approved
115	35	Annual Leave	2025-01-15	2025-01-24	Holiday	Approved
116	36	Sick Leave	2023-11-10	2023-11-11	Cold	Rejected
117	37	Casual Leave	2025-04-10	2025-04-11	Personal work	Approved
118	38	Sick Leave	2022-03-18	2022-03-20	Cold symptoms	Approved
119	1	Casual Leave	2024-06-20	2024-06-21	Power cut at home	Approved
120	2	Sick Leave	2023-08-14	2023-08-15	Stomach ache	Approved
121	3	Casual Leave	2024-09-16	2024-09-16	Bank work	Approved
122	4	Casual Leave	2025-05-22	2025-05-23	Gas connection setup	Approved
123	5	Sick Leave	2023-11-04	2023-11-06	Toothache	Approved
124	6	Casual Leave	2025-06-17	2025-06-17	Plumber visit	Pending
125	7	Sick Leave	2024-07-08	2024-07-09	Headache	Approved
126	8	Annual Leave	2025-01-10	2025-01-15	Out of station trip	Approved
127	9	Casual Leave	2024-04-22	2024-04-23	Home shifting	Approved
128	10	Sick Leave	2024-11-02	2024-11-04	Cold and fever	Approved
129	11	Casual Leave	2025-01-20	2025-01-20	Passport appointment	Approved
130	12	Casual Leave	2023-10-12	2023-10-13	Mobile repair	Approved
131	13	Sick Leave	2024-03-16	2024-03-17	Sprain in leg	Approved
132	14	Casual Leave	2024-07-11	2024-07-12	Driver unavailable	Approved
133	15	Sick Leave	2023-12-06	2023-12-07	Fever and rest	Approved
134	16	Casual Leave	2024-01-18	2024-01-18	Gas delivery	Approved
135	17	Casual Leave	2024-10-03	2024-10-04	Medical check-up	Approved
136	18	Annual Leave	2024-12-01	2024-12-05	Holiday with family	Approved
137	19	Sick Leave	2022-08-02	2022-08-03	Throat infection	Approved
138	20	Casual Leave	2023-05-10	2023-05-10	Cable issue at home	Approved
139	21	Sick Leave	2023-11-11	2023-11-12	Eye irritation	Approved
140	22	Casual Leave	2024-08-20	2024-08-21	Fridge repair	Approved
141	23	Sick Leave	2023-03-28	2023-03-30	Back pain	Approved
142	24	Casual Leave	2025-01-10	2025-01-11	Attending pooja	Approved
143	25	Sick Leave	2024-09-06	2024-09-07	Weakness	Approved
144	26	Casual Leave	2024-02-12	2024-02-12	Guest at home	Approved
145	27	Casual Leave	2025-02-28	2025-03-01	Plumbing issue	Approved
146	28	Sick Leave	2024-06-03	2024-06-04	Ear pain	Approved
147	29	Casual Leave	2024-12-19	2024-12-20	Family function	Approved
148	30	Sick Leave	2023-07-12	2023-07-13	Migraine	Approved
149	31	Casual Leave	2025-02-05	2025-02-06	School meeting	Approved
150	32	Sick Leave	2024-06-01	2024-06-02	Cold	Approved
151	33	Casual Leave	2023-09-05	2023-09-05	Cable installation	Approved
152	34	Sick Leave	2025-03-07	2025-03-08	Food allergy	Approved
153	35	Casual Leave	2023-10-27	2023-10-28	Festival at home	Approved
154	36	Sick Leave	2024-01-09	2024-01-10	Flu	Approved
155	37	Casual Leave	2025-05-12	2025-05-13	Guest reception	Approved
156	38	Sick Leave	2023-02-15	2023-02-16	Back strain	Approved
157	1	Casual Leave	2023-07-03	2023-07-03	Water pipeline issue	Approved
158	2	Sick Leave	2025-04-22	2025-04-23	Neck pain	Approved
159	13	Casual Leave	2025-03-02	2025-03-03	Fever	Approved
160	20	Sick Leave	2023-05-18	2023-05-19	Eye check-up	Approved
161	18	Casual Leave	2023-12-15	2023-12-16	Back pain	Approved
162	5	Annual Leave	2025-04-23	2025-04-23	Water leakage	Approved
163	35	Sick Leave	2024-02-10	2024-02-11	AC maintenance	Approved
164	2	Casual Leave	2023-05-26	2023-05-27	Eye check-up	Pending
165	20	Sick Leave	2024-10-29	2024-10-29	Travel to hometown	Approved
166	37	Sick Leave	2025-06-05	2025-06-05	Family emergency	Pending
167	6	Annual Leave	2023-06-12	2023-06-13	AC maintenance	Approved
168	23	Sick Leave	2024-11-14	2024-11-14	Internet issues	Pending
169	10	Annual Leave	2023-05-22	2023-05-23	Travel to hometown	Pending
170	19	Casual Leave	2024-07-23	2024-07-23	Family emergency	Pending
171	31	Sick Leave	2023-08-20	2023-08-20	Dental appointment	Approved
172	24	Casual Leave	2024-12-18	2024-12-18	AC maintenance	Approved
173	27	Casual Leave	2023-09-07	2023-09-08	Child sick	Pending
174	12	Casual Leave	2023-09-11	2023-09-11	Back pain	Approved
175	4	Casual Leave	2023-06-09	2023-06-09	School admission	Pending
176	27	Annual Leave	2024-02-02	2024-02-03	Headache	Approved
177	21	Annual Leave	2025-02-23	2025-02-24	Plumber visit	Approved
178	17	Annual Leave	2024-10-27	2024-10-28	Sick pet	Approved
179	1	Casual Leave	2025-03-10	2025-03-11	Rain damage repair	Pending
180	34	Sick Leave	2024-03-18	2024-03-19	Eye check-up	Approved
181	3	Casual Leave	2023-12-03	2023-12-04	Electrician work	Approved
182	27	Casual Leave	2025-07-13	2025-07-14	Family emergency	Pending
183	18	Casual Leave	2024-01-03	2024-01-04	Dental appointment	Pending
\.


--
-- Data for Name: salaryhistory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.salaryhistory (salaryid, empid, current_salary, previous_salary, salary_before_previous, date_of_change, reason) FROM stdin;
1	1	95000	87000	78000	2025-02-18	Performance bonus adjustment
2	1	87000	78000	71000	2024-06-26	Annual performance review
3	2	70000	63000	58000	2025-01-15	Team leadership responsibilities
4	2	63000	58000	54000	2024-03-20	Annual increment
5	3	55000	50000	46000	2025-01-05	Promotion to lead role
6	3	50000	46000	42000	2023-12-20	Positive project contribution
7	4	40000	36000	32000	2025-02-25	Moved to full-time role
8	4	36000	32000	30000	2024-03-15	Completion of probation
9	5	42000	37000	33000	2025-01-25	Role expansion
10	5	37000	33000	30000	2023-11-25	Good performance
11	6	35000	32000	29000	2025-05-20	Completed 6-month review
12	6	32000	29000	27000	2024-11-10	Cost of living adjustment
13	7	36000	33000	30000	2024-11-15	Project delivery success
14	7	33000	30000	28000	2023-12-01	First year increment
15	8	120000	110000	100000	2025-03-10	Retained for leadership continuity
16	8	110000	100000	95000	2023-11-01	Excellent quarterly performance
17	9	85000	78000	72000	2025-02-10	High client satisfaction
18	9	78000	72000	68000	2023-12-05	Exceeded KPIs
19	10	80000	73000	68000	2024-09-30	New role with additional responsibility
20	10	73000	68000	64000	2023-11-12	Merit increment
21	11	65000	60000	56000	2025-06-01	Completed major certification
22	11	60000	56000	52000	2024-07-01	Skill upgrade bonus
23	12	60000	54000	50000	2024-05-28	Client praise and retention
24	12	54000	50000	47000	2023-07-15	Role enhancement
25	13	70000	64000	58000	2024-10-01	Mentorship initiative bonus
26	13	64000	58000	53000	2023-08-10	Project delivery success
27	14	62000	57000	52000	2024-08-20	Increased responsibilities
28	14	57000	52000	49000	2023-06-01	Great client feedback
29	15	61000	56000	51000	2025-03-01	Internal promotion
30	15	56000	51000	47000	2023-10-12	Team contribution
31	16	30000	28000	25000	2024-05-18	Internship converted to contract
32	16	28000	25000	23000	2023-03-30	Annual increment
33	17	30000	27000	24000	2024-12-12	Completed 1-year service
34	17	27000	24000	22000	2023-11-01	Performance bonus
35	18	100000	90000	80000	2025-01-01	Strategic project delivery
36	18	90000	80000	75000	2023-09-01	Retained post project success
37	19	75000	68000	62000	2024-11-25	Role upgrade
38	19	68000	62000	58000	2023-05-01	Annual increment
39	20	72000	65000	60000	2024-07-10	Strong team management
40	20	65000	60000	56000	2023-04-10	Exceeded targets
41	21	60000	55000	50000	2025-02-02	Cross-functional team support
42	21	55000	50000	47000	2023-07-07	Consistent delivery
43	22	58000	53000	49000	2025-03-15	Promotion to lead role
44	22	53000	49000	46000	2023-09-28	Completed skill program
45	23	55000	50000	46000	2025-01-08	Great appraisal score
46	23	50000	46000	42000	2023-11-17	Exceeded deadlines
47	24	48000	43000	40000	2024-11-05	Retained after restructuring
48	24	43000	40000	37000	2023-08-14	Positive feedback
49	25	30000	27000	24000	2024-10-10	Completion of 2 years
50	25	27000	24000	22000	2023-06-30	First annual increment
51	26	32000	29000	26000	2024-06-12	Expanded job scope
52	26	29000	26000	24000	2023-06-01	Annual increment
53	27	30000	27000	25000	2025-01-03	Internal training completion
54	27	27000	25000	23000	2023-11-11	Retained with increase
55	28	110000	100000	92000	2025-04-20	Leadership retention
56	28	100000	92000	85000	2023-10-18	Major client onboarding
57	29	80000	74000	68000	2024-09-01	New responsibilities
58	29	74000	68000	63000	2023-07-01	Excellent performance
59	30	75000	68000	61000	2024-06-10	Promoted to senior analyst
60	30	68000	61000	57000	2023-04-25	Strong annual review
61	31	60000	54000	50000	2025-01-20	Top performer reward
62	31	54000	50000	47000	2023-12-10	Regular annual increment
63	32	58000	52000	47000	2025-06-01	New project leadership
64	32	52000	47000	43000	2023-08-30	Recognized contribution
65	33	59000	54000	50000	2024-10-18	Excellent project execution
66	33	54000	50000	46000	2023-06-18	Merit-based raise
67	34	52000	47000	43000	2025-03-25	Increased deliverables
68	34	47000	43000	40000	2023-12-25	Steady performance
69	35	30000	27000	25000	2024-04-10	Annual increment
70	35	27000	25000	23000	2023-02-28	Good performance
71	36	30000	27000	24000	2024-07-15	Maintained excellent attendance
72	36	27000	24000	22000	2023-05-10	Regular review increment
73	37	32000	29000	26000	2025-01-11	Increased workload
74	37	29000	26000	24000	2023-09-09	Consistent performer
75	38	200000	185000	170000	2024-12-01	Board retention bonus
76	38	185000	170000	155000	2023-10-01	Market alignment adjustment
\.


--
-- Name: department_deptid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.department_deptid_seq', 1, false);


--
-- Name: employee_empid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employee_empid_seq', 38, true);


--
-- Name: leaves_data_leaveid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.leaves_data_leaveid_seq', 183, true);


--
-- Name: salaryhistory_salaryid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.salaryhistory_salaryid_seq', 1, false);


--
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (deptid);


--
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (empid);


--
-- Name: leaves_data leaves_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leaves_data
    ADD CONSTRAINT leaves_data_pkey PRIMARY KEY (leaveid);


--
-- Name: salaryhistory salaryhistory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salaryhistory
    ADD CONSTRAINT salaryhistory_pkey PRIMARY KEY (salaryid);


--
-- Name: salaryhistory update_employee_salary_after_insert; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_employee_salary_after_insert AFTER INSERT ON public.salaryhistory FOR EACH ROW EXECUTE FUNCTION public.sync_current_salary();


--
-- Name: employee employee_managerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_managerid_fkey FOREIGN KEY (managerid) REFERENCES public.employee(empid);


--
-- Name: department fk_dept_head; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT fk_dept_head FOREIGN KEY (deptheadid) REFERENCES public.employee(empid);


--
-- Name: leaves_data leaves_data_empid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leaves_data
    ADD CONSTRAINT leaves_data_empid_fkey FOREIGN KEY (empid) REFERENCES public.employee(empid);


--
-- Name: salaryhistory salaryhistory_empid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salaryhistory
    ADD CONSTRAINT salaryhistory_empid_fkey FOREIGN KEY (empid) REFERENCES public.employee(empid);


--
-- PostgreSQL database dump complete
--

