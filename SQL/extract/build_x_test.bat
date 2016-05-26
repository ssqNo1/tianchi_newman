@ECHO OFF
@ECHO build_x_test
@ECHO set time
sqlite3.exe F:/tianchi_data/fresh.db < test_set_time.sql

@ECHO add user_behavior_count
sqlite3.exe F:/tianchi_data/fresh.db < test_set_time.sql
sqlite3.exe F:/tianchi_data/fresh.db < f_user_behavior_count_create.sql
sqlite3.exe F:/tianchi_data/fresh.db < f_user_behavior_count_add.sql
sqlite3.exe F:/tianchi_data/fresh.db < f_user_behavior_count_cut.sql

@ECHO combine_output
sqlite3.exe F:/tianchi_data/fresh.db < test_combine_output.sql
pause 