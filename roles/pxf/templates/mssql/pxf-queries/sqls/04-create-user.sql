USE testdb;
GO
CREATE LOGIN mssqluser WITH PASSWORD = 'Changeme!@#$';
GO
CREATE USER mssqluser FOR LOGIN mssqluser;
GO
GRANT ALL ON database::testdb TO mssqluser;
GO
