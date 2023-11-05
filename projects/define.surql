-- table
DEFINE TABLE projects SCHEMAFULL PERMISSIONS NONE;

-- fields
DEFINE FIELD name ON TABLE projects TYPE string;
DEFINE FIELD keys ON TABLE projects FLEXIBLE TYPE option<array<string>>;

-- indexes

-- events
DEFINE EVENT projects_log ON TABLE projects WHEN $event = "CREATE" OR $event = "UPDATE" OR $event = "DELETE" THEN {
  IF $event = 'DELETE' {
    CREATE logs SET index = $before.id, event = $event, time = time::now();
  } ELSE {
    CREATE logs SET index = $value.id, event = $event, time = time::now();
  }
};
