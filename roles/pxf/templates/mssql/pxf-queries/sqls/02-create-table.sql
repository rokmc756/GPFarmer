USE testdb;
GO
CREATE TABLE dbo.Inventory (
   id INT, name NVARCHAR(50),
   quantity INT
);

INSERT INTO dbo.Inventory VALUES (1, 'banana', 150);
INSERT INTO dbo.Inventory VALUES (2, 'orange', 154);

SELECT * FROM dbo.Inventory WHERE quantity > 152;
GO
