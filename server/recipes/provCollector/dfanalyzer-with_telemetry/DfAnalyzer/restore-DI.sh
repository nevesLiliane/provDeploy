
db_farm=$PWD/data
sql_path=./monetdb/sql

monetdbd create $db_farm
monetdbd stop $db_farm
monetdbd start $db_farm
monetdb destroy -f dataflow_analyzer
monetdb create dataflow_analyzer
monetdb release dataflow_analyzer
monetdb status


mclient -p 50000 -d dataflow_analyzer $sql_path/create-schema.sql
mclient -p 50000 -d dataflow_analyzer $sql_path/database-script-com-epoch-telemetria-environment-dataflow-execution.sql
#mclient -p 50000 -d test sql/dataflow.sql
