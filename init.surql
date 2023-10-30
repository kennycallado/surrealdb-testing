USE NS test DB base;

--

DEFINE TABLE logs SCHEMAFULL PERMISSIONS NONE;

DEFINE FIELD index ON logs TYPE record;
DEFINE FIELD event ON logs TYPE string;
DEFINE FIELD time  ON logs TYPE datetime;

--

DEFINE TABLE users SCHEMAFULL PERMISSIONS
  FOR select, update WHERE id = $auth.id;

DEFINE FIELD name     ON users TYPE string;
DEFINE FIELD pass     ON users TYPE string;
DEFINE FIELD email    ON users TYPE string ASSERT string::is::email($value);
DEFINE FIELD active   ON users TYPE bool DEFAULT false;
DEFINE FIELD project  ON users TYPE record<projects>;

DEFINE EVENT user_log ON TABLE users WHEN $event = "CREATE" OR $event = "UPDATE" OR $event = "DELETE" THEN (
  CREATE logs SET index = $value.id, event = $event, time = time::now()
);

DEFINE INDEX email ON users FIELDS email UNIQUE;

--

DEFINE TABLE store SCHEMAFULL PERMISSIONS NONE;

DEFINE FIELD in  ON TABLE store TYPE record<user>;
DEFINE FIELD out ON TABLE store TYPE record<records>;

--

-- table
DEFINE TABLE projects SCHEMAFULL PERMISSIONS NONE;

-- fields
DEFINE FIELD name ON TABLE projects TYPE string;
DEFINE FIELD keys ON TABLE projects FLEXIBLE TYPE option<array<string>>;

-- events
DEFINE EVENT project_log ON TABLE projects WHEN $event = "CREATE" OR $event = "UPDATE" OR $event = "DELETE" THEN (
  CREATE logs SET index = $value.id, event = $event, time = time::now()
);

-- index

--

DEFINE TABLE records SCHEMALESS PERMISSIONS NONE;
# DEFINE FIELD record ON TABLE records FLEXIBLE TYPE array<object>;

DEFINE EVENT user_store ON TABLE records WHEN $event = 'CREATE' THEN {
  LET $user = $auth.id;
  LET $record = $after.id;

  RELATE $user->store->$record SET created = time::now()
};

RELATE slides:lju5iqyf04fwxp7i1den->store->projects:zdkwis2qy5qygxyux6sp SET created = time::now();

--

DEFINE TABLE questions SCHEMALESS PERMISSIONS NONE;

DEFINE FIELD question.locale ON TABLE questions TYPE object;
DEFINE FIELD question.content ON TABLE questions TYPE object;

--

DEFINE TABLE media SCHEMALESS PERMISSIONS NONE;
DEFINE FIELD name ON TABLE media TYPE string;
DEFINE FIELD url ON TABLE media TYPE string
  ASSERT string::is::url($value);
DEFINE FIELD type ON TABLE media TYPE string
  ASSERT $value INSIDE ['image', 'video'];

--

-- DEFINE TABLE slides SCHEMALESS PERMISSIONS NONE;
DEFINE TABLE slides SCHEMALESS PERMISSIONS FOR SELECT WHERE $auth.id;
DEFINE FIELD type ON TABLE slides TYPE string
  ASSERT $value INSIDE ['content', 'input'];
DEFINE FIELD title ON TABLE slides TYPE string;
DEFINE FIELD content ON TABLE slides TYPE string;
DEFINE FIELD media ON TABLE slides TYPE option<record<media>>;
DEFINE FIELD question ON TABLE slides TYPE option<record<questions>>
  ASSERT $value IS None OR type = 'input';

--

-- DEFINE TABLE resources SCHEMALESS PERMISSIONS NONE;

DEFINE TABLE resources SCHEMALESS PERMISSIONS FOR SELECT WHERE $auth.id;

DEFINE FIELD type ON TABLE resources TYPE string ASSERT $value INSIDE ['slides','module','form','external'];
DEFINE FIELD title ON TABLE resources TYPE string;
DEFINE FIELD description ON TABLE resources TYPE string;
DEFINE FIELD slides ON TABLE resources TYPE option<array<record<slides>>>
  ASSERT $value IS None OR type = 'slides';
DEFINE FIELD module ON TABLE resources TYPE option<array<record<slides>>>
  ASSERT $value IS None OR type = 'module';
DEFINE FIELD form ON TABLE resources TYPE option<array<record<questions>>>
  ASSERT $value IS None OR type = 'form';

--

DEFINE TABLE papers SCHEMALESS PERMISSIONS NONE;
DEFINE FIELD users ON TABLE papers TYPE record<users>;
DEFINE FIELD resource ON TABLE papers TYPE record<resource>;
DEFINE FIELD project ON TABLE papers TYPE record<project>;
DEFINE FIELD completed ON TABLE papers TYPE bool;

--

DEFINE TABLE answers SCHEMALESS PERMISSIONS NONE;
DEFINE FIELD paper ON TABLE answers TYPE record<paper>;
DEFINE FIELD answer ON TABLE answers TYPE string;

--

DEFINE SCOPE user SESSION 1d
  SIGNUP (CREATE users SET email = $email, pass = crypto::argon2::generate($pass), name = $name, active = true, project = $project, created = time::now())
  SIGNIN (SELECT * FROM users WHERE email = $email AND crypto::argon2::compare(pass, $pass));

--
