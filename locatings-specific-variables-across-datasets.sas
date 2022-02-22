options minoperator;

%macro fake_claims;							/*	Begin macro that will create 10 data sets with differing numbers of DX's.			*/

%do yr = 10 %to 20;							/* 	Setting yr macro variable to iterate from 10 (2010) to 20 (2020). 					*/

	%if &yr. in (10 11 12 13 14 15) %then %do;
	data 		work.cc_ot_svc_&yr (drop = i); 	/* 	Below creates the actual data sets.													*/
		array 	dx [2] 3. icd_dgns_cd_1-icd_dgns_cd_2;
		length 	year $4.;
	    do  	pt = 1 to 5000;					/* 	Create a record for each patient													*/
		do		i = 1 to dim(dx);				/* 	Do the following for each diagnosis in the array.									*/
				dx[i] = rand("bernoulli", .4);	/*	Generate a random number between 0 and 1. Just fake placeholders.					*/
				year = catt("20", &yr.);
		end; 									/*	End the <do i = 1 to dim(dx)> do statement											*/
		output;									/* 	Necessary to output information for each patient.									*/
		end;									/*	End the <do pt = 1 to 5000> do statement.											*/
	run;										/* 	Run the data step.																	*/
	%end;
		%else %if &yr. in (16 17 18) %then %do;
			data 		work.cc_ot_svc_&yr (drop = i); 	/* 	Below creates the actual data sets.													*/
				array 	dx [2] 3. icd_prcd_cd_1-icd_prcd_cd_2;
				length 	year $4.;
				
			    do  	pt = 1 to 5000;					/* 	Create a record for each patient													*/
				do		i = 1 to dim(dx);				/* 	Do the following for each diagnosis in the array.									*/
						dx[i] = rand("bernoulli", .4);	/*	Generate a random number between 0 and 1. Just fake placeholders.					*/
						year = catt("20", &yr.);
				end; 									/*	End the <do i = 1 to dim(dx)> do statement											*/
				output;									/* 	Necessary to output information for each patient.									*/
				end;									/*	End the <do pt = 1 to 5000> do statement.											*/    
			run;										/* 	Run the data step.																	*/
		%end;
			%else %do;
                    data 		work.cc_ot_svc_&yr (drop = i); 	/* 	Below creates the actual data sets.													*/
                        array 	dx [2] 3. cpt_1-cpt_2;
                        length 	year $4.;
                        
                        do  	pt = 1 to 5000;					/* 	Create a record for each patient													*/
                        do		i = 1 to dim(dx);				/* 	Do the following for each diagnosis in the array.									*/
                                dx[i] = rand("bernoulli", .4);	/*	Generate a random number between 0 and 1. Just fake placeholders.					*/
                                year = catt("20", &yr.);
                        end; 									/*	End the <do i = 1 to dim(dx)> do statement											*/
                        output;									/* 	Necessary to output information for each patient.									*/
                        end;									/*	End the <do pt = 1 to 5000> do statement.											*/	    
                    run;										/* 	Run the data step.																	*/
            %end;
%end;										/* 	End the %DO processing above.														*/
%mend fake_claims;							/*	End the macro.																		*/
/* Execute the macro */
%fake_claims;

proc sql;
	select
				distinct memname
	from
				dictionary.columns
	where
				upcase(libname) = 'WORK' and upcase(name) contains ('ICD_DGNS');
quit;

proc sql noprint;
	select
				distinct memname
					into: datasets separated by ' '
	from
				dictionary.columns
	where
				upcase(libname) = 'WORK' and upcase(name) contains ('ICD_DGNS');
quit;

%put &datasets.;

%macro extract_icd ();
	%do i = 1 %to %sysfunc(countw(&datasets., " "));
	%let dsn = %scan(&datasets., &i., " ");
	title "10 observations from &dsn.";
		proc sql inobs = 10;
			select
						*
			from
						&dsn.
			where
						icd_dgns_cd_1 = 1 and icd_dgns_cd_2 = 1;
		quit;
	title;
	%end;
%mend extract_icd;

%extract_icd;

proc sql;
	create table	dsn_and_variables as
		select
					memname,
					name
		from
					dictionary.columns
		where
					upcase(libname) = 'WORK' and upcase(name) contains ('ICD_DGNS');
quit;

proc print
	data = dsn_and_variables noobs;
run;
