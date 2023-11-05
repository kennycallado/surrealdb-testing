-- table
DEFINE TABLE slides SCHEMAFULL PERMISSIONS FOR SELECT WHERE $auth;

-- fields
DEFINE FIELD title    ON TABLE slides TYPE string;
DEFINE FIELD content  ON TABLE slides TYPE option<string>;
DEFINE FIELD media    ON TABLE slides TYPE option<record<media>>;
DEFINE FIELD type     ON TABLE slides TYPE string ASSERT $value INSIDE ['content', 'input'];
DEFINE FIELD question ON TABLE slides TYPE option<record<questions>> ASSERT $value IS None OR type = 'input' AND questions = None;

DEFINE FIELD questions    ON TABLE slides TYPE option<array> ASSERT $value IS None OR type = 'input' AND question = NONE;
DEFINE FIELD questions.*  ON TABLE slides TYPE record<questions>;

-- indexes

-- events
-- -- logs
DEFINE EVENT slides_log ON TABLE slides WHEN $event = "CREATE" OR $event = "UPDATE" OR $event = "DELETE" THEN {
  IF $event = 'DELETE' {
    CREATE logs SET index = $before.id, event = $event, time = time::now();
  } ELSE {
    CREATE logs SET index = $value.id, event = $event, time = time::now();
  }
};
