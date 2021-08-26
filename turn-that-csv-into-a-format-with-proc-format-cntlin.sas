data have_pt;
infile datalines delimiter = "," missover;
length enrolid $7. cpt1-cpt10 $5.;
input enrolid cpt1-cpt10;
datalines;
1234567,96020,G0255,96020,,96020,96020,NAAAH,64461
2234567,96105,64446,61150,C9729,COOL,22861
3322112,95999,63655,0169T,NOPE,NOPE,??CPT,IHATE,CPTCD,JUST,JOKIN
4221312,62267,28035,64461,62161,62164,62165
4222145,95965,0434T,0386T,63000,0109T,0437T
;

data have_ccs;
infile datalines delimiter = "," truncover;
input code_range :$15. ccs ccs_label $100.;
datalines;
'61000-61055',1,Incision and excision of CNS
'61105-61106',1,Incision and excision of CNS
'61108-61130',1,Incision and excision of CNS
'61150-61156',1,Incision and excision of CNS
'61250-61315',1,Incision and excision of CNS
'61320-61323',1,Incision and excision of CNS
'61340-61340',1,Incision and excision of CNS
'61345-61440',1,Incision and excision of CNS
'61470-61490',1,Incision and excision of CNS
'61510-61516',1,Incision and excision of CNS
'61518-61530',1,Incision and excision of CNS
'61534-61545',1,Incision and excision of CNS
'61556-61557',1,Incision and excision of CNS
'61570-61576',1,Incision and excision of CNS
'61582-61596',1,Incision and excision of CNS
'61598-61608',1,Incision and excision of CNS
'61615-61616',1,Incision and excision of CNS
'61712-61735',1,Incision and excision of CNS
'61880-61880',1,Incision and excision of CNS
'62161-62164',1,Incision and excision of CNS
'0169T-0169T',2,Insertion, replacement, or removal of extracranial ventricular shunt
'61107-61107',2,Insertion, replacement, or removal of extracranial ventricular shunt
'61210-61210',2,Insertion, replacement, or removal of extracranial ventricular shunt
'62160-62160',2,Insertion, replacement, or removal of extracranial ventricular shunt
'62180-62258',2,Insertion, replacement, or removal of extracranial ventricular shunt
'0202T-0202T',3,Laminectomy, excision intervertebral disc
'0274T-0275T',3,Laminectomy, excision intervertebral disc
'22856-22856',3,Laminectomy, excision intervertebral disc
'22858-22858',3,Laminectomy, excision intervertebral disc
'22861-22861',3,Laminectomy, excision intervertebral disc
'22864-22864',3,Laminectomy, excision intervertebral disc
'61343-61343',3,Laminectomy, excision intervertebral disc
'62287-62287',3,Laminectomy, excision intervertebral disc
'62351-62351',3,Laminectomy, excision intervertebral disc
'62380-63252',3,Laminectomy, excision intervertebral disc
'63655-63655',3,Laminectomy, excision intervertebral disc
'63709-63709',3,Laminectomy, excision intervertebral disc
'63740-63740',3,Laminectomy, excision intervertebral disc
'C9729-C9729',3,Laminectomy, excision intervertebral disc
'G0276-G0276',3,Laminectomy, excision intervertebral disc
'S2348-S2348',3,Laminectomy, excision intervertebral disc
'S2350-S2350',3,Laminectomy, excision intervertebral disc
'S2351-S2351',3,Laminectomy, excision intervertebral disc
'62270-62272',4,Diagnostic spinal tap
'62263-62264',5,Insertion of catheter or spinal stimulator and injection into spinal canal
'62274-62282',5,Insertion of catheter or spinal stimulator and injection into spinal canal
'62288-62289',5,Insertion of catheter or spinal stimulator and injection into spinal canal
'62298-62298',5,Insertion of catheter or spinal stimulator and injection into spinal canal
'62310-62350',5,Insertion of catheter or spinal stimulator and injection into spinal canal
'62355-62355',5,Insertion of catheter or spinal stimulator and injection into spinal canal
'63600-63610',5,Insertion of catheter or spinal stimulator and injection into spinal canal
'63650-63650',5,Insertion of catheter or spinal stimulator and injection into spinal canal
'63657-63688',5,Insertion of catheter or spinal stimulator and injection into spinal canal
'63750-63780',5,Insertion of catheter or spinal stimulator and injection into spinal canal
'64412-64412',5,Insertion of catheter or spinal stimulator and injection into spinal canal
'64416-64416',5,Insertion of catheter or spinal stimulator and injection into spinal canal
'64446-64446',5,Insertion of catheter or spinal stimulator and injection into spinal canal
'64448-64449',5,Insertion of catheter or spinal stimulator and injection into spinal canal
'64461-64484',5,Insertion of catheter or spinal stimulator and injection into spinal canal
'28035-28035',6,Decompression peripheral nerve
'29848-29848',6,Decompression peripheral nerve
'64702-64727',6,Decompression peripheral nerve
'0077T-0077T',7,Other diagnostic nervous system procedures
'0106T-0110T',7,Other diagnostic nervous system procedures
'0199T-0199T',7,Other diagnostic nervous system procedures
'0285T-0285T',7,Other diagnostic nervous system procedures
'0333T-0333T',7,Other diagnostic nervous system procedures
'0341T-0341T',7,Other diagnostic nervous system procedures
'0381T-0386T',7,Other diagnostic nervous system procedures
'0434T-0436T',7,Other diagnostic nervous system procedures
'61140-61140',7,Other diagnostic nervous system procedures
'61750-61751',7,Other diagnostic nervous system procedures
'61795-61795',7,Other diagnostic nervous system procedures
'62267-62267',7,Other diagnostic nervous system procedures
'62269-62269',7,Other diagnostic nervous system procedures
'63690-63690',7,Other diagnostic nervous system procedures
'64795-64795',7,Other diagnostic nervous system procedures
'92516-92516',7,Other diagnostic nervous system procedures
'95857-95872',7,Other diagnostic nervous system procedures
'95874-95882',7,Other diagnostic nervous system procedures
'95885-95943',7,Other diagnostic nervous system procedures
'95965-95982',7,Other diagnostic nervous system procedures
'95999-96003',7,Other diagnostic nervous system procedures
'96020-96020',7,Other diagnostic nervous system procedures
'96105-96115',7,Other diagnostic nervous system procedures
'G0255-G0255',7,Other diagnostic nervous system procedures
'G0453-G0453',7,Other diagnostic nervous system procedures
'S3900-S3900',7,Other diagnostic nervous system procedures
'S3905-S3905',7,Other diagnostic nervous system procedures
'S8040-S8040',7,Other diagnostic nervous system procedures
;

