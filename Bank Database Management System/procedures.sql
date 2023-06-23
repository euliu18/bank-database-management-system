#A procedure that retrieve the bank branches based on their locations
DELIMITER $$
CREATE PROCEDURE GetBankBranchByLocation(IN location varchar(20))
BEGIN 
SELECT * FROM Bank_Branches WHERE bankLocation=location;
END $$
DELIMITER ;

CALL GetBankBranchByLocation('Tirane');



#A procedure that retrieve the name and the social security number from customers of the bank
DELIMITER $$
CREATE PROCEDURE GetCustomers()
BEGIN
SELECT cusFname,Cssn FROM Customer ORDER BY cusFname;
END $$
DELIMITER ;

CALL GetCustomers();



#A procedure that retrieve all data for all dependents 
DELIMITER $$
CREATE PROCEDURE Dependents()
BEGIN 
SELECT * FROM Dependent ORDER BY depenName;
END $$
DELIMITER ;

CALL Dependents();



#A procedure that retrieves the name birthday of male employees and female customers 
DELIMITER $$
CREATE PROCEDURE MaleEmployeeAndFemaleCustomer()
BEGIN 
SELECT empFname,empLname,empBirthday FROM Employee WHERE empGender='M';
SELECT cusFname,cusLname,cusBirthday FROM Customer WHERE cusGender='F';
END $$
DELIMITER ;

CALL MaleEmployeeAndFemaleCustomer();


#A procedure that retrieve number of accounts a customer has in the bank
DELIMITER $$
CREATE PROCEDURE CountCustomerAccounts(IN num INT,OUT total INT)
BEGIN
SELECT COUNT(cusAccountCssn) INTO total FROM Customer_Account WHERE cusAccountCssn=num;
END $$
DELIMITER ;

CALL CountCustomerAccounts(000055555,@total);
SELECT @total AS total;




#A procedure that retrieve number of loans a customer has taken from the bank
DELIMITER $$
CREATE PROCEDURE CountCustomerLoans(IN num INT,OUT total INT)
BEGIN
SELECT COUNT(cusLoanCssn) INTO total FROM Customer_Loan WHERE cusLoanCssn=num;
END $$
DELIMITER ;

CALL CountCustomerLoans(000011111,@total);
SELECT @total AS total;



#A procedure that retrieve the status for a given employee
DELIMITER $$
CREATE PROCEDURE GetEmployeeStatus(IN E_essn INT,OUT EmployeeStatus varchar(20))
BEGIN
DECLARE Salary int;
SELECT empSalary INTO Salary FROM Employee WHERE Essn=E_essn;
IF Salary>=40000 THEN SET EmployeeStatus='Manager';
ELSE SET EmployeeStatus='Normal Employee';
END IF;
END $$
DELIMITER ;

CALL GetEmployeeStatus(333445555,@statuss);
SELECT @statuss AS Employee_Status; 



#A procedure that retrieves all bank branch addresses 
DELIMITER $$
CREATE PROCEDURE GetAddressbyCode(IN codee int)
BEGIN 
SELECT * FROM Bank_Branches_Addresses WHERE addBankCode=codee;
END $$
DELIMITER ;

CALL GetAddressbyCode(1);