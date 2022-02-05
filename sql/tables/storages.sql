drop table if exists storages cascade;

create table storages (
    storage_name    varchar(512) unique,
    group_id         bigint,
    note            varchar(512),
    publicity       varchar(255)[],

    like templates._base including all,
    foreign key(group_id) REFERENCES groups(id)
);

comment on table storages is 'Locations for game collections';
comment on column storages.storage_name is 'Name of the storage';
comment on column storages.group_id is 'Owner of the storage';
comment on column storages.note is 'Free text about the storage';
comment on column storages.publicity is 'Publicity level of the information';