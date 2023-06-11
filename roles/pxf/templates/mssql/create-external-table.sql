DROP EXTERNAL TABLE IF EXISTS countries;
CREATE EXTERNAL TABLE countries (country_id int, country_name varchar, population float)
LOCATION('pxf://dbo.countries?PROFILE=jdbc&SERVER=default')
FORMAT 'CUSTOM' (formatter='pxfwritable_import');
