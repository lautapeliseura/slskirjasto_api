drop table if exists roles CASCADE;

create table roles (
    role_name           varchar(255) not null unique,
    role_description    varchar(512),

    user_id             bigint,
    like templates._base including all
);

comment on table roles is 'User roles for the system';
comment on column roles.role_name is 'Name of the role';
comment on column roles.role_description is 'Purpose of the role';
comment on column roles.user_id is 'Owner of the role description';
