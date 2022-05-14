data have;
infile datalines delimiter = ',' dsd;
input rx_hdc rx_warf rx_hep rx_gabp rx_qtp rx_nap 3.;
datalines;
1,0,0,0,0,1
0,1,0,0,0,1
0,0,1,0,0,0
0,0,0,1,0,1
0,1,0,0,0,0
0,1,0,0,0,1
0,0,0,0,1,0
0,1,0,0,0,1
0,0,0,0,1,0
;
run;

proc print data = have;
run;

data want_single;
	set have;
	array _rx [*] rx:;
	do i = 1 to dim(_rx);
		if _rx[i] = 1 then prescription = strip(tranwrd(vname(_rx[i]), 'rx_', ''));
	end;
run;

proc print data = want_single;
run;

proc format;
	value $ prescrip
		'hdc' = 'Hydrocodone'
		'hep' = 'Heparin'
		'warf' = 'Warfarin'	
		'gabp' = 'Gabapentin'
		'qtp' = 'Quetiapine'
		'nap' = 'Naproxen';
run;

data want_single_fmt;
	set have;
	array _rx [*] rx:;
	do i = 1 to dim(_rx);
		if _rx[i] = 1 then prescription = put(strip(tranwrd(vname(_rx[i]), 'rx_', '')), $prescrip.);
	end;
run;

proc print data = want_single_fmt;
run;

data have_multiple;
infile datalines delimiter = ',' dsd;
input rx_hdc rx_warf rx_hep rx_gabp rx_qtp rx_nap 3.;
datalines;
1,0,0,0,1,1
0,1,0,0,0,1
0,0,1,0,0,0
0,0,0,1,0,0
0,1,0,1,0,0
0,1,0,0,0,1
0,0,0,0,1,0
0,1,0,1,0,1
0,1,0,0,1,1
;
run;

proc print data = have_multiple;
run;

data want_multiple;
	set have_multiple;
	length combined $100.;
	array _rx [*] rx:;
	do i = 1 to dim(_rx);
		if _rx[i] = 1 then do;
			prescription = put(strip(tranwrd(vname(_rx[i]), 'rx_', '')), $prescrip.);
			combined = catx(', ', combined, prescription);
		end;
	end;
run;

proc print data = want_multiple;
run;
