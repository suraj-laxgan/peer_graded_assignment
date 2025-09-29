-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema littlelemoncapstonedb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema littlelemoncapstonedb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `littlelemoncapstonedb` DEFAULT CHARACTER SET utf8mb3 ;
USE `littlelemoncapstonedb` ;

-- -----------------------------------------------------
-- Table `littlelemoncapstonedb`.`book_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemoncapstonedb`.`book_table` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `sit_capacity` INT NOT NULL,
  `avilable_status` INT NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemoncapstonedb`.`castomers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemoncapstonedb`.`castomers` (
  `castomer_id` INT NOT NULL,
  `castomer_name` VARCHAR(45) NOT NULL,
  `castomer_phon_no` VARCHAR(45) NOT NULL,
  `castomer_email` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`castomer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemoncapstonedb`.`staffs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemoncapstonedb`.`staffs` (
  `staff_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  `address` VARCHAR(300) NOT NULL,
  `phone_no` INT NOT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `salary` DECIMAL(10,0) NULL DEFAULT NULL,
  PRIMARY KEY (`staff_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemoncapstonedb`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemoncapstonedb`.`bookings` (
  `booking_id` INT NOT NULL AUTO_INCREMENT,
  `book_table_id` INT NOT NULL,
  `booking_date` TIMESTAMP NOT NULL,
  `book_by_casotmer_id` INT NOT NULL,
  `assign_to_staff_id` INT NULL DEFAULT '0',
  PRIMARY KEY (`booking_id`),
  INDEX `table_id_fk_idx` (`book_table_id` ASC) VISIBLE,
  INDEX `castomer_id_fk_idx` (`book_by_casotmer_id` ASC) VISIBLE,
  INDEX `staff_fk_idx` (`assign_to_staff_id` ASC) VISIBLE,
  CONSTRAINT `castomer_id_fk`
    FOREIGN KEY (`book_by_casotmer_id`)
    REFERENCES `littlelemoncapstonedb`.`castomers` (`castomer_id`),
  CONSTRAINT `staff_fk`
    FOREIGN KEY (`assign_to_staff_id`)
    REFERENCES `littlelemoncapstonedb`.`staffs` (`staff_id`),
  CONSTRAINT `table_id_fk`
    FOREIGN KEY (`book_table_id`)
    REFERENCES `littlelemoncapstonedb`.`book_table` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemoncapstonedb`.`menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemoncapstonedb`.`menu` (
  `menu_id` INT NOT NULL AUTO_INCREMENT,
  `menu_name` VARCHAR(45) NOT NULL,
  `menu_type` VARCHAR(45) NOT NULL,
  `price` DECIMAL(10,0) NOT NULL,
  PRIMARY KEY (`menu_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemoncapstonedb`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemoncapstonedb`.`orders` (
  `orders_id` INT NOT NULL AUTO_INCREMENT,
  `menu_id` INT NOT NULL,
  `booking_id` INT NOT NULL,
  `quantity` CHAR(45) NOT NULL,
  `price` DECIMAL(10,0) NULL DEFAULT NULL,
  `order_date` TIMESTAMP NOT NULL,
  PRIMARY KEY (`orders_id`),
  INDEX `booking_fk_idx` (`booking_id` ASC) VISIBLE,
  INDEX `menu_fk_idx` (`menu_id` ASC) VISIBLE,
  CONSTRAINT `booking_fk`
    FOREIGN KEY (`booking_id`)
    REFERENCES `littlelemoncapstonedb`.`bookings` (`booking_id`),
  CONSTRAINT `menu_fk`
    FOREIGN KEY (`menu_id`)
    REFERENCES `littlelemoncapstonedb`.`menu` (`menu_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemoncapstonedb`.`order_delivary_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemoncapstonedb`.`order_delivary_status` (
  `order_delivary_status_id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `order_delivary_status` BLOB NOT NULL,
  PRIMARY KEY (`order_delivary_status_id`),
  INDEX `order_id_fk_idx` (`order_id` ASC) VISIBLE,
  CONSTRAINT `order_id_fk`
    FOREIGN KEY (`order_id`)
    REFERENCES `littlelemoncapstonedb`.`orders` (`orders_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

USE `littlelemoncapstonedb` ;

-- -----------------------------------------------------
-- Placeholder table for view `littlelemoncapstonedb`.`orderdetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemoncapstonedb`.`orderdetails` (`orders_id` INT, `booking_id` INT, `menu_name` INT, `price` INT, `quantity` INT, `Total_Price` INT, `table_name` INT, `castomer_name` INT, `name` INT);

-- -----------------------------------------------------
-- Placeholder table for view `littlelemoncapstonedb`.`ordersview`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemoncapstonedb`.`ordersview` (`orders_id` INT, `quantity` INT, `price` INT);

-- -----------------------------------------------------
-- procedure AddBooking
-- -----------------------------------------------------

DELIMITER $$
USE `littlelemoncapstonedb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddBooking`(
    IN p_booking_date DATE,
    IN p_table_no INT,
    IN p_customer_id INT,
    IN p_staff_id INT
)
BEGIN
    INSERT INTO bookings (booking_date,book_table_id,book_by_casotmer_id,assign_to_staff_id)
    VALUES (p_booking_date, p_table_no, p_customer_id, p_staff_id); 
    SELECT "New Booking is Added" AS 'Confirmation';      
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddValidBooking
-- -----------------------------------------------------

DELIMITER $$
USE `littlelemoncapstonedb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddValidBooking`(
    IN p_booking_date DATE,
    IN p_table_no INT,
    IN p_customer_id INT,
    IN p_staff_id INT
)
BEGIN
    DECLARE v_exists INT DEFAULT 0;
    START TRANSACTION;
    SELECT COUNT(*) 
    INTO v_exists
    FROM bookings
    WHERE booking_date = p_booking_date
      AND book_table_id  = p_table_no;

    IF v_exists > 0 THEN
        ROLLBACK;
        SELECT CONCAT('Table ', p_table_no,
                      ' is already booked on ',
                      DATE_FORMAT(p_booking_date,'%Y-%m-%d')
                     ) AS 'Booking Status';
    ELSE
        INSERT INTO bookings (booking_date,book_table_id,book_by_casotmer_id,assign_to_staff_id)
        VALUES (p_booking_date, p_table_no, p_customer_id, p_staff_id);

        COMMIT;
        SELECT CONCAT('Booking confirmed: Table ', p_table_no,
                      ' on ',
                      DATE_FORMAT(p_booking_date,'%Y-%m-%d')
                     ) AS 'Booking Status';
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CancelBooking
-- -----------------------------------------------------

DELIMITER $$
USE `littlelemoncapstonedb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CancelBooking`(IN p_booking_id INT)
BEGIN
    DECLARE v_exists INT DEFAULT 0;
    SELECT COUNT(*) 
    INTO v_exists
    FROM bookings
    WHERE booking_id = p_booking_id;

    IF v_exists > 0 THEN
		DELETE FROM bookings WHERE booking_id = p_booking_id;
		SELECT concat("Booking id ", p_booking_id, " Cancelled") AS 'Confirmation';
    ELSE
        SELECT "Booking id is invalid" AS 'Confirmation';
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CancelOrder
-- -----------------------------------------------------

DELIMITER $$
USE `littlelemoncapstonedb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CancelOrder`(IN p_order_id int)
BEGIN
	DELETE FROM orders WHERE orders_id = p_order_id;
    IF ROW_COUNT() > 0 THEN
        SELECT 'confirmation' AS status,
               CONCAT('Order ', p_order_id, ' deleted.') AS message;
    ELSE
        SELECT 'confirmation' AS status,
               CONCAT('Order ', p_order_id, ' not found.') AS message;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CheckBooking
-- -----------------------------------------------------

DELIMITER $$
USE `littlelemoncapstonedb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CheckBooking`(IN p_booking_date DATE,IN p_table_no INT)
BEGIN
DECLARE table_status VARCHAR(100);
SELECT 
    CASE 
        WHEN COUNT(*) > 0 THEN CONCAT('Table ', p_table_no, ' Already Booked')
        ELSE CONCAT('Table ', p_table_no, 'Available')
    END
INTO table_status
FROM bookings
WHERE booking_date = p_booking_date
  AND book_table_id  = p_table_no;
  SELECT table_status AS 'Booking Status';

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure GetMaxQuantity
-- -----------------------------------------------------

DELIMITER $$
USE `littlelemoncapstonedb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetMaxQuantity`()
BEGIN
	SELECT MAX(quantity) AS 'Max Quantity in Order' FROM orders;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure UpdateBooking
-- -----------------------------------------------------

DELIMITER $$
USE `littlelemoncapstonedb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateBooking`(
    IN p_booking_id INT,
    IN p_booking_date DATE
   )
BEGIN
    DECLARE v_exists INT DEFAULT 0;
    SELECT COUNT(*) 
    INTO v_exists
    FROM bookings
    WHERE booking_id = p_booking_id;

    IF v_exists > 0 THEN
		UPDATE bookings SET booking_date = p_booking_date WHERE booking_id = p_booking_id;
		SELECT concat("Booking id ", p_booking_id, " Updated") AS 'Confirmation';
    ELSE
        SELECT "Booking id is invalid" AS 'Confirmation';
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `littlelemoncapstonedb`.`orderdetails`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `littlelemoncapstonedb`.`orderdetails`;
USE `littlelemoncapstonedb`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `littlelemoncapstonedb`.`orderdetails` AS select `o`.`orders_id` AS `orders_id`,`o`.`booking_id` AS `booking_id`,`m`.`menu_name` AS `menu_name`,`m`.`price` AS `price`,`o`.`quantity` AS `quantity`,(`o`.`price` * `o`.`quantity`) AS `Total_Price`,`bt`.`name` AS `table_name`,`c`.`castomer_name` AS `castomer_name`,`s`.`name` AS `name` from (((((`littlelemoncapstonedb`.`orders` `o` join `littlelemoncapstonedb`.`menu` `m` on((`o`.`menu_id` = `m`.`menu_id`))) join `littlelemoncapstonedb`.`bookings` `b` on((`o`.`booking_id` = `b`.`booking_id`))) join `littlelemoncapstonedb`.`book_table` `bt` on((`b`.`book_table_id` = `bt`.`id`))) join `littlelemoncapstonedb`.`castomers` `c` on((`b`.`book_by_casotmer_id` = `c`.`castomer_id`))) join `littlelemoncapstonedb`.`staffs` `s` on((`b`.`assign_to_staff_id` = `s`.`staff_id`))) where (`o`.`price` >= 50);

-- -----------------------------------------------------
-- View `littlelemoncapstonedb`.`ordersview`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `littlelemoncapstonedb`.`ordersview`;
USE `littlelemoncapstonedb`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `littlelemoncapstonedb`.`ordersview` AS select `littlelemoncapstonedb`.`orders`.`orders_id` AS `orders_id`,`littlelemoncapstonedb`.`orders`.`quantity` AS `quantity`,`littlelemoncapstonedb`.`orders`.`price` AS `price` from `littlelemoncapstonedb`.`orders` where (`littlelemoncapstonedb`.`orders`.`quantity` > 2);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
