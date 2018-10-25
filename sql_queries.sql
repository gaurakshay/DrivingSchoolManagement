--CREATING TYPE OBJECTS!!

CREATE TYPE address_obj AS OBJECT
(street varchar2(10),
city varchar2(10));


CREATE TYPE studriver_obj AS OBJECT
(sid number(10),
sname varchar2(10),
address address_obj);

CREATE TYPE drivinginst_obj AS OBJECT
( instid number(10),
instname varchar2(10));

CREATE TYPE date_obj AS OBJECT
( dday number(2),
dmonth number(3),
dyear number(4));

CREATE TYPE hsession_obj AS OBJECT
(sid REF studriver_obj,
 instid REF drivinginst_obj,
 hdate date_obj);
 
 CREATE TYPE dinstvehicle_obj AS OBJECT
 (lplate REF vehicle_obj,
 instid REF drivinginst_obj);
 
 CREATE TYPE eoptions_obj AS VARRAY(40) OF varchar2(60);
 
 CREATE TYPE vehicle_obj AS OBJECT
 (lplate varchar2(10),
 vyear number(10),
 make varchar2(10),
 vmodel varchar2(10),
 eoptions eoptions_obj
 )NOT FINAL;
 
 CREATE TYPE truck_obj UNDER vehicle_obj
 (cabin_type varchar2(10),
 weight varchar2(10)
 );
 
 CREATE TYPE car_obj UNDER vehicle_obj
 (num_doors number(10));
 
 ALTER TYPE vehicle_obj FINAL;
 
 --CREATING TABLES!!
 
 CREATE TABLE studriver_tab OF studriver_obj
 (sid primary key)
 object id primary key;
 
 CREATE TABLE dinst_tab OF drivinginst_obj
 (instid primary key)
 object id primary key;
 
 CREATE TABLE vehicle_tab OF vehicle_obj
 (lplate primary key)
 object id primary key;
 
 CREATE TABLE car_tab OF car_obj
 (lplate primary key)
 object id primary key;
 
 CREATE TABLE truck_tab OF truck_obj
 (lplate primary key)
 object id primary key;
 
 CREATE TABLE hsession_tab OF hsession_obj
 (foreign key(sid) references studriver_tab,
 foreign key(instid) references dinst_tab);
 
 CREATE TABLE dinstvehicle_tab OF dinstvehicle_obj
 (foreign key(instid) references dinst_tab,
 foreign key(lplate) references vehicle_tab);
 
 
 
 -----------------------
 --query1
 --------------------------
 
Insert into vehicle_tab values('444LJB',2014,'acura','tl',
eoptions_obj('navigation','bluetooth'));

Insert into  vehicle_tab values( '333LJB',2011,'honda','civic',
eoptions_obj('bluetooth','v6 engine'));

Insert into  vehicle_tab values('222LJB',2010,'lanser','tl',eoptions_obj('v6 engine','navigation'));

Insert into vehicle_tab values('111LJB',2009,'lanser','mitbushi',eoptions_obj('leather seats','autotime'));

Insert  into vehicle_tab values('000LJB',2008,'acura','mdx',eoptions_obj('autotime','bluetooth'));

 
Insert into car_tab values('444LJB',2014,'acura','tl',eoptions_obj('navigation','bluetooth'),2);

Insert into  car_tab values( '333LJB',2011,'honda','civic',eoptions_obj('bluetooth','v6 engine'),2);

Insert into  car_tab values('222LJB',2010,'lanser','tl',eoptions_obj('v6 engine','navigation'),4);

Insert into car_tab values('111LJB',2009,'lanser','mitbushi',eoptions_obj('leather seats','autotime'),4);

Insert  into car_tab values('000LJB',2008,'acura','mdx',eoptions_obj('autotime','bluetooth'),4);

-----truck_tab

Insert into vehicle_tab values('042SRI',2001,'benz','g3',eoptions_obj('seat heater','sun roof'));

Insert into vehicle_tab values('043SRI',2002,'dodge','charger',eoptions_obj('sun roof','racebrake'));

Insert into vehicle_tab values ('044SRI','2003','honda','accord',eoptions_obj('racebrake','seat heater'));

Insert into vehicle_tab values('045SRI',2004,'acura','mdx',eoptions_obj('autodriver','racebrake'));

Insert into vehicle_tab values('046SRI',2005,'benz','v3',eoptions_obj('Sun roof','autodriver'));


Insert into truck_tab values('042SRI',2001,'benz','g3',eoptions_obj('seat heater','sun roof'),'sleeper',1500);

Insert into truck_tab values('043SRI',2002,'dodge','charger',eoptions_obj('sun roof','racebrake'),'sleeper',2000);

Insert into truck_tab values('044SRI',2003,'honda','accord',eoptions_obj('racebrake','seat heater'),'no sleeper',2500);

Insert into truck_tab values('045SRI',2004,'acura','mdx',eoptions_obj('autodriver','racebrake'),'ac coach',3000);

Insert into truck_tab values('046SRI',2005,'benz','v3',eoptions_obj('Sunroof','autodriver'),'no sleeper',3500);

