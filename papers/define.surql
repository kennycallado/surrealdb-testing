-- table
DEFINE TABLE papers SCHEMAFULL PERMISSIONS NONE;

-- fields
DEFINE FIELD user       ON TABLE papers TYPE record<users>;
DEFINE FIELD resource   ON TABLE papers TYPE record<resource>;
DEFINE FIELD completed  ON TABLE papers TYPE bool DEFAULT false;

-- indexes

-- events
DEFINE EVENT create_paper ON TABLE papers WHEN $event = "CREATE" THEN {
  LET $project = (SELECT value id FROM projects);
  RELATE $project->project_papers->$value;
};

DEFINE EVENT papers_log ON TABLE papers WHEN $event = "CREATE" OR $event = "UPDATE" OR $event = "DELETE" THEN {
  IF $event = 'DELETE' {
    CREATE logs SET index = $before.id, event = $event, time = time::now();
  } ELSE {
    CREATE logs SET index = $value.id, event = $event, time = time::now();
  }
};

 -- usuario recibe paper
 -- usuario push paper
