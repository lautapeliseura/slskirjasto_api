drop view if exists vcollectiongames;
create view vcollectiongames as
select 
        kokoelma as collection_name
        , p.nimi as gamename
        , case 
                when k.omistaja='daFool' then 'Norkkokujan Sirkus'
                when k.omistaja='SLS' then 'SLS'
                else null
        end as group_name
        , replace(k.lahjoittaja,';','.') as donor_name
        , k.paikka as shelf_place
        , k.kunto as condition
        , replace(k.huomautus, ';','.') as note
        , k.tunniste as barcode
        , p.julkaisija as publisher
        , k.lisatty as added_to_collection_at
        , k.peli as oldgameid
from
        kokoelmapeli as k        
join
        peli as p
on (k.peli=p.tunniste);
-- select * from vcollectiongames where note~'Ei nappu'
