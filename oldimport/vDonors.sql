drop view if exists vdonors;
create view vdonors as
select nimi as donor_name, verkkoosoite as credit from lahjoittaja;