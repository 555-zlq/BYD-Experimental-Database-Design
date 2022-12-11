-- 预处理
drop table if exists brand CASCADE;
drop table if exists models CASCADE;
drop table if exists vehicle CASCADE;
drop table if exists vendor CASCADE;
drop table if exists supply CASCADE;
drop table if exists dealer CASCADE;
drop table if exists customer CASCADE;
drop table if exists sale CASCADE;

create table brand(
  brand_name varchar(255),
  PRIMARY KEY(brand_name)
);


create table models(
  models_name varchar(255),
  brand_name varchar(255),
  models_price int,
  PRIMARY KEY(models_name),
  CONSTRAINT models_brand FOREIGN KEY (models_name) REFERENCES models(models_name) ON DELETE CASCADE  on UPDATE CASCADE
);

create table dealer(
  dealer_name varchar(255),
  dealer_adress varchar(255),
  dealer_level varchar(255) DEFAULT NULL,
  PRIMARY KEY (dealer_name)
);


create table vendor(
  vendor_name varchar(255),
  vendor_address varchar(255),
  PRIMARY KEY(vendor_name)
);

create table vehicle(
  VIN varchar(255),
  engine_displacement decimal(10),
  color varchar(255),
  transmission varchar(255),
  brand_name varchar(255),
  models_name varchar(255),
  dealer_name varchar(255),
  product_date date,
  PRIMARY KEY(VIN),
  CONSTRAINT vehicle_brand FOREIGN KEY (brand_name) REFERENCES brand(brand_name) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT vehicle_models FOREIGN KEY (models_name) REFERENCES models(models_name) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT vehicle_dealer FOREIGN KEY (dealer_name) REFERENCES dealer(dealer_name) ON DELETE RESTRICT on UPDATE RESTRICT
);



create table supply(
  models_name varchar(255),
  vendor_name varchar(255),
  supply_date date,
  part_name varchar(255),
  PRIMARY KEY(models_name, vendor_name, supply_date, part_name),
  CONSTRAINT supply_models FOREIGN KEY (models_name) REFERENCES models(models_name) ON DELETE RESTRICT on UPDATE RESTRICT,
  CONSTRAINT supply_vendor FOREIGN KEY (vendor_name) REFERENCES vendor(vendor_name) on DELETE RESTRICT on  UPDATE RESTRICT
);


create table customer(
  customer_id int,
  customer_name varchar(255),
  customer_address varchar(255),
  customer_sex char(2),
  customer_revenue int,
  customer_phone bigint,
  PRIMARY KEY(customer_id)
);


create table sale(
  sale_id int,
  customer_id int,
  dealer_name varchar(255),
  sale_date date,
  VIN varchar(255),
  PRIMARY KEY(sale_id),
  CONSTRAINT sale_customer FOREIGN KEY (customer_id) REFERENCES customer(customer_id) on DELETE RESTRICT on UPDATE RESTRICT,
  CONSTRAINT sale_dealer FOREIGN KEY (dealer_name) REFERENCES dealer(dealer_name) on DELETE RESTRICT on UPDATE RESTRICT,
  CONSTRAINT sale_vehicle FOREIGN KEY (VIN) REFERENCES vehicle(VIN) on DELETE CASCADE on UPDATE CASCADE
);

-- data for brand
insert into brand values
('汉'),
('唐'),
('秦'),
('宋'),
('元'),
('护卫舰07'),
('海豹'),
('驱逐舰05'),
('海豚'),
('东PLUS');

-- data for models
insert into models(models_name, brand_name, models_price) values

('100KM豪华型', '护卫舰07', 207600),
('100KM尊贵型', '护卫舰07', 220600),
('100KM旗舰型', '护卫舰07', 233600),
('205KM尊贵型','护卫舰07', 250600),
('550km标准续航后驱版精英型', '海豹', 222274),
('550km标准续航后驱版尊贵型', '海豹', 235274),
('700km长续航后驱版', '海豹', 272274),
('650km四驱性能版', '海豹', 298140),
('55KM舒适型','驱逐舰05', 124600),
('55KM豪华型','驱逐舰05', 134600),
('55KM尊贵型','驱逐舰05', 140600),
('120KM尊贵型','驱逐舰05', 146600),
('活力版','海豚', 111315),
('自由版','海豚', 125254),
('时尚版','海豚', 130254),
('骑士版','海豚', 143254),
('尊贵型','东PLUS', 157600),
('尊荣型','东PLUS', 167600),
('旗舰型','东PLUS', 170600),
('旗舰PLUS','东PLUS', 180600),
('715KM尊荣型','汉', 282274),
('715KM旗舰型','汉', 299974),
('610KM四驱尊享型','汉', 299940),
('千山翠限量版','汉', 329800),
('202KM四驱旗舰型','汉', 319800),
('121KM尊贵型','汉', 220600),
('121KM尊荣型','汉', 230600),
('121KM尊享型','汉', 240600),
('242KM旗舰型','汉', 294600),
('标准续航版 豪华型','汉', 226140),
('超长续航版 豪华型','汉', 246140),
('超长续航版 尊贵型','汉', 272140),
('四驱高性能版 旗舰型','汉', 295840),