---------------------------------
----2.INSERT A DRIVING INSTRUCTOR WITH A PARTICULAR CAR OR A TRUCK

--FOR THIS QUERY FIRST INTSERT INTO DINST TAB AND THEN ASSOCIATE THEM WITH VEHICLES TAB

Insert into  dinst_tab values(101,'SRI');

Insert into  dinst_tab values(102,'JASHU');

Insert into  dinst_tab values(103,'POOJA');

Insert into  dinst_tab values(104,'KAU');

Insert into  dinst_tab values(105,'SASI');

Insert into dinstvehicle_tab
Select REF(S),REF(V)
From dinst_tab S,vehicle_tab 
Where S.instid=101 and V.lplate='444LJB';


Insert into dinstvehicle_tab
Select REF(I),REF(V)
From dinst_tab I,vehicle_tab V
Where I.instid='102' and V.lplate='222LJB';

Insert into dinstvehicle_tab
Select REF(I),REF(V)
From dinst_tab I,vehicle_tab V
Where I.id=�103� and V.lplate=�111LJB�;

Insert into dinstvehicle_tab
Select REF(I),REF(V)
From dinst_tab I,vehicle_tab V
Where I.id=�104� and V.lplate=�043SRI�;

Insert into dinstvehicle_tab
Select REF(I),REF(V)
From dinst_tab I,vehicle_tab V
Where I.id=�105� and V.lplate=�042SRI�;

--------------------------------------------------------------------------------------
--3.Insert a student driver that had a session with a particular driving instructor

----For this query first we can insert into studentdrivers and then associate them with instdrivers
---------------------------------------------------------------------------------------

Insert into studriver_tab values(1001,'JOSH',address_obj('brooks','norman'));

Insert into studriver_tab values(1002,'JOE',address_obj('rockwell','okc'));

Insert into studriver_tab values(1003,'NAGA',address_obj('alameda','okc'));

Insert into studriver_tab values(1004,'JAMES',address_obj('boyd','norman'));

Insert into studriver_tab values(1005,'SIVA',address_obj('jenkins','norman'));



Insert into hsession_tab
Select date_obj(28,03,1992),
REF(S),REF(I)
From studriver_tab S,dinst_tab I
Where S.sid=1002 and I.instid=101;



Insert into hsession_tab
Select date_obj(05,'march',2013),REF(S),REF(I)
From studriver_tab S,dinst_tab I
Where S.sid=1001 and I.instid=102;


Insert into hsession_tab
Select date_obj(05,'sept',2015),REF(S),REF(I)
From studriver_tab S,dinst_tab I
Where S.sid=�1003� and I.instid=�104�;


Insert into hsession_tab
Select date_obj(�12�,�july�,�2017),REF(S),REF(I)
From studriver_tab S,dinst_tab I
Where S.sid=�1004� and I.instid=�103�;


Insert into hsession_tab
Select date_obj(28,03,1992),REF(S),REF(I)
From studriver_tab S,dinst_tab I
Where S.sid=1005 and I.instid=105;

-------------------------------------------------------------
--4.FIND ALL THE STUDENTS DRIVERS LIVING IN A GIVEN CITY
---------------------------------------------------------------

Select s.sid,s.sname,s.address.street,s.address.city
From studriver_tab s
Where s.address.city='norman';


Select s.sid,s.sname,s.address.street,s.address.city
From studriver_tab s
Where s.address.city='okc';

---------------------------------------------------------------------
---5.FIND ID�S OF STUDENT DRIVERS WHO HAD A SESSION WITH PARTICULAR DRIVING INSTRUCTOR
-----------------------------------------------------------------------

Select H.sid.sname
From  hsession_tab H
Where H.sid.sid='1002';

Select H.sid.sname
From  hsession_tab H
Where H.sid.sname='JOE';

----------------------------------
---6.list the names,id�s and address of all student drivers that had a session on a particular date in a 2-door Honda civic
----------------------------------------------------------

Select H.sid,H.name
From hsession_tab H
Where H.hday=28 and H.hmonth=march and H.hyear=1992
And  H.instid.instid IN
(Select V.instid.instid
from dinstvehicle_tab  V
where V.lplate.lplate IN
 (Select C.lplate
from car_tab C
where C.make=�HONDA�
and C>model=�CIVIC�
and C.num_doors=2));

---------------------------------------------------
---7. Display the license plates, models, makes and years of all the cars that are equipped with a particular equipment option. 
--------------------------------------------------------

Select C.lplate,C.vyear,C.make ,C.vmodel
From car_tab C,Table(C.eoptions) t
where t.column_value='leather seats';

Select C.lplate,C.vyear,C.make ,C.vmodel
From car_tab C,Table(C.eoptions) t
where t.column_value='v6 engine';

------------------------------------
---8.
------------------------------------
-----------------------------------------------------------------------
-- drivers that have trucks more than the specified weight

SELECT d.instid
  FROM dinstvehicle_tab d
  WHERE d.lplate IN
    (SELECT t.lplate
    FROM truck_tab t
    WHERE t.weight > 1000);

-------------------------------------














 