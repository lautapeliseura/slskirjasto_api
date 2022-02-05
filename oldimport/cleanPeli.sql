begin;
create temporary table bar as
with foo as (
select 
        tunniste
        ,lisatty
        ,bgglinkki 
        ,lead(tunniste,1) over (order by bgglinkki, lisatty desc) as seuraava 
        ,lead(lisatty, 1) over (order by bgglinkki, lisatty desc) as seuraavalisatty
        ,lead(bgglinkki,1) over (order by bgglinkki, lisatty desc) as seuraavalinkki
from 
        peli 
where 
        bgglinkki in (
                select 
                        bgglinkki 
                from 
                        peli 
                where 
                        bgglinkki<>'' 
                group by 
                        bgglinkki 
                having count(*)>1
        ) 
order by 
        bgglinkki, 
        lisatty desc 
)
select tunniste,seuraava, bgglinkki from foo where bgglinkki=seuraavalinkki;
delete from bar where tunniste in (select seuraava from bar);
update kokoelmapeli k set peli=bar.tunniste from bar where k.peli=bar.seuraava;
select * from bar order by bgglinkki;
select count(*) from kokoelmapeli;
delete from peli where tunniste in (select seuraava from bar);
select count(*) from kokoelmapeli;
--select bgglinkki from peli  where bgglinkki<>'' group by bgglinkki having count(*)>1;
commit;
drop table bar;
-- select * from kokoelmapeli where kunto is not null and kunto<>''

