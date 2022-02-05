drop table if exists shelves cascade;

create table shelves (
    shelve_name     varchar(255) not null,
    storage_id      bigint,
    group_id        bigint,

    like templates._base including all,
    foreign key(storage_id) references storages(id) on update cascade on delete cascade,
    foreign key(group_id) references groups(id) on update cascade on delete cascade
);

comment on table shelves is 'Shelves in storage';
comment on column shelves.shelve_name is 'Name/identifier of the shelve';
comment on column shelves.storage_id is 'Which storage has this shelve';
comment on column shelves.group_id is 'Owner of the shelve';