# DB_FARM=/Users/vitor/Documents/repository/rest-dfa/db_farm
#recipes/database/DfAnalyzer/
# recipes/database/DfAnalyzer/
DB_FARM=$PWD/DfAnalyzer/data
SQL_PATH=$PWD/DfAnalyzer/monetdb/sql

monetdbd stop $DB_FARM
rm -rf $DB_FARM
monetdbd create $DB_FARM
monetdbd start $DB_FARM

monetdb create -p monetdb dataprov
monetdb create -p monetdb contprov

monetdb start dataprov
monetdb start contprov


# running SQL scripts
mclient -d dataprov $SQL_PATH/create-schema.sql
mclient -d dataprov $SQL_PATH/database-script.sql

mclient -d contprov $SQL_PATH/create-schema.sql
mclient -d contprov $SQL_PATH/provdeploy-schema.sql
