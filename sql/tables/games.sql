drop table if exists games CASCADE;
create table games (
    names       varchar(255)[],
    designers   varchar(255)[],
    publishers  varchar(255)[],

    gtin        varchar(512),
    source      varchar(512),

    bggurl          varchar(512) UNIQUE,
    bggrank         int,
    bggdate         timestamp with time zone,
    bggscore        numeric,

    durationmin     int,
    durationmax     int,
    minplayers      int,
    maxplayers      int,
    yearpublished   int,
    agesince        int,
    ageuntil        int,

    oldid           int,
    like templates._base including all
);

comment on table games is 'Game database';
comment on column games.names is 'Published names of the game';
comment on column games.designers is 'Game designers';
comment on column games.publishers is 'Game publishers';
comment on column games.gtin is 'Barcode on the game box itself';
comment on column games.source is 'Where this game data comes from?';
comment on column games.bggurl is 'Board game geek url of this game';
comment on column games.bggrank is 'General rank of the game on bgg';
comment on column games.bggscore is 'Board game gee score for the game';
comment on column games.durationmin is 'Min duration for the game in minutes';
comment on column games.durationmax is 'Max duration for the game in minutes';
comment on column games.minplayers is 'Minimum number of players';
comment on column games.maxplayers is 'Maximum number of players';
comment on column games.yearpublished is 'When this game was published';
comment on column games.agesince is 'Minimum age of players';
comment on column games.ageuntil is 'Maxmimum age of players';
comment on column games.oldid is 'Old database id for the game';