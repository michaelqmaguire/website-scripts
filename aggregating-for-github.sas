proc sql;
	create table 	invoice_by_make_sql as
		select
					make,
					sum(invoice) as total_invoice format = dollar16.
		from
					sashelp.cars
		group by
					make;
quit;

/* Playing with `WAYS` statement. */

proc means
	data = sashelp.cars
	noprint;
	ways 0;
		class make;
		var invoice;
			output out = invoice_by_make_pm_w0
				sum(invoice) = sum;
run;

/* Use `NWAY` to get all max number of classifications based on `CLASS` statement. */
/* Also, explicitly name the variable being summarized */

proc means
	data = sashelp.cars
	noprint
	nway;
		class make;
		var invoice;
			output out = invoice_by_make_pm_1
				sum(invoice) = sum_invoice;
run;

/* Alternatively, you can use some shorthand techniques. */

proc means
	data = sashelp.cars
	noprint
	nway;
		class make;
		var invoice;
			output out = invoice_by_make_pm_2
				sum = / autoname;
run;

/* Specifying more `CLASS` statements. */

proc means
	data = sashelp.cars
	noprint
	nway;
		class make cylinders;
		var invoice;
			output out = invoice_by_make_cylinders_pm
				sum = / autoname;
run;

/* Calculating multiple summary statistics. */

proc means
	data = sashelp.cars
	noprint
	nway;
		class make;
		var invoice;
			output out = invoice_multiple_stats
				sum = 
				mean = 
				median = 
				q1 = 
				q3 = / autoname;
run;
