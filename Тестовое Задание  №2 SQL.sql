create database restaurant;
CREATE TYPE user_status AS ENUM ('active', 'inactive');
create table USERS(
id int Primary key, name Varchar(50), email Varchar(50), age int, status user_status NOT NULL DEFAULT 'active'
);
insert into USERS(id,name,email,age,status ) values
	(1, 'Иван','ivan@test.com',25,'active'),
	(2, 'Ольга','olga@test.com',30,'inactive'),
	(3, 'Сергей','serg@test.com',22,'active'),
	(4, 'Мария','maria@test.com',35,'active');
select * from USERS;	
-- 1.Напиши SQL-запрос для выборки всех активных пользователей старше 25 лет.
select * from USERS where age>25 and status ='active';
--2.Как получить количество неактивных пользователей?
select Count(*) from USERS where status ='inactive';
--3.Какой запрос покажет имена и email всех пользователей, отсортированных по возрасту по убыванию?
select name,email from USERS 
Order by age DESC;
--4.Как бы ты проверил, что при удалении пользователя данные из связанных таблиц (например, orders) тоже удаляются корректно?
CREATE TABLE orders (
    id INT PRIMARY KEY,user_id INT REFERENCES USERS(id) ON DELETE CASCADE,meal VARCHAR(50)
);
insert into orders(id,user_id,meal) values
			(5, 1, 'Пицца'),
			(6, 2, 'Борщ'),
			(7, 3, 'Паста'),
			(8, 4, 'Суши');
select * from orders;
select * from USERS;
DELETE FROM users WHERE id = 1;
SELECT * FROM orders WHERE user_id = 1;
--5.Придумай 2 бага, которые можно было бы найти, проверяя данные через SQL
-- 1. Первый баг который я придумал:Если имя пользователя совпадут с его ID
select * from users where name = id::text;
---- 2. Второй баг который я придумал:Один пользователь сделал слишком много одинаковых заказов
SELECT user_id, COUNT(*) AS total_orders from orders
GROUP BY user_id
HAVING COUNT(*) > 1000;