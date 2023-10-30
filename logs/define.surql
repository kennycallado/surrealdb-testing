-- table
DEFINE TABLE logs SCHEMAFULL PERMISSIONS NONE;

-- fields
DEFINE FIELD index ON logs TYPE record;
DEFINE FIELD event ON logs TYPE string;
DEFINE FIELD time  ON logs TYPE datetime;

-- relations

-- eventes

-- indexes
