create schema if not exists bank;
use bank;

create table if not exists Bank_Branches
(
  bankName varchar(20) not null,
  bankCode int not null,
  managerEssn int not null,
  bankLocation varchar(20) not null,
  primary key (bankCode),
  unique (bankLocation)
);

create table if not exists Employee
(
  empFname varchar(20) not null,
  empLname varchar(20) not null,
  Essn int not null,
  empBirthday date check(empBirthday>='1965-12-12' and empBirthday<='1998-01-01'),
  empAddress varchar(30),
  empGender varchar(1),
  empSalary int not null,
  empSuperessn int,
  empBankCode int not null,
  primary key (Essn),
  foreign key (empBankCode) references Bank_Branches(bankCode) on delete restrict on update cascade
);
create table  if not exists Account
(
  accountType varchar(30) not null,
  accountNr int not null,
  balance int not null,
  accountBankCode int not null,
  primary key (accountNr),
  foreign key (accountBankCode) references Bank_Branches(bankCode) on delete restrict on update cascade
);

create table if not exists Loan
(
  loanType varchar(30) not null,
  loanNr int not null,
  amount int not null,
  loanBankCode int not null,
  primary key (loanNr),
  foreign key (loanBankCode) references Bank_Branches(bankCode) on delete restrict on update cascade
);

create table if not exists Customer
(
  cusFname varchar(20) not null,
  cusLname varchar(20) not null,
  Cssn int NOT NULL,
  cusBirthday date,
  cusAddress varchar(30),
  cusGender varchar(1),
  primary key (Cssn)
);

create table if not exists Customer_Account
(
  cusAccountNr int not null,
  cusAccountCssn int not null,
  primary key (cusAccountNr, cusAccountCssn),
  foreign key (cusAccountNr) references Account(accountNr) on delete cascade on update cascade,
  foreign key (cusAccountCssn) references Customer(Cssn) on delete cascade on update cascade
);

create table if not exists Customer_Loan
(
  cusLoanNr int not null,
  cusLoanCssn int not null,
  primary key (cusLoanNr, cusLoanCssn),
  foreign key (cusLoanNr) references Loan(loanNr) on delete cascade on update cascade,
  foreign key (cusLoanCssn) references Customer(Cssn) on delete cascade on update cascade
);

create table if not exists Dependent
(
  depenName varchar(10) not null,
  depenGender varchar(1),
  depenBirthday date,
  relationship varchar(10) not null,
  depenEssn int not null,
  primary key (depenName, depenEssn),
  foreign key (depenEssn) references Employee(Essn) on delete cascade on update cascade
);

create table if not exists Bank_Branches_Addresses (
    bankAddress varchar(20) not null,
    addBankCode int not null,
    primary key (bankAddress , addBankCode),
    foreign key (addBankCode) references Bank_Branches (bankCode) on delete cascade on update cascade
);

insert into Bank_Branches values
 ('BKT',1,333445555,'Tirane'),
 ('BKT',2,987654321,'Durres'),
 ('BKT',3,888665555,'Vlore');

insert into Employee values 
 ('Juxhin','Allaisufi',123456789,'1975-01-09','Tirane AL','M',30000,333445555,1),
 ('Denado','Rabeli',333445555,'1981-12-08','Tirane AL','M',40000,888665555,1),
 ('Armela','Ligori',999887777,'1987-01-19','Durres AL','F',25000,987654321,2),
 ('Jasmina','Gaxheri',987654321,'1972-06-20','Durres AL','F',43000,888665555,2),
 ('Egnantis','Basha',666884444,'1980-09-15','Vlore AL','M',38000,333445555,3),
 ('Klinti','Uliu',453453453,'1990-07-31','Tirane AL','M',25000,333445555,3),
 ('Endi','Fejza',987987987,'1994-03-29','Tirane AL','F',25000,987654321,1),
 ('Anila','Hoxha',888665555,'1979-11-10','Vlore AL','F',55000,null,1);
 
 insert into Account values 
 ('Saving',515253,0,1),
 ('Current',545556,250,1),
 ('Fixed Deposit',575859,500,1),
 ('Saving',616263,0,2),
 ('Current',646566,250,2),
 ('Fixed Deposit',676869,500,2),
 ('Saving',717273,0,3),
 ('Current',747576,250,3),
 ('Fixed Deposit',777879,500,3);
 
 insert into Loan values 
 ('Personal',111213,500000,1),
 ('Educational',141516,10000,1),
 ('Home',171819,100000,1),
 ('Personal',212223,500000,2),
 ('Educational',242526,10000,2),
 ('Home',272829,100000,2),
 ('Personal',313233,500000,3),
 ('Educational',343536,10000,3),
 ('Home',373839,100000,3);
 
 insert into Customer values 
 ('Sonila','Dedja',000011111,'2000-01-20','Tirane AL','F'),
 ('Jeton','Duka',000022222,'1995-02-12','Tirane AL','M'),
 ('Aldo','Hoxha',000033333,'1990-03-23','Durres AL','M'),
 ('Ornela','Kamberi',000044444,'1969-04-21','Durres AL','F'),
 ('Gerta','Xhoni',000055555,'1975-05-01','Vlore AL','F'),
 ('Nensi','Xheka',000066666,'2000-06-18','Vlore AL','F'),
 ('Gledis','Basha',000077777,'1985-07-28','Tirane AL','M'),
 ('Valmir','Rama',000088888,'2000-08-14','Tirane AL','M');
 
 insert into Customer_Account values 
 (515253,000011111),
 (545556,000011111),
 (575859,000022222),
 (616263,000033333),
 (646566,000044444),
 (676869,000044444),
 (717273,000055555),
 (747576,000055555),
 (777879,000055555),
 (515253,000066666),
 (646566,000077777),
 (777879,000088888);
 
 insert into Customer_Loan values 
 (111213,000011111),
 (141516,000011111),
 (171819,000022222),
 (212223,000033333),
 (242526,000044444),
 (272829,000044444),
 (313233,000055555),
 (343536,000055555),
 (373839,000055555),
 (111213,000066666),
 (242526,000077777),
 (373839,000088888);
 
 insert into Dependent values 
 ('Alesia','F','2004-04-04','Daughter',333445555),
 ('Tomi','M','2000-10-25','Son',333445555),
 ('Jona','F','1983-05-03','Spouse',333445555),
 ('Andi','M','1970-02-28','Spouse',987654321),
 ('Miri','M','2007-01-04','Son',123456789),
 ('Anja','F','1999-12-30','Daughter',123456789),
 ('Emili','F','1975-05-05','Spouse',123456789);

insert into Bank_Branches_Addresses values
 ('Rruga e Durresit',1),
 ('Rruga e Kavajes',1),
 ('Rruga Ismail Qemali',2),
 ('Rruga e Dibres',3);

alter table Bank_Branches add constraint bankemp foreign key (managerEssn) references Employee(Essn) on delete restrict on update cascade;

alter table Employee add constraint empemp foreign key (empSuperessn) references Employee(Essn) on delete restrict on update cascade;
