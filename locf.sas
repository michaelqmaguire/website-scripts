data have;
infile datalines delimiter = ",";
input year_qtr :yymmn6. state $ num_dspnd;
format year_qtr yymmd7.;
datalines;
201701,FL,24780
201703,FL,24974
201704,FL,24131
201801,FL,23774
201802,FL,23040
201804,FL,19439
201901,FL,15716
201902,FL,15465
201903,FL,14450
202001,FL,13568
202002,FL,13758
202003,FL,14148
202004,FL,14181
201702,IL,17816
201703,IL,17129
201704,IL,16488
201801,IL,15597
201802,IL,17375
201803,IL,17781
201804,IL,17639
201901,IL,17290
201902,IL,17223
201903,IL,17334
201904,IL,16837
202001,IL,16138
202002,IL,15922
202003,IL,16790
202004,IL,9673
;
run;

proc print data = have (obs = 10) noobs;
run;

proc freq data = have noprint;
	tables year_qtr * state / list sparse out = have_1 (drop = percent count);
run;

proc print data = have_1 (obs = 10) noobs;
run;

proc sort data = have_1;
	by state year_qtr;
run;

data want;
	merge have have_1;
	by state year_qtr;
run;

proc print data = want (obs = 10) noobs;
run;

data want;
	merge have have_1;
	by state year_qtr;
	retain num_dspnd_final;
		if first.state then call missing(num_dspnd_final);
		if not missing(num_dspnd) then num_dspnd_final = num_dspnd;
run;

proc print data = want (obs = 10) noobs;
run;

data test;
input id var;
datalines;
1 2
1 .
1 .
1 .
1 4
1 .
1 .
2 3
2 .
2 5
3 1
;
run;

data test_final;
	set test;
	by id;
	retain locf;
		if first.id then call missing(locf);
		if not missing(var) then locf = var;
run;

proc print data = test_final noobs;
run;
