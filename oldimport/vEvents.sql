drop view if exists vEvents;
create view vEvents as 
select 
        nimi as event_name
        ,sijainti as event_location
        ,alkaa as event_starts
        ,loppuu as event_ends
from tapahtuma;