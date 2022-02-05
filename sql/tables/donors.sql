drop table if exists donors cascade;

create table donors (
    donor_name  varchar(512),
    credit      varchar(512),

    like templates._base including all
);

comment on table donors is 'Game donors';
comment on column donors.donor_name is 'Name of the benefactor';
comment on column donors.credit is 'Credit text/address/whatever benefactor wanted to be advertised';
