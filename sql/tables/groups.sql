drop table if exists groups CASCADE;
create table groups (
    group_name      varchar(255) not null unique,
    group_purpose   varchar(512),
    group_type      varchar(20) default 'System',
    user_id         bigint,

    like templates._base including all,
    foreign key(user_id) references users(id) on update cascade on delete restrict
);

comment on table groups is 'User groups';
comment on column groups.group_name is 'Name of the group';
comment on column groups.group_purpose is 'What this group is all about';
comment on column groups.user_id is 'User owning this group definition';
