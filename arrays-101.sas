/* Sample data */

data work.patients;
  infile datalines dsd truncover;
  input enrolid:3. dx1:$7. dx2:$7. dx3:$7. dx4:$7.;
datalines4;
2,A821,E133519,F1194,E133299
4,E75241,E731,E088,E083291
4,E75241,A5139,E088,E083291
5,E0810,A5139,E133291,A710
5,E0810,A360,E133291,A710
6,A3790,A4289,A5041,F19121
7,F810,A4289,A5041,A300
7,F810,E083291,A5041,A300
7,F810,E083291,A5041,E103591
8,E531,A4150,A5041,E103591
8,E531,A4150,A5433,F0630
9,A5275,F04,A5433,F0630
10,E853,A231,E781,A5139
11,F554,A5423,E13641,A5139
12,E848,A5423,E13641,E7881
12,E848,E75240,E13641,E7881
13,A663,E000,F19980,A5423
15,F11129,A3790,A5433,E75240
15,F11129,A3790,A5433,E731
16,A3700,A3790,A5433,E731
16,A3700,E133519,E13641,E0939
17,A5139,E133519,E13641,E0939
18,E030,F524,A231,A1859
20,A5002,E7500,A3952,F18951
20,A5002,F13280,A839,F18951
21,F524,F13280,A839,E089
22,F11129,E1137X9,A5041,E103219
25,A4289,E71313,F1293,A218
25,A4289,E71313,F04,A218
27,A5139,E030,A5209,E103219
27,A5139,F0781,A5209,E103219
30,E28319,F13232,A5209,F812
31,E08311,F13232,A5209,F1821
32,F13280,A5139,E731,A5209
32,F13280,A5402,A5275,A218
33,E103591,A5402,A5275,A218
33,E103591,F554,A5275,A218
33,E103591,F554,E093499,F18951
34,E13641,F521,E093499,F18951
35,E1137X9,F810,E133519,E093541
36,A5002,F554,E133519,F11288
38,A523,F15980,F13181,A5139
44,E853,E731,A5423,F1194
45,E0939,F1194,E0939,E133299
45,E0939,F521,E0939,E133299
46,A300,F521,A4150,F19121
46,A300,A199,E103591,E211
47,F13181,A199,E103591,E211
47,F13181,E58,E030,F19980
49,A3700,E853,F19980,F0781
;;;;

/* What diagnoses are we looking at? */

data work.patients_with_labels;
	set work.patients;
	format dx1 - dx4 $icd_fmt.;
run;

/* The naive method - DATA step */

data patients_data_naive;
	set work.patients;
	length opioid_flag 3.;
		if dx1 = "F1194" or dx2 = "F1194" or dx3 = "F1194" or dx4 = "F1194" then opioid_flag = 1;
			else opioid_flag = 0;
run;

/*  The naive method - PROC SQL */

proc sql;
	create table	work.patients_sql_naive as
		select
					*,
					case
						when dx1 = "F1194" or dx2 = "F1194" or dx3 = "F1194" or dx4 = "F1194" then 1
						else 0
					end as opioid_flag length = 3
		from
					work.patients;
quit;

/* An array with an explicit subscript and explicit variables */

data work.patients_expl_array;
	set work.patients;
	length opioid_flag 3.;
	array _icd [4] dx1 - dx4;
		opioid_flag = 0;
	do i = 1 to 4;
		if _icd[i] = "F1194" then opioid_flag = 1;
	end;
	drop i;
run;

/* An array with an implicit subscript and implicit variables */

data work.patients_impl_array;
	set work.patients;
	length opioid_flag 3.;
	array _icd [*] dx:;
		opioid_flag = 0;
	do i = 1 to dim(_icd);
		if _icd[i] = "F1194" then opioid_flag = 1;
		leave;
	end;
	drop i;
run;

/* An array with multiple diagnoses */

data work.patients_array_mult_dx;
	set work.patients;
	length diabetes_flag 3.;
	array _icd [*] dx:;
		diabetes_flag = 0;
	do i = 1 to dim(_icd);
		if _icd[i] in ("E08311", "E088") then diabetes_flag = 1;
		leave;
	end;
	drop i;
run;

/* Using the in: operator as a shortcut */

data work.patients_array_mult_dx_in;
	set work.patients;
	length diabetes_flag 3.;
	array _icd [*] dx:;
		diabetes_flag = 0;
	do i = 1 to dim(_icd);
		if _icd[i] in: ("E08") then diabetes_flag = 1;
		leave;
	end;
	drop i;
run;
