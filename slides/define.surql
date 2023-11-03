-- table
DEFINE TABLE slides SCHEMAFULL PERMISSIONS
  FOR SELECT WHERE $auth.id;

-- fields
DEFINE FIELD title    ON TABLE slides TYPE string;
DEFINE FIELD content  ON TABLE slides TYPE string;
DEFINE FIELD media    ON TABLE slides TYPE option<record<media>>;
DEFINE FIELD type     ON TABLE slides TYPE string ASSERT $value INSIDE ['content', 'input'];
DEFINE FIELD question ON TABLE slides TYPE option<record<questions>> ASSERT $value IS None OR type = 'input';

-- indexes

-- events
