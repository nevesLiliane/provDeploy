
START TRANSACTION;
SET SCHEMA "public";
CREATE SEQUENCE "public"."enviroment_id_seq" AS INTEGER START WITH 1;
CREATE SEQUENCE "public"."execution_id_seq" AS INTEGER START WITH 1;
CREATE SEQUENCE "public"."image_id_seq" AS INTEGER START WITH 1;
CREATE SEQUENCE "public"."partition_id_seq" AS INTEGER START WITH 1;
CREATE SEQUENCE "public"."network_id_seq" AS INTEGER START WITH 1;
CREATE SEQUENCE "public"."root_id_seq" AS INTEGER START WITH 1;
CREATE SEQUENCE "public"."software_id_seq" AS INTEGER START WITH 1;
CREATE SEQUENCE "public"."iostream_id_seq" AS INTEGER START WITH 1;
CREATE SEQUENCE "public"."env_id_seq" AS INTEGER START WITH 1;
CREATE SEQUENCE "public"."entrypoint_id_seq" AS INTEGER START WITH 1;
CREATE SEQUENCE "public"."cmd_id_seq" AS INTEGER START WITH 1;
CREATE SEQUENCE "public"."label_id_seq" AS INTEGER START WITH 1;
CREATE SEQUENCE "public"."config_id_seq" AS INTEGER START WITH 1;
CREATE SEQUENCE "public"."wf_id_seq" AS INTEGER START WITH 1;
CREATE SEQUENCE "public"."wf_desc_seq" AS INTEGER START WITH 1;
CREATE SEQUENCE "public"."disk_usage_seq" AS INTEGER START WITH 1;
CREATE SEQUENCE "public"."cpu_usage_seq" AS INTEGER START WITH 1;
CREATE SEQUENCE "public"."memory_usage_seq" AS INTEGER START WITH 1;
CREATE SEQUENCE "public"."network_usage_seq" AS INTEGER START WITH 1;

create table environment(
	"id"			INTEGER DEFAULT NEXT VALUE FOR "enviroment_id_seq" NOT NULL,
	"name"			VARCHAR(155),
	"os"			VARCHAR(155),
	"os_version"		VARCHAR(155),
	"scheduler"		VARCHAR(155),
	"kernel"		VARCHAR(155),
	"kernel_version"	VARCHAR(155),
	"kernel_modules"	VARCHAR(155),
	"kernel_bypass_libs"	VARCHAR(155),
	PRIMARY KEY ("id")
	);

create table container_image(
	"id"			INTEGER DEFAULT NEXT VALUE FOR "image_id_seq"	NOT NULL,
	"created"		DATE,
	"author"		VARCHAR(155),
	"arch"			VARCHAR(155),
	"os"			VARCHAR(155),
	"os_version"		VARCHAR(155),
	"url"			VARCHAR(155),
	"config_file"		VARCHAR(155),
	"hash"			VARCHAR(155),
	"requirements"		VARCHAR(155),
	"tag"			VARCHAR(155),
	"mediaType"		VARCHAR(155),
	"vendor"		VARCHAR(155),
	"documentation"	VARCHAR(155),
	"name"			VARCHAR(155),
	"description"		VARCHAR(155),
	"build_environment_id"	INTEGER,
	"image_type"		VARCHAR(155),
	"image_path"		VARCHAR(155),
	"execution_command"	VARCHAR(155),
	"base_image_id"	INTEGER,
	"original_image_id"	INTEGER,
	"default_prov"		INTEGER,
	"OCI_format"		BOOL,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("build_environment_id") REFERENCES environment("id") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ("base_image_id") REFERENCES container_image("id") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ("original_image_id") REFERENCES container_image("id") ON DELETE CASCADE ON UPDATE CASCADE
	);
	
create table workflow(
	"id"			INTEGER DEFAULT NEXT VALUE FOR "wf_id_seq" NOT NULL,
	"workflow"		VARCHAR(155),
	PRIMARY KEY ("id")
);

	
create table env_partition(
	"id"			INTEGER DEFAULT NEXT VALUE FOR "partition_id_seq" NOT NULL,
	"name"			VARCHAR(155),
	"specification"	VARCHAR(155),
	"environment_id"	INTEGER,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("environment_id") REFERENCES environment("id") ON DELETE CASCADE ON UPDATE CASCADE
);
	
create table execution(
	"id"			INTEGER DEFAULT NEXT VALUE FOR "execution_id_seq" NOT NULL,
	"wf_id"		INTEGER	NOT NULL,
	"partition_id"		INTEGER,
	"timestamp"		DATE,
	"job_id"		VARCHAR(155),
	"composition"		VARCHAR(155),
	"elapsed_time"		INTEGER,
	"samples"		INTEGER,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("partition_id") REFERENCES env_partition("id") ON DELETE CASCADE ON UPDATE CASCADE
);



