-- table
DEFINE TABLE media SCHEMAFULL PERMISSIONS NONE;

-- fields
DEFINE FIELD name ON TABLE media TYPE string;
DEFINE FIELD url  ON TABLE media TYPE string ASSERT string::is::url($value);
DEFINE FIELD type ON TABLE media TYPE string ASSERT $value INSIDE ['image', 'video'];

-- indexes

-- events
DEFINE EVENT media_log ON TABLE media WHEN $event = "CREATE" OR $event = "UPDATE" OR $event = "DELETE" THEN {
  IF $event = 'DELETE' {
    CREATE logs SET index = $before.id, event = $event, time = time::now();
  } ELSE {
    CREATE logs SET index = $value.id, event = $event, time = time::now();
  }
};
