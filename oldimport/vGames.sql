drop materialized view if exists vGames;
create materialized view vGames as
select 
        case when nimet is null then array [ nimi ] else nimet end as names
        , array [ suunnittelija ] as designers
        , case when julkaisijat is null then array [ julkaisija ] else julkaisijat end as publishers
        , gtin
        , 'SLSKirjasto old' as source
        , bgglinkki as bggurl
        , bggrank
        , bggdate
        , score as bggscore
        , cast(kesto as int) as durationmin
        , null as durationmax
        , case 
                when pelaajia is null or pelaajia='' then null 
                else cast(substring(pelaajia from '^(\d+)\s*-?') as int) 
        end as minplayers
        , case
                when pelaajia is null or pelaajia='' then null
                when not pelaajia~*'\s*-\s*\d+' then cast(substring(pelaajia from '^(\d+)\s*-?') as int) 
                else cast(substring(pelaajia from '^[0-9]+\s*-\s*(\d*)') as int)
       end as maxplayers
       , vuosi as yearpublished
       , age as agesince
       , null as ageuntil
       , tunniste as oldid
       
from 
        peli 
where
        nimi is not null 
        and not nimi='';
        
refresh materialized view vGames;        