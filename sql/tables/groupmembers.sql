drop table if exists groupmembers;

create table groupmembers (
    user_id     bigint not null,
    role_id     bigint not null,
    group_id     bigint not null,

    like templates._base including ALL,
    foreign key(user_id) REFERENCES users(id) on update cascade on delete cascade,
    foreign key(role_id) references roles(id) on update cascade on delete cascade,
    foreign key(group_id) references groups(id) on update cascade on delete cascade
);

comment on table groupmembers is 'Members of the groups';
comment on column groupmembers.user_id is 'Member user';
comment on column groupmembers.role_id is 'Member role in the group';
comment on column groupmembers.group_id is 'Group';