create table workflow_execution(
	"id"			INTEGER DEFAULT NEXT VALUE FOR "wf_desc_seq" NOT NULL,
	"wf_id"		INTEGER,
	"activity"		VARCHAR(155),
	"script"		VARCHAR(155),
	"exec_command"		VARCHAR(155),
	"parameters"		VARCHAR(155),
	"image_id"		INTEGER,
	"exec_id"		INTEGER,
	"position"		INTEGER,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("wf_id") REFERENCES workflow("id") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ("image_id") REFERENCES container_image("id") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ("exec_id") REFERENCES execution("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE cpu_usage (
	"id" INTEGER DEFAULT NEXT VALUE FOR "cpu_usage_seq" NOT NULL,
	"exec_id" INTEGER NOT NULL,
	"cpu_node" varchar(100) NOT NULL,
	"puser" decimal(18,3),
	"pnice" decimal(18,3),
	"psystem" decimal(18,3),
	"piowait" decimal(18,3),
	"psteal" decimal(18,3),
	"pidle" decimal(18,3),
	PRIMARY KEY ("id"), 
	FOREIGN KEY ("exec_id") REFERENCES EXECUTION("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE disk_usage (
	"id" INTEGER DEFAULT NEXT VALUE FOR "disk_usage_seq" NOT NULL,
	"exec_id" INTEGER NOT NULL,
	"device" varchar(100) NOT NULL,
	"tps" decimal,
	"rkbs" decimal,
	"wkbs" decimal,
	"dkbs" decimal,
	"areqsz" decimal,
	"aqusz" decimal,
	"await" decimal,
	"putil" decimal,
	PRIMARY KEY ("id"), 
	FOREIGN KEY ("exec_id") REFERENCES EXECUTION("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE memory_usage (
	"id" INTEGER DEFAULT NEXT VALUE FOR "memory_usage_seq" NOT NULL,
	"exec_id" bigint NOT NULL,
	"kbmemfree" INTEGER NOT NULL,
	"kbavail" decimal,
	"kbmemused" decimal,
	"pmemused" decimal,
	"kbbuffers" decimal,
	"kbcached" decimal,
	"kbcommit" decimal,
	"pcommit" decimal,
	"kbactive" decimal,
	"kbinact" decimal,
	"kbdirty" decimal,
	PRIMARY KEY ("id"), 
	FOREIGN KEY ("exec_id") REFERENCES EXECUTION("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE network_usage (
	"id" INTEGER DEFAULT NEXT VALUE FOR "network_usage_seq" NOT NULL,
	"exec_id" bigint NOT NULL,
	"IFACE" varchar(100) NOT NULL,
	"rxppcks" decimal,
	"txppcks" decimal,
	"rxkbs" decimal,
	"txkbs" decimal,
	"rxcmps" decimal,
	"txcmps" decimal,
	"rxmcsts" decimal,
	"pifutil" decimal,
	PRIMARY KEY ("id"), 
	FOREIGN KEY ("exec_id") REFERENCES EXECUTION("id") ON DELETE CASCADE ON UPDATE CASCADE
);

create table container(
	"host_environment_id"	INTEGER	NOT NULL,
	"image_id"		INTEGER	NOT NULL,
	"execution_id"		INTEGER	NOT NULL,
	"created"		DATE,
	"empty_layer"		VARCHAR(155),
	"pid"			VARCHAR(155),
	FOREIGN KEY ("host_environment_id") REFERENCES environment("id") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ("image_id") REFERENCES container_image("id") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ("execution_id") REFERENCES execution("id") ON DELETE CASCADE ON UPDATE CASCADE
);

create table start_command(
	"image_id"		INTEGER	NOT NULL,
	"cmd_args"		VARCHAR(155),
	"cmd_envvars"		VARCHAR(155),
	"cmd_additional_args"	VARCHAR(155),
	FOREIGN KEY ("image_id") REFERENCES container_image("id") ON DELETE CASCADE ON UPDATE CASCADE
);



--create table network(
--	"id"		INTEGER DEFAULT NEXT VALUE FOR "network_id_seq" NOT NULL,
--	"net_port"	VARCHAR(155),
--	"image_id"	INTEGER,
--	PRIMARY KEY ("id"),
--	FOREIGN KEY ("image_id") REFERENCES container_image("id") ON DELETE CASCADE ON UPDATE CASCADE
--);

create table rootFS(
	"id"			INTEGER DEFAULT NEXT VALUE FOR "root_id_seq"	NOT NULL,
	"diff_ids"		VARCHAR(155),
	"type"			VARCHAR(155),
	"volums"		VARCHAR(155),
	"size"			VARCHAR(155),
	"virtual_size"		VARCHAR(155),
	"graph_driver_name"	VARCHAR(155),
	"layers"		VARCHAR(155),
	"image_id"		INTEGER,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("image_id") REFERENCES container_image("id") ON DELETE CASCADE ON UPDATE CASCADE
);

create table layers(
	"id"		INTEGER DEFAULT NEXT VALUE FOR "network_id_seq" NOT NULL,
	"value"	VARCHAR(155),
	"rfs_id" INTEGER,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("rfs_id") REFERENCES rootFS("id") ON DELETE CASCADE ON UPDATE CASCADE
);

create table graph_driver(
	"id"		INTEGER DEFAULT NEXT VALUE FOR "network_id_seq" NOT NULL,
	"name"	VARCHAR(155),
	"rfs_id" INTEGER,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("rfs_id") REFERENCES rootFS("id") ON DELETE CASCADE ON UPDATE CASCADE
);

create table data(
	"id"		INTEGER DEFAULT NEXT VALUE FOR "network_id_seq" NOT NULL,
	"name"	VARCHAR(155),
	"value"	VARCHAR(155),
	"gd_id" INTEGER,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("gd_id") REFERENCES graph_driver("id") ON DELETE CASCADE ON UPDATE CASCADE
);



create table software(
	"id"			INTEGER DEFAULT NEXT VALUE FOR "software_id_seq" NOT NULL,
	"name"			VARCHAR(155),
	"provider"		VARCHAR(155),
	"version"		VARCHAR(155),
	"optimized"		VARCHAR(155),
	"compatibility"	VARCHAR(155),
	"image_id"		INTEGER,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("image_id") REFERENCES container_image("id") ON DELETE CASCADE ON UPDATE CASCADE
);

create table IO_stream(
	"id"			INTEGER DEFAULT NEXT VALUE FOR "iostream_id_seq" NOT NULL,
	"image_id"		INTEGER,
	"type"			VARCHAR(155),
	"attach_stdin"		VARCHAR(155),
	"attach_stdout"	VARCHAR(155),
	"attach_stderr"	VARCHAR(155),
	"tty"			VARCHAR(155),
	"open_std_in"		VARCHAR(155),
	"std_in_once"		VARCHAR(155),
	PRIMARY KEY ("id"),
	FOREIGN KEY ("image_id") REFERENCES container_image("id") ON DELETE CASCADE ON UPDATE CASCADE
);

create table configuration(
	"id"			INTEGER DEFAULT NEXT VALUE FOR "config_id_seq" NOT NULL,
	"user"			VARCHAR(155),
	"env_id"		INTEGER,
	"EntryPoint_id"	INTEGER,
	"cmd_id"		INTEGER,
	"label_id"		INTEGER,
	"net_ports_id"	INTEGER,
	"image_id"		INTEGER,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("image_id") REFERENCES container_image("id") ON DELETE CASCADE ON UPDATE CASCADE
);
create table env(
	"id"			INTEGER DEFAULT NEXT VALUE FOR "env_id_seq" NOT NULL,
	"value"		VARCHAR(155),
	"config_id" INTEGER,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("config_id") REFERENCES configuration("id") ON DELETE CASCADE ON UPDATE CASCADE
);

create table entryPoint(
	"id"			INTEGER DEFAULT NEXT VALUE FOR "entrypoint_id_seq" NOT NULL,
	"value"		VARCHAR(155),
	"key"		VARCHAR(155),
	"config_id" INTEGER,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("config_id") REFERENCES configuration("id") ON DELETE CASCADE ON UPDATE CASCADE
);

create table cmd(
	"id"			INTEGER DEFAULT NEXT VALUE FOR "cmd_id_seq" NOT NULL,
	"value"		VARCHAR(155),
	"key"		VARCHAR(155),
	"config_id" INTEGER,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("config_id") REFERENCES configuration("id") ON DELETE CASCADE ON UPDATE CASCADE
);

create table label(
	"id"			INTEGER DEFAULT NEXT VALUE FOR "label_id_seq" NOT NULL,
	"value"		VARCHAR(155),
	"key"		VARCHAR(155),
	"config_id" INTEGER,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("config_id") REFERENCES configuration("id") ON DELETE CASCADE ON UPDATE CASCADE
);

create table net_ports(
	"id"		INTEGER DEFAULT NEXT VALUE FOR "network_id_seq" NOT NULL,
	"net_port"	VARCHAR(155),
	"key"	VARCHAR(155),
	"config_id" INTEGER,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("config_id") REFERENCES configuration("id") ON DELETE CASCADE ON UPDATE CASCADE
);


commit;

-- Qu
-- select  w.workflow, e.name, ep.name ,ep.specification, i.name  , we.activity, ex.composition , ex.elapsed_time, ex.samples_ samples_or_degree,we.exec_command ,we.id wf_exec_id , ex.id exec_id
--from environment e join env_partition ep  on e.id =ep.environment_id
--join execution ex  on ex.partition_id =ep.id 
--left join workflow_execution we on we.exec_id = ex.id
--join image i on we.image_id  = i.id 
--join workflow w on w.id =ex.wf_id 
--order by ex.id 

--"created" DATE, "AUTHOR" VARCHAR(155), "arch" VARCHAR(155), "OS" VARCHAR(155), "OS_version" VARCHAR(155), "url" VARCHAR(155), "config_file" VARCHAR(155), "hash" VARCHAR(155), "requirements" VARCHAR(155), "tag" VARCHAR(155), "mediaType" VARCHAR(155), "vendor" VARCHAR(155), "documentation" VARCHAR(155), "name" VARCHAR(155), "description" VARCHAR(155), "build_environment_id" INTEGER, "image_type" VARCHAR(155), "image_path" VARCHAR(155), "execution_command" VARCHAR(155), "base_image_id"	INTEGER, "original_image_id" INTEGER, "default_prov" INTEGER, "OCI_format" BOOL

insert into container_image (created, author, name, description, image_type, image_path, execution_command) VALUES (curdate(), 'Liliane','icc', 'Intel compiler with dfa-lib-cpp','application','recipes/application/icc/','./recipes/application/icc/icc.sif');

insert into container_image (created, author, name, description, image_type, image_path, execution_command) VALUES (curdate(), 'Liliane','tensorflow', 'Tensorflow with dfa-lib-python','application','recipes/application/tensorflow/','./recipes/application/tensorflow/tensorflow.sif python3');

insert into container_image (created, author, name, description, image_type, image_path, execution_command,  default_prov) VALUES (curdate(), 'Liliane','dfanalyzer', 'Container of dfanalyzer','provCollector','recipes/provCollector/DfAnalyzer','singularity run --pwd $PWD/recipes/provCollector/DfAnalyzer ./recipes/provCollector/DfAnalyzer/java_tomcat.sif java -jar target/DfAnalyzer-1.0.jar', 1);

insert into container_image (created, author, name, description, image_type, image_path, execution_command) VALUES (curdate(), 'Liliane','provDeployDatabase', 'Container of provdeploy database','database','recipes/database/','./recipes/database/database.sif');

insert into container_image (created, author, name, description, image_type, image_path, execution_command) VALUES (curdate(), 'Liliane','py-readseq-modelGenerator', 'ReadSeq, python2, java, raxml, dfa-lib-python with telemetry, and psutils por python applications','application','recipes/application/readSeq-ModelGenerator-py/','./recipes/application/readSeq-ModelGenerator-py/readseq.simg python');

insert into container_image (created, author, name, description, image_type, image_path, execution_command) VALUES (curdate(), 'Liliane','java-readseq-modelGenerator', 'ReadSeq, python2, java, raxml, dfa-lib-python with telemetry, and psutils por python applications','application','recipes/application/readSeq-ModelGenerator-py/','./recipes/application/readSeq-ModelGenerator-py/readseq.simg java');

insert into container_image (created, author, name, description, image_type, image_path, execution_command) VALUES (curdate(), 'Liliane','python37', 'Python 3.7 with dfa-lib-python','application','recipes/application/python37/','./recipes/application/python37/python37.sif python3.7');


insert into container_image (created, author, name, description, image_type, image_path, execution_command, arch, os, os_version, vendor,build_environment_id, base_image_id ) VALUES ('2024-05-22', 'Liliane','denseed', 'DenseED with DfAnalyzer and MonetDB','application','recipes/application/tensorflow/','./recipes/application/tensorflow/denseed.sif python3.7', 'amd64','Ubuntu', '18.04.3', 'singularity',3,2);

insert into container_image (created, author, name, description, image_type, image_path, execution_command, arch, os, os_version, vendor,build_environment_id, base_image_id ) VALUES ('2024-05-22', 'Liliane','provData', 'DfAnalyzer and MonetDB','provenance','recipes/application/provdata/','./recipes/application/provdata/provData.sif ', 'amd64','Ubuntu', '18.04.5', 'singularity',3,3);

insert into container_image (created, author, name, description, image_type, image_path, execution_command) VALUES (curdate(), 'Liliane','mafft', 'Mafft for sciphy','application','recipes/application/mafft/','./recipes/application/mafft/mafft.sif');

insert into container_image (created, author, name, description, image_type, image_path, execution_command) VALUES (curdate(), 'Liliane','java', 'Java Image','aa','recipes/provCollector/DfAnalyzer','singularity run --pwd $PWD/recipes/provCollector/DfAnalyzer ./recipes/provCollector/DfAnalyzer/java_tomcat.sif java '); --model generator roda em cima de imagem java

insert into container_image (created, author, name, description, image_type, image_path, execution_command) VALUES (curdate(), 'Liliane','raxml', 'Java Image','aa','recipes/provCollector/DfAnalyzer','singularity run --pwd $PWD/recipes/provCollector/DfAnalyzer ./recipes/provCollector/DfAnalyzer/java_tomcat.sif java -jar target/DfAnalyzer-1.0.jar');


insert into container_image (created, author, name, description, image_type, image_path, execution_command) VALUES (curdate(), 'Liliane','sciphy', 'Sciphy image','application','recipes/application/sciphy/','./recipes/application/sciphy/sciphy.sif');

insert into container_image (created, author, name, description, image_type, image_path, execution_command) VALUES (curdate(), 'Liliane','sciphy_data', 'Sciphy image with monetdb','aa','recipes/application/sciphy','singularity run --pwd $PWD/recipes/application/sciphy ./recipes/application/sciphy/sciphy_monet.sif java '); --model generator roda em cima de imagem java

insert into container_image (created, author, name, description, image_type, image_path, execution_command) VALUES (curdate(), 'Liliane','tensorflow_java', 'Tensorflow with dfa-lib-python and dfanalyzer','application','recipes/application/tensorflow/','./recipes/application/tensorflow/tensorflow_java.sif python3');

insert into container_image (created, author, name, description, image_type, image_path, execution_command) VALUES (curdate(), 'Liliane','tensorflow_monetdb', 'Tensorflow with dfa-lib-python and monetdb','application','recipes/application/tensorflow/','./recipes/application/tensorflow/tensorflow_monetdb.sif python3');

insert into container_image (created, author, name, description, image_type, image_path, execution_command, vendor) VALUES (curdate(), 'ovvesley','montage', 'Montage actitivies','application','','', 'docker');

insert into container_image (created, author, name, description, image_type, image_path, execution_command, vendor) VALUES (curdate(), 'lilianekunstmann','mProject', 'mProject actitivy','application','','', 'docker');

insert into container_image (created, author, name, description, image_type, image_path, execution_command, vendor) VALUES (curdate(), 'lilianekunstmann','mProjectPP', 'optimized mProject actitivy','application','','', 'docker');

insert into container_image (created, author, name, description, image_type, image_path, execution_command, vendor) VALUES (curdate(), 'lilianekunstmann','mDiffFit', 'mDiffFit actitivy','application','','', 'docker');

insert into container_image (created, author, name, description, image_type, image_path, execution_command, vendor) VALUES (curdate(), 'lilianekunstmann','mConcatFit', 'mConcatFit actitivy','application','','', 'docker');

insert into container_image (created, author, name, description, image_type, image_path, execution_command, vendor) VALUES (curdate(), 'lilianekunstmann','mBgModel', 'mBgModel actitivy','application','','', 'docker');

insert into container_image (created, author, name, description, image_type, image_path, execution_command, vendor) VALUES (curdate(), 'lilianekunstmann','mBackground', 'mBackground actitivy','application','','', 'docker');

insert into container_image (created, author, name, description, image_type, image_path, execution_command, vendor) VALUES (curdate(), 'lilianekunstmann','mImgTbl', 'mImgTbl actitivy','application','','', 'docker');

insert into container_image (created, author, name, description, image_type, image_path, execution_command, vendor) VALUES (curdate(), 'lilianekunstmann','mAdd', 'mAdd actitivy','application','','', 'docker');

insert into container_image (created, author, name, description, image_type, image_path, execution_command, vendor) VALUES (curdate(), 'lilianekunstmann','mViewer', 'mViewer actitivy','application','','', 'docker');

insert into container_image (created, author, name, description, image_type, image_path, execution_command, vendor) VALUES (curdate(), 'lilianekunstmann','mConcatFitBgModel', 'mconcatFit and mBgModel activities','application','','', 'docker');

insert into container_image (created, author, name, description, image_type, image_path, execution_command, vendor) VALUES (curdate(), 'lilianekunstmann','mImgTblAddViewer', 'mImgTbl, mAdd and mViewer actitivies','application','','', 'docker');

--INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) SELECT 2, 'DenseEDActivities, Provenance capture, dataPersistence','DfAnalyzer.jar', 8, e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='DenseD' and composition='Coarse-grained';


--INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) SELECT 2, 'DenseEDActivities','python3 CAN_DenseED.py', 2, e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='DenseD' and composition='Hybrid (Provenance and data)' ;

--INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) SELECT 2, 'Provenance capture, dataPersistence','./provData', 9, e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='DenseD' and composition='Hybrid (Provenance and data)' ;


--INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) SELECT 2, 'DenseEDActivities','python3 CAN_DenseED.py', 2, e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='DenseD' and composition='Hybrid (Data)' ;

--INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) SELECT 2, 'Provenance capture','DfAnalyzer.jar', 3, e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='DenseD' and composition='Hybrid (Data)' ;

--INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) SELECT 2, 'dataPersistence','/start-database.sh', 4, e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='DenseD' and composition='Hybrid (Data)' ;

--ALTER TABLE workflow_execution ADD "position" INTEGER; 

insert into workflow(workflow) values ('SciPhy');
insert into workflow(workflow) values ('DenseED');
insert into workflow(workflow) values ('Montage');


