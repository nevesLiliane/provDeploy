-- msqldump version 11.45.13 (Sep2022-SP2) dump database
-- server: MonetDB v11.33.11 (Apr2019), 'mapi:monetdb://liliane-iMac20-1:50000/dfa_server_db'
-- Tue May  2 15:42:02 2023
START TRANSACTION;
SET SCHEMA "public";
CREATE SEQUENCE "public"."config_id_seq" AS INTEGER;
CREATE SEQUENCE "public"."execution_id_seq" AS INTEGER;
CREATE TABLE "public"."config" (
	"id"                INTEGER       NOT NULL,
	"name"              VARCHAR(40)   NOT NULL,
	"image_path"        VARCHAR(50),
	"description"       VARCHAR(100)  NOT NULL,
	"default_provdata"  INTEGER,
	"type"              VARCHAR(20)   NOT NULL,
	"shub_url"          VARCHAR(50),
	"execution_command" VARCHAR(155),
	"recipe"       VARCHAR(100),
	"image_arch"       VARCHAR(100),
	
	CONSTRAINT "config_id_pkey" PRIMARY KEY ("id")
);
COPY 7 RECORDS INTO "public"."config" FROM stdin USING DELIMITERS E'\t',E'\n','"';
1	"icc"	"recipes/application/icc/"	"Intel compiler with dfa-lib-cpp"	0	"application"	NULL	"./recipes/application/icc/icc.sif"	NULL	NULL
2	"tensorflow"	"recipes/application/tensorflow/"	"Tensorflow with dfa-lib-python"	0	"application"	NULL	"./recipes/application/tensorflow/tensorflow.sif python3"	NULL 	NULL	
3	"dfanalyzer"	"recipes/provCollector/DfAnalyzer"	"Container of dfanalyzer"	1	"provCollector"	NULL	"singularity run --pwd $PWD/recipes/provCollector/DfAnalyzer ./recipes/provCollector/DfAnalyzer/java_tomcat.sif java -jar target/DfAnalyzer-1.0.jar"	NULL 	NULL
4	"provDeployDatabase"	"recipes/database/"	"Container of dfanalyzer database"	1	"database"	NULL	"./recipes/database/database.sif"	NULL	NULL
5	"py-readseq-modelGenerator"	"recipes/application/readSeq-ModelGenerator-py/"	"ReadSeq, python2, java, raxml, dfa-lib-python with telemetry, and psutils por python applications"	0	"application"	NULL	"./recipes/application/readSeq-ModelGenerator-py/readseq.simg python"	NULL 	NULL
6	"java-readseq-modelGenerator"	"recipes/application/readSeq-ModelGenerator/"	"ReadSeq, python2, java, raxml, dfa-lib-python with telemetry, and psutils for java applications"	0	"application"	NULL	"./recipes/application/readSeq-ModelGenerator-py/readseq.simg java"	NULL	NULL
7	"python37"	"recipes/application/python37/"	"Python 3.7 with dfa-lib-python"	0	"application"	NULL	"./recipes/application/python37/python37.sif python3.7"	NULL 	NULL
CREATE TABLE "public"."execution" (
	"id"        INTEGER       NOT NULL,
	"timestamp" VARCHAR(40)   NOT NULL,
	CONSTRAINT "execution_id_pkey" PRIMARY KEY ("id")
);
CREATE TABLE "public"."execution_config" (
	"execution_id"      INTEGER       NOT NULL,
	"config_id"         INTEGER       NOT NULL,
	"execution_command" VARCHAR(100),
	CONSTRAINT "execution_config_execution_id_config_id_pkey" PRIMARY KEY ("execution_id", "config_id")
);
ALTER TABLE "public"."config" ALTER COLUMN "id" SET DEFAULT next value for "public"."config_id_seq";
ALTER TABLE "public"."execution" ALTER COLUMN "id" SET DEFAULT next value for "public"."execution_id_seq";
ALTER TABLE "public"."execution_config" ADD CONSTRAINT "execution_config_config_id_fkey" FOREIGN KEY ("config_id") REFERENCES "public"."config" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."execution_config" ADD CONSTRAINT "execution_config_execution_id_fkey" FOREIGN KEY ("execution_id") REFERENCES "public"."execution" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

COMMIT;
