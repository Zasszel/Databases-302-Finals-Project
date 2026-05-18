-- drop table Orarend;
-- drop table EdzoSzolgaltat;
-- drop table Edzok;
-- drop table Szolgaltatasok;
-- drop table Termek;

CREATE TABLE Szolgaltatasok (
  SzolgID varchar(3) primary key,
  SzNev varchar(40)
) ;

insert into Szolgaltatasok values ('A','Aerobic');
insert into Szolgaltatasok values ('P','Pilates');
insert into Szolgaltatasok values ('Z','Zumba');
insert into Szolgaltatasok values ('KS','Kondi-step');
insert into Szolgaltatasok values ('J','Joga');

CREATE TABLE Edzok (
  EdzoID int NOT NULL,
  ENev varchar(20) NOT NULL,
  ETfSzam varchar(15),
  PRIMARY KEY(EdzoID)
) ;

insert into Edzok values (1,'Gergo','0742334455');
insert into Edzok values (2,'Anna','0743997345');
insert into Edzok values (3,'Eva','0733776699');
insert into Edzok values (4,'Istvan','0765688766');
insert into Edzok values (5,'Andras','0789006544');
insert into Edzok values (6,'Kata','0764345661');

CREATE TABLE Termek (
  TeremID int PRIMARY KEY,
  Emelet int NOT NULL
 ) ;

insert into Termek values (1,0);
insert into Termek values (2,0);
insert into Termek values (3,0);
insert into Termek values (4,0);
insert into Termek values (5,1);
insert into Termek values (6,1);
insert into Termek values (7,1);
insert into Termek values (8,1);

create table EdzoSzolgaltat(
   ESzID int primary key,
   EdzoID int references Edzok(EdzoID),
   SzolgID varchar(3) references Szolgaltatasok(SzolgID)
);

insert into EdzoSzolgaltat values (1,1,'A');
insert into EdzoSzolgaltat values (2,1,'J');
insert into EdzoSzolgaltat values (3,1,'P');
insert into EdzoSzolgaltat values (4,2,'A');
insert into EdzoSzolgaltat values (5,2,'J');
insert into EdzoSzolgaltat values (6,3,'A');
insert into EdzoSzolgaltat values (7,3,'Z');
insert into EdzoSzolgaltat values (8,3,'KS');
insert into EdzoSzolgaltat values (9,4,'P');
insert into EdzoSzolgaltat values (10,5,'Z');
insert into EdzoSzolgaltat values (11,6,'KS');
insert into EdzoSzolgaltat values (12,6,'P');

CREATE TABLE Orarend(
  ID int NOT NULL Primary Key,
  EszID INT NOT NULL REFERENCES EdzoSzolgaltat(ESzID),
  TeremID INT NOT NULL REFERENCES Termek(TeremID),
  Nap int NOT NULL check (Nap>=1 and Nap <=7),
  Ora int NOT NULL check (Ora >=8 and Ora <=18)
) ;

insert into Orarend values (1, 1, 1,1,8);
insert into Orarend values (2, 1, 1,1,10);
insert into Orarend values (3, 3, 8,1,15);
insert into Orarend values (4, 3, 8,1,16);
insert into Orarend values (5, 4, 2,1,16);
insert into Orarend values (6, 5, 3,1,14);

insert into Orarend values (7, 2, 3,2,8);
insert into Orarend values (8, 2, 1,2,12);
insert into Orarend values (9, 2, 1,2,13);
insert into Orarend values (10, 2, 1,2,11);
insert into Orarend values (11, 4, 5,2,8);
insert into Orarend values (12, 5, 5,2,9);

insert into Orarend values (13, 3, 6,3,8);
insert into Orarend values (14, 10, 6,3,9);

insert into Orarend values (15, 8, 6,3,10);
insert into Orarend values (16, 8, 6,3,11);
insert into Orarend values (17, 7, 6,3,12);
insert into Orarend values (18, 8, 6,3,13);
insert into Orarend values (19, 10, 6,3,14);
insert into Orarend values (20, 5, 6,3,15);
insert into Orarend values (21, 5, 6,3,16);
insert into Orarend values (22, 5, 6,3,17);
insert into Orarend values (23, 5, 6,3,18);
insert into Orarend values (24, 8, 6,3,18);

insert into Orarend values (25, 5, 2,4,9);

insert into Orarend values (26, 3, 6,5,16);

insert into Orarend values (27, 5, 3,6,9);

insert into Orarend values (28, 3, 7,7,16);
commit;