data have_fmt 	    (drop = code_range); /* #1 */
	set have_ccs 	(
                     keep = code_range ccs_label /* #2(a) */
				     rename = (ccs_label = label) /* #2(b) */
                    ) 
				    end = z; /* #2(c) */

	retain fmtname "$cpt_fmt" type "c"; /* #3 */
	start = scan(compress(code_range, "'"), 1, "-"); /* #4 */
	end = scan(compress(code_range, "'"), -1, "-"); /* #5 */

		output; /* #6 */

		if z then do; /* #7 */
			start = ""; /* #7(a) */
			end = ""; /* #7(b) */
			label = "Missing"; /* #7(c) */
			hlo = "O"; /* #7(d) */
			output; /* #7(e) */
		end; /* #7(f) */

run; /* #8 */

proc sql;
	create table 	have_fmt_sql as
		select
					scan(compress(code_range,("'")), 1, "-") as start,
					scan(compress(code_range,("'")), -1, "-") as end,
					ccs_label as label,
					"$cpt_fmt" as fmtname,
					"c" as type,
					"" as hlo
		from
					have_ccs;

	insert into		have_fmt_sql
		values		("", "", "Missing", "$cpt_fmt", "c", "O");

quit; 

proc format
    cntlin = have_fmt;
run;

data have_pt_w_fmt_vars (drop = i); /* #1 */
	set have_pt; /* #2 */
		array _cpt [*] cpt:; /* #3 */
		array _fcpt [10] $100. _fcpt1 - _fcpt10; /* #4 */
		do i = 1 to dim(_cpt); /* #5 */
			_fcpt[i] = put(_cpt[i], $cpt_fmt.); /* #5(a) */
		end; /* #5(b) */
run;

data permanent;
	set have_pt;
	format cpt: $cpt_fmt.;
run;

proc print
    data = have_pt (obs = 10);
    format cpt: $cpt_fmt.;
run;

proc print
    data = have_pt (obs = 10);
run;

proc freq
	data = have_pt;
		tables cpt2 / plots = freqplot;
	format cpt2 $cpt_fmt.;
run;

proc transpose
	data = have_pt
	out = have_pt_tp  (
						rename = (
							col1   = cpt_code 
							_name_ = cpt_position
                        )
					  );
		by enrolid;
			var cpt:;
run;

proc print
	data = have_pt_tp (obs = 15) noobs;
run;



title "CPT codes crosswalked to respective CCS labels";
proc sgplot
	data = have_pt_tp
	;
		hbar cpt_code / 	stat = freq 
							group = cpt_code
							datalabel
							missing
							categoryorder = respdesc
		;
	format cpt_code $cpt_fmt.
	;
run;
title;
