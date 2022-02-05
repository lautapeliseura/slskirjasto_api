drop table if exists baskets cascade;
create table baskets (
    group_id    bigint not null,
    basket_name varchar(255) unique not null,
    publicity   varchar(255)[],

    like templates._base including all,
    foreign key (group_id) REFERENCES users(id) on update CASCADE on delete cascade
);

comment on table baskets is 'Game baskets';
comment on column baskets.group_id is 'Foreign key to basket owner group';
comment on column baskets.basket_name is 'Name of the basket';
comment on column baskets.publicity is 'Publicity of basket';

drop table if exists basket_games;

create table basket_games (
    basket_id           bigint not null,
    collectiongame_id   bigint not null,
    note                varchar(512),

    like templates._base including ALL,
    foreign key(basket_id) references baskets(id) on update CASCADE on delete CASCADE,
    foreign key(collectiongame_id) references collections(id) on update CASCADE on DELETE cascade
);

comment on table basket_games is 'Games in a basket';
comment on column basket_games.basket_id is 'Basket this item belongs to';
comment on column basket_games.collectiongame_id is 'Collection this game belongs to';
comment on column basket_games.note is 'Note for the basket';
