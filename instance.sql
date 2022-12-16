-- 假设发现供应商“佛吉亚”在2021年12月之间生产的排气系统存在缺陷。
-- 找到每辆装有这种排气系统的汽车的车辆识别号（VIN）以及向其销售的客户(姓名+电话)

select VIN, customer_name, customer_phone from 
vehicle natural join sale natural join customer
where VIN in 
(select VIN from vendor natural join supply natural join models natural join vehicle
where vendor_name = '佛吉亚' and supply_date >= '2021-12-01' and supply_date <= '2022_12_31' and part_name like '%排气系统%');
 


-- 按销售金额找出销售最好的前两大车型

create view total_sales as
select models_name, sum(models_price) models_total_sales
from sale natural join vehicle natural join models
group by models_name
order by models_total_sales desc;

select  * from total_sales limit 2;



-- 按销售数量找出销售最好的前两大品牌

create view total_nums as
select brand_name, count(brand_name) brand_total_names
from sale natural join vehicle 
group by brand_name
order by brand_total_names desc;

select * from total_nums limit 2;


-- 什么颜色的车卖的最好

create view total_color_nums as
select color, count(*) color_count from sale natural join vehicle
group by color
order by color_count desc;

select * from total_color_nums limit 2;


-- 品牌'汉'的车在哪个月卖的最好
create view best_sale_month as
select to_char(sale_date, 'YYYY-MM') date1, count(*) 
from sale natural join vehicle
where brand_name = '汉'
group by date1
order by count(*);

select * from best_sale_month limit 1;

-- 实现简单的权限控制
create role customers identified by 'kunpeng@1234';
create role vendors identified by 'kunpeng@1234';
create role dealers identified by 'kunpeng@1234';
create user yewenbo identified by 'kunpeng@1234';
create user liqi identified by 'kunpeng@1234';
create user fojiya identified by 'kunpeng@1234';
create user kedaxunfei identified by 'kunpeng@1234';
create user chengdu identified by 'kunpeng@1234';
create user shanghai identified by 'kunpeng@1234';

-- 授予角色连接权限
alter role customers login;
alter role vendors login;
alter role dealers login;

-- 授予角色对模式的使用权限
grant usage on schema zhangliqun to customers, vendors, dealers;
grant usage on schema zhangliqun to yewenbo, liqi;
grant usage on schema zhangliqun to fojiya, kedaxunfei;
grant usage on schema zhangliqun to chengdu, shanghai;

-- 授予角色控制权限
grant select on table vehicle, brand, models, dealer, customer to customers;
grant update on table customer to customers;
grant select on table models, supply, vendor to vendors;
grant update on table supply, vendor to customers;
grant select on table vehicle, customer,  dealer, sale to dealers;
grant update on table sale, dealer to dealers;

-- 将用户添加到角色组
grant customers to yewenbo, liqi;
grant vendors to fojiya, kedaxunfei;
grant dealers to chengdu, shanghai;

-- 测试 
\c zhangliqundb yewenbo
select * from customer;
select * from sale;
update customer set customer_phone = 19135008746 where customer_name = '叶文博';
update sale set customer_id = 1009;