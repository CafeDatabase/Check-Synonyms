-- DEMO of CHECK_SYNONYMS procedure

create user juan identified by juan;
grant connect, resource, dba to juan;
connect juan/juan

create table test (id number);
create public synonym test for juan.test;
drop table test;

connect / as sysdba

set serveroutput on
set lines 140
exec CHECK_SYNONYMS('JUAN')


/*
SQL> exec CHECK_SYNONYMS('JUAN')
Bucle en sinonimo PUBLIC.TEST apuntando a JUAN.TEST

Procedimiento PL/SQL terminado correctamente.
*/