('215KM四驱尊贵型','唐', 294600),
('215KM四驱尊享型','唐', 309800),
('215KM四驱旗舰型','唐', 329800),



('112KM尊贵型','唐', 210600),
('112KM尊荣型','唐', 227600),
('252KM尊享型','唐', 284600),
('600KM尊享型','唐', 291140),
('730KM尊享型','唐', 309800),
('635KM四驱旗舰型','唐', 339800),




('55KM 尊贵型','秦', 116600),
('55KM 旗舰型','秦', 130600),
('120KM 尊贵型','秦', 140600),
('120KM 旗舰型','秦', 156600),
('400KM 豪华型','秦', 151274),
('500KM 豪华型','秦', 161274),
('500KM 尊贵型','秦', 171274),
('600KM 旗舰型','秦', 188274),


('51KM豪华型','宋', 143600),
('51KM尊贵型','宋', 150600),
('51KM尊荣型','宋', 157600),
('110KM旗舰型','宋', 160600),
('105KM尊荣型','宋', 150600),
('105KM旗舰型','宋', 157600),
('430KM豪华型','元', 150274),
('430KM尊贵型','元', 157274),
('510KM尊荣型','元', 160274),
('510KM旗舰型','元', 170274);

-- data for dealer
-- 经销商太多,选取部分
insert into dealer values
('比亚迪汽车王朝网(成都盛世卓御4S店)', '四川省成都市简阳市简城凯力威工业大道北段厂房栋1层1号', '4S'),
('简阳市智合泰汽车销售服务有限公司', '成都市简阳市凯力威大道北段525号', NULL),
('成都万氏启茂车业有限公司', '成都市天府新区大林街道大林村1组301号', NULL),
('比亚迪汽车海洋网(成都新港建武4S店)','成都市龙泉驿区经开区南二路566号','4S'),
('比亚迪汽车王朝网(成都新港建元4S店)','四川省成都市龙泉驿区经开区南二路566号','4S'),
('比亚迪汽车王朝网（时代远景双流美凯龙商超店','四川省成都市天府新区天府大道2608号L1-1002、1003号', NULL),
('比亚迪汽车王朝网（洲迪金山万达商超店', '上海市金山区万达广场1F-1009A号', NULL),
('比亚迪汽车海洋网(上海叶红你好4S店)','上海市金山区山阳镇南阳港东路438号4幢一、二层','4S'),
('比亚迪汽车海洋网(大兴凯德MALL鑫敏恒鑫华商超店)', '北京市大兴区华佗路2号凯德商场L1-03', NULL),
('比亚迪汽车王朝网(北京鑫敏恒汉青4S店)', '北京市房山区顾八路一区2号院3号楼1层101-1','4S'),
('广东欧亚特汽车销售服务有限公司南沙分公司', '广州市南沙区奥园河璟城AB栋101、102铺', NULL),
('比亚迪汽车海洋网（南沙成荟广场誉国潮商超店','广东省广州市南沙区南沙街进港大道6号', NULL),
('比亚迪汽车海洋网（增城石新路鑫迪城市展厅','广州市增城区新塘镇石新路256号', NULL),
('秀山县美达汽车服务有限公司','重庆市秀山县平凯街道凤栖南路30号', NULL),
('比亚迪汽车王朝网(山西悦迪4S店)','山西省太原市小店区坞城路与康宁街交叉口南150米路西','4S'),
('比亚迪汽车海洋网(小店区道蓝4S店)','山西省太原市小店区坞城南路与太原绕城南环高速交叉口南侧(21站石油对面)','4S');

-- data for vendor
-- 供应商太多,选取部分



