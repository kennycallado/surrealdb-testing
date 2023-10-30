-- table
DEFINE TABLE papers SCHEMAFULL PERMISSIONS NONE;

-- fields
DEFINE FIELD users      ON TABLE papers TYPE record<users>;
DEFINE FIELD project    ON TABLE papers TYPE record<project>;
DEFINE FIELD resource   ON TABLE papers TYPE record<resource>;
DEFINE FIELD completed  ON TABLE papers TYPE bool DEFAULT false;

-- relations

-- events
 -- usuario recibe paper
 -- usuario push paper

-- indexes
