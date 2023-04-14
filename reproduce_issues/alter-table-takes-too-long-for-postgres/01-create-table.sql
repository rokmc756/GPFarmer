-- Table Creation(This creation query is given just for show you the table structure)
Create table public.test_add_column(
column1 text,
column2 text,
column3 text,
column4 text,
column5 text,
column6 text,
column7 text,
column8 text,
column9 text,
column10 text,
column11 text,
column12 text,
column13 text,
column14 text,
column15 text,
column16 text,
column17 text,
column18 text,
column19 text,
column20 text,
column21 text,
column22 text,
column23 text,
column24 text,
column25 text,
column26 text,
column27 text,
column28 text,
column29 text,
column30 text,
column31 text,
column32 text,
column33 text,
column34 text,
column35 text,
column36 text,
column37 text,
column38 text,
column39 text,
column40 text,
column41 text,
column42 text,
column43 text,
column44 text,
column45 text,
column46 text,
column47 text,
column48 text,
column49 text,
column50 text,
column51 text,
column52 text,
column53 text,
column54 text,
column55 text,
column56 text,
column57 text,
column58 text,
column59 text,
column60 text,
column61 text,
column62 text,
column63 _numeric,
column64 _numeric,
column65 _numeric,
column66 _numeric,
column67 _numeric,
column68 _numeric,
column69 _numeric,
column70 _numeric,
column71 _numeric,
column72 _numeric,
column73 _text,
column74 _text,
column75 _text,
column76 _text,
column77 _text,
column78 _text,
column79 _text,
column80 _text,
column81 _text,
column82 _text,
column83 _text,
column84 _text,
column85 _text
)
partition by range(column1);

-- CREATE TABLE partition_name
-- PARTITION OF main_table_name FOR VALUES FROM (start_value) TO (end_value);

CREATE TABLE p202001 PARTITION OF public.test_add_column FOR VALUES FROM ('20200101') to ('20200125');
CREATE TABLE p202002 PARTITION OF public.test_add_column FOR VALUES FROM ('20200201') to ('20200225');
CREATE TABLE p202003 PARTITION OF public.test_add_column FOR VALUES FROM ('20200301') to ('20200325');
CREATE TABLE p202004 PARTITION OF public.test_add_column FOR VALUES FROM ('20200401') to ('20200425');
CREATE TABLE p202005 PARTITION OF public.test_add_column FOR VALUES FROM ('20200501') to ('20200525');
CREATE TABLE p202006 PARTITION OF public.test_add_column FOR VALUES FROM ('20200601') to ('20200625');
CREATE TABLE p202007 PARTITION OF public.test_add_column FOR VALUES FROM ('20200701') to ('20200725');
CREATE TABLE p202008 PARTITION OF public.test_add_column FOR VALUES FROM ('20200801') to ('20200825');
CREATE TABLE p202009 PARTITION OF public.test_add_column FOR VALUES FROM ('20200901') to ('20200925');
CREATE TABLE p202010 PARTITION OF public.test_add_column FOR VALUES FROM ('20201001') to ('20201025');
CREATE TABLE p202011 PARTITION OF public.test_add_column FOR VALUES FROM ('20201101') to ('20201125');
CREATE TABLE p202012 PARTITION OF public.test_add_column FOR VALUES FROM ('20201201') to ('20201225');
CREATE TABLE p202101 PARTITION OF public.test_add_column FOR VALUES FROM ('20210101') to ('20210125');
CREATE TABLE p202102 PARTITION OF public.test_add_column FOR VALUES FROM ('20210201') to ('20210225');
CREATE TABLE p202103 PARTITION OF public.test_add_column FOR VALUES FROM ('20210301') to ('20210325');
CREATE TABLE p202104 PARTITION OF public.test_add_column FOR VALUES FROM ('20210401') to ('20210425');
CREATE TABLE p202105 PARTITION OF public.test_add_column FOR VALUES FROM ('20210501') to ('20210525');
CREATE TABLE p202106 PARTITION OF public.test_add_column FOR VALUES FROM ('20210601') to ('20210625');
CREATE TABLE p202107 PARTITION OF public.test_add_column FOR VALUES FROM ('20210701') to ('20210725');
CREATE TABLE p202108 PARTITION OF public.test_add_column FOR VALUES FROM ('20210801') to ('20210825');
CREATE TABLE p202109 PARTITION OF public.test_add_column FOR VALUES FROM ('20210901') to ('20210925');
CREATE TABLE p202110 PARTITION OF public.test_add_column FOR VALUES FROM ('20211001') to ('20211025');
CREATE TABLE p202111 PARTITION OF public.test_add_column FOR VALUES FROM ('20211101') to ('20211125');
CREATE TABLE p202112 PARTITION OF public.test_add_column FOR VALUES FROM ('20211201') to ('20211225');
