/*	-------------------------------------------------------------------	*/
/* 	TITLE: 																*/
/*			Shared Columns Macro										*/
/* 	AUTHOR: 															*/
/*			Michael Q. Maguire, MS										*/
/* 	PURPOSE: 															*/
/*			This macro identifies shared columns between				*/
/* 			two datasets.												*/
/* 	STAGE:																*/
/*			Functional/Development. Attempting to extend for more		*/
/*			than two datasets in `tables` argument.						*/
/* 	MACRO:																*/
/*			%shared_cols(tables, lib_dsn_out)							*/
/*	ARGUMENTS:															*/
/*			`tables`: 													*/
/*						What datasets are you comparing?				*/
/*																		*/
/*						Requirements:									*/
/*							(1) LIBNAME and dataset name				*/
/*								for each dataset.						*/
/*							(2) A pipe (|) separating each				*/
/*								LIBNAME and dataset.					*/
/*						Example:										*/
/*							%shared_cols(sashelp.cars|sashelp.class);	*/
/*																		*/
/*			`lib_dsn_out` (optional):									*/
/*																		*/
/*						Do you want to output a dataset of the shared	*/
/*						columns?										*/
/*						If you do not want a dataset, leave this null.	*/
/*																		*/
/*						Requirements:									*/
/*							(1)	LIBNAME and dataset name for output.	*/
/*																		*/
/*						Example:										*/
/*							%shared_cols(								*/
/*								sashelp.cars|sashelp.class,				*/
/*								work.common_columns						*/
/*							);											*/
/*	OUTPUT:																*/
/*		(1) An HTML listing of the following:							*/
/*			(a) The shared column name.									*/
/*			(b) The column type of the variable in each dataset.		*/
/*			(c) The length of each variable in each dataset.			*/
/*			(d) The label of each variable in each dataset.				*/
/*			(e) The format of each varaible in each dataset.			*/
/*			(f) The informat of each varaible in each dataset.			*/
/*																		*/
/* 	NOTES: 																*/
/*		This macro is still being developed. Additional extensions		*/
/*		will come in the future. You are using this macro at your own	*/
/*		discretion. Limited error detection has been programmed into	*/
/*		the macro, but other errors may occur.							*/
/*	-------------------------------------------------------------------	*/
										
%macro shared_cols (tables, lib_dsn_out);

/* Check for pipe separation in `tables` */
%if %sysfunc(find(&tables., |)) = 0 %then %do;
	%put ERROR: No pipe specified to separate datasets. Please place a pipe between your datasets in the `tables` argument.;
	%return;
%end;

/* Check to see if files exists */
%if %sysfunc(exist(%scan(&tables., 1, |))) = 0 & %sysfunc(exist(%scan(&tables., -1, |))) = 0 %then %do;
	%put ERROR: Neither file exists. Please ensure that you have used libnames and datasets in the `tables` argument.;
	%return;
%end;
	/* Check to see if first dataset exists */
	%else %if %sysfunc(exist(%scan(&tables., 1, |))) = 0 %then %do;
		%put ERROR: The file %scan(&tables., 1, |) does not exist. Please ensure that you have specified a LIBNAME along with the dataset name (e.g., work.dataset).;
		%return;
	%end;
	/* Check to see if second dataset exists */
	%else %if %sysfunc(exist(%scan(&tables., -1, |))) = 0 %then %do;
		%put ERROR: The file %scan(&tables., -1, |) does not exist. Please ensure that you have specified a LIBNAME along with the dataset name (e.g., work.dataset).;
		%return;
	%end;

/* Initiate local macro variables that exist within scope of macro call */
%local ln1 mn1 ln2 mn2 sc;

/* Extract libname of first dataset */
%let ln1 = %upcase(%scan(%scan(&tables., 1, |), 1, .));
/* Extract dataset name of first dataset */
%let mn1 = %upcase(%scan(%scan(&tables., 1, |), -1, .));
/* Extract libname of second dataset */
%let ln2 = %upcase(%scan(%scan(&tables., -1, |), 1, .));
/* Extract dataset name of second dataset */
%let mn2 = %upcase(%scan(%scan(&tables., -1, |), -1, .));

