drop table if exists collections CASCADE;

create table collections (
    collection_name     varchar(512) unique not null,
    collection_class    varchar(20),
    group_id            bigint,
    event_id            bigint,
    publicity           varchar(200)[],

    like templates._base including all,
    foreign key(event_id) references events(id) on delete RESTRICT on update cascade,
    foreign key(group_id) references groups(id) on delete RESTRICT on update cascade
);

comment on table collections is 'Game collections';
comment on column collections.collection_name is 'Name of the collection';
comment on column collections.collection_class is 'Type of the collection';
comment on column collections.group_id is 'Owner of the collection';
comment on column collections.event_id is 'If this an event collection a foreign key to that event';
comment on column collections.publicity is 'Publicity attributes for this collection';