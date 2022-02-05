-- Julkiset pelikokoelmat
-- Antaa luettelon kaikista julkiseksi merkityistä pelikirjastoista kannassa

select 
        collection_name as "Kokoelman nimi"
        , case 
                when collection_class='Event' then 'Tapahtuma'
                when collection_class='Permanent' then 'Pysyvä'
                else 'Tuntematon tyyppi'
        end as "Kokoelman laji"
        , case 
                when event_starts is not null then
                        cast(event_starts as varchar)
                else
                        '*'
                end as "Tapahtuman alkuaika"
        , case
                when event_ends is not null then
                        cast(event_ends as varchar)
                else
                        '*'
                end as "Tapahtuman päätöshetki"
        , case
                when event_location is not null then
                        event_location
                else
                        '*'
                end as "Tapahtumapaikka"
        , c.created_at as "Kokoelma tuotu kantaan"
        , c.updated_at as "Kokoelman perustietoja muokattu viimeksi kannassa"
from 
(
        select 
                * 
        from 
                collections 
        where
                '{"PUBLIC"}' <@ publicity
)                        
as c
left outer join
        events as e        
on (c.event_id=e.id)
order by
        collection_name;
