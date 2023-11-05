-- table
DEFINE TABLE answers SCHEMAFULL PERMISSIONS NONE;

-- fields
DEFINE FIELD answer ON TABLE answers TYPE string;
DEFINE FIELD paper  ON TABLE answers TYPE record<paper>;

-- indexes

-- events
DEFINE EVENT answers_log ON TABLE answers WHEN $event = "CREATE" OR $event = "UPDATE" OR $event = "DELETE" THEN {
  IF $event = 'DELETE' {
    CREATE logs SET index = $before.id, event = $event, time = time::now();
  } ELSE {
    CREATE logs SET index = $value.id, event = $event, time = time::now();
  }
};
