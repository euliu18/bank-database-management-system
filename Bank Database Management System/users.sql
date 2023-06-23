create user administrator@localhost identified by 'administrator';
grant all privileges on bank_database.* to administrator@localhost;
show grants for administrator@localhost;

create user manager@localhost identified by 'manager';
grant insert,update,select,delete on bank_database.* to manager@localhost;
show grants for manager@localhost;

create user employee@localhost identified by 'employee';
grant select on bank_database.Dependent to employee@localhost;
show grants for employee@localhost;

create user customer@localhost identified by 'customer';
grant select on bank_database.Loan to customer@localhost;
show grants for customer@localhost;




