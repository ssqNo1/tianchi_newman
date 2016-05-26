@ECHO OFF
@ECHO create
sqlite3.exe F:/tianchi_data/fresh.db < train_set_time.sql
sqlite3.exe F:/tianchi_data/fresh.db < f_user_behavior_count_create.sql
@ECHO add
For /L %%i in (1,1,23) do (@ECHO %%i 
sqlite3.exe F:/tianchi_data/fresh.db < f_user_behavior_count_add.sql) 
@ECHO output
sqlite3.exe F:/tianchi_data/fresh.db < f_user_behavior_count_output.sql
pause 