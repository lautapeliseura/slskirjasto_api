drop view if exists "vOwnergroupmembers";
create view "vOwnergroupmembers" as
select group_name, group_purpose, user_id, id, group_type from groups where group_type='Owner'
union
(
        
        select g.group_name, group_purpose, gm.user_id, g.id, group_type from                 
                        groupmembers as gm
                join
                        (select * from groups where group_type='Owner') as g
                on (gm.group_id=g.id)
);