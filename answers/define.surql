-- table
DEFINE TABLE answers SCHEMAFULL PERMISSIONS NONE;

-- fields
DEFINE FIELD paper  ON TABLE answers TYPE record<paper>;
DEFINE FIELD answer ON TABLE answers TYPE string;

-- indexes

-- events
DEFINE EVENT answers_log ON TABLE answers WHEN $event = "CREATE" OR $event = "UPDATE" OR $event = "DELETE" THEN (
  CREATE logs SET index = $value.id, event = $event, time = time::now()
);
