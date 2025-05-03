# DB_FARM=/Users/vitor/Documents/repository/rest-dfa/db_farm
DB_FARM=$PWD/recipes/database/DfAnalyzer/data
SQL_PATH=$PWD/recipes/database/DfAnalyzer/monetdb/sql
#monetdbd create $DB_FARM
rm -rf $PWD/recipes/database/DfAnalyzer/data
#unzip data-local.zip

unzip $DB_FARM/data-provdeploy.zip
#monetdbd stop $DB_FARM
monetdbd start $DB_FARM
#monetdb destroy -f dataflow_analyzer
#monetdb create dataflow_analyzer
monetdb status
# running SQL scripts
#mclient -p 50000 -d dataflow_analyzer $SQL_PATH/create-schema.sql
#mclient -p 50000 -d dataflow_analyzer $SQL_PATH/database-script.sql

#monetdb destroy -f dfa_server_db
#monetdb create dfa_server_db
#mclient -p 50001 -d dfa_server_db $SQL_PATH/create-schema.sql
#mclient -p 50001 -d dfa_server_db $SQL_PATH/dfa-database-script.sql
