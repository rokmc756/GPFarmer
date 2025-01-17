psql -c "copy (select 'test_table') to '/home/gpadmin/output.csv' (FORMAT CSV, HEADER TRUE, DELIMITER ';', ENCODING 'UTF8')"

# iconv -f UTF-8 to XXX ( other encoding excel uses ) file_names.csv > new_file_names.csv.
