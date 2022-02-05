drop table if exists lenders CASCADE;

create table lenders (
    lender_name     varchar(512) not null UNIQUE,
    slsmembernumber bigint,

    like templates._base including all
);

comment on table lenders is 'Game lenders';
comment on column lenders.lender_name is 'Name of the lender';
comment on column lenders.slsmembernumber is 'Is lender member of SLS?';