/* Check to see if there are shared columns */
proc sql noprint;
	select
				count(t1.name) 
					into: sc trimmed
	from
				dictionary.columns as t1
					inner join
				dictionary.columns as t2
						on	t1.name = t2.name
		where
					t1.libname = "&ln1." 	and
					t1.memname = "&mn1."	and
					t2.libname = "&ln2."	and
					t2.memname = "&mn2.";
quit;

/* If no variables match, send warning to log and exit the macro */
%if &sc. = 0 %then %do;
	%put WARNING: %upcase(%scan(&tables., 1, |)) and %upcase(%scan(&tables., -1, |)) did not share any columns.;
	%return;
%end;

/* Extract shared variable and each attribute of that column in both datasets. */
proc sql;
	/* If there are shared columns and a dataset is requested, create the dataset in the desired library */
%if &sc. ~=  0 & %length(&lib_dsn_out.) > 0 %then %do;
	create table 	
					&lib_dsn_out. as
		select
					t1.name as t1_name label = "Name in: %scan(&tables., 1, |)",
					t1.type as t1_type label = "Type in: %scan(&tables., 1, |)",
					t2.type as t2_type label = "Type in: %scan(&tables., -1, |)",
					t1.length as t1_length label = "Length in: %scan(&tables., 1, |)",
					t2.length as t2_length label = "Length in: %scan(&tables., -1, |)",
					t1.label as t1_label label = "Label in: %scan(&tables., 1, |)",
					t2.label as t2_label label = "Label in: %scan(&tables., -1, |)",
					t1.format as t1_format label = "Format in: %scan(&tables., 1, |)",
					t2.format as t2_format label = "Format in: %scan(&tables., -1, |)",
					t1.informat as t1_informat label = "Informat in %scan(&tables., 1, |)",
					t2.informat as t2_informat label = "Informat in %scan(&tables., -1, |)"					
		from
					dictionary.columns as t1
						inner join
					dictionary.columns as t2
							on	t1.name = t2.name
		where
					t1.libname = "&ln1." 	and
					t1.memname = "&mn1."	and
					t2.libname = "&ln2."	and
					t2.memname = "&mn2.";

		title "Shared Columns between %upcase(%scan(&tables., 1, |)) [t1] and %upcase(%scan(&tables., -1, |)) [t2]";
		select 
					*
		from
					&lib_dsn_out.;
		title;

%end;
	/* Otherwise, just print the results. */
	%else %do;

		title "Shared Columns between %upcase(%scan(&tables., 1, |)) [t1] and %upcase(%scan(&tables., -1, |)) [t2]";
		select
					t1.name as t1_name label = "Name in: %scan(&tables., 1, |)",
					t1.type as t1_type label = "Type in: %scan(&tables., 1, |)",
					t2.type as t2_type label = "Type in: %scan(&tables., -1, |)",
					t1.length as t1_length label = "Length in: %scan(&tables., 1, |)",
					t2.length as t2_length label = "Length in: %scan(&tables., -1, |)",
					t1.label as t1_label label = "Label in: %scan(&tables., 1, |)",
					t2.label as t2_label label = "Label in: %scan(&tables., -1, |)",
					t1.format as t1_format label = "Format in: %scan(&tables., 1, |)",
					t2.format as t2_format label = "Format in: %scan(&tables., -1, |)",
					t1.informat as t1_informat label = "Informat in %scan(&tables., 1, |)",
					t2.informat as t2_informat label = "Informat in %scan(&tables., -1, |)"					
		from
					dictionary.columns as t1
						inner join
					dictionary.columns as t2
							on	t1.name = t2.name
		where
					t1.libname = "&ln1." 	and
					t1.memname = "&mn1."	and
					t2.libname = "&ln2."	and
					t2.memname = "&mn2.";
		title;

		%end;

quit;

/* End macro */
%mend shared_cols;

/* No dataset requested */
%shared_cols(sashelp.heart|sashelp.heart);

/* Dataset requested */
%shared_cols(sashelp.heart|sashelp.class);
