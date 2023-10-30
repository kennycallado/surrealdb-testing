-- table
DEFINE TABLE questions SCHEMAFULL PERMISSIONS
  FOR select WHERE $auth.id;

-- fields
DEFINE FIELD question ON TABLE questions TYPE array;
DEFINE FIELD question.* ON TABLE questions TYPE object;

DEFINE FIELD question.*.locale ON TABLE questions TYPE string;
DEFINE FIELD question.*.content ON TABLE questions TYPE string;

-- relations

-- events

-- indexes