insert into vendor(vendor_name, vendor_address) values
('比亚迪','深圳市坪山新区坪山横坪公路3001、3007号'),
('马勒','中国上海市奉贤区环城北路1299号'),
('佛吉亚','辽宁省沈阳经济技术开发区开发二十五号路123号'),
('宁波丰沃','宁波杭州湾新区兴慈七路433号'),
('重庆蓝黛',' 重庆市璧山区璧泉街道剑山路100号 '),
('重庆弗迪','重庆市璧山区青杠街道虎峰大道8号'),
('弗迪科技','吉林省长春市汽车经济技术开发区汽车大路10888号'),
('德赛西威','惠州仲恺高新区和畅五路西103号'),
('科大讯飞','合肥市高新区望江西路666号 '),
('深圳天丽','深圳市龙岗区龙岗街道新生社区井田路13号'),
('镇江汉邦','深圳市南山区创业路现代城华庭2栋29C');

    

-- data for supply
-- 不是实际数据
insert into supply(models_name, vendor_name, supply_date, part_name) values
('715KM尊荣型', '比亚迪', '2022-03-04', '汉DM-2.0T发动机'),
('四驱高性能版 旗舰型', '马勒', '2022-03-05', '汉DM-发动机冷却模块ECM'),
('715KM尊荣型', '佛吉亚', '2021-12-23', '汉DM-排气系统'),
('202KM四驱旗舰型', '宁波丰沃', '2021-04-08', '汉DM-增压器'),
('715KM尊荣型', '重庆弗迪', '2022-02-05', '汉EV-磷酸铁锂刀片电池'),
('610KM四驱尊享型', '比亚迪', '2022-03-06', '汉DM-三元锂电池'),

('100KM豪华型', '比亚迪', '2021-09-14', '驱动电机'),
('100KM尊贵型', '比亚迪', '2022-11-04', '电机控制器 '),
('100KM旗舰型', '比亚迪', '2022-06-04', '电机控制器 '),
('100KM旗舰型', '比亚迪', '2022-05-04', '电机控制器 '),


('骑士版', '弗迪科技', '2021-12-23', '12.3寸液晶仪表'),
('时尚版', '比亚迪', '2022-08-04', 'DiPilot智能驾驶辅助系统'),
('自由版', '比亚迪', '2021-12-27', '电池管理系统(BMS)'),

('千山翠限量版', '重庆蓝黛', '2022-09-04', '混动DCT '),
('120KM尊贵型', '比亚迪', '2022-07-30', '碳化硅电机控制模块 '),
('55KM豪华型', '德赛西威', '2022-06-24', '自动泊车系统 '),

('120KM 旗舰型', '科大讯飞', '2022-05-10', '语音助理3.5'),
('尊贵型', '科大讯飞', '2022-03-09', '语音助理3.5'),
('标准续航版 豪华型', '科大讯飞', '2022-11-16', '语音助理3.5'),
('715KM尊荣型', '科大讯飞', '2022-11-16', '语音助理3.5'),

('610KM四驱尊享型', '深圳天丽', '2021-03-25', '汽车天线'),
('430KM尊贵型', '弗迪科技', '2022-08-21', '空调HVAC总成'),
('500KM 豪华型', '弗迪科技', '2022-10-11', '电动压缩机总成'),
('510KM旗舰型', '镇江汉邦', '2022-11-08', '负离子发生器');

-- data for customer
insert into customer(customer_id, customer_name, customer_address, customer_sex, customer_revenue, customer_phone) values
(201901, '叶文博', '成都', 'M', 6000, 17536099347),
(201902,'李鸿柯', '重庆', 'M', 5500, 17227455232),
(201903,'梅野石', '广州', 'F', 8800,16551914771),
(201904,'李琦', '太原', 'F', 7800, 18694627441),
(201905,'徐胜治', '上海', 'M', 6600, 15550271435),
(201906,'齐守正', '北京', 'M', 9999, 18615306331),
(201907,'李佳奇', '成都', 'M', 5600, 17157062326),
(201908,'乔振华', '上海', 'M', 8888,14732413907),
(201909,'江浩然', '重庆', 'M', 5500, 15382571635),
(2019010,'赵伟', '北京', 'M', 6777,18526016824),
(2019011,'徐达', '广州', 'M', 8800,17859904541);
-- (2019012,'张超', '重庆', 'M', 5500, 18167352756),
-- (2019013,'黄柏慧','重庆', 'F', 5500,13218064854),
-- (2019014,'朱孟然', '上海', 'M', 6600, 18169765588),
-- (2019015,'张东升', '成都', 'M', 6900, 15057281263),
-- (2019016,'李煜', '重庆', 'M', 6666, 18423339991),
-- (2019017,'曾宇然', '成都', 'M', 6000, 18119555968),
-- (2019018,'罗翔', '北京', 'M', 9999,15998544072);


