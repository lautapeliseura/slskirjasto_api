drop table if exists cards;

create table cards (
    lender_id       bigint,
    deposit         varchar(255),
    card_given      timestamp with time zone,
    card_returned   timestamp with time zone,

    like templates._base including all,
    foreign key(lender_id) REFERENCES lenders(id) on update cascade on delete set null
);

comment on table cards is 'Library cards';
comment on column cards.lender_id is 'Current holder of the card';
comment on column cards.deposit is 'Holders deposit';
comment on column cards.card_given is 'When was this card given to the holder';
comment on column cards.card_returned is 'When this card was returned to the library';