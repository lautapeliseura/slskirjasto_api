drop table if exists collectiongames cascade;
create table collectiongames (
    collection_id           bigint,
    game_id                 bigint,
    group_id                bigint,
    donor_id                bigint,
    shelve_id               bigint,
    shelf_place             varchar(255),
    storage_id              bigint,
    condition               varchar(255),
    note                    varchar(512),
    original_collection_id  bigint,
    importTimestamp         timestamp with time zone,
    original_game_id        bigint,
    in_box_with_id          bigint,
    gamename                varchar(255),
    publisher               varchar(255),
    gamestate               varchar(255),
    barcode                 varchar(512) unique,
    added_to_collection_at  timestamp with time zone,

    like templates._base including all,
    foreign key(game_id) references games(id) on update cascade on delete RESTRICT,
    foreign key(collection_id) references collections(id) on update cascade on delete RESTRICT,
    foreign key(group_id) references groups(id) on update cascade on delete RESTRICT,
    foreign key(storage_id) references storages(id) on update cascade on delete restrict,
    foreign key(donor_id) references donors(id) on update cascade on delete set null,
    foreign key(original_collection_id) references collections(id) on update cascade on delete restrict,
    foreign key(original_game_id) references collectiongames(id) on update cascade on delete restrict,
    foreign key(in_box_with_id) REFERENCES collectiongames(id) on update cascade on delete restrict,
    foreign key(shelve_id) references shelves(id) on update cascade on delete restrict
);

comment on table collectiongames is 'Collection games';
comment on column collectiongames.collection_id is 'Collection owning this game';
comment on column collectiongames.game_id is 'Game definition for this collection game';
comment on column collectiongames.group_id is 'Owner of the game';
comment on column collectiongames.donor_id is 'Donor of this game';
comment on column collectiongames.shelve_id is 'Shelf this game can be found';
comment on column collectiongames.shelf_place is 'Place on the shelf';
comment on column collectiongames.condition is 'Game condition';
comment on column collectiongames.note is 'Note';
comment on column collectiongames.original_collection_id is 'Games id on it''s original collection';
comment on column collectiongames.gamename is 'Name of the game';
comment on column collectiongames.publisher is 'Game publisher';
comment on column collectiongames.gamestate is 'Collection state for the game';
comment on column collectiongames.barcode is 'Barcode for the game';
comment on column collectiongames.in_box_with_id is 'This game/expansion is packed with this game';
comment on column collectiongames.added_to_collection_at is 'When this game was added to the collection';