-- date for vehicle 
-- 不是真实数据
insert into vehicle values
('LGXC16DF7C0178765', NULL, '蓝色', NULL, '汉', '715KM尊荣型', '成都万氏启茂车业有限公司', '2022-01-25'),
('LGXC16af5f0144459', NULL, '绿色', NULL, '汉', '千山翠限量版', '比亚迪汽车海洋网(成都新港建武4S店)', '2022-02-25'),
('LGXC16AF2K0043096', 1.5, '黑色', 'EHS电混系统', '唐', '215KM四驱旗舰型', '广东欧亚特汽车销售服务有限公司南沙分公司', '2022-06-25'),
('LGXC16DG1A1025086', NULL, '蓝色', NULL, '秦', '600KM 旗舰型', '比亚迪汽车王朝网(成都新港建元4S店)', '2022-04-25'),
('LGXC72E06JY722961', NULL, '红色', NULL, '宋', '105KM尊荣型', '比亚迪汽车海洋网(上海叶红你好4S店)', '2022-02-25'),
('LGXCB83LXJA004593', 1.5, '黑色', 'EHS电混系统', '元', '510KM尊荣型', '比亚迪汽车王朝网(北京鑫敏恒汉青4S店)', '2022-07-25'),
('LGXCA1BS8G4780383', NULL, '白色', NULL, '护卫舰07', '100KM旗舰型', '比亚迪汽车王朝网(山西悦迪4S店)', '2022-08-25'),
('LGXC71B16N2183172', NULL, '白色', NULL, '海豹', '700km长续航后驱版', '比亚迪汽车王朝网(成都盛世卓御4S店)', '2022-11-25'),
('LGXC656F3NG554475', 1.5, '绿色', 'EHS电混系统', '驱逐舰05', '55KM豪华型', '简阳市智合泰汽车销售服务有限公司', '2022-10-25'),
('LGXCA2157H3630578', 1.5, '银色', 'EHS电混系统', '东PLUS', '旗舰型', '比亚迪汽车海洋网(小店区道蓝4S店)', '2022-05-25'),
('LGXCR8883J5006488', NULL, '白色', NULL, '海豚', '骑士版', '比亚迪汽车海洋网(大兴凯德MALL鑫敏恒鑫华商超店)', '2022-03-25');

-- date for sale
-- 不是真实数据
insert into sale values
(10001, 201901, '成都万氏启茂车业有限公司', '2020-06-06', 'LGXC16DF7C0178765'),
(10002, 201902, '比亚迪汽车海洋网(成都新港建武4S店)', '2020-06-06', 'LGXC16af5f0144459'),
(10003, 201903, '广东欧亚特汽车销售服务有限公司南沙分公司', '2020-06-06', 'LGXC16AF2K0043096'),
(10004, 201904, '比亚迪汽车王朝网(成都新港建元4S店)', '2020-06-06', 'LGXC16DG1A1025086'),
(10005, 201905, '比亚迪汽车海洋网(上海叶红你好4S店)', '2020-06-06', 'LGXC72E06JY722961'),
(10006, 201906, '比亚迪汽车王朝网(北京鑫敏恒汉青4S店)', '2020-06-06', 'LGXCB83LXJA004593'),
(10007, 201907, '比亚迪汽车王朝网(山西悦迪4S店)', '2020-06-06', 'LGXCA1BS8G4780383'),
(10008, 201908, '比亚迪汽车王朝网(成都盛世卓御4S店)', '2020-06-06', 'LGXC71B16N2183172'),
(10009, 201909, '简阳市智合泰汽车销售服务有限公司', '2020-06-06', 'LGXC656F3NG554475'),
(10010, 2019010, '比亚迪汽车海洋网(小店区道蓝4S店)', '2020-06-06', 'LGXCA2157H3630578'),
(10011, 2019011, '比亚迪汽车海洋网(大兴凯德MALL鑫敏恒鑫华商超店)', '2020-06-06', 'LGXCR8883J5006488');




















    
    
    
    
    
    
    
    
    
