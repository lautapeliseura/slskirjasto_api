drop view if exists vLoans;
create view vLoans as
select 
        lainattu as lent_at
        , palautettu as returned_at
        , kp.tunniste as collectiongame_id
        , p.nimi as game_id
        , case when lainaaja~*'\d+' then true else false end as slsmember
        , tapahtuma as event_id
from 
        laina as l
join
        kokoelmapeli as kp
on (l.kokoelmapeli=kp.tunniste)
join
        peli as p
on (kp.peli=p.tunniste)        
where 
        pantti<>'Kokoelmalaina';
        
-- select count(*) from vLoans;        