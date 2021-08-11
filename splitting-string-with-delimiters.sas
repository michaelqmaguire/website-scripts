data have;
infile datalines delimiter = "|" truncover;
input id string $100.;
datalines;
1|Gabapentin,Escitalopram,Fluoxetine
2|Solotol Hydrochloride
3|Hydrocodone,Neurontin,Topamax,Carbamazepine
;

data want;
	set have;
	do i = 1 to countw(string, ",");
		drug = scan(string, i, ",");
		output;
	end;
run;

proc print
	data = want noobs;
run;

proc transpose
	data = want
	out = want_tp (drop = _name_)
	prefix = drug;
		by id;
		var drug;
run;

proc print
	data = want_tp noobs;
run;