SELECT array_to_string(ARRAY(SELECT 'ALTER TABLE ' || quote_ident(c.table_schema) || '.'
  || quote_ident(c.table_name) || ' RENAME "' || c.column_name || '" TO ' || quote_ident(lower(replace(c.column_name, ' ','_'))) || ';'
  FROM information_schema.columns As c
  WHERE c.table_schema NOT IN('information_schema', 'pg_catalog')
      AND c.column_name <> lower(c.column_name)
  ORDER BY c.table_schema, c.table_name, c.column_name
  ) ,
   E'\r') As ddlsql;
