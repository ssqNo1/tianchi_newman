@ECHO OFF

@ECHO combine_output
sqlite3.exe F:/tianchi_data/fresh.db < train_combine_output.sql
pause 