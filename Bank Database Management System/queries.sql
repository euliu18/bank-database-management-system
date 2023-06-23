#Retrieve the name and Essn of all employees who work for the bank branch located in Tirana order by employee first name
SELECT empFname,empLname,Essn 
FROM Employee,Bank_Branches 
WHERE bankLocation='Tirane' AND bankCode=empBankCode 
ORDER BY empFname;



/*For every loan with amount 100000 retrieve the loan number,controlling bank branch code and the bank branch 
manager's name*/
SELECT loanNr,loanBankCode,empFname 
FROM Loan,Bank_Branches,Employee 
WHERE bankCode=loanBankCode AND managerEssn=Essn AND amount=100000;



/*For each employee retrieve the employee's name and the Essn of his/her supervisor*/
SELECT E.empFname,E.empLname,S.Essn 
FROM Employee AS E,Employee AS S 
WHERE E.empSuperessn=S.Essn;



/*Select  all customers Cssn,name and account type they have created.*/
SELECT Cssn,cusFname,cusLname,accountType 
FROM Customer,Customer_Account,Account 
WHERE Cssn=cusAccountCssn AND cusAccountNr=accountNr;



/*Select the name,surname and the dependent name of all employees that are married.*/
SELECT empFname,depenName,empLname 
FROM Employee,Dependent 
WHERE Relationship='Spouse' AND Essn=depenEssn;



/*Make a list of all loan numbers and account numbers that involve a customer whose name is='Nensi'*/
SELECT loanNr 
FROM Loan,Customer_Loan,Customer 
WHERE loanNr=cusLoanNr AND cusLoanCssn=Cssn AND cusFname='Nensi'
UNION
SELECT accountNr 
FROM Account,Customer_Account,Customer 
WHERE accountNr=cusAccountNr AND cusAccountCssn=Cssn AND cusFname='Nensi';



/*Show the resulting salaries if every employee working for the bank branch 
where managerEssn=333445555,is given a 5% raise */

SELECT empFname,empLname,0.05*empSalary+empSalary AS Increased_Salary
FROM Employee,Bank_Branches 
WHERE empBankCode=bankCode AND managerEssn=333445555;



/*Retrieve all the employees and customers who were born during the 1970s*/
SELECT empFname,empLname,empBirthday
FROM Employee
WHERE empBirthday LIKE '197_______'
UNION 
SELECT cusFname,cusLname,cusBirthday
FROM Customer
WHERE cusBirthday LIKE '197_______';



/*Retrieve a list of all employees and the bank branch they are working on ordered by employee name*/
SELECT empFname,empLname,bankName,bankLocation
FROM Employee,Bank_Branches
WHERE empBankCode=bankCode 
ORDER BY empFname;



/*Retrieve the name of each employee who whas a dependent with the same gender as his*/
SELECT empFname,empLname
FROM Employee
WHERE Essn IN (SELECT depenEssn
               FROM Dependent
			   WHERE empGender=depenGender);
               


/*Retrieve the name of customers who have no loans*/
SELECT cusFname,cusLname
FROM Customer
WHERE NOT EXISTS (SELECT * 
			      FROM Customer_Loan 
				  WHERE cusLoanCssn=Cssn);
                  


/*List the code and the location of bank branches that have at least two addresses*/

SELECT bankCode,bankLocation
FROM Bank_Branches
WHERE (SELECT COUNT(*) FROM Bank_Branches_Addresses WHERE bankCode=addBankCode)>=2;



/*For every account with type='Saving',retrieve the account number,controlling bank branch and bank branch managers's*/
SELECT accountNr,bankCode,managerEssn
FROM Account JOIN Bank_Branches ON accountBankCode=bankCode JOIN Employee ON managerEssn=Essn
WHERE accountType='Saving';



/*Find all the sum of all salaries of all employees of Durres bank branch location as well as the max,min 
and average salary*/

SELECT SUM(empSalary),MAX(empSalary),MIN(empSalary),AVG(empSalary)
FROM Employee JOIN Bank_Branches ON empBankCode=bankCode
WHERE bankLocation='Durres';



/*Retrieve the total number of employees that have a daughter*/
SELECT COUNT(*)
FROM Employee,Dependent 
WHERE depenEssn=Essn AND Relationship='Daughter';



/*For every bank branch count the number of loans that offers*/
SELECT bankCode,bankLocation,COUNT(*)
FROM Bank_Branches,Loan
WHERE bankCode=loanBankCode
GROUP BY bankCode,bankLocation;



/*For each customer that has more than two accounts created retrieve the name and surname*/

SELECT cusFname,cusLname
FROM Customer,Customer_Account
WHERE Cssn=cusAccountCssn
GROUP BY cusFname,cusLname
HAVING COUNT(*)>2;



/*Retrieve the names of employees who have no dependent*/
SELECT empFname,empLname 
FROM Employee
WHERE NOT EXISTS(SELECT * 
                 FROM Dependent 
				 WHERE Essn=depenEssn )
ORDER BY empFname;



/*Retrieve all customers cssn who have created a loan with number 111213,373839 
and a account with number 646566,575859*/

SELECT DISTINCT cusLoanCssn 
FROM  Customer_Loan
WHERE cusLoanNr IN (111213,373839)
UNION
SELECT DISTINCT cusAccountCssn 
FROM  Customer_Account
WHERE cusAccountNr IN (646566,575859);



/*Retrieve all the employees who are managed by manager with Essn=888665555*/
SELECT *
FROM Employee JOIN Bank_Branches on empBankCode=bankCode
WHERE managerEssn=888665555;



/*Retrive the total loan amount customer with cssn=000055555 has taken*/
SELECT cusLoanCssn,SUM(amount)
FROM Loan,Customer_Loan
WHERE cusLoanNr=loanNr and cusLoanCssn=000055555;



/*Retrieve the maximum and min account balance customer with cssn=000011111 has taken*/
SELECT cusAccountCssn,MIN(balance),MAX(balance)
FROM Account,Customer_Account
WHERE cusAccountNr=accountNr and cusAccountCssn=000011111;

