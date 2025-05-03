# DB_FARM=/Users/vitor/Documents/repository/rest-dfa/db_farm
DFA_dir=$PWD/recipes/database/DfAnalyzer
DB_FARM=$DFA_dir/data
SQL_PATH=$DFA_dir/monetdb/sql
#monetdbd create $DB_FARM
#rm -rf $DB_FARM
#se o diretório do data não existir, dá o unzip
[ ! -d "$DFA_dir/data" ]  && unzip $DFA_dir/data-provdeploy.zip -d $DFA_dir
#monetdbd stop $DB_FARM
monetdbd start $DB_FARM

monetdb status

