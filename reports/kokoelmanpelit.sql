-- Luettelo valitun kokoelman peleistä
-- Listaa kaikki valitun kokoelman pelit
-- VARIABLE: { name: "collection_id", display: "Valitse kokoelma", type: "select", database_options: { table: "collections", column : "id", display : "collection_name", where :"'{\"PUBLIC\"}' <@publicity order by collection_name asc"}}

select 
       gamename as "Pelin nimi"
       ,case when gamestate is null then 'Tuntematon' else gamestate end as "Pelin tila"
       ,donor_name as "Lahjoittaja"
       ,case when shelve_name is null then 'Tuntematon' else shelve_name end as "Hyllyn tunniste"
       ,shelf_place as "Hyllpaikka"
       ,condition as "Pelin kunto"
       ,note as "Huomautukset"
       ,barcode as "Viivakoodi"
       ,added_to_collection_at as "Lisätty kokoelmaan"
       ,case when c.collection_name is null then '*' else c.collection_name end as "Tuotu kokoelmasta"
from 

        collectiongames as cg
left outer join
(
  select 
        collection_name
        ,id       
  from collections       
) as c
on (cg.collection_id is not null and original_collection_id=c.id)  
left outer join
(
  select
        donor_name
        ,id
  from donors
) as d
on (cg.donor_id=d.id)
left outer join
(
  select
        shelve_name
        ,id
  from shelves
) as h
on (cg.shelve_id = h.id)
where cg.collection_id = {{ collection_id }};