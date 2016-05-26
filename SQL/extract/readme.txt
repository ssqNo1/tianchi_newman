--使用说明


--提取训练集特征：
先依次运行 “f_特征名.bat”，生成相应特征文件到 F:\tianchi_data\feature\feature_train
再运行 “build_x_train.bat” ，合并所有特征，生成 x_train.csv 到 F:\tianchi_data\feature
如果要选择组合的特征请修改 “build_x_train.bat”

--提取测试集特征：
运行 “build_x_test.bat” ，生成 x_test.csv 到 F:\tianchi_data\feature
如果要选择组合的特征请修改 “build_x_test.bat”

--提取训练集标签：
运行 “build_y_train.bat” ，生成 y_train.csv 到 F:\tianchi_data\feature

--线上测试（考察日是2014-12-19）
1、更改测试集
修改 “test_set_time.sql” 中的时间为 “2014-12-19”
重新提取测试集特征
2、增加训练集（可选）

3、用python重新训练、预测