insert into environment(name, os, os_version, scheduler) VALUES ('Santos Dumont', 'Red Hat', '7.0', 'slurm');
insert into environment(name) VALUES ('AWS');
insert into environment(name) VALUES ('LocalEnv');
insert into environment(name) VALUES ('Labesi');
insert into environment(name) VALUES ('GCP');

insert into env_partition(name, environment_id) values ('cpu', 1);
insert into env_partition(name, environment_id) values ('cpu_small', 1);
insert into env_partition(name, environment_id) values ('cpu_dev', 1);
insert into env_partition(name, environment_id) values ('sequana_gpu', 1);
insert into env_partition(name, environment_id) values ('sequana_gpu_dev', 1);
insert into env_partition(name, environment_id) values ('gdl', 1);

insert into env_partition(name, environment_id) values ('c5.xlarge', 2);
insert into env_partition(name, environment_id) values ('c5.4xlarge', 2);
insert into env_partition(name, environment_id) values ('c5.xlarge spot', 2);
insert into env_partition(name, environment_id) values ('c5.4xlarge spot', 2);
insert into env_partition(name, environment_id) values ('t3a.large', 2);

insert into env_partition(name, environment_id) values ('liliane-iMac20-1', 3);

insert into env_partition(name, environment_id) values ('M1', 4);
insert into env_partition(name, environment_id) values ('M2', 4);

insert into env_partition(name, environment_id) values ('n2-highcpu-32', 5);


insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'coarse grained', 13240,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'coarse grained', 13170,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'coarse grained', 13165,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'coarse grained', 13166,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'coarse grained', 13196,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'coarse grained', 13406,200);


INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'sciphy_data'), id , curdate()
from execution where composition like 'coarse grained' and wf_id=1 and partition_id=2; 

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) values (SELECT 1, 'Sciphy Execution, provenance service, dataPersistence','./sciphy_data.sif', (select id from container_image where name like 'sciphy_data') , e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='SciPhy' and composition='coarse grained')

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Data)', 13194,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Data)', 13195,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Data)', 13199,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Data)', 13195,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Data)', 13205,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Data)', 13211,200);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'sciphy'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=1 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=1 and partition_id=2; 

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) values (SELECT 1, 'Sciphy Execution, provenance service','./sciphy.sif', (select id from container_image where name like 'sciphy_data') , e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='SciPhy' and composition='Hybrid (Data)')

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) values (SELECT 1, 'dataPersistence','./sciphy.sif', (select id from container_image where name like 'provDeployDatabase') , e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='SciPhy' and composition='Hybrid (Data)')

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Provenance)', 13188,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Provenance)', 13172,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Provenance)', 13566,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Provenance)', 13198,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Provenance)', 13220,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Provenance)', 13235,200);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'sciphy_data'), id , curdate()
from execution where composition like 'Hybrid (Provenance)' and wf_id=1 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'java'), id , curdate()
from execution where composition like 'Hybrid (Provenance)' and wf_id=1 and partition_id=2; 

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) values (SELECT 1, 'Sciphy Execution, dataPersistence','./sciphy_data.sif', (select id from container_image where name like 'sciphy_data') , e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='SciPhy' and composition='Hybrid (Provenance)')

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) values (SELECT 1, 'Provenance service','./java.sif', (select id from container_image where name like 'java') , e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='SciPhy' and composition='Hybrid (Provenance)')

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Workflow)', 13248,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Workflow)', 13242,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Workflow)', 13236,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Workflow)', 13264,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Workflow)', 13258,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Workflow)', 13260,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Workflow)', 13266,200);


INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'sciphy'), id , curdate()
from execution where composition like 'Hybrid (Workflow)' and wf_id=1 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'provData'), id , curdate()
from execution where composition like 'Hybrid (Workflow)' and wf_id=1 and partition_id=2; 

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) values (SELECT 1, 'Sciphy Execution','./sciphy.sif', (select id from container_image where name like 'sciphy') , e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='SciPhy' and composition='Hybrid (Workflow)')

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) values (SELECT 1, 'Provenance service, Data persistence','./java_monetdb.sif', (select id from container_image where name like 'provData') , e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='SciPhy' and composition='Hybrid (Workflow)')


insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Provenance and data)', 13243,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Provenance and data)', 13276,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Provenance and data)', 13392,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Provenance and data)', 13297,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Provenance and data)', 13256,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Provenance and data)', 13248,200); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'sciphy'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'java'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=2; 

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) values (SELECT 1, 'Sciphy Execution','./sciphy.sif', (select id from container_image where name like 'sciphy') , e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='SciPhy' and composition='Hybrid (Provenance and data)')

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) values (SELECT 1, 'Provenance service','./java.sif', (select id from container_image where name like 'java') , e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='SciPhy' and composition='Hybrid (Provenance and data)')

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) values (SELECT 1, 'DataPersistence','./monetdb.sif', (select id from container_image where name like 'provDeployDatabase') , e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='SciPhy' and composition='Hybrid (Provenance and data)')

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Fine grained', 14904,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Fine grained', 13240,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Fine grained', 13170,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Fine grained', 13165,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Fine grained', 13166,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Fine grained', 13196,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Fine grained', 13406,200);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'mafft'), id , curdate()
from execution where composition like 'Fine grained' and wf_id=1 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'py-readseq-modelGenerator'), id , curdate()
from execution where composition like 'Fine grained' and wf_id=1 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'java'), id , curdate()
from execution where composition like 'Fine grained' and wf_id=1 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'raxml'), id , curdate()
from execution where composition like 'Fine grained' and wf_id=1 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Fine grained' and wf_id=1 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'dfanalyzer'), id , curdate()
from execution where composition like 'Fine grained' and wf_id=1 and partition_id=2;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) values (SELECT 1, 'Mafft Execution','./mafft.sif', (select id from container_image where name like 'mafft') , e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='SciPhy' and composition='Fine grained')

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) values (SELECT 1, 'ReadSeq execution','./readseq.sif', (select id from container_image where name like 'py-readseq-modelGenerator') , e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='SciPhy' and composition='Fine grained')

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) values (SELECT 1, 'ModelGenerator','./java.sif', (select id from container_image where name like 'java') , e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='SciPhy' and composition='Fine grained')

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) values (SELECT 1, 'RaXML Execution','./raxml.sif', (select id from container_image where name like 'raxml') , e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='SciPhy' and composition='Fine grained')

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) values (SELECT 1, 'DataPersistence','./monetdb.sif', (select id from container_image where name like 'provDeployDatabase') , e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='SciPhy' and composition='Fine grained')

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) values (SELECT 1, 'Provenance service','./dfanalyzer.sif', (select id from container_image where name like 'dfanalyzer') , e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='SciPhy' and composition='Fine grained')

--400 samples

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Coarse-grained', 26340,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Coarse-grained', 26328,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Coarse-grained', 26355,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Coarse-grained', 26357,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Coarse-grained', 26375,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Coarse-grained', 26383,400);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'sciphy_data'), id , curdate()
from execution where composition like 'Coarse-grained' and wf_id=1 and partition_id=2; 

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) values (SELECT 1, 'Sciphy Execution, provenance service, dataPersistence','./sciphy_data.sif', (select id from container_image where name like 'sciphy_data') , e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='SciPhy' and composition='Coarse-grained')

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Data)', 26358,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Data)', 26356,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Data)', 26313,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Data)', 26055,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Data)', 26428,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Data)', 26471,400);

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Provenance)', 26318,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Provenance)', 26321,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Provenance)', 26345,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Provenance)', 26350,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Provenance)', 26389,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Provenance)', 26369,400);

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Workflow)', 26315,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Workflow)', 26411,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Workflow)', 26308,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Workflow)', 26372,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Workflow)', 26410,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Workflow)', 26481,400);

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Provenance and data)', 26356,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Provenance and data)', 26350,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Provenance and data)', 26376,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Provenance and data)', 26392,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Provenance and data)', 26420,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Provenance and data)', 26435,400);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'sciphy'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data' and wf_id=1 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'java'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data' and wf_id=1 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data' and wf_id=1 and partition_id=2; 

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(),'Fine-grained', 27062,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(),'Fine-grained', 27121,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(),'Fine-grained', 27281,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(),'Fine-grained', 27229,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(),'Fine-grained', 27293,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(),'Fine-grained', 27331,400);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'mafft'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'py-readseq-modelGenerator'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'java'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'raxml'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'dfanalyzer'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=2;

---- start aws - first

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,11,curdate(),'Coarse-grained', 91935,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,11,curdate(),'Coarse-grained', 87254,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,11,curdate(),'Coarse-grained', 92296,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,11,curdate(),'Coarse-grained', 87600,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,11,curdate(),'Coarse-grained', 91746,200); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'sciphy_data'), id , curdate()
from execution where composition like 'Coarse-grained' and wf_id=1 and partition_id=11; 

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,11,curdate(), 'Hybrid (Data)', 86958,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,11,curdate(), 'Hybrid (Data)', 86383,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,11,curdate(), 'Hybrid (Data)', 87282,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,11,curdate(), 'Hybrid (Data)', 90744,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,11,curdate(), 'Hybrid (Data)', 88172,200);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'sciphy'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=1 and partition_id=11; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=1 and partition_id=11; 

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,11,curdate(), 'Hybrid (Provenance)', 88981,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,11,curdate(), 'Hybrid (Provenance)', 92383,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,11,curdate(), 'Hybrid (Provenance)', 93055,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,11,curdate(), 'Hybrid (Provenance)', 88899,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,11,curdate(), 'Hybrid (Provenance)', 92128,200);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'sciphy_data'), id , curdate()
from execution where composition like 'Hybrid (Provenance)' and wf_id=1 and partition_id=11; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'java'), id , curdate()
from execution where composition like 'Hybrid (Provenance)' and wf_id=1 and partition_id=11; 

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,11,curdate(), 'Hybrid (Workflow)', 91712,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,11,curdate(), 'Hybrid (Workflow)', 88628,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,11,curdate(), 'Hybrid (Workflow)', 91523,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,11,curdate(), 'Hybrid (Workflow)', 90731,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,11,curdate(), 'Hybrid (Workflow)', 87780,200);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'sciphy'), id , curdate()
from execution where composition like 'Hybrid (Workflow)' and wf_id=1 and partition_id=11; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'provData'), id , curdate()
from execution where composition like 'Hybrid (Workflow)' and wf_id=1 and partition_id=11; 

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,11,curdate(), 'Hybrid (Provenance and data)', 90094,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,11,curdate(), 'Hybrid (Provenance and data)', 87759,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,11,curdate(), 'Hybrid (Provenance and data)', 86711,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,11,curdate(), 'Hybrid (Provenance and data)', 92974,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,11,curdate(), 'Hybrid (Provenance and data)', 87383,200); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'sciphy'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=11; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'java'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=11; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=11; 

--c5.xlarge

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Coarse-grained', 54738,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Coarse-grained', 54908,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Coarse-grained', 55120,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Coarse-grained', 54501,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Coarse-grained', 55240,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Coarse-grained', 54491,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Coarse-grained', 51630,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Coarse-grained', 54459,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Coarse-grained', 50767,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Coarse-grained', 55329,200); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'sciphy_data'), id , curdate()
from execution where composition like 'Coarse-grained' and wf_id=1 and partition_id=7; 

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Hybrid (Data)', 51496,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Hybrid (Data)', 54207,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Hybrid (Data)', 49019,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Hybrid (Data)', 54168,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Hybrid (Data)', 53442,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Hybrid (Data)', 56323,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Hybrid (Data)', 56416,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Hybrid (Data)', 54921,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Hybrid (Data)', 55008,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Hybrid (Data)', 56402,200); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'sciphy'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=1 and partition_id=7; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=1 and partition_id=7; 

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Hybrid (Provenance and data)', 56252,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Hybrid (Provenance and data)', 58024,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Hybrid (Provenance and data)', 59483,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Hybrid (Provenance and data)', 57909,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Hybrid (Provenance and data)', 58403,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Hybrid (Provenance and data)', 57696,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Hybrid (Provenance and data)', 57584,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Hybrid (Provenance and data)', 55044,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Hybrid (Provenance and data)', 56286,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Hybrid (Provenance and data)', 58307,200);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'sciphy'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=7; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'java'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=7; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=7; 

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Fine-grained', 69430,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Fine-grained', 70058,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Fine-grained', 67895,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Fine-grained', 73998,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Fine-grained', 69400,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Fine-grained', 68624,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Fine-grained', 68949,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Fine-grained', 67990,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Fine-grained', 69369,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Fine-grained', 67096,200);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'mafft'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=7; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'py-readseq-modelGenerator'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=7; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'java'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=7; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'raxml'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=7; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=7; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'dfanalyzer'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=7; 
 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Fine-grained (Restricted)',60982,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Fine-grained (Restricted)',58822,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Fine-grained (Restricted)',60999,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Fine-grained (Restricted)',62435,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Fine-grained (Restricted)',60927,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Fine-grained (Restricted)',58228,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Fine-grained (Restricted)',62087,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Fine-grained (Restricted)',67042,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Fine-grained (Restricted)',64903,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(), 'Fine-grained (Restricted)',60184,200);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'mafft'), id , curdate()
