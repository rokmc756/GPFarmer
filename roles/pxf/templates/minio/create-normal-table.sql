DROP EXTERNAL TABLE IF EXISTS gp_pxf_parquet_s3;
CREATE TABLE gp_pxf_parquet_s3
(
    MONTH0 text,
    CUSTOMER_ID text,
    SERVICE text,
    SERVICE_NUMBER text,
    TYPE_OF_SHAREPLUS__MOBILE_ text,
    SHAREPLUS_PARENT_NUMBER__MOBILE_ text,
    STUDENT_DISCOUNT_COMPONENT__MOBILE_ text,
    CIS_STATUS___SUB__MOBILE_ text,
    HANDSET__MOBILE_ text,
    HUBCLUB_MEMBER text,
    GENDER text,
    RACE text,
    AGE_BAND text,
    RESIDENT_STATUS text,
    ADDRESS_ID___HH text,
    POSTAL_CODE___HH text,
    SMART_CARD_NUMBER text
 )
WITH (appendoptimized=true, compresslevel=5) 
DISTRIBUTED BY (CUSTOMER_ID);
