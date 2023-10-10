-- Ensure user has DBA privileges.
create or replace procedure CHECK_SYNONYMS (p_owner varchar2) 
is
  usuario varchar2(30);
  bucle_sinonimos exception;
	sinonimo_no_valido exception;
	PRAGMA EXCEPTION_INIT(bucle_sinonimos,-1775);
	PRAGMA EXCEPTION_INIT(sinonimo_no_valido,-980);
	filas number;
begin 
  dbms_output.enable;
  for x in (select owner, synonym_name,table_owner,table_name,NVL2(db_link,'@'||db_link,null) db_link 
              from dba_synonyms where owner IN (p_owner,'PUBLIC'))
			  -- It takes time to check SYS synonyms, but I think it's worth it.
	loop
	   begin 
		     select DECODE(x.owner,'PUBLIC','',x.owner||'.') into usuario from dual;
			 execute immediate 'select count(*) into :filas from '||usuario||x.synonym_name||' where 1=0' into filas;
	   exception 
		   when bucle_sinonimos then 
			   dbms_output.put_line('Synonym in a loop chain '||x.owner||'.'||x.synonym_name||' pointing to '
				            ||x.table_owner||'.'||x.table_name||x.db_link);
									
		   when sinonimo_no_valido then 
			   dbms_output.put_line('Synonym not valid '||x.owner||'.'||x.synonym_name||'  pointing to '
				            ||x.table_owner||'.'||x.table_name||x.db_link);
			 when others then null;
	   end;
	end loop;
end;
/