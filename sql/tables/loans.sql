drop table if exists loans;
create table loans (
    lender_id           bigint,
    lent_at             timestamp with time zone default now(),
    returned_at         timestamp with time zone,
    collectiongame_id   bigint,
    game_id             bigint,
    slsmember           boolean,
    event_id            bigint,

    like templates._base including all,
    foreign key(lender_id) references lenders(id) on update set null on delete set null,
    foreign key(collectiongame_id) references collectiongames(id) on update set null on delete set null,
    foreign key(game_id) references games(id) on update cascade on delete restrict,
    foreign key(event_id) references events(id) on update cascade on delete restrict
);

comment on table loans is 'Loans from collections by individuals';
comment on column loans.lender_id is 'Lender';
comment on column loans.lent_at is 'When this game was lent out';
comment on column loans.returned_at is 'When this game was returned';
comment on column loans.collectiongame_id is 'Collection game that was lent out';
comment on column loans.game_id is 'The game that was lent out';
comment on column loans.event_id is 'Is this an event loan - which event?';