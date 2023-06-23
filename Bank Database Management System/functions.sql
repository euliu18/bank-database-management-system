#A function that return the age of the employees in the bank 
DELIMITER $$
CREATE FUNCTION age_of_employees(date1 DATE) RETURNS INT 
DETERMINISTIC
BEGIN
DECLARE date2 DATE;
SELECT CURRENT_DATE() INTO date2;
RETURN YEAR(date2)-YEAR(date1);
END$$
DELIMITER ;

SELECT empFname,empLname,age_of_employees(empBirthday) as Age FROM Employee;




#A function that return types of Accounts in the bank based on their balance
DELIMITER $$
CREATE FUNCTION Account_type(balancee INT) RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
DECLARE typee VARCHAR(30);
IF balancee=0 THEN SET typee='Savings';
ELSEIF balancee=250 THEN SET typee='Current';
ELSEIF balancee=500 THEN SET typee='Fixed Deposit';
END IF;
RETURN (typee);
END $$
DELIMITER ;

SELECT DISTINCT account_type(balance) from Account;




#A function that return types of Loans in the bank based on their amount
DELIMITER $$
CREATE FUNCTION Loan_type(amountt INT) RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
DECLARE typee VARCHAR(30);
IF amountt=10000 THEN SET typee='Educational';
ELSEIF amountt=100000 THEN SET typee='Home';
ELSEIF amountt=500000 THEN SET typee='Personal';
END IF;
RETURN (typee);
END $$
DELIMITER ;

SELECT DISTINCT loan_type(amount) from Loan;





#A function that returns the position of the employees (employee or manager) in the bank
DELIMITER $$
CREATE FUNCTION Manager(manager INT,employee INT)RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN 
DECLARE position varchar(20);
IF manager=employee THEN SET position='Manager';
ELSE SET position='Employee';
END IF;
RETURN (position);
END $$
DELIMITER ;

SELECT DISTINCT empFname,empLname,Manager(managerEssn,Essn) FROM Employee,Bank_Branches;