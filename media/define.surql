-- table
DEFINE TABLE media SCHEMAFULL PERMISSIONS NONE;

-- fields
DEFINE FIELD name ON TABLE media TYPE string;
DEFINE FIELD url  ON TABLE media TYPE string ASSERT string::is::url($value);
DEFINE FIELD type ON TABLE media TYPE string ASSERT $value INSIDE ['image', 'video'];

-- indexes

-- events
