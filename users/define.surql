-- table
DEFINE TABLE users SCHEMAFULL PERMISSIONS NONE;
  -- FOR update WHERE id = $auth AND 'admin' IN (SELECT VALUE role FROM users WHERE id = $auth) AND $value.role != 'admin';

-- views
-- the idea es mantener tablas privadas y exponer views
DEFINE TABLE public_users AS SELECT id, name, email, role FROM users;

-- fields
DEFINE FIELD name     ON users TYPE string;
DEFINE FIELD pass     ON users TYPE string;
DEFINE FIELD role     ON users TYPE string ASSERT $value INSIDE ['admin', 'user', 'guest'] DEFAULT 'user';
DEFINE FIELD email    ON users TYPE string ASSERT string::is::email($value);
DEFINE FIELD active   ON users TYPE bool DEFAULT true;
DEFINE FIELD project  ON users TYPE record<projects> DEFAULT (SELECT VALUE id FROM projects)[0];
DEFINE FIELD created  ON users TYPE datetime DEFAULT time::now();

-- indexes
DEFINE INDEX email ON users FIELDS email UNIQUE;

-- events
-- -- logs
DEFINE EVENT users_log ON TABLE users WHEN $event = "CREATE" OR $event = "UPDATE" OR $event = "DELETE" THEN {
  IF $event = 'DELETE' {
    CREATE logs SET index = $before.id, event = $event, time = time::now();
  } ELSE {
    CREATE logs SET index = $value.id, event = $event, time = time::now();
  }
};
