# Check Synonyms
 Procedure to check synonym's health

This procedure checks the health of all public and schema specific private synonyms.

It's valid for TABLES, VIEWS and MATERIALIZED VIEWS, as it raises a SELECT statement for all synonyms under a specific schema and public synonyms.

NOTE: This procedure doesn't check PROCEDURES, FUNCTIONS or PACKAGES as their execution may be much more intrusive.

