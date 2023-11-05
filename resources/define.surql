-- table
DEFINE TABLE resources SCHEMAFULL PERMISSIONS
  FOR select WHERE $auth.id;

-- fields
DEFINE FIELD title        ON TABLE resources TYPE string;
DEFINE FIELD description  ON TABLE resources TYPE string;
DEFINE FIELD type         ON TABLE resources TYPE string ASSERT $value INSIDE ['slides','module','form','external'];
DEFINE FIELD form         ON TABLE resources TYPE option<array<record<questions>>> ASSERT $value IS None OR type = 'form';

DEFINE FIELD module ON TABLE resources TYPE option<array<record<slides>>>;
DEFINE FIELD slides ON TABLE resources TYPE option<array<record<slides>>>;

-- DEFINE FIELD slides       ON TABLE resources TYPE option<array<record<slides>>> ASSERT $value IS None    OR type = 'slides';
-- DEFINE FIELD module       ON TABLE resources TYPE option<array<record<slides>>> ASSERT $value IS None    OR type = 'module';
-- DEFINE FIELD form         ON TABLE resources TYPE option<array<record<questions>>> ASSERT $value IS None OR type = 'form';

-- indexes

-- events
DEFINE EVENT resources_log ON TABLE resources WHEN $event = "CREATE" OR $event = "UPDATE" OR $event = "DELETE" THEN {
  IF $event = 'DELETE' {
    CREATE logs SET index = $before.id, event = $event, time = time::now();
  } ELSE {
    CREATE logs SET index = $value.id, event = $event, time = time::now();
  }
};
