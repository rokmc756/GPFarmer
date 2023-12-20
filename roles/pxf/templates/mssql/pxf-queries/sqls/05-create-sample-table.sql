USE testdb;
GO
CREATE TABLE countries (country_id int, country_name varchar(40), population float);
INSERT INTO countries (country_id, country_name, population) values (3, 'Portugal', 10.28);
INSERT INTO countries (country_id, country_name, population) values (24, 'Zambia', 17.86);
GO
USE testdb;
GO
GRANT SELECT, INSERT, UPDATE, DELETE ON countries TO mssqluser;
GO
