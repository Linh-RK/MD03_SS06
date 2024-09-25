create database ss06_ex01;
use ss06_ex01;
create TABLE users(
id int primary key AUTO_INCREMENT,
name varchar(100),
address varchar(255),
phone varchar(11),
dateOfBirth date,
status bit(1) default 1
);
create TABLE products(
id int primary key AUTO_INCREMENT,
name varchar(100),
price double,
stock int,
status bit(1) default 1
);
create TABLE shopping_card(
id int primary key AUTO_INCREMENT,
user_id int REFERENCES users(id),
product_id int REFERENCES products(id),
quatity int,
amount double
);
insert into users(name,address,phone,dateOfBirth) values 
('linh','tb','0987654321','1993-11-10'),
('huong','hn','0987654321','1993-11-10'),
('hung','bn','0987654321','2001-11-10');
insert into products(name,price,stock) values
('banh',80,100),
('keo',40,100),
('snack',20,100),
('noodle',10,100);
insert into shopping_card(user_id,product_id,quatity,amount) values
(1,1,2,160),
(1,2,1,40),
(2,3,3,60),
(3,1,2,160),
(3,4,2,20);

-- Tạo Trigger khi thay đổi giá của sản phẩm thì amount (tổng giá) cũng sẽ phải cập nhật lại
DELIMITER $$
CREATE TRIGGER change_price
after UPDATE ON products
FOR EACH ROW
BEGIN 
       update shopping_card 
       Set shopping_card.amount = new.price * (select quantity from products where id = new.id)
       where shopping_card.product_id = new.id;
END $$
DELIMITER ;

UPDATE products 
SET price = 30 
WHERE id = 1;

start transaction;
update products 

-- --------------

-- Tạo trigger khi xóa product thì những dữ liệu ở bảng shopping_cart có chứa product bị xóa thì cũng phải xóa theo
DELIMITER $$
CREATE TRIGGER change_class
after UPDATE ON student
FOR EACH ROW
BEGIN 
       update class Set class.total =class.total - 1 where class.c_id =old.c_id ; 
       update class Set class.total =class.total + 1 where class.c_id =new.c_id ;
END $$
DELIMITER ;

-- Khi thêm một sản phẩm vào shopping_cart với số lượng n thì bên product cũng sẽ phải trừ đi số lượng n
DELIMITER $$
CREATE TRIGGER change_class
after UPDATE ON student
FOR EACH ROW
BEGIN 
       update class Set class.total =class.total - 1 where class.c_id =old.c_id ; 
       update class Set class.total =class.total + 1 where class.c_id =new.c_id ;
END $$
DELIMITER ;