drop table if exists events cascade;

create table events (
    event_name      varchar(512),
    event_location  varchar(512),
    event_starts    timestamp with time zone,
    event_ends      timestamp with time zone,

    group_id        bigint, 
    publicity       varchar(255)[],

    like templates._base including all
);

comment on table events is 'Events';
comment on column events.event_location is 'Place of the event';
comment on column events.event_starts is 'Start time of the event';
comment on column events.event_ends is 'End time of the event';
comment on column events.group_id is 'Owner of this event';
comment on column events.publicity is 'Publicity of this event';