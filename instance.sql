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