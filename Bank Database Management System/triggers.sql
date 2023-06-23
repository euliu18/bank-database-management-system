/*A trigger that checks if the balance of a new account inserted is no higher than the specified value,if it is higher
changes that value with a new specified one.*/
DELIMITER $$
CREATE TRIGGER NoHigherBalance BEFORE INSERT ON Account FOR EACH ROW
BEGIN 
IF NEW.balance>500 then set NEW.balance=500;
END IF;
END $$
DELIMITER ;



/*A trigger that checks if the amount of a new loan inserted is no lower than the specified value,if it is lower
changes that value with a new specified one.*/
DELIMITER $$
CREATE TRIGGER NoLowerAmount BEFORE INSERT ON Loan FOR EACH ROW 
BEGIN 
IF NEW.amount<10000 THEN SET NEW.amount=10000;
END IF;
END $$
DELIMITER ;



/*A trigger that checks if the salary of a new employee inserted is no lower than the specified value,if it is lower
changes that value with a new specified one.*/

DELIMITER $$
CREATE TRIGGER Check_Salary BEFORE INSERT ON employee FOR EACH ROW
BEGIN
IF NEW.empSalary<20000 THEN SET NEW.empSalary=20000;
END IF;
END $$
DELIMITER ; 



#A trigger that keep tracks of the deleted customers from the bank in a new table 
CREATE TABLE Customer_Backup ( 
  FirstName varchar(20) not null,
  LastName varchar(20) not null,
  Ssn int NOT NULL,
  primary key (Ssn)
);


DELIMITER $$
CREATE TRIGGER Backup BEFORE DELETE ON Customer 
FOR EACH ROW
BEGIN
INSERT INTO Customer_Backup
VALUES (OLD.cusFname, OLD.cusLname, 
        OLD.Cssn);
END $$
DELIMITER ; 



#A trigger that reminds the employee to update its gender if he hasn't declare it yet.
CREATE TABLE Reminder(
essn int not null,
Fname varchar(20) not null,
Message varchar(200) not null,
primary key(essn)
);

DELIMITER $$
CREATE TRIGGER Remind AFTER INSERT ON Employee FOR EACH ROW
BEGIN
IF NEW.empGender IS NULL THEN INSERT INTO Reminder VALUES(NEW.Essn,NEW.empFname,CONCAT('Hi ', NEW.empFname, ', Please update your gender.'));
END IF;
END $$
DELIMITER ;


#A trigger that gives employee a default address if the address hasn't been specified
DELIMITER $$
CREATE TRIGGER Address BEFORE INSERT ON Employee FOR EACH ROW 
BEGIN 
IF NEW.empAddress IS NULL THEN SET NEW.empAddress='Tirane';
END IF;
END $$
DELIMITER ;