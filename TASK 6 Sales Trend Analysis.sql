create sequence if not exists ord_seq;
--select nextval('ord_seq');
--select currval('ord_seq');
drop sequence ord_seq;

create table online_sales(
	order_id text not null default('OID'||nextval('ord_seq')),
	order_date date unique,
	amount numeric(10,3),
	product_id int,
	update_date timestamp default now()
);
drop table online_sales;
select * from online_sales;
INSERT INTO online_sales (order_date, amount, product_id) VALUES
('2024-01-15', 250.00, 501),
('2024-01-20', 450.00, 502),
('2024-02-10', 130.00, 503),
('2024-02-15', 200.00, 501),
('2024-03-05', 600.00, 504),
('2024-03-18', 300.00, 502),
('2024-03-25', 220.00, 505),
('2024-04-01', 180.00, 501),
('2024-04-10', 500.00, 506),
('2024-04-20', 350.00, 507),
('2025-01-15', 250.00, 501),
('2025-01-20', 450.00, 502),
('2025-02-10', 130.00, 503),
('2025-02-15', 200.00, 501),
('2025-03-05', 600.00, 504),
('2025-03-18', 300.00, 502),
('2025-03-25', 220.00, 505),
('2025-04-01', 180.00, 501),
('2025-04-10', 500.00, 506),
('2025-04-20', 350.00, 507) returning *;

--upsert
INSERT INTO online_sales (order_date, amount, product_id) VALUES
('2024-01-15', 250.00, 501),
('2024-01-20', 450.00, 502),
('2024-02-10', 130.00, 503),
('2024-02-15', 200.00, 501),
('2024-03-05', 600.00, 504),
('2024-03-18', 300.00, 502),
('2024-03-25', 220.00, 505),
('2024-04-01', 180.00, 501),
('2024-04-10', 500.00, 506),
('2024-04-20', 350.00, 507),
('2025-01-15', 460.00, 501),
('2025-01-20', 862.00, 502),
('2025-02-10', 7412.00, 503),
('2025-02-15', 582.00, 501),
('2025-03-05', 8631.00, 504),
('2025-03-18', 353.00, 502),
('2025-03-25', 2611.00, 505),
('2025-04-01', 782.00, 501),
('2025-04-10', 964.00, 506),
('2025-04-20', 500.00, 507),
('2025-04-21', 1000.00, 506)
	on conflict(order_date)
	do update 
	set amount = excluded.amount,
	update_date = now()
	returning *;

-- Use EXTRACT(MONTH FROM order_date) for month
select 
extract(year from order_date) as year,
extract(month from order_date) as month
	from online_sales;

--distinct
select count(distinct amount) from online_sales;

--GROUP BY, ORDER BY year/month.
select 
	extract(year from order_date) as year,
	extract(month from order_date) as month,
	sum(amount) as monthly_revenue,
	count(distinct order_id) no_of_orders
from online_sales
group by year,month
order by 1,2
limit 3;

