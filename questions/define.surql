-- table
DEFINE TABLE questions SCHEMAFULL PERMISSIONS
  FOR select WHERE $auth.id;

-- fields
DEFINE FIELD question ON TABLE questions TYPE array ASSERT array::len($value) < 4 AND array::len($value) > 0;

DEFINE FIELD type               ON TABLE questions TYPE string ASSERT $value INSIDE ['range', 'input'];
DEFINE FIELD question.*         ON TABLE questions TYPE object;
DEFINE FIELD question.*.locale  ON TABLE questions TYPE string ASSERT $value INSIDE ['vl', 'es', 'en'];
DEFINE FIELD question.*.content ON TABLE questions TYPE string;

-- indexes

-- events
DEFINE EVENT create_question ON TABLE questions WHEN $event = "CREATE" THEN {
  LET $project = (SELECT VALUE id FROM projects);
  RELATE $project->project_questions->$value;
};

DEFINE EVENT questions_log ON TABLE questions WHEN $event = "CREATE" OR $event = "UPDATE" OR $event = "DELETE" THEN {
  IF $event = 'DELETE' {
    CREATE logs SET index = $before.id, event = $event, time = time::now();
  } ELSE {
    CREATE logs SET index = $value.id, event = $event, time = time::now();
  }
};
