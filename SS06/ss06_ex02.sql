create DATABASE banking;
use banking;
create table account(
id int PRIMARY key AUTO_INCREMENT,
name varchar(100),
balance int
);
insert into account(name, balance) values
('linh',1000),
('yen',100),
('huong',100),
('hung',100);


DELIMITER $$
CREATE PROCEDURE check_money( IN id_gui int,IN id_nhan int, IN st int)
BEGIN
START TRANSACTION;
-- Trừ tiền từ tài khoản 1
	UPDATE account
	SET balance = balance - st
	WHERE id = id_gui;
-- Cộng tiền vào tài khoản 2
    UPDATE account
    SET balance = balance + st
    WHERE id = id_nhan;
	-- Nếu khong co tk nhan
IF (SELECT id FROM account WHERE id = id_nhan) = 0 THEN
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'khong co tk nhan';
    ROLLBACK;
    -- Nếu số dư không đủ, hủy giao dịch
ELSEIF (SELECT balance FROM account WHERE id = id_gui) < st THEN
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'số dư không đủ, hủy giao dịch';
	ROLLBACK;
ELSE
    COMMIT;
END IF;
END //
DELIMITER ;