from execution where composition like 'Fine-grained (Restricted)' and wf_id=1 and partition_id=7; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'py-readseq-modelGenerator'), id , curdate()
from execution where composition like 'Fine-grained (Restricted)' and wf_id=1 and partition_id=7; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'java'), id , curdate()
from execution where composition like 'Fine-grained (Restricted)' and wf_id=1 and partition_id=7; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'raxml'), id , curdate()
from execution where composition like 'Fine-grained (Restricted)' and wf_id=1 and partition_id=7; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Fine-grained (Restricted)' and wf_id=1 and partition_id=7; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'dfanalyzer'), id , curdate()
from execution where composition like 'Fine-grained (Restricted)' and wf_id=1 and partition_id=7;
 
-- c5.4xlarge 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Coarse-grained', 21319,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Coarse-grained', 20618,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Coarse-grained', 20920,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Coarse-grained', 19225,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Coarse-grained', 18855,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Coarse-grained', 20894,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Coarse-grained', 21487,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Coarse-grained', 20180,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Coarse-grained', 20587,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Coarse-grained', 17603,200); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'sciphy_data'), id , curdate()
from execution where composition like 'Coarse-grained' and wf_id=1 and partition_id=8; 

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Hybrid (Data)', 21724,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Hybrid (Data)', 17519,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Hybrid (Data)', 20373,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Hybrid (Data)', 14745,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Hybrid (Data)', 17793,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Hybrid (Data)', 23340,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Hybrid (Data)', 14575,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Hybrid (Data)', 18269,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Hybrid (Data)', 15077,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Hybrid (Data)', 22567,200); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'sciphy'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=1 and partition_id=8; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=1 and partition_id=8; 

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Hybrid (Provenance and data)', 15032,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Hybrid (Provenance and data)', 16065,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Hybrid (Provenance and data)', 17196,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Hybrid (Provenance and data)', 20892,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Hybrid (Provenance and data)', 14401,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Hybrid (Provenance and data)', 10703,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Hybrid (Provenance and data)', 17131,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Hybrid (Provenance and data)',20973,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Hybrid (Provenance and data)',19429,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Hybrid (Provenance and data)', 21436,200); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'sciphy'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=8; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'java'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=8; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=8; 

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Fine-grained', 22822,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Fine-grained', 27278,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Fine-grained', 20341,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(), 'Fine-grained', 21403,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Fine-grained', 21238,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Fine-grained', 20351,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Fine-grained', 23355,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Fine-grained', 20841,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Fine-grained', 17365,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Fine-grained', 22840,200); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'mafft'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=8; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'py-readseq-modelGenerator'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=8; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'java'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=8; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'raxml'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=8; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=8; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'dfanalyzer'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=8;

--c5.xlarge spot
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Coarse-grained', 55801,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Coarse-grained', 46361,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Coarse-grained', 46258,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Coarse-grained', 39523,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Coarse-grained', 51135,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Coarse-grained', 49658,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Coarse-grained', 45005,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Coarse-grained', 72188,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Coarse-grained', 65733,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Coarse-grained', 57406,200);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'sciphy_data'), id , curdate()
from execution where composition like 'Coarse-grained' and wf_id=1 and partition_id=9; 
 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Data)',59761,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Data)',57823,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Data)',52810,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Data)',47843,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Data)',58683,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Data)',60764,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Data)',59472,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Data)',54725,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Data)',53680,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Data)',56744,200); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'sciphy'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=1 and partition_id=9; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=1 and partition_id=9; 

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Provenance and data)',58092,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Provenance and data)',56576,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Provenance and data)',64119,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Provenance and data)',63167,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Provenance and data)',54978,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Provenance and data)',60473,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Provenance and data)',62887,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Provenance and data)',60157,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Provenance and data)',67026,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Provenance and data)',58577,200); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'sciphy'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=9; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'java'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=9; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=9; 

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Fine-grained',68219,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Fine-grained',76912,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Fine-grained',77860,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Fine-grained',64053,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Fine-grained',80530,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Fine-grained',73379,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Fine-grained',71887,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Fine-grained',73392,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Fine-grained',72202,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Fine-grained',65950,200); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'mafft'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=9; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'py-readseq-modelGenerator'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=9; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'java'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=9; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'raxml'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=9; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=9; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'dfanalyzer'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=9;

--c5.4xlarge spot

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Coarse-grained',22901,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Coarse-grained',18556,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Coarse-grained',22194,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Coarse-grained',20266,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Coarse-grained',25436,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Coarse-grained',21822,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Coarse-grained',24542,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Coarse-grained',27266,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Coarse-grained',26148,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Coarse-grained',22378,200); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'sciphy_data'), id , curdate()
from execution where composition like 'Coarse-grained' and wf_id=1 and partition_id=10; 

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Data)',22256,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Data)',23435,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Data)',23244,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Data)',21830,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Data)',20391,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Data)',24099,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Data)',24210,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Data)',24376,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Data)',24173,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Data)',23469,200);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'sciphy'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=1 and partition_id=10; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=1 and partition_id=10; 

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Provenance and data)',25167,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Provenance and data)',21052,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Provenance and data)',22553,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Provenance and data)',24249,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Provenance and data)',24945,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Provenance and data)',22735,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Provenance and data)',19038,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Provenance and data)',24957,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Provenance and data)',19912,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Provenance and data)',20970,200); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'sciphy'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=10; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'java'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=10; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=10;

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Fine-grained',29527,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Fine-grained',20446,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Fine-grained',27296,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Fine-grained',21615,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Fine-grained',27490,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Fine-grained',22399,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Fine-grained',22864,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Fine-grained',21781,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Fine-grained',24074,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Fine-grained',22305,200); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'mafft'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=10; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'py-readseq-modelGenerator'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=10; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'java'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=10; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'raxml'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=10; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=10; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'dfanalyzer'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=10;

--400 c5.xlarge

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Coarse-grained',92371,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Coarse-grained',93193,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Coarse-grained',95296,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Coarse-grained',94459,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Coarse-grained',100662,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Coarse-grained',88714,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Coarse-grained',94623,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Coarse-grained',94284,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Coarse-grained',90694,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Coarse-grained',89171,400); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'sciphy_data'), id , curdate()
from execution where composition like 'Coarse-grained' and wf_id=1 and partition_id=7; 

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Hybrid (Data)',93672,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Hybrid (Data)',94787,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Hybrid (Data)',95120,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Hybrid (Data)',89903,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Hybrid (Data)',87925,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Hybrid (Data)',100828,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Hybrid (Data)',94543,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Hybrid (Data)',96623,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Hybrid (Data)',94193,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Hybrid (Data)',97991,400);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'sciphy'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=1 and partition_id=7; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=1 and partition_id=7; 
 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Hybrid (Provenance and data)',93519,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Hybrid (Provenance and data)',90355,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Hybrid (Provenance and data)',97354,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Hybrid (Provenance and data)',96085,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Hybrid (Provenance and data)',92865,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Hybrid (Provenance and data)',98692,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Hybrid (Provenance and data)',95702,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Hybrid (Provenance and data)',95427,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Hybrid (Provenance and data)',99689,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Hybrid (Provenance and data)',98072,400); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'sciphy'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=7; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'java'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=7; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=7;

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Fine-grained',101347,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Fine-grained',112692,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Fine-grained',101829,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Fine-grained',108553,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Fine-grained',110411,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Fine-grained',104159,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Fine-grained',110755,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Fine-grained',107299,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Fine-grained',105223,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Fine-grained',108495,400);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'mafft'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=7; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'py-readseq-modelGenerator'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=7; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'java'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=7; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'raxml'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=7; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=7; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'dfanalyzer'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=7;
 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Fine-grained (Restricted)',100163,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Fine-grained (Restricted)',94911,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Fine-grained (Restricted)',115949,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Fine-grained (Restricted)',101317,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Fine-grained (Restricted)',103685,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Fine-grained (Restricted)',109803,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Fine-grained (Restricted)',108140,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Fine-grained (Restricted)',121974,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Fine-grained (Restricted)',107549,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,7,curdate(),'Fine-grained (Restricted)',103580,400); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'mafft'), id , curdate()
from execution where composition like 'Fine-grained (Restricted)' and wf_id=1 and partition_id=7; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'py-readseq-modelGenerator'), id , curdate()
from execution where composition like 'Fine-grained (Restricted)' and wf_id=1 and partition_id=7; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'java'), id , curdate()
from execution where composition like 'Fine-grained (Restricted)' and wf_id=1 and partition_id=7; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'raxml'), id , curdate()
from execution where composition like 'Fine-grained (Restricted)' and wf_id=1 and partition_id=7; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Fine-grained (Restricted)' and wf_id=1 and partition_id=7; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'dfanalyzer'), id , curdate()
from execution where composition like 'Fine-grained (Restricted)' and wf_id=1 and partition_id=7;

-- 400 c5.xlarge spot
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Coarse-grained',96494,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Coarse-grained',96772,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Coarse-grained',101234,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Coarse-grained',98622,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Coarse-grained',97239,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Coarse-grained',96030,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Coarse-grained',90270,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Coarse-grained',98796,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Coarse-grained',101181,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Coarse-grained',101700,400); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'sciphy_data'), id , curdate()
from execution where composition like 'Coarse-grained' and wf_id=1 and partition_id=9; 

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Data)',99020,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Data)',99737,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Data)',99524,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Data)',97680,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Data)',99751,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Data)',98581,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Data)',101157,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Data)',100695,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Data)',98634,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Data)',100591,400);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'sciphy'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=1 and partition_id=9; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=1 and partition_id=9; 
 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Provenance and data)',98168,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Provenance and data)',98066,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Provenance and data)',102927,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Provenance and data)',99279,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Provenance and data)',97206,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Provenance and data)',97422,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Provenance and data)',101105,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Provenance and data)',99806,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Provenance and data)',101924,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Hybrid (Provenance and data)',101263,400); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'sciphy'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=9; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'java'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=9; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=9;

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Fine-grained',120065,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Fine-grained',119650,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Fine-grained',117138,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Fine-grained',115706,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Fine-grained',120295,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Fine-grained',118900,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Fine-grained',112262,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Fine-grained',114306,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Fine-grained',117240,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Fine-grained',115048,400); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'mafft'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=9; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'py-readseq-modelGenerator'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=9; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'java'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=9; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'raxml'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=9; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=9; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'dfanalyzer'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=9;

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Fine-grained (Restricted)',112068,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Fine-grained (Restricted)',111849,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Fine-grained (Restricted)',115440,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Fine-grained (Restricted)',107301,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Fine-grained (Restricted)',109289,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Fine-grained (Restricted)',103642,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Fine-grained (Restricted)',110301,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Fine-grained (Restricted)',105391,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Fine-grained (Restricted)',108540,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,9,curdate(),'Fine-grained (Restricted)',101195,400); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'mafft'), id , curdate()
from execution where composition like 'Fine-grained (Restricted)' and wf_id=1 and partition_id=9; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'py-readseq-modelGenerator'), id , curdate()
from execution where composition like 'Fine-grained (Restricted)' and wf_id=1 and partition_id=9; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'java'), id , curdate()
from execution where composition like 'Fine-grained (Restricted)' and wf_id=1 and partition_id=9; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'raxml'), id , curdate()
from execution where composition like 'Fine-grained (Restricted)' and wf_id=1 and partition_id=9; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Fine-grained (Restricted)' and wf_id=1 and partition_id=9; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'dfanalyzer'), id , curdate()
from execution where composition like 'Fine-grained (Restricted)' and wf_id=1 and partition_id=9;

