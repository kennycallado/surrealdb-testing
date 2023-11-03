-- table
DEFINE TABLE users SCHEMAFULL PERMISSIONS
  FOR select, update WHERE id = $auth.id;

-- fields
DEFINE FIELD name     ON users TYPE string;
DEFINE FIELD pass     ON users TYPE string;
DEFINE FIELD email    ON users TYPE string ASSERT string::is::email($value);
DEFINE FIELD active   ON users TYPE bool DEFAULT false;
DEFINE FIELD project  ON users TYPE record<projects>;

-- indexes
DEFINE INDEX email ON users FIELDS email UNIQUE;

-- events
DEFINE EVENT user_log ON TABLE users WHEN $event = "CREATE" OR $event = "UPDATE" OR $event = "DELETE" THEN (
  CREATE logs SET index = $value.id, event = $event, time = time::now()
);
