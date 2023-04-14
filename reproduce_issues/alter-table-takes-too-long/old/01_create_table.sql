create table test.test_column(

column1 text,

column2 text,

...

column70 text,

column71 _numeric,

...

column75 _numeric,

column76 _text,

...

column85 _text

) distributed by (column1,column2,column3)

partition by range(column2)

(partition p202001 start('20200101') end('20200201') with (appendonly=true,compresslevel=7,compresstype=zstd,

...

partition p202303 start('20230301') end('20230401') with (appendonly=true,compresslevel=7,compresstype=zstd
); -- (the table total size is 70TB)