--c5.4xlarge
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Coarse-grained',47342,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Coarse-grained',37126,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Coarse-grained',41170,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Coarse-grained',41910,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Coarse-grained',42679,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Coarse-grained',41131,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Coarse-grained',41296,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Coarse-grained',37894,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Coarse-grained',37649,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Coarse-grained',38767,400);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'sciphy_data'), id , curdate()
from execution where composition like 'Coarse-grained' and wf_id=1 and partition_id=8;  

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Hybrid (data)',39381,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Hybrid (data)',39959,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Hybrid (data)',37259,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Hybrid (data)',45391,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Hybrid (data)',39960,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Hybrid (data)',38217,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Hybrid (data)',44035,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Hybrid (data)',47779,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Hybrid (data)',42416,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Hybrid (data)',42594,400); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'sciphy'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=1 and partition_id=8; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=1 and partition_id=8; 

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Hybrid (Provenance and data)',37391,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Hybrid (Provenance and data)',43332,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Hybrid (Provenance and data)',41531,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Hybrid (Provenance and data)',41276,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Hybrid (Provenance and data)',39719,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Hybrid (Provenance and data)',50197,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Hybrid (Provenance and data)',39183,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Hybrid (Provenance and data)',38674,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Hybrid (Provenance and data)',42272,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Hybrid (Provenance and data)',43788,400); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'sciphy'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=8; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'java'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=8; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=8;

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Fine-grained',48396,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Fine-grained',44110,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Fine-grained',45927,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Fine-grained',45761,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Fine-grained',44981,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Fine-grained',42880,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Fine-grained',46518,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Fine-grained',41359,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Fine-grained',45245,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,8,curdate(),'Fine-grained',45825,400);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'mafft'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=8; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'py-readseq-modelGenerator'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=8; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'java'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=8; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'raxml'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=8; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=8; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'dfanalyzer'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=8;

--c5.4xlarge
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Coarse-grained',41568,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Coarse-grained',46083,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Coarse-grained',48646,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Coarse-grained',51071,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Coarse-grained',49019,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Coarse-grained',49209,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Coarse-grained',48146,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Coarse-grained',51420,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Coarse-grained',46689,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Coarse-grained',45106,400); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'sciphy_data'), id , curdate()
from execution where composition like 'Coarse-grained' and wf_id=1 and partition_id=10;  

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Data)',43448,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Data)',50913,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Data)',52447,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Data)',48778,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Data)',45550,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Data)',47291,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Data)',49256,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Data)',50565,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Data)',49678,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Data)',48265,400); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'sciphy'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=1 and partition_id=10; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=1 and partition_id=10; 

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Provenance and Data)',48979,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Provenance and Data)',50135,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Provenance and Data)',45001,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Provenance and Data)',44876,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Provenance and Data)',49327,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Provenance and Data)',55861,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Provenance and Data)',51187,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Provenance and Data)',46224,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Provenance and Data)',57316,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Hybrid (Provenance and Data)',45848,400); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'sciphy'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=10; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'java'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=10; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=10;

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Fine-grained',52491,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Fine-grained',44897,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Fine-grained',50428,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Fine-grained',48784,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Fine-grained',48402,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Fine-grained',51829,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Fine-grained',51136,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Fine-grained',48567,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Fine-grained',43862,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,10,curdate(),'Fine-grained',56140,400);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'mafft'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=10; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'py-readseq-modelGenerator'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=10; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'java'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=10; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'raxml'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=10; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=10; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 2, (select id from container_image where name like 'dfanalyzer'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=1 and partition_id=10;

----------------------- DenseED k=24, L=4 cpu
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',1264,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',1283,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',1266,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',1269,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',1264,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',1273,100); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'denseed'), id , curdate()
from execution where composition like 'Coarse-grained' and wf_id=2 and partition_id=1; 

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',1284,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',1293,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',1289,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',1278,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',1283,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',1318,100); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'tensorflow_java'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=2 and partition_id=1; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=2 and partition_id=1; 

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Provenance and data)',1251,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Provenance and data)',1240,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Provenance and data)',1247,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Provenance and data)',1233,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Provenance and data)',1233,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Provenance and data)',1252,100); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'tensorflow'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=2 and partition_id=1; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'dfanalyzer'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=2 and partition_id=1; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=2 and partition_id=1;

----------------------- DenseED k=24, L=4 cpu 300 epocas
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',3768,300);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',3767,300); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',3778,300);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',3787,300); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',3814,300);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',3767,300); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'denseed'), id , curdate()
from execution where composition like 'Coarse-grained' and wf_id=2 and partition_id=1; 

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',3717,300);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',3727,300); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',3703,300);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',3721,300); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',3691,300);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',3752,300);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'tensorflow_java'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=2 and partition_id=1; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=2 and partition_id=1; 

----------------------- DenseED k=24, L=4 cpu 100 epocas maquina local
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,12,curdate(),'Coarse-grained',2068,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,12,curdate(),'Coarse-grained',2001,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,12,curdate(),'Coarse-grained',1968,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,12,curdate(),'Coarse-grained',1967,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,12,curdate(),'Coarse-grained',1967,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,12,curdate(),'Coarse-grained',1973,100); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 3, (select id from container_image where name like 'denseed'), id , curdate()
from execution where composition like 'Coarse-grained' and wf_id=2 and partition_id=12; 

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,12,curdate(),'Hybrid (Data)',2313,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,12,curdate(),'Hybrid (Data)',2133,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,12,curdate(),'Hybrid (Data)',2113,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,12,curdate(),'Hybrid (Data)',2113,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,12,curdate(),'Hybrid (Data)',2114,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,12,curdate(),'Hybrid (Data)',2111,100);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 3, (select id from container_image where name like 'tensorflow_java'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=2 and partition_id=12; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 3, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=2 and partition_id=12; 

----------------------- DenseED k=24, L=6 cpu 100 epocas maquina local
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,12,curdate(),'Coarse-grained',4001,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,12,curdate(),'Coarse-grained',3980,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,12,curdate(),'Coarse-grained',3988,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,12,curdate(),'Coarse-grained',3940,100); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 3, (select id from container_image where name like 'denseed'), id , curdate()
from execution where composition like 'Coarse-grained' and wf_id=2 and partition_id=12; 

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,12,curdate(),'Hybrid (Data)',4178,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,12,curdate(),'Hybrid (Data)',4388,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,12,curdate(),'Hybrid (Data)',3908,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,12,curdate(),'Hybrid (Data)',3964,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,12,curdate(),'Hybrid (Data)',4098,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,12,curdate(),'Hybrid (Data)',4673,100);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 3, (select id from container_image where name like 'tensorflow_java'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=2 and partition_id=12; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 3, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=2 and partition_id=12; 

----------------------- DenseED k=24, L=4 cpu 100 epocas cpu sdumont 12000 pontos
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',1263,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',1247,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',1240,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',1237,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',1270,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',1254,100); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'denseed'), id , curdate()
from execution where composition like 'Coarse-grained' and wf_id=2 and partition_id=1; 

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',1277,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',1268,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',1266,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',1250,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',1254,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',1251,100);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'tensorflow_java'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=2 and partition_id=1; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=2 and partition_id=1; 

----------------------- DenseED k=24, L=6 cpu 100 epocas cpu sdumont 12000 pontos
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',2145,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',2151,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',2138,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',2130,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',2139,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',2119,100); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'denseed'), id , curdate()
from execution where composition like 'Coarse-grained' and wf_id=2 and partition_id=1; 

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',2182,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',2150,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',2150,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',2149,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',2167,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',2138,100);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'tensorflow_java'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=2 and partition_id=1; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=2 and partition_id=1; 

----------------------- DenseED k=24, L=8 cpu 100 epocas cpu sdumont 12000 pontos
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',3208,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',3158,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',3145,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',3187,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',3223,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',3187,100); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'denseed'), id , curdate()
from execution where composition like 'Coarse-grained' and wf_id=2 and partition_id=1; 

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',3192,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',3230,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',3190,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',3245,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',3235,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',3185,100);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'tensorflow_java'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=2 and partition_id=1; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=2 and partition_id=1; 

----------------------- DenseED k=24, L=9 cpu 100 epocas cpu sdumont 12000 pontos
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',3831,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',3841,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',3828,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',3868,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',3825,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Coarse-grained',3889,100);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'denseed'), id , curdate()
from execution where composition like 'Coarse-grained' and wf_id=2 and partition_id=1; 

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',3824,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',3858,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',3932,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',3871,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',3875,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,1,curdate(),'Hybrid (Data)',3904,100); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'tensorflow_java'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=2 and partition_id=1; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=2 and partition_id=1; 

----------------------- DenseED k=24, L=4 gpu sequana
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,4,curdate(),'Coarse-grained',261,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,4,curdate(),'Coarse-grained',251,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,4,curdate(),'Coarse-grained',253,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,4,curdate(),'Coarse-grained',249,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,4,curdate(),'Coarse-grained',251,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,4,curdate(),'Coarse-grained',252,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,4,curdate(),'Coarse-grained',254,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,4,curdate(),'Coarse-grained',249,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,4,curdate(),'Coarse-grained',255,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,4,curdate(),'Coarse-grained',251,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,4,curdate(),'Coarse-grained',252,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,4,curdate(),'Coarse-grained',250,100);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'denseed'), id , curdate()
from execution where composition like 'Coarse-grained' and wf_id=2 and partition_id=4; 

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,4,curdate(),'Hybrid (Data)',255,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,4,curdate(),'Hybrid (Data)',244,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,4,curdate(),'Hybrid (Data)',250,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,4,curdate(),'Hybrid (Data)',241,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,4,curdate(),'Hybrid (Data)',244,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,4,curdate(),'Hybrid (Data)',243,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,4,curdate(),'Hybrid (Data)',256,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,4,curdate(),'Hybrid (Data)',249,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,4,curdate(),'Hybrid (Data)',249,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,4,curdate(),'Hybrid (Data)',250,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,4,curdate(),'Hybrid (Data)',249,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,4,curdate(),'Hybrid (Data)',248,100); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'tensorflow_java'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=2 and partition_id=4; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Data)' and wf_id=2 and partition_id=4;

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,4,curdate(),'Hybrid (Provenance and data)',259,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,4,curdate(),'Hybrid (Provenance and data)',248,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,4,curdate(),'Hybrid (Provenance and data)',247,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,4,curdate(),'Hybrid (Provenance and data)',247,100); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,4,curdate(),'Hybrid (Provenance and data)',244,100);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (2,4,curdate(),'Hybrid (Provenance and data)',246,100); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'tensorflow'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=2 and partition_id=4; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'dfanalyzer'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=2 and partition_id=4; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=2 and partition_id=4;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
(SELECT 1, 'Sciphy Execution, dataPersistence','./sciphy_data.sif', (select id from container_image where name like 'sciphy_data') , e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='SciPhy' and composition='Hybrid (Provenance)')

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) values (SELECT 1, 'Provenance service','./java.sif', (select id from container_image where name like 'java') , e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='SciPhy' and composition='Hybrid (Provenance)')

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Workflow)', 13248,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Workflow)', 13242,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Workflow)', 13236,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Workflow)', 13264,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Workflow)', 13258,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Workflow)', 13260,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Workflow)', 13266,200);


INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'sciphy'), id , curdate()
from execution where composition like 'Hybrid (Workflow)' and wf_id=1 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'provData'), id , curdate()
from execution where composition like 'Hybrid (Workflow)' and wf_id=1 and partition_id=2; 

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) values (SELECT 1, 'Sciphy Execution','./sciphy.sif', (select id from container_image where name like 'sciphy') , e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='SciPhy' and composition='Hybrid (Workflow)')

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) values (SELECT 1, 'Provenance service, Data persistence','./java_monetdb.sif', (select id from container_image where name like 'provData') , e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='SciPhy' and composition='Hybrid (Workflow)')


insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Provenance and data)', 13243,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Provenance and data)', 13276,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Provenance and data)', 13392,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Provenance and data)', 13297,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Provenance and data)', 13256,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Hybrid (Provenance and data)', 13248,200); 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'sciphy'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'java'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Hybrid (Provenance and data)' and wf_id=1 and partition_id=2; 

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) values (SELECT 1, 'Sciphy Execution','./sciphy.sif', (select id from container_image where name like 'sciphy') , e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='SciPhy' and composition='Hybrid (Provenance and data)')

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) values (SELECT 1, 'Provenance service','./java.sif', (select id from container_image where name like 'java') , e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='SciPhy' and composition='Hybrid (Provenance and data)')

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) values (SELECT 1, 'DataPersistence','./monetdb.sif', (select id from container_image where name like 'provDeployDatabase') , e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='SciPhy' and composition='Hybrid (Provenance and data)')

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Fine grained', 14904,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Fine grained', 13240,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Fine grained', 13170,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Fine grained', 13165,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Fine grained', 13166,200);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Fine grained', 13196,200); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Fine grained', 13406,200);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'mafft'), id , curdate()
from execution where composition like 'Fine grained' and wf_id=1 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'py-readseq-modelGenerator'), id , curdate()
from execution where composition like 'Fine grained' and wf_id=1 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'java'), id , curdate()
from execution where composition like 'Fine grained' and wf_id=1 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'raxml'), id , curdate()
from execution where composition like 'Fine grained' and wf_id=1 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'provDeployDatabase'), id , curdate()
from execution where composition like 'Fine grained' and wf_id=1 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'dfanalyzer'), id , curdate()
from execution where composition like 'Fine grained' and wf_id=1 and partition_id=2;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) values (SELECT 1, 'Mafft Execution','./mafft.sif', (select id from container_image where name like 'mafft') , e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='SciPhy' and composition='Fine grained')

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) values (SELECT 1, 'ReadSeq execution','./readseq.sif', (select id from container_image where name like 'py-readseq-modelGenerator') , e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='SciPhy' and composition='Fine grained')

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) values (SELECT 1, 'ModelGenerator','./java.sif', (select id from container_image where name like 'java') , e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='SciPhy' and composition='Fine grained')

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) values (SELECT 1, 'RaXML Execution','./raxml.sif', (select id from container_image where name like 'raxml') , e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='SciPhy' and composition='Fine grained')

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) values (SELECT 1, 'DataPersistence','./monetdb.sif', (select id from container_image where name like 'provDeployDatabase') , e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='SciPhy' and composition='Fine grained')

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) values (SELECT 1, 'Provenance service','./dfanalyzer.sif', (select id from container_image where name like 'dfanalyzer') , e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='SciPhy' and composition='Fine grained')

--400 samples

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Coarse-grained', 26340,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Coarse-grained', 26328,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Coarse-grained', 26355,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Coarse-grained', 26357,400);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Coarse-grained', 26375,400); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (1,2,curdate(), 'Coarse-grained', 26383,400);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'sciphy_data'), id , curdate()
from execution where composition like 'Coarse-grained' and wf_id=1 and partition_id=2; 

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) values (SELECT 1, 'Sciphy Execution, provenance service, dataPersistence','./sciphy_data.sif', (select id from container_image where name like 'sciphy_data') , e.id FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='SciPhy' and composition='Coarse-grained')


insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Coarse-grained', 259,5); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Coarse-grained', 259,5);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Coarse-grained', 255,5); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Coarse-grained', 255,5);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Coarse-grained', 260,5); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Coarse-grained', 255,5);

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Coarse-grained', 540,1); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Coarse-grained', 536,1);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Coarse-grained', 536,1); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Coarse-grained', 539,1);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Coarse-grained', 534,1); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Coarse-grained', 534,1);

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Coarse-grained', 1855,2); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Coarse-grained', 1846,2);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Coarse-grained', 1846,2); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Coarse-grained', 1847,2);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Coarse-grained', 1852,2); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Coarse-grained', 1840,2);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'montage'), id , curdate()
from execution where composition like 'Coarse-grained' and wf_id=6 and partition_id=2; 

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mProject, mDiffFit, mConcatFit, mBgModel, mBackground , mImgTbl, mAdd, mViewer ','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/coarse /bin/bash ./bashmontage_5.sh ', 
	(select id from container_image where name like 'montage') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow  like 'Montage' and composition='Coarse-grained' and e.samples=5;



INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mProject, mDiffFit, mConcatFit, mBgModel, mBackground , mImgTbl, mAdd, mViewer ','docker run -v ./data_10:/akoflow-wfa-shared lilianekunstmann/coarse /bin/bash ./bashmontage_1.sh ', 
	(select id from container_image where name like 'montage') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Coarse-grained' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mProject, mDiffFit, mConcatFit, mBgModel, mBackground , mImgTbl, mAdd, mViewer ','docker run -v ./data_20:/akoflow-wfa-shared lilianekunstmann/coarse /bin/bash ./bashmontage_2.sh ', 
	(select id from container_image where name like 'montage') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Coarse-grained' and samples=2;


insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Hybrid', 501,1); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Hybrid', 514,1);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Hybrid', 505,1); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Hybrid', 501,1);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Hybrid', 506,1); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Hybrid', 500,1);

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Hybrid', 251,5); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Hybrid', 252,5);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Hybrid', 249,5); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Hybrid', 245,5);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Hybrid', 262,5); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Hybrid', 264,5);

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Hybrid', 1848,2); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Hybrid', 1831,2);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Hybrid', 1852,2); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Hybrid', 1820,2);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Hybrid', 1836,2); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Hybrid', 1812,2);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'mProject'), id , curdate()
from execution where composition like 'Hybrid' and wf_id=6 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'mDiffFit'), id , curdate()
from execution where composition like 'Hybrid' and wf_id=6 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'mConcatFitBgModel'), id , curdate()
from execution where composition like 'Hybrid' and wf_id=6 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'mBackground'), id , curdate()
from execution where composition like 'Hybrid' and wf_id=6 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'mImgTblAddViewer'), id , curdate()
from execution where composition like 'Hybrid' and wf_id=6 and partition_id=2; 

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mProject','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mproject /bin/bash ./bashmproject_5.sh ', 
	(select id from container_image where name like 'mProject') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, ' mDiffFit','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mdifffit /bin/bash ./bashmdifffit_5.sh ', 
	(select id from container_image where name like 'mDiffFit') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mConcatFitBgModel','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mconcatfitbgmodel /bin/bash ./bashmconcatfitbgmodel_5.sh ', 
	(select id from container_image where name like 'mConcatFitBgModel') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mBackground','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mbackground /bin/bash ./bashmbackground_5.sh ', 
	(select id from container_image where name like 'mBackground') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mImgTbl, mAdd and mViewer','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mimgtbladdviewer /bin/bash ./bashmImgTblAddViewer_5.sh ', 
	(select id from container_image where name like 'mImgTblAddViewer') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mProject','docker run -v ./data_10:/akoflow-wfa-shared lilianekunstmann/mproject /bin/bash ./bashmproject_1.sh ', 
	(select id from container_image where name like 'mProject') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, ' mDiffFit','docker run -v ./data_10:/akoflow-wfa-shared lilianekunstmann/mdifffit /bin/bash ./bashmdifffit_1.sh ', 
	(select id from container_image where name like 'mDiffFit') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mConcatFitBgModel','docker run -v ./data_1:/akoflow-wfa-shared lilianekunstmann/mconcatfitbgmodel /bin/bash ./bashmconcatfitbgmodel_1.sh ', 
	(select id from container_image where name like 'mConcatFitBgModel') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mBackground','docker run -v ./data_10:/akoflow-wfa-shared lilianekunstmann/mbackground /bin/bash ./bashmbackground_1.sh ', 
	(select id from container_image where name like 'mBackground') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mImgTbl, mAdd and mViewer','docker run -v ./data_10:/akoflow-wfa-shared lilianekunstmann/mimgtbladdviewer /bin/bash ./bashmImgTblAddViewer_1.sh ', 
	(select id from container_image where name like 'mImgTblAddViewer') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mProject','docker run -v ./data_20:/akoflow-wfa-shared lilianekunstmann/mproject /bin/bash ./bashmproject_2.sh ', 
	(select id from container_image where name like 'mProject') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=2;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, ' mDiffFit','docker run -v ./data_20:/akoflow-wfa-shared lilianekunstmann/mdifffit /bin/bash ./bashmdifffit_2.sh ', 
	(select id from container_image where name like 'mDiffFit') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=2;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mConcatFitBgModel','docker run -v ./data_2:/akoflow-wfa-shared lilianekunstmann/mconcatfitbgmodel /bin/bash ./bashmconcatfitbgmodel_2.sh ', 
	(select id from container_image where name like 'mConcatFitBgModel') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=2;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mBackground','docker run -v ./data_20:/akoflow-wfa-shared lilianekunstmann/mbackground /bin/bash ./bashmbackground_2.sh ', 
	(select id from container_image where name like 'mBackground') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=2;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mImgTbl, mAdd and mViewer','docker run -v ./data_20:/akoflow-wfa-shared lilianekunstmann/mimgtbladdviewer /bin/bash ./bashmImgTblAddViewer_2.sh ', 
	(select id from container_image where name like 'mImgTblAddViewer') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=2;


insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Fine-grained', 271,5); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Fine-grained', 259,5);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Fine-grained', 262,5); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Fine-grained', 268,5);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Fine-grained', 275,5); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Fine-grained', 266,5);

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Fine-grained', 559,1); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Fine-grained', 556,1);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Fine-grained', 606,1); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Fine-grained', 596,1);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Fine-grained', 594,1); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Fine-grained', 688,1);

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Fine-grained', 1840,2); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Fine-grained', 1820,2);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Fine-grained', 1815,2); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Fine-grained', 1866,2);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Fine-grained', 1856,2); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,2,curdate(), 'Fine-grained', 1828,2);


INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'mProject'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=6 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'mDiffFit'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=6 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'mConcatFit'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=6 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'mBgModel'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=6 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'mBackground'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=6 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'mImgTbl'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=6 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'mAdd'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=6 and partition_id=2; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 1, (select id from container_image where name like 'mViewer'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=6 and partition_id=2; 


INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mProject','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mproject /bin/bash ./bashmproject_5.sh ', 
	(select id from container_image where name like 'mProject') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, ' mDiffFit','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mdifffit /bin/bash ./bashmdifffit_5.sh ', 
	(select id from container_image where name like 'mDiffFit') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mConcatFit','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mconcatfit /bin/bash ./bashmconcatfit_5.sh ', 
	(select id from container_image where name like 'mConcatFit') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mBgModel','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mbgmodel /bin/bash ./bashmbgmodel_5.sh ', 
	(select id from container_image where name like 'mBgModel') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mBackground','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mbackground /bin/bash ./bashmbackground_5.sh ', 
	(select id from container_image where name like 'mBackground') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mImgTbl','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mimgtbl /bin/bash ./bashmImgTbl_5.sh ', 
	(select id from container_image where name like 'mImgTbl') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mAdd','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/madd /bin/bash ./bashmAdd_5.sh ', 
	(select id from container_image where name like 'mAdd') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mViewer','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mviewer /bin/bash ./bashmViewer_5.sh ', 
	(select id from container_image where name like 'mViewer') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=5;


INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mProject','docker run -v ./data_10:/akoflow-wfa-shared lilianekunstmann/mproject /bin/bash ./bashmproject_1.sh ', 
	(select id from container_image where name like 'mProject') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, ' mDiffFit','docker run -v ./data_10:/akoflow-wfa-shared lilianekunstmann/mdifffit /bin/bash ./bashmdifffit_1.sh ', 
	(select id from container_image where name like 'mDiffFit') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mConcatFit','docker run -v ./data_10:/akoflow-wfa-shared lilianekunstmann/mconcatfit /bin/bash ./bashmconcatfit_1.sh ', 
	(select id from container_image where name like 'mConcatFit') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mBgModel','docker run -v ./data_10:/akoflow-wfa-shared lilianekunstmann/mbgmodel /bin/bash ./bashmbgmodel_1.sh ', 
	(select id from container_image where name like 'mBgModel') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mBackground','docker run -v ./data_10:/akoflow-wfa-shared lilianekunstmann/mbackground /bin/bash ./bashmbackground_1.sh ', 
	(select id from container_image where name like 'mBackground') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mImgTbl','docker run -v ./data_10:/akoflow-wfa-shared lilianekunstmann/mimgtbl /bin/bash ./bashmImgTbl_1.sh ', 
	(select id from container_image where name like 'mImgTbl') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mAdd','docker run -v ./data_10:/akoflow-wfa-shared lilianekunstmann/madd /bin/bash ./bashmAdd_1.sh ', 
	(select id from container_image where name like 'mAdd') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mViewer','docker run -v ./data_10:/akoflow-wfa-shared lilianekunstmann/mviewer /bin/bash ./bashmViewer_1.sh ', 
	(select id from container_image where name like 'mViewer') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mProject','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mproject /bin/bash ./bashmproject_5.sh ', 
	(select id from container_image where name like 'mProject') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=2;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, ' mDiffFit','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mdifffit /bin/bash ./bashmdifffit_5.sh ', 
	(select id from container_image where name like 'mDiffFit') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=2;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mConcatFit','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mconcatfit /bin/bash ./bashmconcatfit_5.sh ', 
	(select id from container_image where name like 'mConcatFit') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=2;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mBgModel','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mbgmodel /bin/bash ./bashmbgmodel_5.sh ', 
	(select id from container_image where name like 'mBgModel') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=2;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mBackground','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mbackground /bin/bash ./bashmbackground_5.sh ', 
	(select id from container_image where name like 'mBackground') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mImgTbl','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mimgtbl /bin/bash ./bashmImgTbl_5.sh ', 
	(select id from container_image where name like 'mImgTbl') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mAdd','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/madd /bin/bash ./bashmAdd_5.sh ', 
	(select id from container_image where name like 'mAdd') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mViewer','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mviewer /bin/bash ./bashmViewer_5.sh ', 
	(select id from container_image where name like 'mViewer') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=5;


insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Coarse-grained', 18,5); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Coarse-grained', 27.008,5);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Coarse-grained', 29.062,5); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Coarse-grained', 27.084,5);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Coarse-grained', 24.038,5); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Coarse-grained', 26.069,5);

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Coarse-grained', 65.033,1); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Coarse-grained', 58.088,1);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Coarse-grained', 58.026,1); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Coarse-grained', 73.074,1);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Coarse-grained', 74.009,1); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Coarse-grained', 73.045,1);

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Coarse-grained', 295.092,2); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Coarse-grained', 307.077,2);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Coarse-grained', 292.076,2); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Coarse-grained', 294.095,2);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Coarse-grained', 297.031,2); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Coarse-grained', 294.038,2);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 4, (select id from container_image where name like 'montage'), id , curdate()
from execution where composition like 'Coarse-grained' and wf_id=6 and partition_id=14; 

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mProjectPP, mDiffFit, mConcatFit, mBgModel, mBackground , mImgTbl, mAdd, mViewer ','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/coarse /bin/bash ./bashmontage_5.sh ', 
	(select id from container_image where name like 'montage') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Coarse-grained' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mProjectPP, mDiffFit, mConcatFit, mBgModel, mBackground , mImgTbl, mAdd, mViewer ','docker run -v ./data_10:/akoflow-wfa-shared lilianekunstmann/coarse /bin/bash ./bashmontage_1.sh ', 
	(select id from container_image where name like 'montage') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Coarse-grained' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mProjectPP, mDiffFit, mConcatFit, mBgModel, mBackground , mImgTbl, mAdd, mViewer ','docker run -v ./data_20:/akoflow-wfa-shared lilianekunstmann/coarse /bin/bash ./bashmontage_2.sh ', 
	(select id from container_image where name like 'montage') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Coarse-grained' and samples=2;


insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Hybrid', 26.003,1); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Hybrid', 29.016,1);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Hybrid', 25.083,1); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Hybrid', 28.095,1);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Hybrid', 29.016,1); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Hybrid', 29.022,1);

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Hybrid', 72.02,5); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Hybrid', 84.051,5);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Hybrid', 73.037,5); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Hybrid', 78.035,5);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Hybrid', 73.059,5); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Hybrid', 70.021,5);

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Hybrid', 318.058,2); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Hybrid', 345.003,2);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Hybrid', 330.077,2); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Hybrid', 340.068,2);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Hybrid', 347.046,2); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Hybrid', 332.073,2);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 4, (select id from container_image where name like 'mProjectPP'), id , curdate()
from execution where composition like 'Hybrid' and wf_id=6 and partition_id=14; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 4, (select id from container_image where name like 'mDiffFit'), id , curdate()
from execution where composition like 'Hybrid' and wf_id=6 and partition_id=14; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 4, (select id from container_image where name like 'mConcatFitBgModel'), id , curdate()
from execution where composition like 'Hybrid' and wf_id=6 and partition_id=14; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 4, (select id from container_image where name like 'mBackground'), id , curdate()
from execution where composition like 'Hybrid' and wf_id=6 and partition_id=14; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 4, (select id from container_image where name like 'mImgTblAddViewer'), id , curdate()
from execution where composition like 'Hybrid' and wf_id=6 and partition_id=14; 

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mProjectPP','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mprojectpp /bin/bash ./bashmprojectpp_5.sh ', 
	(select id from container_image where name like 'mProjectPP') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6 ,' mDiffFit','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mdifffit /bin/bash ./bashmdifffit_5.sh ', 
	(select id from container_image where name like 'mDiffFit') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mConcatFitBgModel','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mconcatfitbgmodel /bin/bash ./bashmconcatfitbgmodel_5.sh ', 
	(select id from container_image where name like 'mConcatFitBgModel') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mBackground','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mbackground /bin/bash ./bashmbackground_5.sh ', 
	(select id from container_image where name like 'mBackground') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mImgTbl, mAdd and mViewer','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mimgtbladdviewer /bin/bash ./bashmImgTblAddViewer_5.sh ', 
	(select id from container_image where name like 'mImgTblAddViewer') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mProjectPP','docker run -v ./data_10:/akoflow-wfa-shared lilianekunstmann/mprojectpp /bin/bash ./bashmprojectpp_1.sh ', 
	(select id from container_image where name like 'mProjectPP') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, ' mDiffFit','docker run -v ./data_10:/akoflow-wfa-shared lilianekunstmann/mdifffit /bin/bash ./bashmdifffit_1.sh ', 
	(select id from container_image where name like 'mDiffFit') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mConcatFitBgModel','docker run -v ./data_1:/akoflow-wfa-shared lilianekunstmann/mconcatfitbgmodel /bin/bash ./bashmconcatfitbgmodel_1.sh ', 
	(select id from container_image where name like 'mConcatFitBgModel') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mBackground','docker run -v ./data_10:/akoflow-wfa-shared lilianekunstmann/mbackground /bin/bash ./bashmbackground_1.sh ', 
	(select id from container_image where name like 'mBackground') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mImgTbl, mAdd and mViewer','docker run -v ./data_10:/akoflow-wfa-shared lilianekunstmann/mimgtbladdviewer /bin/bash ./bashmImgTblAddViewer_1.sh ', 
	(select id from container_image where name like 'mImgTblAddViewer') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mProjectPP','docker run -v ./data_20:/akoflow-wfa-shared lilianekunstmann/mprojectpp /bin/bash ./bashmprojectpp_2.sh ', 
	(select id from container_image where name like 'mProjectPP') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=2;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, ' mDiffFit','docker run -v ./data_20:/akoflow-wfa-shared lilianekunstmann/mdifffit /bin/bash ./bashmdifffit_2.sh ', 
	(select id from container_image where name like 'mDiffFit') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=2;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mConcatFitBgModel','docker run -v ./data_2:/akoflow-wfa-shared lilianekunstmann/mconcatfitbgmodel /bin/bash ./bashmconcatfitbgmodel_2.sh ', 
	(select id from container_image where name like 'mConcatFitBgModel') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=2;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mBackground','docker run -v ./data_20:/akoflow-wfa-shared lilianekunstmann/mbackground /bin/bash ./bashmbackground_2.sh ', 
	(select id from container_image where name like 'mBackground') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=2;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mImgTbl, mAdd and mViewer','docker run -v ./data_20:/akoflow-wfa-shared lilianekunstmann/mimgtbladdviewer /bin/bash ./bashmImgTblAddViewer_2.sh ', 
	(select id from container_image where name like 'mImgTblAddViewer') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=2;


insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Fine-grained', 17.006,5); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Fine-grained', 30.013,5);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Fine-grained', 22.056,5); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Fine-grained', 30.026,5);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Fine-grained', 30.046,5); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,14,curdate(), 'Fine-grained', 27.005,5);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 4, (select id from container_image where name like 'mProjectPP'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=6 and partition_id=14; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 4, (select id from container_image where name like 'mDiffFit'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=6 and partition_id=14; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 4, (select id from container_image where name like 'mConcatFit'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=6 and partition_id=14; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 4, (select id from container_image where name like 'mBgModel'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=6 and partition_id=14; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 4, (select id from container_image where name like 'mBackground'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=6 and partition_id=14; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 4, (select id from container_image where name like 'mImgTbl'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=6 and partition_id=14; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 4, (select id from container_image where name like 'mAdd'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=6 and partition_id=14; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 4, (select id from container_image where name like 'mViewer'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=6 and partition_id=14; 


INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mProjectPP','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mprojectpp /bin/bash ./bashmprojectpp_5.sh ', 
	(select id from container_image where name like 'mProjectPP') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, ' mDiffFit','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mdifffit /bin/bash ./bashmdifffit_5.sh ', 
	(select id from container_image where name like 'mDiffFit') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mConcatFit','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mconcatfit /bin/bash ./bashmconcatfit_5.sh ', 
	(select id from container_image where name like 'mConcatFit') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mBgModel','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mbgmodel /bin/bash ./bashmbgmodel_5.sh ', 
	(select id from container_image where name like 'mBgModel') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mBackground','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mbackground /bin/bash ./bashmbackground_5.sh ', 
	(select id from container_image where name like 'mBackground') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mImgTbl','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mimgtbl /bin/bash ./bashmImgTbl_5.sh ', 
	(select id from container_image where name like 'mImgTbl') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mAdd','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/madd /bin/bash ./bashmAdd_5.sh ', 
	(select id from container_image where name like 'mAdd') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mViewer','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mviewer /bin/bash ./bashmViewer_5.sh ', 
	(select id from container_image where name like 'mViewer') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=5;


insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Coarse-grained', 29.013,5); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Coarse-grained', 28.071,5);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Coarse-grained', 28.063,5); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Coarse-grained', 28.066,5);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Coarse-grained', 28.091,5); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Coarse-grained', 28.063,5);

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Coarse-grained', 84.076,1); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Coarse-grained', 86.087,1);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Coarse-grained', 86.091,1); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Coarse-grained', 86.08,1);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Coarse-grained', 83.015,1); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Coarse-grained', 86.063,1);

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Coarse-grained', 430.098,2); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Coarse-grained', 438.025,2);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Coarse-grained', 437.083,2); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Coarse-grained', 453.044,2);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Coarse-grained', 443.036,2); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Coarse-grained', 447.091,2);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 5, (select id from container_image where name like 'montage'), id , curdate()
from execution where composition like 'Coarse-grained' and wf_id=6 and partition_id=15; 

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mprojectPP, mDiffFit, mConcatFit, mBgModel, mBackground , mImgTbl, mAdd, mViewer ','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/coarse /bin/bash ./bashmontage_5.sh ', 
	(select id from container_image where name like 'montage') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Coarse-grained' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mProjectPP, mDiffFit, mConcatFit, mBgModel, mBackground , mImgTbl, mAdd, mViewer ','docker run -v ./data_10:/akoflow-wfa-shared lilianekunstmann/coarse /bin/bash ./bashmontage_1.sh ', 
	(select id from container_image where name like 'montage') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Coarse-grained' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mProjectPP, mDiffFit, mConcatFit, mBgModel, mBackground , mImgTbl, mAdd, mViewer ','docker run -v ./data_20:/akoflow-wfa-shared lilianekunstmann/coarse /bin/bash ./bashmontage_2.sh ', 
	(select id from container_image where name like 'montage') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Coarse-grained' and samples=2;


insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Hybrid', 41.042,5); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Hybrid', 30.062,5);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Hybrid', 30.068,5); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Hybrid', 30.06,5);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Hybrid', 30.053,5); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Hybrid', 30.085,5);

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Hybrid', 106.084,1); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Hybrid', 105.022,1);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Hybrid', 107.041,1); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Hybrid', 105.045,1);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Hybrid', 107.038,1); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Hybrid', 105.052,1);

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Hybrid', 505.012,2); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Hybrid', 474.035,2);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Hybrid', 467.041,2); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Hybrid', 465.007,2);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Hybrid', 464.039,2); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Hybrid', 460.013,2);

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 5, (select id from container_image where name like 'mProjectPP'), id , curdate()
from execution where composition like 'Hybrid' and wf_id=6 and partition_id=15; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 5, (select id from container_image where name like 'mDiffFit'), id , curdate()
from execution where composition like 'Hybrid' and wf_id=6 and partition_id=15; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 5, (select id from container_image where name like 'mConcatFitBgModel'), id , curdate()
from execution where composition like 'Hybrid' and wf_id=6 and partition_id=15; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 5, (select id from container_image where name like 'mBackground'), id , curdate()
from execution where composition like 'Hybrid' and wf_id=6 and partition_id=15; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 5, (select id from container_image where name like 'mImgTblAddViewer'), id , curdate()
from execution where composition like 'Hybrid' and wf_id=6 and partition_id=15; 

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mProjectPP','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mprojectpp /bin/bash ./bashmprojectpp_5.sh ', 
	(select id from container_image where name like 'mProjectPP') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, ' mDiffFit','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mdifffit /bin/bash ./bashmdifffit_5.sh ', 
	(select id from container_image where name like 'mDiffFit') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mConcatFitBgModel','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mconcatfitbgmodel /bin/bash ./bashmconcatfitbgmodel_5.sh ', 
	(select id from container_image where name like 'mConcatFitBgModel') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mBackground','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mbackground /bin/bash ./bashmbackground_5.sh ', 
	(select id from container_image where name like 'mBackground') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mImgTbl, mAdd and mViewer','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mimgtbladdviewer /bin/bash ./bashmImgTblAddViewer_5.sh ', 
	(select id from container_image where name like 'mImgTblAddViewer') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mProjectPP','docker run -v ./data_10:/akoflow-wfa-shared lilianekunstmann/mprojectpp /bin/bash ./bashmprojectpp_1.sh ', 
	(select id from container_image where name like 'mProjectPP') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, ' mDiffFit','docker run -v ./data_10:/akoflow-wfa-shared lilianekunstmann/mdifffit /bin/bash ./bashmdifffit_1.sh ', 
	(select id from container_image where name like 'mDiffFit') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mConcatFitBgModel','docker run -v ./data_1:/akoflow-wfa-shared lilianekunstmann/mconcatfitbgmodel /bin/bash ./bashmconcatfitbgmodel_1.sh ', 
	(select id from container_image where name like 'mConcatFitBgModel') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mBackground','docker run -v ./data_10:/akoflow-wfa-shared lilianekunstmann/mbackground /bin/bash ./bashmbackground_1.sh ', 
	(select id from container_image where name like 'mBackground') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mImgTbl, mAdd and mViewer','docker run -v ./data_10:/akoflow-wfa-shared lilianekunstmann/mimgtbladdviewer /bin/bash ./bashmImgTblAddViewer_1.sh ', 
	(select id from container_image where name like 'mImgTblAddViewer') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mProjectPP','docker run -v ./data_20:/akoflow-wfa-shared lilianekunstmann/mprojectpp /bin/bash ./bashmprojectpp_2.sh ', 
	(select id from container_image where name like 'mProjectPP') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=2;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, ' mDiffFit','docker run -v ./data_20:/akoflow-wfa-shared lilianekunstmann/mdifffit /bin/bash ./bashmdifffit_2.sh ', 
	(select id from container_image where name like 'mDiffFit') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=2;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mConcatFitBgModel','docker run -v ./data_2:/akoflow-wfa-shared lilianekunstmann/mconcatfitbgmodel /bin/bash ./bashmconcatfitbgmodel_2.sh ', 
	(select id from container_image where name like 'mConcatFitBgModel') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=2;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mBackground','docker run -v ./data_20:/akoflow-wfa-shared lilianekunstmann/mbackground /bin/bash ./bashmbackground_2.sh ', 
	(select id from container_image where name like 'mBackground') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=2;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mImgTbl, mAdd and mViewer','docker run -v ./data_20:/akoflow-wfa-shared lilianekunstmann/mimgtbladdviewer /bin/bash ./bashmImgTblAddViewer_2.sh ', 
	(select id from container_image where name like 'mImgTblAddViewer') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Hybrid' and samples=2;


insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Fine-grained', 39.077,5); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Fine-grained', 32.027,5);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Fine-grained', 32.051,5); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Fine-grained', 32.03,5);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Fine-grained', 32.023,5); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Fine-grained', 32.047,5);

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Fine-grained', 110.023,1); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Fine-grained', 108.088,1);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Fine-grained', 109.052,1); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Fine-grained', 108.094,1);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Fine-grained', 109.018,1); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Fine-grained', 109.079,1);

insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Fine-grained', 506,2); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Fine-grained', 490,2);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Fine-grained', 481.081,2); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Fine-grained', 469.024,2);
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Fine-grained', 470.021,2); 
insert into execution(wf_id, partition_id, timestamp, composition, elapsed_time,samples) values (6,15,curdate(), 'Fine-grained', 463.087,2);


INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 5, (select id from container_image where name like 'mProject'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=6 and partition_id=15; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 5, (select id from container_image where name like 'mDiffFit'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=6 and partition_id=15; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 5, (select id from container_image where name like 'mConcatFit'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=6 and partition_id=15; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 5, (select id from container_image where name like 'mBgModel'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=6 and partition_id=15; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 5, (select id from container_image where name like 'mBackground'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=6 and partition_id=15; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 5, (select id from container_image where name like 'mImgTbl'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=6 and partition_id=15; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 5, (select id from container_image where name like 'mAdd'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=6 and partition_id=15; 

INSERT INTO "public".container (host_environment_id, image_id, execution_id, created) 
SELECT 5, (select id from container_image where name like 'mViewer'), id , curdate()
from execution where composition like 'Fine-grained' and wf_id=6 and partition_id=15; 


INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mProjectPP','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mprojectpp /bin/bash ./bashmprojectpp_5.sh ', 
	(select id from container_image where name like 'mProjectPP') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, ' mDiffFit','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mdifffit /bin/bash ./bashmdifffit_5.sh ', 
	(select id from container_image where name like 'mDiffFit') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mConcatFit','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mconcatfit /bin/bash ./bashmconcatfit_5.sh ', 
	(select id from container_image where name like 'mConcatFit') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mBgModel','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mbgmodel /bin/bash ./bashmbgmodel_5.sh ', 
	(select id from container_image where name like 'mBgModel') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mBackground','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mbackground /bin/bash ./bashmbackground_5.sh ', 
	(select id from container_image where name like 'mBackground') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mImgTbl','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mimgtbl /bin/bash ./bashmImgTbl_5.sh ', 
	(select id from container_image where name like 'mImgTbl') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mAdd','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/madd /bin/bash ./bashmAdd_5.sh ', 
	(select id from container_image where name like 'mAdd') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=5;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mViewer','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mviewer /bin/bash ./bashmViewer_5.sh ', 
	(select id from container_image where name like 'mViewer') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=5;


INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mProjectPP','docker run -v ./data_10:/akoflow-wfa-shared lilianekunstmann/mprojectpp /bin/bash ./bashmprojectpp_1.sh ', 
	(select id from container_image where name like 'mProjectPP') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, ' mDiffFit','docker run -v ./data_10:/akoflow-wfa-shared lilianekunstmann/mdifffit /bin/bash ./bashmdifffit_1.sh ', 
	(select id from container_image where name like 'mDiffFit') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mConcatFit','docker run -v ./data_10:/akoflow-wfa-shared lilianekunstmann/mconcatfit /bin/bash ./bashmconcatfit_1.sh ', 
	(select id from container_image where name like 'mConcatFit') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mBgModel','docker run -v ./data_10:/akoflow-wfa-shared lilianekunstmann/mbgmodel /bin/bash ./bashmbgmodel_1.sh ', 
	(select id from container_image where name like 'mBgModel') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mBackground','docker run -v ./data_10:/akoflow-wfa-shared lilianekunstmann/mbackground /bin/bash ./bashmbackground_1.sh ', 
	(select id from container_image where name like 'mBackground') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mImgTbl','docker run -v ./data_10:/akoflow-wfa-shared lilianekunstmann/mimgtbl /bin/bash ./bashmImgTbl_1.sh ', 
	(select id from container_image where name like 'mImgTbl') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mAdd','docker run -v ./data_10:/akoflow-wfa-shared lilianekunstmann/madd /bin/bash ./bashmAdd_1.sh ', 
	(select id from container_image where name like 'mAdd') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mViewer','docker run -v ./data_10:/akoflow-wfa-shared lilianekunstmann/mviewer /bin/bash ./bashmViewer_1.sh ', 
	(select id from container_image where name like 'mViewer') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=1;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mProjectPP','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mprojectpp /bin/bash ./bashmprojectpp_5.sh ', 
	(select id from container_image where name like 'mProjectPP') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=2;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, ' mDiffFit','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mdifffit /bin/bash ./bashmdifffit_5.sh ', 
	(select id from container_image where name like 'mDiffFit') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=2;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mConcatFit','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mconcatfit /bin/bash ./bashmconcatfit_5.sh ', 
	(select id from container_image where name like 'mConcatFit') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=2;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mBgModel','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mbgmodel /bin/bash ./bashmbgmodel_5.sh ', 
	(select id from container_image where name like 'mBgModel') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=2;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mBackground','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mbackground /bin/bash ./bashmbackground_5.sh ', 
	(select id from container_image where name like 'mBackground') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=2;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mImgTbl','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mimgtbl /bin/bash ./bashmImgTbl_5.sh ', 
	(select id from container_image where name like 'mImgTbl') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=2;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mAdd','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/madd /bin/bash ./bashmAdd_5.sh ', 
	(select id from container_image where name like 'mAdd') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=2;

INSERT INTO workflow_execution(wf_id, activity, exec_command, image_id, exec_id) 
SELECT 6, 'mViewer','docker run -v ./data_50:/akoflow-wfa-shared lilianekunstmann/mviewer /bin/bash ./bashmViewer_5.sh ', 
	(select id from container_image where name like 'mViewer') , e.id 
FROM execution e join workflow w on w.id=e.wf_id JOIN env_partition ep on e.partition_id=ep.id where w.workflow='Montage' and composition='Fine-grained' and samples=2;

