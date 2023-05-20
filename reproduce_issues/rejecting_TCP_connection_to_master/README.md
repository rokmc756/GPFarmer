[1] From client on first terminal
$ psql -h mdw -p 5432
# create table test_table(a int) distributed by (a);
# insert into test_table values (generate_series(1,100000000));

[2] From other client on second terminal
# Select the data from the table you created and reboot the client host to simulate the network communication failure.
$ nohup psql -h mdw -U gpadmin -p 5432 -c "select * from test_table" &
$ nohup: ignoring input and appending output to ‘nohup.out’
$ sleep 5; reboot

