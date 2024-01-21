Create database employee;
USE employee; 
Select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT From emp_record_table;


Select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, Emp_Rating From emp_record_table
where Emp_Rating <2;


Select concat(FIRST_NAME,"", LAST_NAME) as Name from emp_record_table where DEPT='FINANCE';


SELECT m.EMP_ID,m.FIRST_NAME,m.LAST_NAME,m.ROLE,
m.EXP,COUNT(e.EMP_ID) as "EMP_COUNT"
FROM emp_record_table m
INNER JOIN emp_record_table e
ON m.EMP_ID = e.MANAGER_ID
GROUP BY m.EMP_ID
ORDER BY m.EMP_ID;
 SET sql_mode = '';
 
 
SELECT m.EMP_ID,m.FIRST_NAME,m.LAST_NAME,m. DEPT From emp_record_table m where m. DEPT In ('Healthcare')
Union select EMP_ID, FIRST_NAME, LAST_NAME, DEPT from emp_record_table where DEPT In ('Finance') Order by DEPT, EMP_ID;


Select EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPT, EMP_RATING, max(EMP_RATING)
over (partition by DEPT)  as "Max_Emp_Rating" From emp_record_table;

SELECT EMP_ID, FIRST_NAME, LAST_NAME, ROLE, MAX(SALARY), MIN(SALARY) FROM emp_record_table
GROUP BY ROLE;


SELECT EMP_ID, FIRST_NAME, LAST_NAME, ROLE, EXP, RANK()
OVER (ORDER BY EXP) AS "RANK" From emp_record_table;


CREATE view EMPLOYEE_VIEW AS select EMP_ID, FIRST_NAME, LAST_NAME, ROLE, COUNTRY, DEPT, SALARY
FROM emp_record_table WHERE SALARY> 6000;
SELECT * FROM  EMPLOYEE_VIEW; 


SELECT EMP_ID,FIRST_NAME,LAST_NAME,EXP FROM emp_record_table
WHERE EMP_ID IN(SELECT EMP_ID FROM emp_record_table WHERE EXP> 10);



Delimiter $$
Create procedure GetEmpExp()
Begin 
Select EMP_ID,FIRST_NAME,LAST_NAME,EXP, DEPT, Role from  emp_record_table
where EXP >3;
End$$
Call GetEmpExp();



Delimiter $$
Create function Employee_Role(EXP INT)
Returns Varchar (40) deterministic
Begin
Declare Employee_Role Varchar (40);
if EXP <= 2 then set Employee_Role= 'JUNIOR DATA SCIENTIST';
elseif (EXP>= 2 AND EXP<=5) THEN SET Employee_Role= 'ASSOCIATE DATA SCIENTIST';
elseif (EXP>= 5 AND EXP<=10) THEN SET Employee_Role= 'SENIOR DATA SCIENTIST';
elseif (EXP>= 10 AND EXP<=12) THEN SET Employee_Role= 'LEAD DATA SCIENTIST';
elseif (EXP>= 12 AND EXP<=16) THEN SET Employee_Role= 'MANAGER';
END IF;
RETURN (Employee_Role);
END $$
DELIMITER ;
SELECT EMP_ID, EXP, Employee_Role (EXP) from emp_record_table;



CREATE INDEX first_name_index
ON emp_record_table(FIRST_NAME(20));
SELECT * FROM emp_record_table
WHERE FIRST_NAME='Eric';



update emp_record_table set salary=(salary +(salary*.05*EMP_RATING));
Select * from emp_record_table;

Select emp_id, First_Name, Last_Name, Role, Dept, Salary, Country, Continent,
AVG (Salary) OVER(PARTITION BY COUNTRY order by Continent) as "AVG_salary_IN_COUNTRY",
AVG(salary)OVER(PARTITION BY CONTINENT) as 'AVG_salary_IN_CONTINENT', 
Count( Salary) OVER(PARTITION BY COUNTRY order by Continent) as "Count_salary_IN_COUNTRY",
COUNT(*)OVER(PARTITION BY CONTINENT) as 'COUNT_IN_CONTINENT'
From emp_record_table;
