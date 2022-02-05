truncate table groups cascade;
insert into groups (group_name, group_purpose, created_at, created_by) values ('Norkkokujan Sirkus', 'Fuula-sedän pelikokoelman ylläpitoryhmä', now(), 'Initial load');
insert into groups (group_name, group_purpose, created_at, created_by) values ('SLS', 'Suomen lautapeliseura ry:n pelikokoelman ylläpitoryhmä', now(), 'Initial load');
insert into groups (group_name, group_purpose, created_at, created_by) values ('Taikaviitat', 'Koko järjestelmän ylläpitoryhmä', now(), 'Initial load');

truncate table roles cascade;
insert into roles (role_name, role_description, created_at, created_by) values ('Owner', 'The owner of a subject', now(), 'Initial load');
insert into roles (role_name, role_description, created_at, created_by) values ('Admin', 'Operator of a subject', now(), 'Initial load');
insert into roles (role_name, role_description, created_at, created_by) values ('ServiceManager', 'Can lend out games and return them', now(), 'Initial load');