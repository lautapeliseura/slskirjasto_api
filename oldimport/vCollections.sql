drop view if exists vCollections;
create view vCollections as
select 
        nimi as collection_name
        ,case laji
                when 0 then 'Event'
                when 1 then 'Permanent'
        end as collection_class
        , case 
                when omistaja='daFool' then 'Norkkokujan Sirkus'
                else 'SLS'
        end as group_name
        , tapahtuma as event_name
        , '{"PUBLIC"}' as publicity
from kokoelma;
