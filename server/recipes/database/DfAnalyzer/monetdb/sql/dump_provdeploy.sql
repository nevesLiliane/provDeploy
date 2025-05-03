-- msqldump version 11.45.13 (Sep2022-SP2) dump database
-- server: MonetDB v11.33.11 (Apr2019), 'mapi:monetdb://liliane-iMac20-1:50000/contprov'
-- Fri Nov 29 21:59:03 2024
START TRANSACTION;
SET SCHEMA "public";
CREATE SEQUENCE "public"."cmd_id_seq" AS INTEGER;
CREATE SEQUENCE "public"."config_id_seq" AS INTEGER;
CREATE SEQUENCE "public"."cpu_usage_seq" AS INTEGER;
CREATE SEQUENCE "public"."disk_usage_seq" AS INTEGER;
CREATE SEQUENCE "public"."entrypoint_id_seq" AS INTEGER;
CREATE SEQUENCE "public"."env_id_seq" AS INTEGER;
CREATE SEQUENCE "public"."enviroment_id_seq" AS INTEGER;
CREATE SEQUENCE "public"."execution_id_seq" AS INTEGER;
CREATE SEQUENCE "public"."image_id_seq" AS INTEGER;
CREATE SEQUENCE "public"."iostream_id_seq" AS INTEGER;
CREATE SEQUENCE "public"."label_id_seq" AS INTEGER;
CREATE SEQUENCE "public"."memory_usage_seq" AS INTEGER;
CREATE SEQUENCE "public"."network_id_seq" AS INTEGER;
CREATE SEQUENCE "public"."network_usage_seq" AS INTEGER;
CREATE SEQUENCE "public"."partition_id_seq" AS INTEGER;
CREATE SEQUENCE "public"."root_id_seq" AS INTEGER;
CREATE SEQUENCE "public"."software_id_seq" AS INTEGER;
CREATE SEQUENCE "public"."wf_desc_seq" AS INTEGER;
CREATE SEQUENCE "public"."wf_id_seq" AS INTEGER;
CREATE TABLE "public"."environment" (
	"id"                 INTEGER       NOT NULL,
	"name"               VARCHAR(155),
	"os"                 VARCHAR(155),
	"os_version"         VARCHAR(155),
	"scheduler"          VARCHAR(155),
	"kernel"             VARCHAR(155),
	"kernel_version"     VARCHAR(155),
	"kernel_modules"     VARCHAR(155),
	"kernel_bypass_libs" VARCHAR(155),
	CONSTRAINT "environment_id_pkey" PRIMARY KEY ("id")
);
COPY 8 RECORDS INTO "public"."environment" FROM stdin USING DELIMITERS E'\t',E'\n','"';
1	"Santos Dumont"	"Red Hat"	"7.0"	"slurm"	NULL	NULL	NULL	NULL
2	"Santos Dumont"	"Red Hat"	"7.0"	"slurm"	NULL	NULL	NULL	NULL
3	"AWS"	NULL	NULL	NULL	NULL	NULL	NULL	NULL
4	"Santos Dumont"	"Red Hat"	"7.0"	"slurm"	NULL	NULL	NULL	NULL
5	"AWS"	NULL	NULL	NULL	NULL	NULL	NULL	NULL
6	"LocalEnv"	NULL	NULL	NULL	NULL	NULL	NULL	NULL
7	"Labesi"	NULL	NULL	NULL	NULL	NULL	NULL	NULL
8	"GCP"	NULL	NULL	NULL	NULL	NULL	NULL	NULL
CREATE TABLE "public"."image" (
	"id"                   INTEGER       NOT NULL,
	"created"              DATE,
	"author"               VARCHAR(155),
	"arch"                 VARCHAR(155),
	"os"                   VARCHAR(155),
	"os_version"           VARCHAR(155),
	"url"                  VARCHAR(155),
	"config_file"          VARCHAR(155),
	"hash"                 VARCHAR(155),
	"requirements"         VARCHAR(155),
	"tag"                  VARCHAR(155),
	"mediaType"            VARCHAR(155),
	"vendor"               VARCHAR(155),
	"documentation"        VARCHAR(155),
	"name"                 VARCHAR(155),
	"description"          VARCHAR(155),
	"build_environment_id" INTEGER,
	"image_type"           VARCHAR(155),
	"image_path"           VARCHAR(155),
	"execution_command"    VARCHAR(155),
	"base_image_id"        INTEGER,
	"original_image_id"    INTEGER,
	"default_prov"         INTEGER,
	"OCI_format"           BOOLEAN,
	"lib_origin"           VARCHAR(100),
	"engine_version"       VARCHAR(100),
	"schema_version"       VARCHAR(100),
	CONSTRAINT "image_id_pkey" PRIMARY KEY ("id")
);
COPY 29 RECORDS INTO "public"."image" FROM stdin USING DELIMITERS E'\t',E'\n','"';
1	2024-03-01	"Liliane"	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	"icc"	"Intel compiler with dfa-lib-cpp"	NULL	"application"	"recipes/application/icc/"	"./recipes/application/icc/icc.sif"	NULL	NULL	NULL	NULL	NULL	NULL	NULL
2	2024-03-01	"Liliane"	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	"tensorflow"	"Tensorflow with dfa-lib-python"	NULL	"application"	"recipes/application/tensorflow/"	"./recipes/application/tensorflow/tensorflow.sif python3"	NULL	NULL	NULL	NULL	NULL	NULL	NULL
3	2024-03-01	"Liliane"	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	"dfanalyzer"	"Container of dfanalyzer"	NULL	"provCollector"	"recipes/provCollector/DfAnalyzer"	"singularity run --pwd $PWD/recipes/provCollector/DfAnalyzer ./recipes/provCollector/DfAnalyzer/java_tomcat.sif java -jar target/DfAnalyzer-1.0.jar"	NULL	NULL	1	NULL	NULL	NULL	NULL
4	2024-03-01	"Liliane"	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	"provDeployDatabase"	"Container of provdeploy database"	NULL	"database"	"recipes/database/"	"./recipes/database/database.sif"	NULL	NULL	NULL	NULL	NULL	NULL	NULL
5	2024-03-01	"Liliane"	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	"py-readseq-modelGenerator"	"ReadSeq, python2, java, raxml, dfa-lib-python with telemetry, and psutils por python applications"	NULL	"application"	"recipes/application/readSeq-ModelGenerator-py/"	"./recipes/application/readSeq-ModelGenerator-py/readseq.simg python"	NULL	NULL	NULL	NULL	NULL	NULL	NULL
6	2024-03-01	"Liliane"	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	"java-readseq-modelGenerator"	"ReadSeq, python2, java, raxml, dfa-lib-python with telemetry, and psutils por python applications"	NULL	"application"	"recipes/application/readSeq-ModelGenerator-py/"	"./recipes/application/readSeq-ModelGenerator-py/readseq.simg java"	NULL	NULL	NULL	NULL	NULL	NULL	NULL
7	2024-03-01	"Liliane"	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	"python37"	"Python 3.7 with dfa-lib-python"	NULL	"application"	"recipes/application/python37/"	"./recipes/application/python37/python37.sif python3.7"	NULL	NULL	NULL	NULL	NULL	NULL	NULL
22	2024-05-22	"Liliane"	"amd64"	"Ubuntu"	"18.04.3"	NULL	NULL	NULL	NULL	NULL	NULL	"singularity"	NULL	"denseed"	"DenseED with DfAnalyzer and MonetDB"	3	"application"	"recipes/application/tensorflow/"	"./recipes/application/tensorflow/denseed.sif python3.7"	2	NULL	NULL	NULL	NULL	NULL	NULL
23	2024-05-22	"Liliane"	"amd64"	"Ubuntu"	"18.04.5"	NULL	NULL	NULL	NULL	NULL	NULL	"singularity"	NULL	"provData"	"DfAnalyzer and MonetDB"	3	"provenance"	"recipes/application/provdata/"	"./recipes/application/provdata/provData.sif "	3	NULL	NULL	NULL	NULL	NULL	NULL
24	2024-11-27	"Liliane"	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	"mafft"	"Mafft for sciphy"	NULL	"application"	"recipes/application/mafft/"	"./recipes/application/mafft/mafft.sif"	NULL	NULL	NULL	NULL	NULL	NULL	NULL
25	2024-11-27	"Liliane"	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	"java"	"Java Image"	NULL	"aa"	"recipes/provCollector/DfAnalyzer"	"singularity run --pwd $PWD/recipes/provCollector/DfAnalyzer ./recipes/provCollector/DfAnalyzer/java_tomcat.sif java "	NULL	NULL	NULL	NULL	NULL	NULL	NULL
26	2024-11-27	"Liliane"	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	"raxml"	"Java Image"	NULL	"aa"	"recipes/provCollector/DfAnalyzer"	"singularity run --pwd $PWD/recipes/provCollector/DfAnalyzer ./recipes/provCollector/DfAnalyzer/java_tomcat.sif java -jar target/DfAnalyzer-1.0.jar"	NULL	NULL	NULL	NULL	NULL	NULL	NULL
27	2024-11-27	"Liliane"	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	"sciphy"	"Sciphy image"	NULL	"application"	"recipes/application/sciphy/"	"./recipes/application/sciphy/sciphy.sif"	NULL	NULL	NULL	NULL	NULL	NULL	NULL
28	2024-11-27	"Liliane"	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	"sciphy_data"	"Sciphy image with monetdb"	NULL	"aa"	"recipes/application/sciphy"	"singularity run --pwd $PWD/recipes/application/sciphy ./recipes/application/sciphy/sciphy_monet.sif java "	NULL	NULL	NULL	NULL	NULL	NULL	NULL
29	2024-11-27	"Liliane"	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	"tensorflow_java"	"Tensorflow with dfa-lib-python and dfanalyzer"	NULL	"application"	"recipes/application/tensorflow/"	"./recipes/application/tensorflow/tensorflow_java.sif python3"	NULL	NULL	NULL	NULL	NULL	NULL	NULL
30	2024-11-27	"Liliane"	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	"tensorflow_monetdb"	"Tensorflow with dfa-lib-python and monetdb"	NULL	"application"	"recipes/application/tensorflow/"	"./recipes/application/tensorflow/tensorflow_monetdb.sif python3"	NULL	NULL	NULL	NULL	NULL	NULL	NULL
31	2024-11-27	"ovvesley"	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	"docker"	NULL	"montage"	"Montage actitivies"	NULL	"application"	""	""	NULL	NULL	NULL	NULL	NULL	NULL	NULL
32	2024-11-27	"lilianekunstmann"	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	"docker"	NULL	"mProject"	"mProject actitivy"	NULL	"application"	""	""	NULL	NULL	NULL	NULL	NULL	NULL	NULL
33	2024-11-27	"lilianekunstmann"	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	"docker"	NULL	"mProjectPP"	"optimized mProject actitivy"	NULL	"application"	""	""	NULL	NULL	NULL	NULL	NULL	NULL	NULL
34	2024-11-27	"lilianekunstmann"	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	"docker"	NULL	"mDiffFit"	"mDiffFit actitivy"	NULL	"application"	""	""	NULL	NULL	NULL	NULL	NULL	NULL	NULL
35	2024-11-27	"lilianekunstmann"	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	"docker"	NULL	"mConcatFit"	"mConcatFit actitivy"	NULL	"application"	""	""	NULL	NULL	NULL	NULL	NULL	NULL	NULL
36	2024-11-27	"lilianekunstmann"	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	"docker"	NULL	"mBgModel"	"mBgModel actitivy"	NULL	"application"	""	""	NULL	NULL	NULL	NULL	NULL	NULL	NULL
37	2024-11-27	"lilianekunstmann"	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	"docker"	NULL	"mBackground"	"mBackground actitivy"	NULL	"application"	""	""	NULL	NULL	NULL	NULL	NULL	NULL	NULL
38	2024-11-27	"lilianekunstmann"	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	"docker"	NULL	"mImgTbl"	"mImgTbl actitivy"	NULL	"application"	""	""	NULL	NULL	NULL	NULL	NULL	NULL	NULL
39	2024-11-27	"lilianekunstmann"	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	"docker"	NULL	"mAdd"	"mAdd actitivy"	NULL	"application"	""	""	NULL	NULL	NULL	NULL	NULL	NULL	NULL
40	2024-11-27	"lilianekunstmann"	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	"docker"	NULL	"mViewer"	"mViewer actitivy"	NULL	"application"	""	""	NULL	NULL	NULL	NULL	NULL	NULL	NULL
41	2024-11-27	"lilianekunstmann"	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	"docker"	NULL	"mConcatFitBgModel"	"mconcatFit and mBgModel activities"	NULL	"application"	""	""	NULL	NULL	NULL	NULL	NULL	NULL	NULL
42	2024-11-27	"lilianekunstmann"	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	"docker"	NULL	"mImgTblAddViewer"	"mImgTbl, mAdd and mViewer actitivies"	NULL	"application"	""	""	NULL	NULL	NULL	NULL	NULL	NULL	NULL
48	2024-11-23	NULL	" amd64"	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	"singularity"	NULL	"denseed2"	"Test adição"	NULL	"a"	"/recipes/application/denseed2"	"./denseed.sif python"	22	NULL	0	NULL	" localimage"	" eb61379-dirty"	" 1.0"
CREATE TABLE "public"."workflow" (
	"id"       INTEGER       NOT NULL,
	"workflow" VARCHAR(155),
	CONSTRAINT "workflow_id_pkey" PRIMARY KEY ("id")
);
COPY 32 RECORDS INTO "public"."workflow" FROM stdin USING DELIMITERS E'\t',E'\n','"';
1	"SciPhy"
2	"DenseD"
3	"SciPhy"
4	"DenseD"
5	"SciPhy"
6	"DenseD"
7	"wf-test-hibrid"
8	"wf-test-hibrid"
9	"wf-test-hibrid"
10	"wf-test-hibrid"
11	"wf-test-hibrid"
12	"wf-test-hibrid"
13	"wf-test-hibrid"
14	"wf-test-hibrid"
15	"wf-test-hibrid"
16	"wf-test-hibrid"
17	"wf-test-hibrid"
18	"wf-test-hibrid"
19	"wf-test-hibrid"
20	"wf-test-hibrid"
21	"wf-test-hibrid"
22	"wf-test-hibrid"
23	"wf-test-hibrid"
24	"wf-test-hibrid"
25	"wf-test-hibrid"
26	"wf-test-hibrid"
27	"wf-test-hibrid"
28	"wf-test-hibrid"
29	"wf-test-hibrid"
30	"SciPhy"
31	"DenseED"
32	"Montage"
CREATE TABLE "public"."env_partition" (
	"id"             INTEGER       NOT NULL,
	"name"           VARCHAR(155),
	"specification"  VARCHAR(155),
	"environment_id" INTEGER,
	CONSTRAINT "env_partition_id_pkey" PRIMARY KEY ("id")
);
COPY 25 RECORDS INTO "public"."env_partition" FROM stdin USING DELIMITERS E'\t',E'\n','"';
1	"cpu"	NULL	1
2	"cpu_small"	NULL	1
3	"cpu_dev"	NULL	1
4	"sequana_gpu"	NULL	1
5	"sequana_gpu_dev"	NULL	1
6	"gdl"	NULL	1
7	"c5.xlarge"	NULL	2
8	"c5.4xlarge"	NULL	2
9	"c5.xlarge spot"	NULL	2
10	"c5.4xlarge spot"	NULL	2
11	"cpu"	NULL	1
12	"cpu_small"	NULL	1
13	"cpu_dev"	NULL	1
14	"sequana_gpu"	NULL	1
15	"sequana_gpu_dev"	NULL	1
16	"gdl"	NULL	1
17	"c5.xlarge"	NULL	2
18	"c5.4xlarge"	NULL	2
19	"c5.xlarge spot"	NULL	2
20	"c5.4xlarge spot"	NULL	2
21	"t3a.large"	NULL	2
22	"liliane-iMac20-1"	NULL	3
23	"M1"	NULL	4
24	"M2"	NULL	4
25	"n2-highcpu-32"	NULL	5
CREATE TABLE "public"."execution" (
	"id"           INTEGER       NOT NULL,
	"wf_id"        INTEGER       NOT NULL,
	"partition_id" INTEGER,
	"timestamp"    DATE,
	"job_id"       VARCHAR(155),
	"composition"  VARCHAR(155),
	"elapsed_time" INTEGER,
	"samples"      VARCHAR(100),
	CONSTRAINT "execution_id_pkey" PRIMARY KEY ("id")
);
COPY 795 RECORDS INTO "public"."execution" FROM stdin USING DELIMITERS E'\t',E'\n','"';
63	1	2	2024-03-01	NULL	"coarse grained"	13240	NULL
64	1	2	2024-03-01	NULL	"coarse grained"	13170	NULL
65	1	2	2024-03-01	NULL	"coarse grained"	13165	NULL
66	1	2	2024-03-01	NULL	"coarse grained"	13166	NULL
67	1	2	2024-03-01	NULL	"coarse grained"	13196	NULL
68	1	2	2024-03-01	NULL	"coarse grained"	13406	NULL
69	1	2	2024-03-01	NULL	"Partial Modular(Data)"	13194	NULL
70	1	2	2024-03-01	NULL	"Partial Modular(Data)"	13195	NULL
71	1	2	2024-03-01	NULL	"Partial Modular(Data)"	13199	NULL
72	1	2	2024-03-01	NULL	"Partial Modular(Data)"	13195	NULL
73	1	2	2024-03-01	NULL	"Partial Modular(Data)"	13205	NULL
74	1	2	2024-03-01	NULL	"Partial Modular(Data)"	13211	NULL
75	1	2	2024-03-01	NULL	"Partial Modular(Provenance)"	13188	NULL
76	1	2	2024-03-01	NULL	"Partial Modular(Provenance)"	13172	NULL
77	1	2	2024-03-01	NULL	"Partial Modular(Provenance)"	13566	NULL
78	1	2	2024-03-01	NULL	"Partial Modular(Provenance)"	13198	NULL
79	1	2	2024-03-01	NULL	"Partial Modular(Provenance)"	13220	NULL
80	1	2	2024-03-01	NULL	"Partial Modular(Provenance)"	13235	NULL
81	1	2	2024-03-01	NULL	"Partial Modular(Workflow)"	13248	NULL
82	1	2	2024-03-01	NULL	"Partial Modular(Workflow)"	13242	NULL
83	1	2	2024-03-01	NULL	"Partial Modular(Workflow)"	13236	NULL
84	1	2	2024-03-01	NULL	"Partial Modular(Workflow)"	13264	NULL
85	1	2	2024-03-01	NULL	"Partial Modular(Workflow)"	13258	NULL
86	1	2	2024-03-01	NULL	"Partial Modular(Workflow)"	13260	NULL
87	1	2	2024-03-01	NULL	"Partial Modular(Workflow)"	13266	NULL
88	1	2	2024-03-01	NULL	"Partial Modular(Provenance and data)"	13195	NULL
89	1	2	2024-03-01	NULL	"Partial Modular(Data)"	13205	NULL
90	1	2	2024-03-01	NULL	"Partial Modular(Data)"	13211	NULL
91	1	2	2024-03-01	NULL	"Partial Modular(Data)"	13199	NULL
92	1	2	2024-03-01	NULL	"Partial Modular(Data)"	13195	NULL
93	1	2	2024-03-01	NULL	"Partial Modular(Data)"	13199	NULL
94	1	2	2024-03-01	NULL	"Partial Modular(Data)"	13195	NULL
100	22	NULL	2024-03-28	NULL	"Hybrid"	NULL	NULL
101	23	NULL	2024-03-28	NULL	"Hybrid"	NULL	NULL
102	24	NULL	2024-03-28	NULL	"Hybrid"	NULL	NULL
103	25	NULL	2024-03-28	NULL	"Hybrid"	NULL	NULL
104	26	NULL	2024-03-28	NULL	"Hybrid"	NULL	NULL
105	27	NULL	2024-03-28	NULL	"Hybrid"	NULL	NULL
106	28	NULL	2024-03-28	NULL	"Hybrid"	NULL	NULL
107	29	NULL	2024-03-28	NULL	"Hybrid"	NULL	NULL
108	1	2	2024-11-27	NULL	"coarse grained"	13240	"200"
109	1	2	2024-11-27	NULL	"coarse grained"	13170	"200"
110	1	2	2024-11-27	NULL	"coarse grained"	13165	"200"
111	1	2	2024-11-27	NULL	"coarse grained"	13166	"200"
112	1	2	2024-11-27	NULL	"coarse grained"	13196	"200"
113	1	2	2024-11-27	NULL	"coarse grained"	13406	"200"
114	1	2	2024-11-27	NULL	"Hybrid (Data)"	13194	"200"
115	1	2	2024-11-27	NULL	"Hybrid (Data)"	13195	"200"
116	1	2	2024-11-27	NULL	"Hybrid (Data)"	13199	"200"
117	1	2	2024-11-27	NULL	"Hybrid (Data)"	13195	"200"
118	1	2	2024-11-27	NULL	"Hybrid (Data)"	13205	"200"
119	1	2	2024-11-27	NULL	"Hybrid (Data)"	13211	"200"
120	1	2	2024-11-27	NULL	"Hybrid (Provenance)"	13188	"200"
121	1	2	2024-11-27	NULL	"Hybrid (Provenance)"	13172	"200"
122	1	2	2024-11-27	NULL	"Hybrid (Provenance)"	13566	"200"
123	1	2	2024-11-27	NULL	"Hybrid (Provenance)"	13198	"200"
124	1	2	2024-11-27	NULL	"Hybrid (Provenance)"	13220	"200"
125	1	2	2024-11-27	NULL	"Hybrid (Provenance)"	13235	"200"
126	1	2	2024-11-27	NULL	"Hybrid (Workflow)"	13248	"200"
127	1	2	2024-11-27	NULL	"Hybrid (Workflow)"	13242	"200"
128	1	2	2024-11-27	NULL	"Hybrid (Workflow)"	13236	"200"
129	1	2	2024-11-27	NULL	"Hybrid (Workflow)"	13264	"200"
130	1	2	2024-11-27	NULL	"Hybrid (Workflow)"	13258	"200"
131	1	2	2024-11-27	NULL	"Hybrid (Workflow)"	13260	"200"
132	1	2	2024-11-27	NULL	"Hybrid (Workflow)"	13266	"200"
133	1	2	2024-11-27	NULL	"Hybrid (Provenance and data)"	13243	"200"
134	1	2	2024-11-27	NULL	"Hybrid (Provenance and data)"	13276	"200"
135	1	2	2024-11-27	NULL	"Hybrid (Provenance and data)"	13392	"200"
136	1	2	2024-11-27	NULL	"Hybrid (Provenance and data)"	13297	"200"
137	1	2	2024-11-27	NULL	"Hybrid (Provenance and data)"	13256	"200"
138	1	2	2024-11-27	NULL	"Hybrid (Provenance and data)"	13248	"200"
139	1	2	2024-11-27	NULL	"Fine grained"	14904	"200"
140	1	2	2024-11-27	NULL	"Fine grained"	13240	"200"
141	1	2	2024-11-27	NULL	"Fine grained"	13170	"200"
142	1	2	2024-11-27	NULL	"Fine grained"	13165	"200"
143	1	2	2024-11-27	NULL	"Fine grained"	13166	"200"
144	1	2	2024-11-27	NULL	"Fine grained"	13196	"200"
145	1	2	2024-11-27	NULL	"Fine grained"	13406	"200"
146	1	2	2024-11-27	NULL	"Coarse-grained"	26340	"400"
147	1	2	2024-11-27	NULL	"Coarse-grained"	26328	"400"
148	1	2	2024-11-27	NULL	"Coarse-grained"	26355	"400"
149	1	2	2024-11-27	NULL	"Coarse-grained"	26357	"400"
150	1	2	2024-11-27	NULL	"Coarse-grained"	26375	"400"
151	1	2	2024-11-27	NULL	"Coarse-grained"	26383	"400"
152	1	2	2024-11-27	NULL	"Hybrid (Data)"	26358	"400"
153	1	2	2024-11-27	NULL	"Hybrid (Data)"	26356	"400"
154	1	2	2024-11-27	NULL	"Hybrid (Data)"	26313	"400"
155	1	2	2024-11-27	NULL	"Hybrid (Data)"	26055	"400"
156	1	2	2024-11-27	NULL	"Hybrid (Data)"	26428	"400"
157	1	2	2024-11-27	NULL	"Hybrid (Data)"	26471	"400"
158	1	2	2024-11-27	NULL	"Hybrid (Provenance)"	26318	"400"
159	1	2	2024-11-27	NULL	"Hybrid (Provenance)"	26321	"400"
160	1	2	2024-11-27	NULL	"Hybrid (Provenance)"	26345	"400"
161	1	2	2024-11-27	NULL	"Hybrid (Provenance)"	26350	"400"
162	1	2	2024-11-27	NULL	"Hybrid (Provenance)"	26389	"400"
163	1	2	2024-11-27	NULL	"Hybrid (Provenance)"	26369	"400"
164	1	2	2024-11-27	NULL	"Hybrid (Workflow)"	26315	"400"
165	1	2	2024-11-27	NULL	"Hybrid (Workflow)"	26411	"400"
166	1	2	2024-11-27	NULL	"Hybrid (Workflow)"	26308	"400"
167	1	2	2024-11-27	NULL	"Hybrid (Workflow)"	26372	"400"
168	1	2	2024-11-27	NULL	"Hybrid (Workflow)"	26410	"400"
169	1	2	2024-11-27	NULL	"Hybrid (Workflow)"	26481	"400"
170	1	2	2024-11-27	NULL	"Hybrid (Provenance and data)"	26356	"400"
171	1	2	2024-11-27	NULL	"Hybrid (Provenance and data)"	26350	"400"
172	1	2	2024-11-27	NULL	"Hybrid (Provenance and data)"	26376	"400"
173	1	2	2024-11-27	NULL	"Hybrid (Provenance and data)"	26392	"400"
174	1	2	2024-11-27	NULL	"Hybrid (Provenance and data)"	26420	"400"
175	1	2	2024-11-27	NULL	"Hybrid (Provenance and data)"	26435	"400"
176	1	2	2024-11-27	NULL	"Fine-grained"	27062	"400"
177	1	2	2024-11-27	NULL	"Fine-grained"	27121	"400"
178	1	2	2024-11-27	NULL	"Fine-grained"	27281	"400"
179	1	2	2024-11-27	NULL	"Fine-grained"	27229	"400"
180	1	2	2024-11-27	NULL	"Fine-grained"	27293	"400"
181	1	2	2024-11-27	NULL	"Fine-grained"	27331	"400"
182	1	11	2024-11-27	NULL	"Coarse-grained"	91935	"200"
183	1	11	2024-11-27	NULL	"Coarse-grained"	87254	"200"
184	1	11	2024-11-27	NULL	"Coarse-grained"	92296	"200"
185	1	11	2024-11-27	NULL	"Coarse-grained"	87600	"200"
186	1	11	2024-11-27	NULL	"Coarse-grained"	91746	"200"
187	1	11	2024-11-27	NULL	"Hybrid (Data)"	86958	"200"
188	1	11	2024-11-27	NULL	"Hybrid (Data)"	86383	"200"
189	1	11	2024-11-27	NULL	"Hybrid (Data)"	87282	"200"
190	1	11	2024-11-27	NULL	"Hybrid (Data)"	90744	"200"
191	1	11	2024-11-27	NULL	"Hybrid (Data)"	88172	"200"
192	1	11	2024-11-27	NULL	"Hybrid (Provenance)"	88981	"200"
193	1	11	2024-11-27	NULL	"Hybrid (Provenance)"	92383	"200"
194	1	11	2024-11-27	NULL	"Hybrid (Provenance)"	93055	"200"
195	1	11	2024-11-27	NULL	"Hybrid (Provenance)"	88899	"200"
196	1	11	2024-11-27	NULL	"Hybrid (Provenance)"	92128	"200"
197	1	11	2024-11-27	NULL	"Hybrid (Workflow)"	91712	"200"
198	1	11	2024-11-27	NULL	"Hybrid (Workflow)"	88628	"200"
199	1	11	2024-11-27	NULL	"Hybrid (Workflow)"	91523	"200"
200	1	11	2024-11-27	NULL	"Hybrid (Workflow)"	90731	"200"
201	1	11	2024-11-27	NULL	"Hybrid (Workflow)"	87780	"200"
202	1	11	2024-11-27	NULL	"Hybrid (Provenance and data)"	90094	"200"
203	1	11	2024-11-27	NULL	"Hybrid (Provenance and data)"	87759	"200"
204	1	11	2024-11-27	NULL	"Hybrid (Provenance and data)"	86711	"200"
205	1	11	2024-11-27	NULL	"Hybrid (Provenance and data)"	92974	"200"
206	1	11	2024-11-27	NULL	"Hybrid (Provenance and data)"	87383	"200"
207	1	7	2024-11-27	NULL	"Coarse-grained"	54738	"200"
208	1	7	2024-11-27	NULL	"Coarse-grained"	54908	"200"
209	1	7	2024-11-27	NULL	"Coarse-grained"	55120	"200"
210	1	7	2024-11-27	NULL	"Coarse-grained"	54501	"200"
211	1	7	2024-11-27	NULL	"Coarse-grained"	55240	"200"
212	1	7	2024-11-27	NULL	"Coarse-grained"	54491	"200"
213	1	7	2024-11-27	NULL	"Coarse-grained"	51630	"200"
214	1	7	2024-11-27	NULL	"Coarse-grained"	54459	"200"
215	1	7	2024-11-27	NULL	"Coarse-grained"	50767	"200"
216	1	7	2024-11-27	NULL	"Coarse-grained"	55329	"200"
217	1	7	2024-11-27	NULL	"Hybrid (Data)"	51496	"200"
218	1	7	2024-11-27	NULL	"Hybrid (Data)"	54207	"200"
219	1	7	2024-11-27	NULL	"Hybrid (Data)"	49019	"200"
220	1	7	2024-11-27	NULL	"Hybrid (Data)"	54168	"200"
221	1	7	2024-11-27	NULL	"Hybrid (Data)"	53442	"200"
222	1	7	2024-11-27	NULL	"Hybrid (Data)"	56323	"200"
223	1	7	2024-11-27	NULL	"Hybrid (Data)"	56416	"200"
224	1	7	2024-11-27	NULL	"Hybrid (Data)"	54921	"200"
225	1	7	2024-11-27	NULL	"Hybrid (Data)"	55008	"200"
226	1	7	2024-11-27	NULL	"Hybrid (Data)"	56402	"200"
227	1	7	2024-11-27	NULL	"Hybrid (Provenance and data)"	56252	"200"
228	1	7	2024-11-27	NULL	"Hybrid (Provenance and data)"	58024	"200"
229	1	7	2024-11-27	NULL	"Hybrid (Provenance and data)"	59483	"200"
230	1	7	2024-11-27	NULL	"Hybrid (Provenance and data)"	57909	"200"
231	1	7	2024-11-27	NULL	"Hybrid (Provenance and data)"	58403	"200"
232	1	7	2024-11-27	NULL	"Hybrid (Provenance and data)"	57696	"200"
233	1	7	2024-11-27	NULL	"Hybrid (Provenance and data)"	57584	"200"
234	1	7	2024-11-27	NULL	"Hybrid (Provenance and data)"	55044	"200"
235	1	7	2024-11-27	NULL	"Hybrid (Provenance and data)"	56286	"200"
236	1	7	2024-11-27	NULL	"Hybrid (Provenance and data)"	58307	"200"
237	1	7	2024-11-27	NULL	"Fine-grained"	69430	"200"
238	1	7	2024-11-27	NULL	"Fine-grained"	70058	"200"
239	1	7	2024-11-27	NULL	"Fine-grained"	67895	"200"
240	1	7	2024-11-27	NULL	"Fine-grained"	73998	"200"
241	1	7	2024-11-27	NULL	"Fine-grained"	69400	"200"
242	1	7	2024-11-27	NULL	"Fine-grained"	68624	"200"
243	1	7	2024-11-27	NULL	"Fine-grained"	68949	"200"
244	1	7	2024-11-27	NULL	"Fine-grained"	67990	"200"
245	1	7	2024-11-27	NULL	"Fine-grained"	69369	"200"
246	1	7	2024-11-27	NULL	"Fine-grained"	67096	"200"
247	1	7	2024-11-27	NULL	"Fine-grained (Restricted)"	60982	"200"
248	1	7	2024-11-27	NULL	"Fine-grained (Restricted)"	58822	"200"
249	1	7	2024-11-27	NULL	"Fine-grained (Restricted)"	60999	"200"
250	1	7	2024-11-27	NULL	"Fine-grained (Restricted)"	62435	"200"
251	1	7	2024-11-27	NULL	"Fine-grained (Restricted)"	60927	"200"
252	1	7	2024-11-27	NULL	"Fine-grained (Restricted)"	58228	"200"
253	1	7	2024-11-27	NULL	"Fine-grained (Restricted)"	62087	"200"
254	1	7	2024-11-27	NULL	"Fine-grained (Restricted)"	67042	"200"
255	1	7	2024-11-27	NULL	"Fine-grained (Restricted)"	64903	"200"
256	1	7	2024-11-27	NULL	"Fine-grained (Restricted)"	60184	"200"
257	1	8	2024-11-27	NULL	"Coarse-grained"	21319	"200"
258	1	8	2024-11-27	NULL	"Coarse-grained"	20618	"200"
259	1	8	2024-11-27	NULL	"Coarse-grained"	20920	"200"
260	1	8	2024-11-27	NULL	"Coarse-grained"	19225	"200"
261	1	8	2024-11-27	NULL	"Coarse-grained"	18855	"200"
262	1	8	2024-11-27	NULL	"Coarse-grained"	20894	"200"
263	1	8	2024-11-27	NULL	"Coarse-grained"	21487	"200"
264	1	8	2024-11-27	NULL	"Coarse-grained"	20180	"200"
265	1	8	2024-11-27	NULL	"Coarse-grained"	20587	"200"
266	1	8	2024-11-27	NULL	"Coarse-grained"	17603	"200"
267	1	8	2024-11-27	NULL	"Hybrid (Data)"	21724	"200"
268	1	8	2024-11-27	NULL	"Hybrid (Data)"	17519	"200"
269	1	8	2024-11-27	NULL	"Hybrid (Data)"	20373	"200"
270	1	8	2024-11-27	NULL	"Hybrid (Data)"	14745	"200"
271	1	8	2024-11-27	NULL	"Hybrid (Data)"	17793	"200"
272	1	8	2024-11-27	NULL	"Hybrid (Data)"	23340	"200"
273	1	8	2024-11-27	NULL	"Hybrid (Data)"	14575	"200"
274	1	8	2024-11-27	NULL	"Hybrid (Data)"	18269	"200"
275	1	8	2024-11-27	NULL	"Hybrid (Data)"	15077	"200"
276	1	8	2024-11-27	NULL	"Hybrid (Data)"	22567	"200"
277	1	8	2024-11-27	NULL	"Hybrid (Provenance and data)"	15032	"200"
278	1	8	2024-11-27	NULL	"Hybrid (Provenance and data)"	16065	"200"
279	1	8	2024-11-27	NULL	"Hybrid (Provenance and data)"	17196	"200"
280	1	8	2024-11-27	NULL	"Hybrid (Provenance and data)"	20892	"200"
281	1	8	2024-11-27	NULL	"Hybrid (Provenance and data)"	14401	"200"
282	1	8	2024-11-27	NULL	"Hybrid (Provenance and data)"	10703	"200"
283	1	8	2024-11-27	NULL	"Hybrid (Provenance and data)"	17131	"200"
284	1	8	2024-11-27	NULL	"Hybrid (Provenance and data)"	20973	"200"
285	1	8	2024-11-27	NULL	"Hybrid (Provenance and data)"	19429	"200"
286	1	8	2024-11-27	NULL	"Hybrid (Provenance and data)"	21436	"200"
287	1	8	2024-11-27	NULL	"Fine-grained"	22822	"200"
288	1	8	2024-11-27	NULL	"Fine-grained"	27278	"200"
289	1	8	2024-11-27	NULL	"Fine-grained"	20341	"200"
290	1	8	2024-11-27	NULL	"Fine-grained"	21403	"200"
291	1	8	2024-11-27	NULL	"Fine-grained"	21238	"200"
292	1	8	2024-11-27	NULL	"Fine-grained"	20351	"200"
293	1	8	2024-11-27	NULL	"Fine-grained"	23355	"200"
294	1	8	2024-11-27	NULL	"Fine-grained"	20841	"200"
295	1	8	2024-11-27	NULL	"Fine-grained"	17365	"200"
296	1	8	2024-11-27	NULL	"Fine-grained"	22840	"200"
297	1	9	2024-11-27	NULL	"Coarse-grained"	55801	"200"
298	1	9	2024-11-27	NULL	"Coarse-grained"	46361	"200"
299	1	9	2024-11-27	NULL	"Coarse-grained"	46258	"200"
300	1	9	2024-11-27	NULL	"Coarse-grained"	39523	"200"
301	1	9	2024-11-27	NULL	"Coarse-grained"	51135	"200"
302	1	9	2024-11-27	NULL	"Coarse-grained"	49658	"200"
303	1	9	2024-11-27	NULL	"Coarse-grained"	45005	"200"
304	1	9	2024-11-27	NULL	"Coarse-grained"	72188	"200"
305	1	9	2024-11-27	NULL	"Coarse-grained"	65733	"200"
306	1	9	2024-11-27	NULL	"Coarse-grained"	57406	"200"
307	1	9	2024-11-27	NULL	"Hybrid (Data)"	59761	"200"
308	1	9	2024-11-27	NULL	"Hybrid (Data)"	57823	"200"
309	1	9	2024-11-27	NULL	"Hybrid (Data)"	52810	"200"
310	1	9	2024-11-27	NULL	"Hybrid (Data)"	47843	"200"
311	1	9	2024-11-27	NULL	"Hybrid (Data)"	58683	"200"
312	1	9	2024-11-27	NULL	"Hybrid (Data)"	60764	"200"
313	1	9	2024-11-27	NULL	"Hybrid (Data)"	59472	"200"
314	1	9	2024-11-27	NULL	"Hybrid (Data)"	54725	"200"
315	1	9	2024-11-27	NULL	"Hybrid (Data)"	53680	"200"
316	1	9	2024-11-27	NULL	"Hybrid (Data)"	56744	"200"
317	1	9	2024-11-27	NULL	"Hybrid (Provenance and data)"	58092	"200"
318	1	9	2024-11-27	NULL	"Hybrid (Provenance and data)"	56576	"200"
319	1	9	2024-11-27	NULL	"Hybrid (Provenance and data)"	64119	"200"
320	1	9	2024-11-27	NULL	"Hybrid (Provenance and data)"	63167	"200"
321	1	9	2024-11-27	NULL	"Hybrid (Provenance and data)"	54978	"200"
322	1	9	2024-11-27	NULL	"Hybrid (Provenance and data)"	60473	"200"
323	1	9	2024-11-27	NULL	"Hybrid (Provenance and data)"	62887	"200"
324	1	9	2024-11-27	NULL	"Hybrid (Provenance and data)"	60157	"200"
325	1	9	2024-11-27	NULL	"Hybrid (Provenance and data)"	67026	"200"
326	1	9	2024-11-27	NULL	"Hybrid (Provenance and data)"	58577	"200"
327	1	9	2024-11-27	NULL	"Fine-grained"	68219	"200"
328	1	9	2024-11-27	NULL	"Fine-grained"	76912	"200"
329	1	9	2024-11-27	NULL	"Fine-grained"	77860	"200"
330	1	9	2024-11-27	NULL	"Fine-grained"	64053	"200"
331	1	9	2024-11-27	NULL	"Fine-grained"	80530	"200"
332	1	9	2024-11-27	NULL	"Fine-grained"	73379	"200"
333	1	9	2024-11-27	NULL	"Fine-grained"	71887	"200"
334	1	9	2024-11-27	NULL	"Fine-grained"	73392	"200"
335	1	9	2024-11-27	NULL	"Fine-grained"	72202	"200"
336	1	9	2024-11-27	NULL	"Fine-grained"	65950	"200"
337	1	10	2024-11-27	NULL	"Coarse-grained"	22901	"200"
338	1	10	2024-11-27	NULL	"Coarse-grained"	18556	"200"
339	1	10	2024-11-27	NULL	"Coarse-grained"	22194	"200"
340	1	10	2024-11-27	NULL	"Coarse-grained"	20266	"200"
341	1	10	2024-11-27	NULL	"Coarse-grained"	25436	"200"
342	1	10	2024-11-27	NULL	"Coarse-grained"	21822	"200"
343	1	10	2024-11-27	NULL	"Coarse-grained"	24542	"200"
344	1	10	2024-11-27	NULL	"Coarse-grained"	27266	"200"
345	1	10	2024-11-27	NULL	"Coarse-grained"	26148	"200"
346	1	10	2024-11-27	NULL	"Coarse-grained"	22378	"200"
347	1	10	2024-11-27	NULL	"Hybrid (Data)"	22256	"200"
348	1	10	2024-11-27	NULL	"Hybrid (Data)"	23435	"200"
349	1	10	2024-11-27	NULL	"Hybrid (Data)"	23244	"200"
350	1	10	2024-11-27	NULL	"Hybrid (Data)"	21830	"200"
351	1	10	2024-11-27	NULL	"Hybrid (Data)"	20391	"200"
352	1	10	2024-11-27	NULL	"Hybrid (Data)"	24099	"200"
353	1	10	2024-11-27	NULL	"Hybrid (Data)"	24210	"200"
354	1	10	2024-11-27	NULL	"Hybrid (Data)"	24376	"200"
355	1	10	2024-11-27	NULL	"Hybrid (Data)"	24173	"200"
356	1	10	2024-11-27	NULL	"Hybrid (Data)"	23469	"200"
357	1	10	2024-11-27	NULL	"Hybrid (Provenance and data)"	25167	"200"
358	1	10	2024-11-27	NULL	"Hybrid (Provenance and data)"	21052	"200"
359	1	10	2024-11-27	NULL	"Hybrid (Provenance and data)"	22553	"200"
360	1	10	2024-11-27	NULL	"Hybrid (Provenance and data)"	24249	"200"
361	1	10	2024-11-27	NULL	"Hybrid (Provenance and data)"	24945	"200"
362	1	10	2024-11-27	NULL	"Hybrid (Provenance and data)"	22735	"200"
363	1	10	2024-11-27	NULL	"Hybrid (Provenance and data)"	19038	"200"
364	1	10	2024-11-27	NULL	"Hybrid (Provenance and data)"	24957	"200"
365	1	10	2024-11-27	NULL	"Hybrid (Provenance and data)"	19912	"200"
366	1	10	2024-11-27	NULL	"Hybrid (Provenance and data)"	20970	"200"
367	1	10	2024-11-27	NULL	"Fine-grained"	29527	"200"
368	1	10	2024-11-27	NULL	"Fine-grained"	20446	"200"
369	1	10	2024-11-27	NULL	"Fine-grained"	27296	"200"
370	1	10	2024-11-27	NULL	"Fine-grained"	21615	"200"
371	1	10	2024-11-27	NULL	"Fine-grained"	27490	"200"
372	1	10	2024-11-27	NULL	"Fine-grained"	22399	"200"
373	1	10	2024-11-27	NULL	"Fine-grained"	22864	"200"
374	1	10	2024-11-27	NULL	"Fine-grained"	21781	"200"
375	1	10	2024-11-27	NULL	"Fine-grained"	24074	"200"
376	1	10	2024-11-27	NULL	"Fine-grained"	22305	"200"
377	1	7	2024-11-27	NULL	"Coarse-grained"	92371	"400"
378	1	7	2024-11-27	NULL	"Coarse-grained"	93193	"400"
379	1	7	2024-11-27	NULL	"Coarse-grained"	95296	"400"
380	1	7	2024-11-27	NULL	"Coarse-grained"	94459	"400"
381	1	7	2024-11-27	NULL	"Coarse-grained"	100662	"400"
382	1	7	2024-11-27	NULL	"Coarse-grained"	88714	"400"
383	1	7	2024-11-27	NULL	"Coarse-grained"	94623	"400"
384	1	7	2024-11-27	NULL	"Coarse-grained"	94284	"400"
385	1	7	2024-11-27	NULL	"Coarse-grained"	90694	"400"
386	1	7	2024-11-27	NULL	"Coarse-grained"	89171	"400"
387	1	7	2024-11-27	NULL	"Hybrid (Data)"	93672	"400"
388	1	7	2024-11-27	NULL	"Hybrid (Data)"	94787	"400"
389	1	7	2024-11-27	NULL	"Hybrid (Data)"	95120	"400"
390	1	7	2024-11-27	NULL	"Hybrid (Data)"	89903	"400"
391	1	7	2024-11-27	NULL	"Hybrid (Data)"	87925	"400"
392	1	7	2024-11-27	NULL	"Hybrid (Data)"	100828	"400"
393	1	7	2024-11-27	NULL	"Hybrid (Data)"	94543	"400"
394	1	7	2024-11-27	NULL	"Hybrid (Data)"	96623	"400"
395	1	7	2024-11-27	NULL	"Hybrid (Data)"	94193	"400"
396	1	7	2024-11-27	NULL	"Hybrid (Data)"	97991	"400"
397	1	7	2024-11-27	NULL	"Hybrid (Provenance and data)"	93519	"400"
398	1	7	2024-11-27	NULL	"Hybrid (Provenance and data)"	90355	"400"
399	1	7	2024-11-27	NULL	"Hybrid (Provenance and data)"	97354	"400"
400	1	7	2024-11-27	NULL	"Hybrid (Provenance and data)"	96085	"400"
401	1	7	2024-11-27	NULL	"Hybrid (Provenance and data)"	92865	"400"
402	1	7	2024-11-27	NULL	"Hybrid (Provenance and data)"	98692	"400"
403	1	7	2024-11-27	NULL	"Hybrid (Provenance and data)"	95702	"400"
404	1	7	2024-11-27	NULL	"Hybrid (Provenance and data)"	95427	"400"
405	1	7	2024-11-27	NULL	"Hybrid (Provenance and data)"	99689	"400"
406	1	7	2024-11-27	NULL	"Hybrid (Provenance and data)"	98072	"400"
407	1	7	2024-11-27	NULL	"Fine-grained"	101347	"400"
408	1	7	2024-11-27	NULL	"Fine-grained"	112692	"400"
409	1	7	2024-11-27	NULL	"Fine-grained"	101829	"400"
410	1	7	2024-11-27	NULL	"Fine-grained"	108553	"400"
411	1	7	2024-11-27	NULL	"Fine-grained"	110411	"400"
412	1	7	2024-11-27	NULL	"Fine-grained"	104159	"400"
413	1	7	2024-11-27	NULL	"Fine-grained"	110755	"400"
414	1	7	2024-11-27	NULL	"Fine-grained"	107299	"400"
415	1	7	2024-11-27	NULL	"Fine-grained"	105223	"400"
416	1	7	2024-11-27	NULL	"Fine-grained"	108495	"400"
417	1	7	2024-11-27	NULL	"Fine-grained (Restricted)"	100163	"400"
418	1	7	2024-11-27	NULL	"Fine-grained (Restricted)"	94911	"400"
419	1	7	2024-11-27	NULL	"Fine-grained (Restricted)"	115949	"400"
420	1	7	2024-11-27	NULL	"Fine-grained (Restricted)"	101317	"400"
421	1	7	2024-11-27	NULL	"Fine-grained (Restricted)"	103685	"400"
422	1	7	2024-11-27	NULL	"Fine-grained (Restricted)"	109803	"400"
423	1	7	2024-11-27	NULL	"Fine-grained (Restricted)"	108140	"400"
424	1	7	2024-11-27	NULL	"Fine-grained (Restricted)"	121974	"400"
425	1	7	2024-11-27	NULL	"Fine-grained (Restricted)"	107549	"400"
426	1	7	2024-11-27	NULL	"Fine-grained (Restricted)"	103580	"400"
427	1	9	2024-11-27	NULL	"Coarse-grained"	96494	"400"
428	1	9	2024-11-27	NULL	"Coarse-grained"	96772	"400"
429	1	9	2024-11-27	NULL	"Coarse-grained"	101234	"400"
430	1	9	2024-11-27	NULL	"Coarse-grained"	98622	"400"
431	1	9	2024-11-27	NULL	"Coarse-grained"	97239	"400"
432	1	9	2024-11-27	NULL	"Coarse-grained"	96030	"400"
433	1	9	2024-11-27	NULL	"Coarse-grained"	90270	"400"
434	1	9	2024-11-27	NULL	"Coarse-grained"	98796	"400"
435	1	9	2024-11-27	NULL	"Coarse-grained"	101181	"400"
436	1	9	2024-11-27	NULL	"Coarse-grained"	101700	"400"
437	1	9	2024-11-27	NULL	"Hybrid (Data)"	99020	"400"
438	1	9	2024-11-27	NULL	"Hybrid (Data)"	99737	"400"
439	1	9	2024-11-27	NULL	"Hybrid (Data)"	99524	"400"
440	1	9	2024-11-27	NULL	"Hybrid (Data)"	97680	"400"
441	1	9	2024-11-27	NULL	"Hybrid (Data)"	99751	"400"
442	1	9	2024-11-27	NULL	"Hybrid (Data)"	98581	"400"
443	1	9	2024-11-27	NULL	"Hybrid (Data)"	101157	"400"
444	1	9	2024-11-27	NULL	"Hybrid (Data)"	100695	"400"
445	1	9	2024-11-27	NULL	"Hybrid (Data)"	98634	"400"
446	1	9	2024-11-27	NULL	"Hybrid (Data)"	100591	"400"
447	1	9	2024-11-27	NULL	"Hybrid (Provenance and data)"	98168	"400"
448	1	9	2024-11-27	NULL	"Hybrid (Provenance and data)"	98066	"400"
449	1	9	2024-11-27	NULL	"Hybrid (Provenance and data)"	102927	"400"
450	1	9	2024-11-27	NULL	"Hybrid (Provenance and data)"	99279	"400"
451	1	9	2024-11-27	NULL	"Hybrid (Provenance and data)"	97206	"400"
452	1	9	2024-11-27	NULL	"Hybrid (Provenance and data)"	97422	"400"
453	1	9	2024-11-27	NULL	"Hybrid (Provenance and data)"	101105	"400"
454	1	9	2024-11-27	NULL	"Hybrid (Provenance and data)"	99806	"400"
455	1	9	2024-11-27	NULL	"Hybrid (Provenance and data)"	101924	"400"
456	1	9	2024-11-27	NULL	"Hybrid (Provenance and data)"	101263	"400"
457	1	9	2024-11-27	NULL	"Fine-grained"	120065	"400"
458	1	9	2024-11-27	NULL	"Fine-grained"	119650	"400"
459	1	9	2024-11-27	NULL	"Fine-grained"	117138	"400"
460	1	9	2024-11-27	NULL	"Fine-grained"	115706	"400"
461	1	9	2024-11-27	NULL	"Fine-grained"	120295	"400"
462	1	9	2024-11-27	NULL	"Fine-grained"	118900	"400"
463	1	9	2024-11-27	NULL	"Fine-grained"	112262	"400"
464	1	9	2024-11-27	NULL	"Fine-grained"	114306	"400"
465	1	9	2024-11-27	NULL	"Fine-grained"	117240	"400"
466	1	9	2024-11-27	NULL	"Fine-grained"	115048	"400"
467	1	9	2024-11-27	NULL	"Fine-grained (Restricted)"	112068	"400"
468	1	9	2024-11-27	NULL	"Fine-grained (Restricted)"	111849	"400"
469	1	9	2024-11-27	NULL	"Fine-grained (Restricted)"	115440	"400"
470	1	9	2024-11-27	NULL	"Fine-grained (Restricted)"	107301	"400"
471	1	9	2024-11-27	NULL	"Fine-grained (Restricted)"	109289	"400"
472	1	9	2024-11-27	NULL	"Fine-grained (Restricted)"	103642	"400"
473	1	9	2024-11-27	NULL	"Fine-grained (Restricted)"	110301	"400"
474	1	9	2024-11-27	NULL	"Fine-grained (Restricted)"	105391	"400"
475	1	9	2024-11-27	NULL	"Fine-grained (Restricted)"	108540	"400"
476	1	9	2024-11-27	NULL	"Fine-grained (Restricted)"	101195	"400"
477	1	8	2024-11-27	NULL	"Coarse-grained"	47342	"400"
478	1	8	2024-11-27	NULL	"Coarse-grained"	37126	"400"
479	1	8	2024-11-27	NULL	"Coarse-grained"	41170	"400"
480	1	8	2024-11-27	NULL	"Coarse-grained"	41910	"400"
481	1	8	2024-11-27	NULL	"Coarse-grained"	42679	"400"
482	1	8	2024-11-27	NULL	"Coarse-grained"	41131	"400"
483	1	8	2024-11-27	NULL	"Coarse-grained"	41296	"400"
484	1	8	2024-11-27	NULL	"Coarse-grained"	37894	"400"
485	1	8	2024-11-27	NULL	"Coarse-grained"	37649	"400"
486	1	8	2024-11-27	NULL	"Coarse-grained"	38767	"400"
487	1	8	2024-11-27	NULL	"Hybrid (data)"	39381	"400"
488	1	8	2024-11-27	NULL	"Hybrid (data)"	39959	"400"
489	1	8	2024-11-27	NULL	"Hybrid (data)"	37259	"400"
490	1	8	2024-11-27	NULL	"Hybrid (data)"	45391	"400"
491	1	8	2024-11-27	NULL	"Hybrid (data)"	39960	"400"
492	1	8	2024-11-27	NULL	"Hybrid (data)"	38217	"400"
493	1	8	2024-11-27	NULL	"Hybrid (data)"	44035	"400"
494	1	8	2024-11-27	NULL	"Hybrid (data)"	47779	"400"
495	1	8	2024-11-27	NULL	"Hybrid (data)"	42416	"400"
496	1	8	2024-11-27	NULL	"Hybrid (data)"	42594	"400"
497	1	8	2024-11-27	NULL	"Hybrid (Provenance and data)"	37391	"400"
498	1	8	2024-11-27	NULL	"Hybrid (Provenance and data)"	43332	"400"
499	1	8	2024-11-27	NULL	"Hybrid (Provenance and data)"	41531	"400"
500	1	8	2024-11-27	NULL	"Hybrid (Provenance and data)"	41276	"400"
501	1	8	2024-11-27	NULL	"Hybrid (Provenance and data)"	39719	"400"
502	1	8	2024-11-27	NULL	"Hybrid (Provenance and data)"	50197	"400"
503	1	8	2024-11-27	NULL	"Hybrid (Provenance and data)"	39183	"400"
504	1	8	2024-11-27	NULL	"Hybrid (Provenance and data)"	38674	"400"
505	1	8	2024-11-27	NULL	"Hybrid (Provenance and data)"	42272	"400"
506	1	8	2024-11-27	NULL	"Hybrid (Provenance and data)"	43788	"400"
507	1	8	2024-11-27	NULL	"Fine-grained"	48396	"400"
508	1	8	2024-11-27	NULL	"Fine-grained"	44110	"400"
509	1	8	2024-11-27	NULL	"Fine-grained"	45927	"400"
510	1	8	2024-11-27	NULL	"Fine-grained"	45761	"400"
511	1	8	2024-11-27	NULL	"Fine-grained"	44981	"400"
512	1	8	2024-11-27	NULL	"Fine-grained"	42880	"400"
513	1	8	2024-11-27	NULL	"Fine-grained"	46518	"400"
514	1	8	2024-11-27	NULL	"Fine-grained"	41359	"400"
515	1	8	2024-11-27	NULL	"Fine-grained"	45245	"400"
516	1	8	2024-11-27	NULL	"Fine-grained"	45825	"400"
517	1	10	2024-11-27	NULL	"Coarse-grained"	41568	"400"
518	1	10	2024-11-27	NULL	"Coarse-grained"	46083	"400"
519	1	10	2024-11-27	NULL	"Coarse-grained"	48646	"400"
520	1	10	2024-11-27	NULL	"Coarse-grained"	51071	"400"
521	1	10	2024-11-27	NULL	"Coarse-grained"	49019	"400"
522	1	10	2024-11-27	NULL	"Coarse-grained"	49209	"400"
523	1	10	2024-11-27	NULL	"Coarse-grained"	48146	"400"
524	1	10	2024-11-27	NULL	"Coarse-grained"	51420	"400"
525	1	10	2024-11-27	NULL	"Coarse-grained"	46689	"400"
526	1	10	2024-11-27	NULL	"Coarse-grained"	45106	"400"
527	1	10	2024-11-27	NULL	"Hybrid (Data)"	43448	"400"
528	1	10	2024-11-27	NULL	"Hybrid (Data)"	50913	"400"
529	1	10	2024-11-27	NULL	"Hybrid (Data)"	52447	"400"
530	1	10	2024-11-27	NULL	"Hybrid (Data)"	48778	"400"
531	1	10	2024-11-27	NULL	"Hybrid (Data)"	45550	"400"
532	1	10	2024-11-27	NULL	"Hybrid (Data)"	47291	"400"
533	1	10	2024-11-27	NULL	"Hybrid (Data)"	49256	"400"
534	1	10	2024-11-27	NULL	"Hybrid (Data)"	50565	"400"
535	1	10	2024-11-27	NULL	"Hybrid (Data)"	49678	"400"
536	1	10	2024-11-27	NULL	"Hybrid (Data)"	48265	"400"
537	1	10	2024-11-27	NULL	"Hybrid (Provenance and Data)"	48979	"400"
538	1	10	2024-11-27	NULL	"Hybrid (Provenance and Data)"	50135	"400"
539	1	10	2024-11-27	NULL	"Hybrid (Provenance and Data)"	45001	"400"
540	1	10	2024-11-27	NULL	"Hybrid (Provenance and Data)"	44876	"400"
541	1	10	2024-11-27	NULL	"Hybrid (Provenance and Data)"	49327	"400"
542	1	10	2024-11-27	NULL	"Hybrid (Provenance and Data)"	55861	"400"
543	1	10	2024-11-27	NULL	"Hybrid (Provenance and Data)"	51187	"400"
544	1	10	2024-11-27	NULL	"Hybrid (Provenance and Data)"	46224	"400"
545	1	10	2024-11-27	NULL	"Hybrid (Provenance and Data)"	57316	"400"
546	1	10	2024-11-27	NULL	"Hybrid (Provenance and Data)"	45848	"400"
547	1	10	2024-11-27	NULL	"Fine-grained"	52491	"400"
548	1	10	2024-11-27	NULL	"Fine-grained"	44897	"400"
549	1	10	2024-11-27	NULL	"Fine-grained"	50428	"400"
550	1	10	2024-11-27	NULL	"Fine-grained"	48784	"400"
551	1	10	2024-11-27	NULL	"Fine-grained"	48402	"400"
552	1	10	2024-11-27	NULL	"Fine-grained"	51829	"400"
553	1	10	2024-11-27	NULL	"Fine-grained"	51136	"400"
554	1	10	2024-11-27	NULL	"Fine-grained"	48567	"400"
555	1	10	2024-11-27	NULL	"Fine-grained"	43862	"400"
556	1	10	2024-11-27	NULL	"Fine-grained"	56140	"400"
557	2	1	2024-11-27	NULL	"Coarse-grained"	1264	"100"
558	2	1	2024-11-27	NULL	"Coarse-grained"	1283	"100"
559	2	1	2024-11-27	NULL	"Coarse-grained"	1266	"100"
560	2	1	2024-11-27	NULL	"Coarse-grained"	1269	"100"
561	2	1	2024-11-27	NULL	"Coarse-grained"	1264	"100"
562	2	1	2024-11-27	NULL	"Coarse-grained"	1273	"100"
563	2	1	2024-11-27	NULL	"Hybrid (Data)"	1284	"100"
564	2	1	2024-11-27	NULL	"Hybrid (Data)"	1293	"100"
565	2	1	2024-11-27	NULL	"Hybrid (Data)"	1289	"100"
566	2	1	2024-11-27	NULL	"Hybrid (Data)"	1278	"100"
567	2	1	2024-11-27	NULL	"Hybrid (Data)"	1283	"100"
568	2	1	2024-11-27	NULL	"Hybrid (Data)"	1318	"100"
569	2	1	2024-11-27	NULL	"Hybrid (Provenance and data)"	1251	"100"
570	2	1	2024-11-27	NULL	"Hybrid (Provenance and data)"	1240	"100"
571	2	1	2024-11-27	NULL	"Hybrid (Provenance and data)"	1247	"100"
572	2	1	2024-11-27	NULL	"Hybrid (Provenance and data)"	1233	"100"
573	2	1	2024-11-27	NULL	"Hybrid (Provenance and data)"	1233	"100"
574	2	1	2024-11-27	NULL	"Hybrid (Provenance and data)"	1252	"100"
575	2	1	2024-11-27	NULL	"Coarse-grained"	3768	"300"
576	2	1	2024-11-27	NULL	"Coarse-grained"	3767	"300"
577	2	1	2024-11-27	NULL	"Coarse-grained"	3778	"300"
578	2	1	2024-11-27	NULL	"Coarse-grained"	3787	"300"
579	2	1	2024-11-27	NULL	"Coarse-grained"	3814	"300"
580	2	1	2024-11-27	NULL	"Coarse-grained"	3767	"300"
581	2	1	2024-11-27	NULL	"Hybrid (Data)"	3717	"300"
582	2	1	2024-11-27	NULL	"Hybrid (Data)"	3727	"300"
583	2	1	2024-11-27	NULL	"Hybrid (Data)"	3703	"300"
584	2	1	2024-11-27	NULL	"Hybrid (Data)"	3721	"300"
585	2	1	2024-11-27	NULL	"Hybrid (Data)"	3691	"300"
586	2	1	2024-11-27	NULL	"Hybrid (Data)"	3752	"300"
587	2	12	2024-11-27	NULL	"Coarse-grained"	2068	"100"
588	2	12	2024-11-27	NULL	"Coarse-grained"	2001	"100"
589	2	12	2024-11-27	NULL	"Coarse-grained"	1968	"100"
590	2	12	2024-11-27	NULL	"Coarse-grained"	1967	"100"
591	2	12	2024-11-27	NULL	"Coarse-grained"	1967	"100"
592	2	12	2024-11-27	NULL	"Coarse-grained"	1973	"100"
593	2	12	2024-11-27	NULL	"Hybrid (Data)"	2313	"100"
594	2	12	2024-11-27	NULL	"Hybrid (Data)"	2133	"100"
595	2	12	2024-11-27	NULL	"Hybrid (Data)"	2113	"100"
596	2	12	2024-11-27	NULL	"Hybrid (Data)"	2113	"100"
597	2	12	2024-11-27	NULL	"Hybrid (Data)"	2114	"100"
598	2	12	2024-11-27	NULL	"Hybrid (Data)"	2111	"100"
599	2	12	2024-11-27	NULL	"Coarse-grained"	4001	"100"
600	2	12	2024-11-27	NULL	"Coarse-grained"	3980	"100"
601	2	12	2024-11-27	NULL	"Coarse-grained"	3988	"100"
602	2	12	2024-11-27	NULL	"Coarse-grained"	3940	"100"
603	2	12	2024-11-27	NULL	"Hybrid (Data)"	4178	"100"
604	2	12	2024-11-27	NULL	"Hybrid (Data)"	4388	"100"
605	2	12	2024-11-27	NULL	"Hybrid (Data)"	3908	"100"
606	2	12	2024-11-27	NULL	"Hybrid (Data)"	3964	"100"
607	2	12	2024-11-27	NULL	"Hybrid (Data)"	4098	"100"
608	2	12	2024-11-27	NULL	"Hybrid (Data)"	4673	"100"
609	2	1	2024-11-27	NULL	"Coarse-grained"	1263	"100"
610	2	1	2024-11-27	NULL	"Coarse-grained"	1247	"100"
611	2	1	2024-11-27	NULL	"Coarse-grained"	1240	"100"
612	2	1	2024-11-27	NULL	"Coarse-grained"	1237	"100"
613	2	1	2024-11-27	NULL	"Coarse-grained"	1270	"100"
614	2	1	2024-11-27	NULL	"Coarse-grained"	1254	"100"
615	2	1	2024-11-27	NULL	"Hybrid (Data)"	1277	"100"
616	2	1	2024-11-27	NULL	"Hybrid (Data)"	1268	"100"
617	2	1	2024-11-27	NULL	"Hybrid (Data)"	1266	"100"
618	2	1	2024-11-27	NULL	"Hybrid (Data)"	1250	"100"
619	2	1	2024-11-27	NULL	"Hybrid (Data)"	1254	"100"
620	2	1	2024-11-27	NULL	"Hybrid (Data)"	1251	"100"
621	2	1	2024-11-27	NULL	"Coarse-grained"	2145	"100"
622	2	1	2024-11-27	NULL	"Coarse-grained"	2151	"100"
623	2	1	2024-11-27	NULL	"Coarse-grained"	2138	"100"
624	2	1	2024-11-27	NULL	"Coarse-grained"	2130	"100"
625	2	1	2024-11-27	NULL	"Coarse-grained"	2139	"100"
626	2	1	2024-11-27	NULL	"Coarse-grained"	2119	"100"
627	2	1	2024-11-27	NULL	"Hybrid (Data)"	2182	"100"
628	2	1	2024-11-27	NULL	"Hybrid (Data)"	2150	"100"
629	2	1	2024-11-27	NULL	"Hybrid (Data)"	2150	"100"
630	2	1	2024-11-27	NULL	"Hybrid (Data)"	2149	"100"
631	2	1	2024-11-27	NULL	"Hybrid (Data)"	2167	"100"
632	2	1	2024-11-27	NULL	"Hybrid (Data)"	2138	"100"
633	2	1	2024-11-27	NULL	"Coarse-grained"	3208	"100"
634	2	1	2024-11-27	NULL	"Coarse-grained"	3158	"100"
635	2	1	2024-11-27	NULL	"Coarse-grained"	3145	"100"
636	2	1	2024-11-27	NULL	"Coarse-grained"	3187	"100"
637	2	1	2024-11-27	NULL	"Coarse-grained"	3223	"100"
638	2	1	2024-11-27	NULL	"Coarse-grained"	3187	"100"
639	2	1	2024-11-27	NULL	"Hybrid (Data)"	3192	"100"
640	2	1	2024-11-27	NULL	"Hybrid (Data)"	3230	"100"
641	2	1	2024-11-27	NULL	"Hybrid (Data)"	3190	"100"
642	2	1	2024-11-27	NULL	"Hybrid (Data)"	3245	"100"
643	2	1	2024-11-27	NULL	"Hybrid (Data)"	3235	"100"
644	2	1	2024-11-27	NULL	"Hybrid (Data)"	3185	"100"
645	2	1	2024-11-27	NULL	"Coarse-grained"	3831	"100"
646	2	1	2024-11-27	NULL	"Coarse-grained"	3841	"100"
647	2	1	2024-11-27	NULL	"Coarse-grained"	3828	"100"
648	2	1	2024-11-27	NULL	"Coarse-grained"	3868	"100"
649	2	1	2024-11-27	NULL	"Coarse-grained"	3825	"100"
650	2	1	2024-11-27	NULL	"Coarse-grained"	3889	"100"
651	2	1	2024-11-27	NULL	"Hybrid (Data)"	3824	"100"
652	2	1	2024-11-27	NULL	"Hybrid (Data)"	3858	"100"
653	2	1	2024-11-27	NULL	"Hybrid (Data)"	3932	"100"
654	2	1	2024-11-27	NULL	"Hybrid (Data)"	3871	"100"
655	2	1	2024-11-27	NULL	"Hybrid (Data)"	3875	"100"
656	2	1	2024-11-27	NULL	"Hybrid (Data)"	3904	"100"
657	2	4	2024-11-27	NULL	"Coarse-grained"	261	"100"
658	2	4	2024-11-27	NULL	"Coarse-grained"	251	"100"
659	2	4	2024-11-27	NULL	"Coarse-grained"	253	"100"
660	2	4	2024-11-27	NULL	"Coarse-grained"	249	"100"
661	2	4	2024-11-27	NULL	"Coarse-grained"	251	"100"
662	2	4	2024-11-27	NULL	"Coarse-grained"	252	"100"
663	2	4	2024-11-27	NULL	"Coarse-grained"	254	"100"
664	2	4	2024-11-27	NULL	"Coarse-grained"	249	"100"
665	2	4	2024-11-27	NULL	"Coarse-grained"	255	"100"
666	2	4	2024-11-27	NULL	"Coarse-grained"	251	"100"
667	2	4	2024-11-27	NULL	"Coarse-grained"	252	"100"
668	2	4	2024-11-27	NULL	"Coarse-grained"	250	"100"
669	2	4	2024-11-27	NULL	"Hybrid (Data)"	255	"100"
670	2	4	2024-11-27	NULL	"Hybrid (Data)"	244	"100"
671	2	4	2024-11-27	NULL	"Hybrid (Data)"	250	"100"
672	2	4	2024-11-27	NULL	"Hybrid (Data)"	241	"100"
673	2	4	2024-11-27	NULL	"Hybrid (Data)"	244	"100"
674	2	4	2024-11-27	NULL	"Hybrid (Data)"	243	"100"
675	2	4	2024-11-27	NULL	"Hybrid (Data)"	256	"100"
676	2	4	2024-11-27	NULL	"Hybrid (Data)"	249	"100"
677	2	4	2024-11-27	NULL	"Hybrid (Data)"	249	"100"
678	2	4	2024-11-27	NULL	"Hybrid (Data)"	250	"100"
679	2	4	2024-11-27	NULL	"Hybrid (Data)"	249	"100"
680	2	4	2024-11-27	NULL	"Hybrid (Data)"	248	"100"
681	2	4	2024-11-27	NULL	"Hybrid (Provenance and data)"	259	"100"
682	2	4	2024-11-27	NULL	"Hybrid (Provenance and data)"	248	"100"
683	2	4	2024-11-27	NULL	"Hybrid (Provenance and data)"	247	"100"
684	2	4	2024-11-27	NULL	"Hybrid (Provenance and data)"	247	"100"
685	2	4	2024-11-27	NULL	"Hybrid (Provenance and data)"	244	"100"
686	2	4	2024-11-27	NULL	"Hybrid (Provenance and data)"	246	"100"
687	1	2	2024-11-27	NULL	"Hybrid (Workflow)"	13248	"200"
688	1	2	2024-11-27	NULL	"Hybrid (Workflow)"	13242	"200"
689	1	2	2024-11-27	NULL	"Hybrid (Workflow)"	13236	"200"
690	1	2	2024-11-27	NULL	"Hybrid (Workflow)"	13264	"200"
691	1	2	2024-11-27	NULL	"Hybrid (Workflow)"	13258	"200"
692	1	2	2024-11-27	NULL	"Hybrid (Workflow)"	13260	"200"
693	1	2	2024-11-27	NULL	"Hybrid (Workflow)"	13266	"200"
694	1	2	2024-11-27	NULL	"Hybrid (Provenance and data)"	13243	"200"
695	1	2	2024-11-27	NULL	"Hybrid (Provenance and data)"	13276	"200"
696	1	2	2024-11-27	NULL	"Hybrid (Provenance and data)"	13392	"200"
697	1	2	2024-11-27	NULL	"Hybrid (Provenance and data)"	13297	"200"
698	1	2	2024-11-27	NULL	"Hybrid (Provenance and data)"	13256	"200"
699	1	2	2024-11-27	NULL	"Hybrid (Provenance and data)"	13248	"200"
700	1	2	2024-11-27	NULL	"Fine grained"	14904	"200"
701	1	2	2024-11-27	NULL	"Fine grained"	13240	"200"
702	1	2	2024-11-27	NULL	"Fine grained"	13170	"200"
703	1	2	2024-11-27	NULL	"Fine grained"	13165	"200"
704	1	2	2024-11-27	NULL	"Fine grained"	13166	"200"
705	1	2	2024-11-27	NULL	"Fine grained"	13196	"200"
706	1	2	2024-11-27	NULL	"Fine grained"	13406	"200"
707	1	2	2024-11-27	NULL	"Coarse-grained"	26340	"400"
708	1	2	2024-11-27	NULL	"Coarse-grained"	26328	"400"
709	1	2	2024-11-27	NULL	"Coarse-grained"	26355	"400"
710	1	2	2024-11-27	NULL	"Coarse-grained"	26357	"400"
711	1	2	2024-11-27	NULL	"Coarse-grained"	26375	"400"
712	1	2	2024-11-27	NULL	"Coarse-grained"	26383	"400"
713	6	2	2024-11-27	NULL	"Coarse-grained"	259	"5"
714	6	2	2024-11-27	NULL	"Coarse-grained"	259	"5"
715	6	2	2024-11-27	NULL	"Coarse-grained"	255	"5"
716	6	2	2024-11-27	NULL	"Coarse-grained"	255	"5"
717	6	2	2024-11-27	NULL	"Coarse-grained"	260	"5"
718	6	2	2024-11-27	NULL	"Coarse-grained"	255	"5"
719	6	2	2024-11-27	NULL	"Coarse-grained"	540	"1"
720	6	2	2024-11-27	NULL	"Coarse-grained"	536	"1"
721	6	2	2024-11-27	NULL	"Coarse-grained"	536	"1"
722	6	2	2024-11-27	NULL	"Coarse-grained"	539	"1"
723	6	2	2024-11-27	NULL	"Coarse-grained"	534	"1"
724	6	2	2024-11-27	NULL	"Coarse-grained"	534	"1"
725	6	2	2024-11-27	NULL	"Coarse-grained"	1855	"2"
726	6	2	2024-11-27	NULL	"Coarse-grained"	1846	"2"
727	6	2	2024-11-27	NULL	"Coarse-grained"	1846	"2"
728	6	2	2024-11-27	NULL	"Coarse-grained"	1847	"2"
729	6	2	2024-11-27	NULL	"Coarse-grained"	1852	"2"
730	6	2	2024-11-27	NULL	"Coarse-grained"	1840	"2"
731	6	2	2024-11-27	NULL	"Hybrid"	501	"1"
732	6	2	2024-11-27	NULL	"Hybrid"	514	"1"
733	6	2	2024-11-27	NULL	"Hybrid"	505	"1"
734	6	2	2024-11-27	NULL	"Hybrid"	501	"1"
735	6	2	2024-11-27	NULL	"Hybrid"	506	"1"
736	6	2	2024-11-27	NULL	"Hybrid"	500	"1"
737	6	2	2024-11-27	NULL	"Hybrid"	251	"5"
738	6	2	2024-11-27	NULL	"Hybrid"	252	"5"
739	6	2	2024-11-27	NULL	"Hybrid"	249	"5"
740	6	2	2024-11-27	NULL	"Hybrid"	245	"5"
741	6	2	2024-11-27	NULL	"Hybrid"	262	"5"
742	6	2	2024-11-27	NULL	"Hybrid"	264	"5"
743	6	2	2024-11-27	NULL	"Hybrid"	1848	"2"
744	6	2	2024-11-27	NULL	"Hybrid"	1831	"2"
745	6	2	2024-11-27	NULL	"Hybrid"	1852	"2"
746	6	2	2024-11-27	NULL	"Hybrid"	1820	"2"
747	6	2	2024-11-27	NULL	"Hybrid"	1836	"2"
748	6	2	2024-11-27	NULL	"Hybrid"	1812	"2"
749	6	2	2024-11-27	NULL	"Fine-grained"	271	"5"
750	6	2	2024-11-27	NULL	"Fine-grained"	259	"5"
751	6	2	2024-11-27	NULL	"Fine-grained"	262	"5"
752	6	2	2024-11-27	NULL	"Fine-grained"	268	"5"
753	6	2	2024-11-27	NULL	"Fine-grained"	275	"5"
754	6	2	2024-11-27	NULL	"Fine-grained"	266	"5"
755	6	2	2024-11-27	NULL	"Fine-grained"	559	"1"
756	6	2	2024-11-27	NULL	"Fine-grained"	556	"1"
757	6	2	2024-11-27	NULL	"Fine-grained"	606	"1"
758	6	2	2024-11-27	NULL	"Fine-grained"	596	"1"
759	6	2	2024-11-27	NULL	"Fine-grained"	594	"1"
760	6	2	2024-11-27	NULL	"Fine-grained"	688	"1"
761	6	2	2024-11-27	NULL	"Fine-grained"	1840	"2"
762	6	2	2024-11-27	NULL	"Fine-grained"	1820	"2"
763	6	2	2024-11-27	NULL	"Fine-grained"	1815	"2"
764	6	2	2024-11-27	NULL	"Fine-grained"	1866	"2"
765	6	2	2024-11-27	NULL	"Fine-grained"	1856	"2"
766	6	2	2024-11-27	NULL	"Fine-grained"	1828	"2"
767	6	14	2024-11-27	NULL	"Coarse-grained"	18	"5"
768	6	14	2024-11-27	NULL	"Coarse-grained"	27	"5"
769	6	14	2024-11-27	NULL	"Coarse-grained"	29	"5"
770	6	14	2024-11-27	NULL	"Coarse-grained"	27	"5"
771	6	14	2024-11-27	NULL	"Coarse-grained"	24	"5"
772	6	14	2024-11-27	NULL	"Coarse-grained"	26	"5"
773	6	14	2024-11-27	NULL	"Coarse-grained"	65	"1"
774	6	14	2024-11-27	NULL	"Coarse-grained"	58	"1"
775	6	14	2024-11-27	NULL	"Coarse-grained"	58	"1"
776	6	14	2024-11-27	NULL	"Coarse-grained"	73	"1"
777	6	14	2024-11-27	NULL	"Coarse-grained"	74	"1"
778	6	14	2024-11-27	NULL	"Coarse-grained"	73	"1"
779	6	14	2024-11-27	NULL	"Coarse-grained"	295	"2"
780	6	14	2024-11-27	NULL	"Coarse-grained"	307	"2"
781	6	14	2024-11-27	NULL	"Coarse-grained"	292	"2"
782	6	14	2024-11-27	NULL	"Coarse-grained"	294	"2"
783	6	14	2024-11-27	NULL	"Coarse-grained"	297	"2"
784	6	14	2024-11-27	NULL	"Coarse-grained"	294	"2"
785	6	14	2024-11-27	NULL	"Hybrid"	26	"1"
786	6	14	2024-11-27	NULL	"Hybrid"	29	"1"
787	6	14	2024-11-27	NULL	"Hybrid"	25	"1"
788	6	14	2024-11-27	NULL	"Hybrid"	28	"1"
789	6	14	2024-11-27	NULL	"Hybrid"	29	"1"
790	6	14	2024-11-27	NULL	"Hybrid"	29	"1"
791	6	14	2024-11-27	NULL	"Hybrid"	72	"5"
792	6	14	2024-11-27	NULL	"Hybrid"	84	"5"
793	6	14	2024-11-27	NULL	"Hybrid"	73	"5"
794	6	14	2024-11-27	NULL	"Hybrid"	78	"5"
795	6	14	2024-11-27	NULL	"Hybrid"	73	"5"
796	6	14	2024-11-27	NULL	"Hybrid"	70	"5"
797	6	14	2024-11-27	NULL	"Hybrid"	318	"2"
798	6	14	2024-11-27	NULL	"Hybrid"	345	"2"
799	6	14	2024-11-27	NULL	"Hybrid"	330	"2"
800	6	14	2024-11-27	NULL	"Hybrid"	340	"2"
801	6	14	2024-11-27	NULL	"Hybrid"	347	"2"
802	6	14	2024-11-27	NULL	"Hybrid"	332	"2"
803	6	14	2024-11-27	NULL	"Fine-grained"	17	"5"
804	6	14	2024-11-27	NULL	"Fine-grained"	30	"5"
805	6	14	2024-11-27	NULL	"Fine-grained"	22	"5"
806	6	14	2024-11-27	NULL	"Fine-grained"	30	"5"
807	6	14	2024-11-27	NULL	"Fine-grained"	30	"5"
808	6	14	2024-11-27	NULL	"Fine-grained"	27	"5"
809	6	15	2024-11-27	NULL	"Coarse-grained"	29	"5"
810	6	15	2024-11-27	NULL	"Coarse-grained"	28	"5"
811	6	15	2024-11-27	NULL	"Coarse-grained"	28	"5"
812	6	15	2024-11-27	NULL	"Coarse-grained"	28	"5"
813	6	15	2024-11-27	NULL	"Coarse-grained"	28	"5"
814	6	15	2024-11-27	NULL	"Coarse-grained"	28	"5"
815	6	15	2024-11-27	NULL	"Coarse-grained"	84	"1"
816	6	15	2024-11-27	NULL	"Coarse-grained"	86	"1"
817	6	15	2024-11-27	NULL	"Coarse-grained"	86	"1"
818	6	15	2024-11-27	NULL	"Coarse-grained"	86	"1"
819	6	15	2024-11-27	NULL	"Coarse-grained"	83	"1"
820	6	15	2024-11-27	NULL	"Coarse-grained"	86	"1"
821	6	15	2024-11-27	NULL	"Coarse-grained"	430	"2"
822	6	15	2024-11-27	NULL	"Coarse-grained"	438	"2"
823	6	15	2024-11-27	NULL	"Coarse-grained"	437	"2"
824	6	15	2024-11-27	NULL	"Coarse-grained"	453	"2"
825	6	15	2024-11-27	NULL	"Coarse-grained"	443	"2"
826	6	15	2024-11-27	NULL	"Coarse-grained"	447	"2"
827	6	15	2024-11-27	NULL	"Hybrid"	41	"5"
828	6	15	2024-11-27	NULL	"Hybrid"	30	"5"
829	6	15	2024-11-27	NULL	"Hybrid"	30	"5"
830	6	15	2024-11-27	NULL	"Hybrid"	30	"5"
831	6	15	2024-11-27	NULL	"Hybrid"	30	"5"
832	6	15	2024-11-27	NULL	"Hybrid"	30	"5"
833	6	15	2024-11-27	NULL	"Hybrid"	106	"1"
834	6	15	2024-11-27	NULL	"Hybrid"	105	"1"
835	6	15	2024-11-27	NULL	"Hybrid"	107	"1"
836	6	15	2024-11-27	NULL	"Hybrid"	105	"1"
837	6	15	2024-11-27	NULL	"Hybrid"	107	"1"
838	6	15	2024-11-27	NULL	"Hybrid"	105	"1"
839	6	15	2024-11-27	NULL	"Hybrid"	505	"2"
840	6	15	2024-11-27	NULL	"Hybrid"	474	"2"
841	6	15	2024-11-27	NULL	"Hybrid"	467	"2"
842	6	15	2024-11-27	NULL	"Hybrid"	465	"2"
843	6	15	2024-11-27	NULL	"Hybrid"	464	"2"
844	6	15	2024-11-27	NULL	"Hybrid"	460	"2"
845	6	15	2024-11-27	NULL	"Fine-grained"	39	"5"
846	6	15	2024-11-27	NULL	"Fine-grained"	32	"5"
847	6	15	2024-11-27	NULL	"Fine-grained"	32	"5"
848	6	15	2024-11-27	NULL	"Fine-grained"	32	"5"
849	6	15	2024-11-27	NULL	"Fine-grained"	32	"5"
850	6	15	2024-11-27	NULL	"Fine-grained"	32	"5"
851	6	15	2024-11-27	NULL	"Fine-grained"	110	"1"
852	6	15	2024-11-27	NULL	"Fine-grained"	108	"1"
853	6	15	2024-11-27	NULL	"Fine-grained"	109	"1"
854	6	15	2024-11-27	NULL	"Fine-grained"	108	"1"
855	6	15	2024-11-27	NULL	"Fine-grained"	109	"1"
856	6	15	2024-11-27	NULL	"Fine-grained"	109	"1"
857	6	15	2024-11-27	NULL	"Fine-grained"	506	"2"
858	6	15	2024-11-27	NULL	"Fine-grained"	490	"2"
859	6	15	2024-11-27	NULL	"Fine-grained"	481	"2"
860	6	15	2024-11-27	NULL	"Fine-grained"	469	"2"
861	6	15	2024-11-27	NULL	"Fine-grained"	470	"2"
862	6	15	2024-11-27	NULL	"Fine-grained"	463	"2"
CREATE TABLE "public"."container" (
	"host_environment_id" INTEGER       NOT NULL,
	"image_id"            INTEGER       NOT NULL,
	"execution_id"        INTEGER       NOT NULL,
	"created"             DATE,
	"empty_layer"         VARCHAR(155),
	"pid"                 VARCHAR(155)
);
COPY 3184 RECORDS INTO "public"."container" FROM stdin USING DELIMITERS E'\t',E'\n','"';
1	28	63	2024-11-27	NULL	NULL
1	28	64	2024-11-27	NULL	NULL
1	28	65	2024-11-27	NULL	NULL
1	28	66	2024-11-27	NULL	NULL
1	28	67	2024-11-27	NULL	NULL
1	28	68	2024-11-27	NULL	NULL
1	28	108	2024-11-27	NULL	NULL
1	28	109	2024-11-27	NULL	NULL
1	28	110	2024-11-27	NULL	NULL
1	28	111	2024-11-27	NULL	NULL
1	28	112	2024-11-27	NULL	NULL
1	28	113	2024-11-27	NULL	NULL
1	27	114	2024-11-27	NULL	NULL
1	27	115	2024-11-27	NULL	NULL
1	27	116	2024-11-27	NULL	NULL
1	27	117	2024-11-27	NULL	NULL
1	27	118	2024-11-27	NULL	NULL
1	27	119	2024-11-27	NULL	NULL
1	4	114	2024-11-27	NULL	NULL
1	4	115	2024-11-27	NULL	NULL
1	4	116	2024-11-27	NULL	NULL
1	4	117	2024-11-27	NULL	NULL
1	4	118	2024-11-27	NULL	NULL
1	4	119	2024-11-27	NULL	NULL
1	28	120	2024-11-27	NULL	NULL
1	28	121	2024-11-27	NULL	NULL
1	28	122	2024-11-27	NULL	NULL
1	28	123	2024-11-27	NULL	NULL
1	28	124	2024-11-27	NULL	NULL
1	28	125	2024-11-27	NULL	NULL
1	25	120	2024-11-27	NULL	NULL
1	25	121	2024-11-27	NULL	NULL
1	25	122	2024-11-27	NULL	NULL
1	25	123	2024-11-27	NULL	NULL
1	25	124	2024-11-27	NULL	NULL
1	25	125	2024-11-27	NULL	NULL
1	27	126	2024-11-27	NULL	NULL
1	27	127	2024-11-27	NULL	NULL
1	27	128	2024-11-27	NULL	NULL
1	27	129	2024-11-27	NULL	NULL
1	27	130	2024-11-27	NULL	NULL
1	27	131	2024-11-27	NULL	NULL
1	27	132	2024-11-27	NULL	NULL
1	23	126	2024-11-27	NULL	NULL
1	23	127	2024-11-27	NULL	NULL
1	23	128	2024-11-27	NULL	NULL
1	23	129	2024-11-27	NULL	NULL
1	23	130	2024-11-27	NULL	NULL
1	23	131	2024-11-27	NULL	NULL
1	23	132	2024-11-27	NULL	NULL
1	27	133	2024-11-27	NULL	NULL
1	27	134	2024-11-27	NULL	NULL
1	27	135	2024-11-27	NULL	NULL
1	27	136	2024-11-27	NULL	NULL
1	27	137	2024-11-27	NULL	NULL
1	27	138	2024-11-27	NULL	NULL
1	25	133	2024-11-27	NULL	NULL
1	25	134	2024-11-27	NULL	NULL
1	25	135	2024-11-27	NULL	NULL
1	25	136	2024-11-27	NULL	NULL
1	25	137	2024-11-27	NULL	NULL
1	25	138	2024-11-27	NULL	NULL
1	4	133	2024-11-27	NULL	NULL
1	4	134	2024-11-27	NULL	NULL
1	4	135	2024-11-27	NULL	NULL
1	4	136	2024-11-27	NULL	NULL
1	4	137	2024-11-27	NULL	NULL
1	4	138	2024-11-27	NULL	NULL
1	24	139	2024-11-27	NULL	NULL
1	24	140	2024-11-27	NULL	NULL
1	24	141	2024-11-27	NULL	NULL
1	24	142	2024-11-27	NULL	NULL
1	24	143	2024-11-27	NULL	NULL
1	24	144	2024-11-27	NULL	NULL
1	24	145	2024-11-27	NULL	NULL
1	5	139	2024-11-27	NULL	NULL
1	5	140	2024-11-27	NULL	NULL
1	5	141	2024-11-27	NULL	NULL
1	5	142	2024-11-27	NULL	NULL
1	5	143	2024-11-27	NULL	NULL
1	5	144	2024-11-27	NULL	NULL
1	5	145	2024-11-27	NULL	NULL
1	25	139	2024-11-27	NULL	NULL
1	25	140	2024-11-27	NULL	NULL
1	25	141	2024-11-27	NULL	NULL
1	25	142	2024-11-27	NULL	NULL
1	25	143	2024-11-27	NULL	NULL
1	25	144	2024-11-27	NULL	NULL
1	25	145	2024-11-27	NULL	NULL
1	26	139	2024-11-27	NULL	NULL
1	26	140	2024-11-27	NULL	NULL
1	26	141	2024-11-27	NULL	NULL
1	26	142	2024-11-27	NULL	NULL
1	26	143	2024-11-27	NULL	NULL
1	26	144	2024-11-27	NULL	NULL
1	26	145	2024-11-27	NULL	NULL
1	4	139	2024-11-27	NULL	NULL
1	4	140	2024-11-27	NULL	NULL
1	4	141	2024-11-27	NULL	NULL
1	4	142	2024-11-27	NULL	NULL
1	4	143	2024-11-27	NULL	NULL
1	4	144	2024-11-27	NULL	NULL
1	4	145	2024-11-27	NULL	NULL
1	3	139	2024-11-27	NULL	NULL
1	3	140	2024-11-27	NULL	NULL
1	3	141	2024-11-27	NULL	NULL
1	3	142	2024-11-27	NULL	NULL
1	3	143	2024-11-27	NULL	NULL
1	3	144	2024-11-27	NULL	NULL
1	3	145	2024-11-27	NULL	NULL
1	28	146	2024-11-27	NULL	NULL
1	28	147	2024-11-27	NULL	NULL
1	28	148	2024-11-27	NULL	NULL
1	28	149	2024-11-27	NULL	NULL
1	28	150	2024-11-27	NULL	NULL
1	28	151	2024-11-27	NULL	NULL
1	24	176	2024-11-27	NULL	NULL
1	24	177	2024-11-27	NULL	NULL
1	24	178	2024-11-27	NULL	NULL
1	24	179	2024-11-27	NULL	NULL
1	24	180	2024-11-27	NULL	NULL
1	24	181	2024-11-27	NULL	NULL
1	5	176	2024-11-27	NULL	NULL
1	5	177	2024-11-27	NULL	NULL
1	5	178	2024-11-27	NULL	NULL
1	5	179	2024-11-27	NULL	NULL
1	5	180	2024-11-27	NULL	NULL
1	5	181	2024-11-27	NULL	NULL
1	25	176	2024-11-27	NULL	NULL
1	25	177	2024-11-27	NULL	NULL
1	25	178	2024-11-27	NULL	NULL
1	25	179	2024-11-27	NULL	NULL
1	25	180	2024-11-27	NULL	NULL
1	25	181	2024-11-27	NULL	NULL
1	26	176	2024-11-27	NULL	NULL
1	26	177	2024-11-27	NULL	NULL
1	26	178	2024-11-27	NULL	NULL
1	26	179	2024-11-27	NULL	NULL
1	26	180	2024-11-27	NULL	NULL
1	26	181	2024-11-27	NULL	NULL
1	4	176	2024-11-27	NULL	NULL
1	4	177	2024-11-27	NULL	NULL
1	4	178	2024-11-27	NULL	NULL
1	4	179	2024-11-27	NULL	NULL
1	4	180	2024-11-27	NULL	NULL
1	4	181	2024-11-27	NULL	NULL
1	3	176	2024-11-27	NULL	NULL
1	3	177	2024-11-27	NULL	NULL
1	3	178	2024-11-27	NULL	NULL
1	3	179	2024-11-27	NULL	NULL
1	3	180	2024-11-27	NULL	NULL
1	3	181	2024-11-27	NULL	NULL
2	28	182	2024-11-27	NULL	NULL
2	28	183	2024-11-27	NULL	NULL
2	28	184	2024-11-27	NULL	NULL
2	28	185	2024-11-27	NULL	NULL
2	28	186	2024-11-27	NULL	NULL
2	27	187	2024-11-27	NULL	NULL
2	27	188	2024-11-27	NULL	NULL
2	27	189	2024-11-27	NULL	NULL
2	27	190	2024-11-27	NULL	NULL
2	27	191	2024-11-27	NULL	NULL
2	4	187	2024-11-27	NULL	NULL
2	4	188	2024-11-27	NULL	NULL
2	4	189	2024-11-27	NULL	NULL
2	4	190	2024-11-27	NULL	NULL
2	4	191	2024-11-27	NULL	NULL
2	28	192	2024-11-27	NULL	NULL
2	28	193	2024-11-27	NULL	NULL
2	28	194	2024-11-27	NULL	NULL
2	28	195	2024-11-27	NULL	NULL
2	28	196	2024-11-27	NULL	NULL
2	25	192	2024-11-27	NULL	NULL
2	25	193	2024-11-27	NULL	NULL
2	25	194	2024-11-27	NULL	NULL
2	25	195	2024-11-27	NULL	NULL
2	25	196	2024-11-27	NULL	NULL
2	27	197	2024-11-27	NULL	NULL
2	27	198	2024-11-27	NULL	NULL
2	27	199	2024-11-27	NULL	NULL
2	27	200	2024-11-27	NULL	NULL
2	27	201	2024-11-27	NULL	NULL
2	23	197	2024-11-27	NULL	NULL
2	23	198	2024-11-27	NULL	NULL
2	23	199	2024-11-27	NULL	NULL
2	23	200	2024-11-27	NULL	NULL
2	23	201	2024-11-27	NULL	NULL
2	27	202	2024-11-27	NULL	NULL
2	27	203	2024-11-27	NULL	NULL
2	27	204	2024-11-27	NULL	NULL
2	27	205	2024-11-27	NULL	NULL
2	27	206	2024-11-27	NULL	NULL
2	25	202	2024-11-27	NULL	NULL
2	25	203	2024-11-27	NULL	NULL
2	25	204	2024-11-27	NULL	NULL
2	25	205	2024-11-27	NULL	NULL
2	25	206	2024-11-27	NULL	NULL
2	4	202	2024-11-27	NULL	NULL
2	4	203	2024-11-27	NULL	NULL
2	4	204	2024-11-27	NULL	NULL
2	4	205	2024-11-27	NULL	NULL
2	4	206	2024-11-27	NULL	NULL
2	28	207	2024-11-27	NULL	NULL
2	28	208	2024-11-27	NULL	NULL
2	28	209	2024-11-27	NULL	NULL
2	28	210	2024-11-27	NULL	NULL
2	28	211	2024-11-27	NULL	NULL
2	28	212	2024-11-27	NULL	NULL
2	28	213	2024-11-27	NULL	NULL
2	28	214	2024-11-27	NULL	NULL
2	28	215	2024-11-27	NULL	NULL
2	28	216	2024-11-27	NULL	NULL
2	27	217	2024-11-27	NULL	NULL
2	27	218	2024-11-27	NULL	NULL
2	27	219	2024-11-27	NULL	NULL
2	27	220	2024-11-27	NULL	NULL
2	27	221	2024-11-27	NULL	NULL
2	27	222	2024-11-27	NULL	NULL
2	27	223	2024-11-27	NULL	NULL
2	27	224	2024-11-27	NULL	NULL
2	27	225	2024-11-27	NULL	NULL
2	27	226	2024-11-27	NULL	NULL
2	4	217	2024-11-27	NULL	NULL
2	4	218	2024-11-27	NULL	NULL
2	4	219	2024-11-27	NULL	NULL
2	4	220	2024-11-27	NULL	NULL
2	4	221	2024-11-27	NULL	NULL
2	4	222	2024-11-27	NULL	NULL
2	4	223	2024-11-27	NULL	NULL
2	4	224	2024-11-27	NULL	NULL
2	4	225	2024-11-27	NULL	NULL
2	4	226	2024-11-27	NULL	NULL
2	27	227	2024-11-27	NULL	NULL
2	27	228	2024-11-27	NULL	NULL
2	27	229	2024-11-27	NULL	NULL
2	27	230	2024-11-27	NULL	NULL
2	27	231	2024-11-27	NULL	NULL
2	27	232	2024-11-27	NULL	NULL
2	27	233	2024-11-27	NULL	NULL
2	27	234	2024-11-27	NULL	NULL
2	27	235	2024-11-27	NULL	NULL
2	27	236	2024-11-27	NULL	NULL
2	25	227	2024-11-27	NULL	NULL
2	25	228	2024-11-27	NULL	NULL
2	25	229	2024-11-27	NULL	NULL
2	25	230	2024-11-27	NULL	NULL
2	25	231	2024-11-27	NULL	NULL
2	25	232	2024-11-27	NULL	NULL
2	25	233	2024-11-27	NULL	NULL
2	25	234	2024-11-27	NULL	NULL
2	25	235	2024-11-27	NULL	NULL
2	25	236	2024-11-27	NULL	NULL
2	4	227	2024-11-27	NULL	NULL
2	4	228	2024-11-27	NULL	NULL
2	4	229	2024-11-27	NULL	NULL
2	4	230	2024-11-27	NULL	NULL
2	4	231	2024-11-27	NULL	NULL
2	4	232	2024-11-27	NULL	NULL
2	4	233	2024-11-27	NULL	NULL
2	4	234	2024-11-27	NULL	NULL
2	4	235	2024-11-27	NULL	NULL
2	4	236	2024-11-27	NULL	NULL
2	24	237	2024-11-27	NULL	NULL
2	24	238	2024-11-27	NULL	NULL
2	24	239	2024-11-27	NULL	NULL
2	24	240	2024-11-27	NULL	NULL
2	24	241	2024-11-27	NULL	NULL
2	24	242	2024-11-27	NULL	NULL
2	24	243	2024-11-27	NULL	NULL
2	24	244	2024-11-27	NULL	NULL
2	24	245	2024-11-27	NULL	NULL
2	24	246	2024-11-27	NULL	NULL
2	5	237	2024-11-27	NULL	NULL
2	5	238	2024-11-27	NULL	NULL
2	5	239	2024-11-27	NULL	NULL
2	5	240	2024-11-27	NULL	NULL
2	5	241	2024-11-27	NULL	NULL
2	5	242	2024-11-27	NULL	NULL
2	5	243	2024-11-27	NULL	NULL
2	5	244	2024-11-27	NULL	NULL
2	5	245	2024-11-27	NULL	NULL
2	5	246	2024-11-27	NULL	NULL
2	25	237	2024-11-27	NULL	NULL
2	25	238	2024-11-27	NULL	NULL
2	25	239	2024-11-27	NULL	NULL
2	25	240	2024-11-27	NULL	NULL
2	25	241	2024-11-27	NULL	NULL
2	25	242	2024-11-27	NULL	NULL
2	25	243	2024-11-27	NULL	NULL
2	25	244	2024-11-27	NULL	NULL
2	25	245	2024-11-27	NULL	NULL
2	25	246	2024-11-27	NULL	NULL
2	26	237	2024-11-27	NULL	NULL
2	26	238	2024-11-27	NULL	NULL
2	26	239	2024-11-27	NULL	NULL
2	26	240	2024-11-27	NULL	NULL
2	26	241	2024-11-27	NULL	NULL
2	26	242	2024-11-27	NULL	NULL
2	26	243	2024-11-27	NULL	NULL
2	26	244	2024-11-27	NULL	NULL
2	26	245	2024-11-27	NULL	NULL
2	26	246	2024-11-27	NULL	NULL
2	4	237	2024-11-27	NULL	NULL
2	4	238	2024-11-27	NULL	NULL
2	4	239	2024-11-27	NULL	NULL
2	4	240	2024-11-27	NULL	NULL
2	4	241	2024-11-27	NULL	NULL
2	4	242	2024-11-27	NULL	NULL
2	4	243	2024-11-27	NULL	NULL
2	4	244	2024-11-27	NULL	NULL
2	4	245	2024-11-27	NULL	NULL
2	4	246	2024-11-27	NULL	NULL
2	3	237	2024-11-27	NULL	NULL
2	3	238	2024-11-27	NULL	NULL
2	3	239	2024-11-27	NULL	NULL
2	3	240	2024-11-27	NULL	NULL
2	3	241	2024-11-27	NULL	NULL
2	3	242	2024-11-27	NULL	NULL
2	3	243	2024-11-27	NULL	NULL
2	3	244	2024-11-27	NULL	NULL
2	3	245	2024-11-27	NULL	NULL
2	3	246	2024-11-27	NULL	NULL
2	24	247	2024-11-27	NULL	NULL
2	24	248	2024-11-27	NULL	NULL
2	24	249	2024-11-27	NULL	NULL
2	24	250	2024-11-27	NULL	NULL
2	24	251	2024-11-27	NULL	NULL
2	24	252	2024-11-27	NULL	NULL
2	24	253	2024-11-27	NULL	NULL
2	24	254	2024-11-27	NULL	NULL
2	24	255	2024-11-27	NULL	NULL
2	24	256	2024-11-27	NULL	NULL
2	5	247	2024-11-27	NULL	NULL
2	5	248	2024-11-27	NULL	NULL
2	5	249	2024-11-27	NULL	NULL
2	5	250	2024-11-27	NULL	NULL
2	5	251	2024-11-27	NULL	NULL
2	5	252	2024-11-27	NULL	NULL
2	5	253	2024-11-27	NULL	NULL
2	5	254	2024-11-27	NULL	NULL
2	5	255	2024-11-27	NULL	NULL
2	5	256	2024-11-27	NULL	NULL
2	25	247	2024-11-27	NULL	NULL
2	25	248	2024-11-27	NULL	NULL
2	25	249	2024-11-27	NULL	NULL
2	25	250	2024-11-27	NULL	NULL
2	25	251	2024-11-27	NULL	NULL
2	25	252	2024-11-27	NULL	NULL
2	25	253	2024-11-27	NULL	NULL
2	25	254	2024-11-27	NULL	NULL
2	25	255	2024-11-27	NULL	NULL
2	25	256	2024-11-27	NULL	NULL
2	26	247	2024-11-27	NULL	NULL
2	26	248	2024-11-27	NULL	NULL
2	26	249	2024-11-27	NULL	NULL
2	26	250	2024-11-27	NULL	NULL
2	26	251	2024-11-27	NULL	NULL
2	26	252	2024-11-27	NULL	NULL
2	26	253	2024-11-27	NULL	NULL
2	26	254	2024-11-27	NULL	NULL
2	26	255	2024-11-27	NULL	NULL
2	26	256	2024-11-27	NULL	NULL
2	4	247	2024-11-27	NULL	NULL
2	4	248	2024-11-27	NULL	NULL
2	4	249	2024-11-27	NULL	NULL
2	4	250	2024-11-27	NULL	NULL
2	4	251	2024-11-27	NULL	NULL
2	4	252	2024-11-27	NULL	NULL
2	4	253	2024-11-27	NULL	NULL
2	4	254	2024-11-27	NULL	NULL
2	4	255	2024-11-27	NULL	NULL
2	4	256	2024-11-27	NULL	NULL
2	3	247	2024-11-27	NULL	NULL
2	3	248	2024-11-27	NULL	NULL
2	3	249	2024-11-27	NULL	NULL
2	3	250	2024-11-27	NULL	NULL
2	3	251	2024-11-27	NULL	NULL
2	3	252	2024-11-27	NULL	NULL
2	3	253	2024-11-27	NULL	NULL
2	3	254	2024-11-27	NULL	NULL
2	3	255	2024-11-27	NULL	NULL
2	3	256	2024-11-27	NULL	NULL
2	28	257	2024-11-27	NULL	NULL
2	28	258	2024-11-27	NULL	NULL
2	28	259	2024-11-27	NULL	NULL
2	28	260	2024-11-27	NULL	NULL
2	28	261	2024-11-27	NULL	NULL
2	28	262	2024-11-27	NULL	NULL
2	28	263	2024-11-27	NULL	NULL
2	28	264	2024-11-27	NULL	NULL
2	28	265	2024-11-27	NULL	NULL
2	28	266	2024-11-27	NULL	NULL
2	27	267	2024-11-27	NULL	NULL
2	27	268	2024-11-27	NULL	NULL
2	27	269	2024-11-27	NULL	NULL
2	27	270	2024-11-27	NULL	NULL
2	27	271	2024-11-27	NULL	NULL
2	27	272	2024-11-27	NULL	NULL
2	27	273	2024-11-27	NULL	NULL
2	27	274	2024-11-27	NULL	NULL
2	27	275	2024-11-27	NULL	NULL
2	27	276	2024-11-27	NULL	NULL
2	4	267	2024-11-27	NULL	NULL
2	4	268	2024-11-27	NULL	NULL
2	4	269	2024-11-27	NULL	NULL
2	4	270	2024-11-27	NULL	NULL
2	4	271	2024-11-27	NULL	NULL
2	4	272	2024-11-27	NULL	NULL
2	4	273	2024-11-27	NULL	NULL
2	4	274	2024-11-27	NULL	NULL
2	4	275	2024-11-27	NULL	NULL
2	4	276	2024-11-27	NULL	NULL
2	27	277	2024-11-27	NULL	NULL
2	27	278	2024-11-27	NULL	NULL
2	27	279	2024-11-27	NULL	NULL
2	27	280	2024-11-27	NULL	NULL
2	27	281	2024-11-27	NULL	NULL
2	27	282	2024-11-27	NULL	NULL
2	27	283	2024-11-27	NULL	NULL
2	27	284	2024-11-27	NULL	NULL
2	27	285	2024-11-27	NULL	NULL
2	27	286	2024-11-27	NULL	NULL
2	25	277	2024-11-27	NULL	NULL
2	25	278	2024-11-27	NULL	NULL
2	25	279	2024-11-27	NULL	NULL
2	25	280	2024-11-27	NULL	NULL
2	25	281	2024-11-27	NULL	NULL
2	25	282	2024-11-27	NULL	NULL
2	25	283	2024-11-27	NULL	NULL
2	25	284	2024-11-27	NULL	NULL
2	25	285	2024-11-27	NULL	NULL
2	25	286	2024-11-27	NULL	NULL
2	4	277	2024-11-27	NULL	NULL
2	4	278	2024-11-27	NULL	NULL
2	4	279	2024-11-27	NULL	NULL
2	4	280	2024-11-27	NULL	NULL
2	4	281	2024-11-27	NULL	NULL
2	4	282	2024-11-27	NULL	NULL
2	4	283	2024-11-27	NULL	NULL
2	4	284	2024-11-27	NULL	NULL
2	4	285	2024-11-27	NULL	NULL
2	4	286	2024-11-27	NULL	NULL
2	24	287	2024-11-27	NULL	NULL
2	24	288	2024-11-27	NULL	NULL
2	24	289	2024-11-27	NULL	NULL
2	24	290	2024-11-27	NULL	NULL
2	24	291	2024-11-27	NULL	NULL
2	24	292	2024-11-27	NULL	NULL
2	24	293	2024-11-27	NULL	NULL
2	24	294	2024-11-27	NULL	NULL
2	24	295	2024-11-27	NULL	NULL
2	24	296	2024-11-27	NULL	NULL
2	5	287	2024-11-27	NULL	NULL
2	5	288	2024-11-27	NULL	NULL
2	5	289	2024-11-27	NULL	NULL
2	5	290	2024-11-27	NULL	NULL
2	5	291	2024-11-27	NULL	NULL
2	5	292	2024-11-27	NULL	NULL
2	5	293	2024-11-27	NULL	NULL
2	5	294	2024-11-27	NULL	NULL
2	5	295	2024-11-27	NULL	NULL
2	5	296	2024-11-27	NULL	NULL
2	25	287	2024-11-27	NULL	NULL
2	25	288	2024-11-27	NULL	NULL
2	25	289	2024-11-27	NULL	NULL
2	25	290	2024-11-27	NULL	NULL
2	25	291	2024-11-27	NULL	NULL
2	25	292	2024-11-27	NULL	NULL
2	25	293	2024-11-27	NULL	NULL
2	25	294	2024-11-27	NULL	NULL
2	25	295	2024-11-27	NULL	NULL
2	25	296	2024-11-27	NULL	NULL
2	26	287	2024-11-27	NULL	NULL
2	26	288	2024-11-27	NULL	NULL
2	26	289	2024-11-27	NULL	NULL
2	26	290	2024-11-27	NULL	NULL
2	26	291	2024-11-27	NULL	NULL
2	26	292	2024-11-27	NULL	NULL
2	26	293	2024-11-27	NULL	NULL
2	26	294	2024-11-27	NULL	NULL
2	26	295	2024-11-27	NULL	NULL
2	26	296	2024-11-27	NULL	NULL
2	4	287	2024-11-27	NULL	NULL
2	4	288	2024-11-27	NULL	NULL
2	4	289	2024-11-27	NULL	NULL
2	4	290	2024-11-27	NULL	NULL
2	4	291	2024-11-27	NULL	NULL
2	4	292	2024-11-27	NULL	NULL
2	4	293	2024-11-27	NULL	NULL
2	4	294	2024-11-27	NULL	NULL
2	4	295	2024-11-27	NULL	NULL
2	4	296	2024-11-27	NULL	NULL
2	3	287	2024-11-27	NULL	NULL
2	3	288	2024-11-27	NULL	NULL
2	3	289	2024-11-27	NULL	NULL
2	3	290	2024-11-27	NULL	NULL
2	3	291	2024-11-27	NULL	NULL
2	3	292	2024-11-27	NULL	NULL
2	3	293	2024-11-27	NULL	NULL
2	3	294	2024-11-27	NULL	NULL
2	3	295	2024-11-27	NULL	NULL
2	3	296	2024-11-27	NULL	NULL
2	28	297	2024-11-27	NULL	NULL
2	28	298	2024-11-27	NULL	NULL
2	28	299	2024-11-27	NULL	NULL
2	28	300	2024-11-27	NULL	NULL
2	28	301	2024-11-27	NULL	NULL
2	28	302	2024-11-27	NULL	NULL
2	28	303	2024-11-27	NULL	NULL
2	28	304	2024-11-27	NULL	NULL
2	28	305	2024-11-27	NULL	NULL
2	28	306	2024-11-27	NULL	NULL
2	27	307	2024-11-27	NULL	NULL
2	27	308	2024-11-27	NULL	NULL
2	27	309	2024-11-27	NULL	NULL
2	27	310	2024-11-27	NULL	NULL
2	27	311	2024-11-27	NULL	NULL
2	27	312	2024-11-27	NULL	NULL
2	27	313	2024-11-27	NULL	NULL
2	27	314	2024-11-27	NULL	NULL
2	27	315	2024-11-27	NULL	NULL
2	27	316	2024-11-27	NULL	NULL
2	4	307	2024-11-27	NULL	NULL
2	4	308	2024-11-27	NULL	NULL
2	4	309	2024-11-27	NULL	NULL
2	4	310	2024-11-27	NULL	NULL
2	4	311	2024-11-27	NULL	NULL
2	4	312	2024-11-27	NULL	NULL
2	4	313	2024-11-27	NULL	NULL
2	4	314	2024-11-27	NULL	NULL
2	4	315	2024-11-27	NULL	NULL
2	4	316	2024-11-27	NULL	NULL
2	27	317	2024-11-27	NULL	NULL
2	27	318	2024-11-27	NULL	NULL
2	27	319	2024-11-27	NULL	NULL
2	27	320	2024-11-27	NULL	NULL
2	27	321	2024-11-27	NULL	NULL
2	27	322	2024-11-27	NULL	NULL
2	27	323	2024-11-27	NULL	NULL
2	27	324	2024-11-27	NULL	NULL
2	27	325	2024-11-27	NULL	NULL
2	27	326	2024-11-27	NULL	NULL
2	25	317	2024-11-27	NULL	NULL
2	25	318	2024-11-27	NULL	NULL
2	25	319	2024-11-27	NULL	NULL
2	25	320	2024-11-27	NULL	NULL
2	25	321	2024-11-27	NULL	NULL
2	25	322	2024-11-27	NULL	NULL
2	25	323	2024-11-27	NULL	NULL
2	25	324	2024-11-27	NULL	NULL
2	25	325	2024-11-27	NULL	NULL
2	25	326	2024-11-27	NULL	NULL
2	4	317	2024-11-27	NULL	NULL
2	4	318	2024-11-27	NULL	NULL
2	4	319	2024-11-27	NULL	NULL
2	4	320	2024-11-27	NULL	NULL
2	4	321	2024-11-27	NULL	NULL
2	4	322	2024-11-27	NULL	NULL
2	4	323	2024-11-27	NULL	NULL
2	4	324	2024-11-27	NULL	NULL
2	4	325	2024-11-27	NULL	NULL
2	4	326	2024-11-27	NULL	NULL
1	24	327	2024-11-27	NULL	NULL
1	24	328	2024-11-27	NULL	NULL
1	24	329	2024-11-27	NULL	NULL
1	24	330	2024-11-27	NULL	NULL
1	24	331	2024-11-27	NULL	NULL
1	24	332	2024-11-27	NULL	NULL
1	24	333	2024-11-27	NULL	NULL
1	24	334	2024-11-27	NULL	NULL
1	24	335	2024-11-27	NULL	NULL
1	24	336	2024-11-27	NULL	NULL
1	5	327	2024-11-27	NULL	NULL
1	5	328	2024-11-27	NULL	NULL
1	5	329	2024-11-27	NULL	NULL
1	5	330	2024-11-27	NULL	NULL
1	5	331	2024-11-27	NULL	NULL
1	5	332	2024-11-27	NULL	NULL
1	5	333	2024-11-27	NULL	NULL
1	5	334	2024-11-27	NULL	NULL
1	5	335	2024-11-27	NULL	NULL
1	5	336	2024-11-27	NULL	NULL
1	25	327	2024-11-27	NULL	NULL
1	25	328	2024-11-27	NULL	NULL
1	25	329	2024-11-27	NULL	NULL
1	25	330	2024-11-27	NULL	NULL
1	25	331	2024-11-27	NULL	NULL
1	25	332	2024-11-27	NULL	NULL
1	25	333	2024-11-27	NULL	NULL
1	25	334	2024-11-27	NULL	NULL
1	25	335	2024-11-27	NULL	NULL
1	25	336	2024-11-27	NULL	NULL
1	26	327	2024-11-27	NULL	NULL
1	26	328	2024-11-27	NULL	NULL
1	26	329	2024-11-27	NULL	NULL
1	26	330	2024-11-27	NULL	NULL
1	26	331	2024-11-27	NULL	NULL
1	26	332	2024-11-27	NULL	NULL
1	26	333	2024-11-27	NULL	NULL
1	26	334	2024-11-27	NULL	NULL
1	26	335	2024-11-27	NULL	NULL
1	26	336	2024-11-27	NULL	NULL
1	4	327	2024-11-27	NULL	NULL
1	4	328	2024-11-27	NULL	NULL
1	4	329	2024-11-27	NULL	NULL
1	4	330	2024-11-27	NULL	NULL
1	4	331	2024-11-27	NULL	NULL
1	4	332	2024-11-27	NULL	NULL
1	4	333	2024-11-27	NULL	NULL
1	4	334	2024-11-27	NULL	NULL
1	4	335	2024-11-27	NULL	NULL
1	4	336	2024-11-27	NULL	NULL
1	3	327	2024-11-27	NULL	NULL
1	3	328	2024-11-27	NULL	NULL
1	3	329	2024-11-27	NULL	NULL
1	3	330	2024-11-27	NULL	NULL
1	3	331	2024-11-27	NULL	NULL
1	3	332	2024-11-27	NULL	NULL
1	3	333	2024-11-27	NULL	NULL
1	3	334	2024-11-27	NULL	NULL
1	3	335	2024-11-27	NULL	NULL
1	3	336	2024-11-27	NULL	NULL
2	28	337	2024-11-27	NULL	NULL
2	28	338	2024-11-27	NULL	NULL
2	28	339	2024-11-27	NULL	NULL
2	28	340	2024-11-27	NULL	NULL
2	28	341	2024-11-27	NULL	NULL
2	28	342	2024-11-27	NULL	NULL
2	28	343	2024-11-27	NULL	NULL
2	28	344	2024-11-27	NULL	NULL
2	28	345	2024-11-27	NULL	NULL
2	28	346	2024-11-27	NULL	NULL
2	27	347	2024-11-27	NULL	NULL
2	27	348	2024-11-27	NULL	NULL
2	27	349	2024-11-27	NULL	NULL
2	27	350	2024-11-27	NULL	NULL
2	27	351	2024-11-27	NULL	NULL
2	27	352	2024-11-27	NULL	NULL
2	27	353	2024-11-27	NULL	NULL
2	27	354	2024-11-27	NULL	NULL
2	27	355	2024-11-27	NULL	NULL
2	27	356	2024-11-27	NULL	NULL
2	4	347	2024-11-27	NULL	NULL
2	4	348	2024-11-27	NULL	NULL
2	4	349	2024-11-27	NULL	NULL
2	4	350	2024-11-27	NULL	NULL
2	4	351	2024-11-27	NULL	NULL
2	4	352	2024-11-27	NULL	NULL
2	4	353	2024-11-27	NULL	NULL
2	4	354	2024-11-27	NULL	NULL
2	4	355	2024-11-27	NULL	NULL
2	4	356	2024-11-27	NULL	NULL
2	27	357	2024-11-27	NULL	NULL
2	27	358	2024-11-27	NULL	NULL
2	27	359	2024-11-27	NULL	NULL
2	27	360	2024-11-27	NULL	NULL
2	27	361	2024-11-27	NULL	NULL
2	27	362	2024-11-27	NULL	NULL
2	27	363	2024-11-27	NULL	NULL
2	27	364	2024-11-27	NULL	NULL
2	27	365	2024-11-27	NULL	NULL
2	27	366	2024-11-27	NULL	NULL
2	25	357	2024-11-27	NULL	NULL
2	25	358	2024-11-27	NULL	NULL
2	25	359	2024-11-27	NULL	NULL
2	25	360	2024-11-27	NULL	NULL
2	25	361	2024-11-27	NULL	NULL
2	25	362	2024-11-27	NULL	NULL
2	25	363	2024-11-27	NULL	NULL
2	25	364	2024-11-27	NULL	NULL
2	25	365	2024-11-27	NULL	NULL
2	25	366	2024-11-27	NULL	NULL
2	4	357	2024-11-27	NULL	NULL
2	4	358	2024-11-27	NULL	NULL
2	4	359	2024-11-27	NULL	NULL
2	4	360	2024-11-27	NULL	NULL
2	4	361	2024-11-27	NULL	NULL
2	4	362	2024-11-27	NULL	NULL
2	4	363	2024-11-27	NULL	NULL
2	4	364	2024-11-27	NULL	NULL
2	4	365	2024-11-27	NULL	NULL
2	4	366	2024-11-27	NULL	NULL
2	24	367	2024-11-27	NULL	NULL
2	24	368	2024-11-27	NULL	NULL
2	24	369	2024-11-27	NULL	NULL
2	24	370	2024-11-27	NULL	NULL
2	24	371	2024-11-27	NULL	NULL
2	24	372	2024-11-27	NULL	NULL
2	24	373	2024-11-27	NULL	NULL
2	24	374	2024-11-27	NULL	NULL
2	24	375	2024-11-27	NULL	NULL
2	24	376	2024-11-27	NULL	NULL
2	5	367	2024-11-27	NULL	NULL
2	5	368	2024-11-27	NULL	NULL
2	5	369	2024-11-27	NULL	NULL
2	5	370	2024-11-27	NULL	NULL
2	5	371	2024-11-27	NULL	NULL
2	5	372	2024-11-27	NULL	NULL
2	5	373	2024-11-27	NULL	NULL
2	5	374	2024-11-27	NULL	NULL
2	5	375	2024-11-27	NULL	NULL
2	5	376	2024-11-27	NULL	NULL
2	25	367	2024-11-27	NULL	NULL
2	25	368	2024-11-27	NULL	NULL
2	25	369	2024-11-27	NULL	NULL
2	25	370	2024-11-27	NULL	NULL
2	25	371	2024-11-27	NULL	NULL
2	25	372	2024-11-27	NULL	NULL
2	25	373	2024-11-27	NULL	NULL
2	25	374	2024-11-27	NULL	NULL
2	25	375	2024-11-27	NULL	NULL
2	25	376	2024-11-27	NULL	NULL
2	26	367	2024-11-27	NULL	NULL
2	26	368	2024-11-27	NULL	NULL
2	26	369	2024-11-27	NULL	NULL
2	26	370	2024-11-27	NULL	NULL
2	26	371	2024-11-27	NULL	NULL
2	26	372	2024-11-27	NULL	NULL
2	26	373	2024-11-27	NULL	NULL
2	26	374	2024-11-27	NULL	NULL
2	26	375	2024-11-27	NULL	NULL
2	26	376	2024-11-27	NULL	NULL
2	4	367	2024-11-27	NULL	NULL
2	4	368	2024-11-27	NULL	NULL
2	4	369	2024-11-27	NULL	NULL
2	4	370	2024-11-27	NULL	NULL
2	4	371	2024-11-27	NULL	NULL
2	4	372	2024-11-27	NULL	NULL
2	4	373	2024-11-27	NULL	NULL
2	4	374	2024-11-27	NULL	NULL
2	4	375	2024-11-27	NULL	NULL
2	4	376	2024-11-27	NULL	NULL
2	3	367	2024-11-27	NULL	NULL
2	3	368	2024-11-27	NULL	NULL
2	3	369	2024-11-27	NULL	NULL
2	3	370	2024-11-27	NULL	NULL
2	3	371	2024-11-27	NULL	NULL
2	3	372	2024-11-27	NULL	NULL
2	3	373	2024-11-27	NULL	NULL
2	3	374	2024-11-27	NULL	NULL
2	3	375	2024-11-27	NULL	NULL
2	3	376	2024-11-27	NULL	NULL
2	28	207	2024-11-27	NULL	NULL
2	28	208	2024-11-27	NULL	NULL
2	28	209	2024-11-27	NULL	NULL
2	28	210	2024-11-27	NULL	NULL
2	28	211	2024-11-27	NULL	NULL
2	28	212	2024-11-27	NULL	NULL
2	28	213	2024-11-27	NULL	NULL
2	28	214	2024-11-27	NULL	NULL
2	28	215	2024-11-27	NULL	NULL
2	28	216	2024-11-27	NULL	NULL
2	28	377	2024-11-27	NULL	NULL
2	28	378	2024-11-27	NULL	NULL
2	28	379	2024-11-27	NULL	NULL
2	28	380	2024-11-27	NULL	NULL
2	28	381	2024-11-27	NULL	NULL
2	28	382	2024-11-27	NULL	NULL
2	28	383	2024-11-27	NULL	NULL
2	28	384	2024-11-27	NULL	NULL
2	28	385	2024-11-27	NULL	NULL
2	28	386	2024-11-27	NULL	NULL
2	27	217	2024-11-27	NULL	NULL
2	27	218	2024-11-27	NULL	NULL
2	27	219	2024-11-27	NULL	NULL
2	27	220	2024-11-27	NULL	NULL
2	27	221	2024-11-27	NULL	NULL
2	27	222	2024-11-27	NULL	NULL
2	27	223	2024-11-27	NULL	NULL
2	27	224	2024-11-27	NULL	NULL
2	27	225	2024-11-27	NULL	NULL
2	27	226	2024-11-27	NULL	NULL
2	27	387	2024-11-27	NULL	NULL
2	27	388	2024-11-27	NULL	NULL
2	27	389	2024-11-27	NULL	NULL
2	27	390	2024-11-27	NULL	NULL
2	27	391	2024-11-27	NULL	NULL
2	27	392	2024-11-27	NULL	NULL
2	27	393	2024-11-27	NULL	NULL
2	27	394	2024-11-27	NULL	NULL
2	27	395	2024-11-27	NULL	NULL
2	27	396	2024-11-27	NULL	NULL
2	4	217	2024-11-27	NULL	NULL
2	4	218	2024-11-27	NULL	NULL
2	4	219	2024-11-27	NULL	NULL
2	4	220	2024-11-27	NULL	NULL
2	4	221	2024-11-27	NULL	NULL
2	4	222	2024-11-27	NULL	NULL
2	4	223	2024-11-27	NULL	NULL
2	4	224	2024-11-27	NULL	NULL
2	4	225	2024-11-27	NULL	NULL
2	4	226	2024-11-27	NULL	NULL
2	4	387	2024-11-27	NULL	NULL
2	4	388	2024-11-27	NULL	NULL
2	4	389	2024-11-27	NULL	NULL
2	4	390	2024-11-27	NULL	NULL
2	4	391	2024-11-27	NULL	NULL
2	4	392	2024-11-27	NULL	NULL
2	4	393	2024-11-27	NULL	NULL
2	4	394	2024-11-27	NULL	NULL
2	4	395	2024-11-27	NULL	NULL
2	4	396	2024-11-27	NULL	NULL
2	27	227	2024-11-27	NULL	NULL
2	27	228	2024-11-27	NULL	NULL
2	27	229	2024-11-27	NULL	NULL
2	27	230	2024-11-27	NULL	NULL
2	27	231	2024-11-27	NULL	NULL
2	27	232	2024-11-27	NULL	NULL
2	27	233	2024-11-27	NULL	NULL
2	27	234	2024-11-27	NULL	NULL
2	27	235	2024-11-27	NULL	NULL
2	27	236	2024-11-27	NULL	NULL
2	27	397	2024-11-27	NULL	NULL
2	27	398	2024-11-27	NULL	NULL
2	27	399	2024-11-27	NULL	NULL
2	27	400	2024-11-27	NULL	NULL
2	27	401	2024-11-27	NULL	NULL
2	27	402	2024-11-27	NULL	NULL
2	27	403	2024-11-27	NULL	NULL
2	27	404	2024-11-27	NULL	NULL
2	27	405	2024-11-27	NULL	NULL
2	27	406	2024-11-27	NULL	NULL
2	25	227	2024-11-27	NULL	NULL
2	25	228	2024-11-27	NULL	NULL
2	25	229	2024-11-27	NULL	NULL
2	25	230	2024-11-27	NULL	NULL
2	25	231	2024-11-27	NULL	NULL
2	25	232	2024-11-27	NULL	NULL
2	25	233	2024-11-27	NULL	NULL
2	25	234	2024-11-27	NULL	NULL
2	25	235	2024-11-27	NULL	NULL
2	25	236	2024-11-27	NULL	NULL
2	25	397	2024-11-27	NULL	NULL
2	25	398	2024-11-27	NULL	NULL
2	25	399	2024-11-27	NULL	NULL
2	25	400	2024-11-27	NULL	NULL
2	25	401	2024-11-27	NULL	NULL
2	25	402	2024-11-27	NULL	NULL
2	25	403	2024-11-27	NULL	NULL
2	25	404	2024-11-27	NULL	NULL
2	25	405	2024-11-27	NULL	NULL
2	25	406	2024-11-27	NULL	NULL
2	4	227	2024-11-27	NULL	NULL
2	4	228	2024-11-27	NULL	NULL
2	4	229	2024-11-27	NULL	NULL
2	4	230	2024-11-27	NULL	NULL
2	4	231	2024-11-27	NULL	NULL
2	4	232	2024-11-27	NULL	NULL
2	4	233	2024-11-27	NULL	NULL
2	4	234	2024-11-27	NULL	NULL
2	4	235	2024-11-27	NULL	NULL
2	4	236	2024-11-27	NULL	NULL
2	4	397	2024-11-27	NULL	NULL
2	4	398	2024-11-27	NULL	NULL
2	4	399	2024-11-27	NULL	NULL
2	4	400	2024-11-27	NULL	NULL
2	4	401	2024-11-27	NULL	NULL
2	4	402	2024-11-27	NULL	NULL
2	4	403	2024-11-27	NULL	NULL
2	4	404	2024-11-27	NULL	NULL
2	4	405	2024-11-27	NULL	NULL
2	4	406	2024-11-27	NULL	NULL
2	24	237	2024-11-27	NULL	NULL
2	24	238	2024-11-27	NULL	NULL
2	24	239	2024-11-27	NULL	NULL
2	24	240	2024-11-27	NULL	NULL
2	24	241	2024-11-27	NULL	NULL
2	24	242	2024-11-27	NULL	NULL
2	24	243	2024-11-27	NULL	NULL
2	24	244	2024-11-27	NULL	NULL
2	24	245	2024-11-27	NULL	NULL
2	24	246	2024-11-27	NULL	NULL
2	24	407	2024-11-27	NULL	NULL
2	24	408	2024-11-27	NULL	NULL
2	24	409	2024-11-27	NULL	NULL
2	24	410	2024-11-27	NULL	NULL
2	24	411	2024-11-27	NULL	NULL
2	24	412	2024-11-27	NULL	NULL
2	24	413	2024-11-27	NULL	NULL
2	24	414	2024-11-27	NULL	NULL
2	24	415	2024-11-27	NULL	NULL
2	24	416	2024-11-27	NULL	NULL
2	5	237	2024-11-27	NULL	NULL
2	5	238	2024-11-27	NULL	NULL
2	5	239	2024-11-27	NULL	NULL
2	5	240	2024-11-27	NULL	NULL
2	5	241	2024-11-27	NULL	NULL
2	5	242	2024-11-27	NULL	NULL
2	5	243	2024-11-27	NULL	NULL
2	5	244	2024-11-27	NULL	NULL
2	5	245	2024-11-27	NULL	NULL
2	5	246	2024-11-27	NULL	NULL
2	5	407	2024-11-27	NULL	NULL
2	5	408	2024-11-27	NULL	NULL
2	5	409	2024-11-27	NULL	NULL
2	5	410	2024-11-27	NULL	NULL
2	5	411	2024-11-27	NULL	NULL
2	5	412	2024-11-27	NULL	NULL
2	5	413	2024-11-27	NULL	NULL
2	5	414	2024-11-27	NULL	NULL
2	5	415	2024-11-27	NULL	NULL
2	5	416	2024-11-27	NULL	NULL
2	25	237	2024-11-27	NULL	NULL
2	25	238	2024-11-27	NULL	NULL
2	25	239	2024-11-27	NULL	NULL
2	25	240	2024-11-27	NULL	NULL
2	25	241	2024-11-27	NULL	NULL
2	25	242	2024-11-27	NULL	NULL
2	25	243	2024-11-27	NULL	NULL
2	25	244	2024-11-27	NULL	NULL
2	25	245	2024-11-27	NULL	NULL
2	25	246	2024-11-27	NULL	NULL
2	25	407	2024-11-27	NULL	NULL
2	25	408	2024-11-27	NULL	NULL
2	25	409	2024-11-27	NULL	NULL
2	25	410	2024-11-27	NULL	NULL
2	25	411	2024-11-27	NULL	NULL
2	25	412	2024-11-27	NULL	NULL
2	25	413	2024-11-27	NULL	NULL
2	25	414	2024-11-27	NULL	NULL
2	25	415	2024-11-27	NULL	NULL
2	25	416	2024-11-27	NULL	NULL
2	26	237	2024-11-27	NULL	NULL
2	26	238	2024-11-27	NULL	NULL
2	26	239	2024-11-27	NULL	NULL
2	26	240	2024-11-27	NULL	NULL
2	26	241	2024-11-27	NULL	NULL
2	26	242	2024-11-27	NULL	NULL
2	26	243	2024-11-27	NULL	NULL
2	26	244	2024-11-27	NULL	NULL
2	26	245	2024-11-27	NULL	NULL
2	26	246	2024-11-27	NULL	NULL
2	26	407	2024-11-27	NULL	NULL
2	26	408	2024-11-27	NULL	NULL
2	26	409	2024-11-27	NULL	NULL
2	26	410	2024-11-27	NULL	NULL
2	26	411	2024-11-27	NULL	NULL
2	26	412	2024-11-27	NULL	NULL
2	26	413	2024-11-27	NULL	NULL
2	26	414	2024-11-27	NULL	NULL
2	26	415	2024-11-27	NULL	NULL
2	26	416	2024-11-27	NULL	NULL
2	4	237	2024-11-27	NULL	NULL
2	4	238	2024-11-27	NULL	NULL
2	4	239	2024-11-27	NULL	NULL
2	4	240	2024-11-27	NULL	NULL
2	4	241	2024-11-27	NULL	NULL
2	4	242	2024-11-27	NULL	NULL
2	4	243	2024-11-27	NULL	NULL
2	4	244	2024-11-27	NULL	NULL
2	4	245	2024-11-27	NULL	NULL
2	4	246	2024-11-27	NULL	NULL
2	4	407	2024-11-27	NULL	NULL
2	4	408	2024-11-27	NULL	NULL
2	4	409	2024-11-27	NULL	NULL
2	4	410	2024-11-27	NULL	NULL
2	4	411	2024-11-27	NULL	NULL
2	4	412	2024-11-27	NULL	NULL
2	4	413	2024-11-27	NULL	NULL
2	4	414	2024-11-27	NULL	NULL
2	4	415	2024-11-27	NULL	NULL
2	4	416	2024-11-27	NULL	NULL
2	3	237	2024-11-27	NULL	NULL
2	3	238	2024-11-27	NULL	NULL
2	3	239	2024-11-27	NULL	NULL
2	3	240	2024-11-27	NULL	NULL
2	3	241	2024-11-27	NULL	NULL
2	3	242	2024-11-27	NULL	NULL
2	3	243	2024-11-27	NULL	NULL
2	3	244	2024-11-27	NULL	NULL
2	3	245	2024-11-27	NULL	NULL
2	3	246	2024-11-27	NULL	NULL
2	3	407	2024-11-27	NULL	NULL
2	3	408	2024-11-27	NULL	NULL
2	3	409	2024-11-27	NULL	NULL
2	3	410	2024-11-27	NULL	NULL
2	3	411	2024-11-27	NULL	NULL
2	3	412	2024-11-27	NULL	NULL
2	3	413	2024-11-27	NULL	NULL
2	3	414	2024-11-27	NULL	NULL
2	3	415	2024-11-27	NULL	NULL
2	3	416	2024-11-27	NULL	NULL
2	24	247	2024-11-27	NULL	NULL
2	24	248	2024-11-27	NULL	NULL
2	24	249	2024-11-27	NULL	NULL
2	24	250	2024-11-27	NULL	NULL
2	24	251	2024-11-27	NULL	NULL
2	24	252	2024-11-27	NULL	NULL
2	24	253	2024-11-27	NULL	NULL
2	24	254	2024-11-27	NULL	NULL
2	24	255	2024-11-27	NULL	NULL
2	24	256	2024-11-27	NULL	NULL
2	24	417	2024-11-27	NULL	NULL
2	24	418	2024-11-27	NULL	NULL
2	24	419	2024-11-27	NULL	NULL
2	24	420	2024-11-27	NULL	NULL
2	24	421	2024-11-27	NULL	NULL
2	24	422	2024-11-27	NULL	NULL
2	24	423	2024-11-27	NULL	NULL
2	24	424	2024-11-27	NULL	NULL
2	24	425	2024-11-27	NULL	NULL
2	24	426	2024-11-27	NULL	NULL
2	5	247	2024-11-27	NULL	NULL
2	5	248	2024-11-27	NULL	NULL
2	5	249	2024-11-27	NULL	NULL
2	5	250	2024-11-27	NULL	NULL
2	5	251	2024-11-27	NULL	NULL
2	5	252	2024-11-27	NULL	NULL
2	5	253	2024-11-27	NULL	NULL
2	5	254	2024-11-27	NULL	NULL
2	5	255	2024-11-27	NULL	NULL
2	5	256	2024-11-27	NULL	NULL
2	5	417	2024-11-27	NULL	NULL
2	5	418	2024-11-27	NULL	NULL
2	5	419	2024-11-27	NULL	NULL
2	5	420	2024-11-27	NULL	NULL
2	5	421	2024-11-27	NULL	NULL
2	5	422	2024-11-27	NULL	NULL
2	5	423	2024-11-27	NULL	NULL
2	5	424	2024-11-27	NULL	NULL
2	5	425	2024-11-27	NULL	NULL
2	5	426	2024-11-27	NULL	NULL
2	25	247	2024-11-27	NULL	NULL
2	25	248	2024-11-27	NULL	NULL
2	25	249	2024-11-27	NULL	NULL
2	25	250	2024-11-27	NULL	NULL
2	25	251	2024-11-27	NULL	NULL
2	25	252	2024-11-27	NULL	NULL
2	25	253	2024-11-27	NULL	NULL
2	25	254	2024-11-27	NULL	NULL
2	25	255	2024-11-27	NULL	NULL
2	25	256	2024-11-27	NULL	NULL
2	25	417	2024-11-27	NULL	NULL
2	25	418	2024-11-27	NULL	NULL
2	25	419	2024-11-27	NULL	NULL
2	25	420	2024-11-27	NULL	NULL
2	25	421	2024-11-27	NULL	NULL
2	25	422	2024-11-27	NULL	NULL
2	25	423	2024-11-27	NULL	NULL
2	25	424	2024-11-27	NULL	NULL
2	25	425	2024-11-27	NULL	NULL
2	25	426	2024-11-27	NULL	NULL
2	26	247	2024-11-27	NULL	NULL
2	26	248	2024-11-27	NULL	NULL
2	26	249	2024-11-27	NULL	NULL
2	26	250	2024-11-27	NULL	NULL
2	26	251	2024-11-27	NULL	NULL
2	26	252	2024-11-27	NULL	NULL
2	26	253	2024-11-27	NULL	NULL
2	26	254	2024-11-27	NULL	NULL
2	26	255	2024-11-27	NULL	NULL
2	26	256	2024-11-27	NULL	NULL
2	26	417	2024-11-27	NULL	NULL
2	26	418	2024-11-27	NULL	NULL
2	26	419	2024-11-27	NULL	NULL
2	26	420	2024-11-27	NULL	NULL
2	26	421	2024-11-27	NULL	NULL
2	26	422	2024-11-27	NULL	NULL
2	26	423	2024-11-27	NULL	NULL
2	26	424	2024-11-27	NULL	NULL
2	26	425	2024-11-27	NULL	NULL
2	26	426	2024-11-27	NULL	NULL
2	4	247	2024-11-27	NULL	NULL
2	4	248	2024-11-27	NULL	NULL
2	4	249	2024-11-27	NULL	NULL
2	4	250	2024-11-27	NULL	NULL
2	4	251	2024-11-27	NULL	NULL
2	4	252	2024-11-27	NULL	NULL
2	4	253	2024-11-27	NULL	NULL
2	4	254	2024-11-27	NULL	NULL
2	4	255	2024-11-27	NULL	NULL
2	4	256	2024-11-27	NULL	NULL
2	4	417	2024-11-27	NULL	NULL
2	4	418	2024-11-27	NULL	NULL
2	4	419	2024-11-27	NULL	NULL
2	4	420	2024-11-27	NULL	NULL
2	4	421	2024-11-27	NULL	NULL
2	4	422	2024-11-27	NULL	NULL
2	4	423	2024-11-27	NULL	NULL
2	4	424	2024-11-27	NULL	NULL
2	4	425	2024-11-27	NULL	NULL
2	4	426	2024-11-27	NULL	NULL
2	3	247	2024-11-27	NULL	NULL
2	3	248	2024-11-27	NULL	NULL
2	3	249	2024-11-27	NULL	NULL
2	3	250	2024-11-27	NULL	NULL
2	3	251	2024-11-27	NULL	NULL
2	3	252	2024-11-27	NULL	NULL
2	3	253	2024-11-27	NULL	NULL
2	3	254	2024-11-27	NULL	NULL
2	3	255	2024-11-27	NULL	NULL
2	3	256	2024-11-27	NULL	NULL
2	3	417	2024-11-27	NULL	NULL
2	3	418	2024-11-27	NULL	NULL
2	3	419	2024-11-27	NULL	NULL
2	3	420	2024-11-27	NULL	NULL
2	3	421	2024-11-27	NULL	NULL
2	3	422	2024-11-27	NULL	NULL
2	3	423	2024-11-27	NULL	NULL
2	3	424	2024-11-27	NULL	NULL
2	3	425	2024-11-27	NULL	NULL
2	3	426	2024-11-27	NULL	NULL
2	28	297	2024-11-27	NULL	NULL
2	28	298	2024-11-27	NULL	NULL
2	28	299	2024-11-27	NULL	NULL
2	28	300	2024-11-27	NULL	NULL
2	28	301	2024-11-27	NULL	NULL
2	28	302	2024-11-27	NULL	NULL
2	28	303	2024-11-27	NULL	NULL
2	28	304	2024-11-27	NULL	NULL
2	28	305	2024-11-27	NULL	NULL
2	28	306	2024-11-27	NULL	NULL
2	28	427	2024-11-27	NULL	NULL
2	28	428	2024-11-27	NULL	NULL
2	28	429	2024-11-27	NULL	NULL
2	28	430	2024-11-27	NULL	NULL
2	28	431	2024-11-27	NULL	NULL
2	28	432	2024-11-27	NULL	NULL
2	28	433	2024-11-27	NULL	NULL
2	28	434	2024-11-27	NULL	NULL
2	28	435	2024-11-27	NULL	NULL
2	28	436	2024-11-27	NULL	NULL
2	27	307	2024-11-27	NULL	NULL
2	27	308	2024-11-27	NULL	NULL
2	27	309	2024-11-27	NULL	NULL
2	27	310	2024-11-27	NULL	NULL
2	27	311	2024-11-27	NULL	NULL
2	27	312	2024-11-27	NULL	NULL
2	27	313	2024-11-27	NULL	NULL
2	27	314	2024-11-27	NULL	NULL
2	27	315	2024-11-27	NULL	NULL
2	27	316	2024-11-27	NULL	NULL
2	27	437	2024-11-27	NULL	NULL
2	27	438	2024-11-27	NULL	NULL
2	27	439	2024-11-27	NULL	NULL
2	27	440	2024-11-27	NULL	NULL
2	27	441	2024-11-27	NULL	NULL
2	27	442	2024-11-27	NULL	NULL
2	27	443	2024-11-27	NULL	NULL
2	27	444	2024-11-27	NULL	NULL
2	27	445	2024-11-27	NULL	NULL
2	27	446	2024-11-27	NULL	NULL
2	4	307	2024-11-27	NULL	NULL
2	4	308	2024-11-27	NULL	NULL
2	4	309	2024-11-27	NULL	NULL
2	4	310	2024-11-27	NULL	NULL
2	4	311	2024-11-27	NULL	NULL
2	4	312	2024-11-27	NULL	NULL
2	4	313	2024-11-27	NULL	NULL
2	4	314	2024-11-27	NULL	NULL
2	4	315	2024-11-27	NULL	NULL
2	4	316	2024-11-27	NULL	NULL
2	4	437	2024-11-27	NULL	NULL
2	4	438	2024-11-27	NULL	NULL
2	4	439	2024-11-27	NULL	NULL
2	4	440	2024-11-27	NULL	NULL
2	4	441	2024-11-27	NULL	NULL
2	4	442	2024-11-27	NULL	NULL
2	4	443	2024-11-27	NULL	NULL
2	4	444	2024-11-27	NULL	NULL
2	4	445	2024-11-27	NULL	NULL
2	4	446	2024-11-27	NULL	NULL
2	27	317	2024-11-27	NULL	NULL
2	27	318	2024-11-27	NULL	NULL
2	27	319	2024-11-27	NULL	NULL
2	27	320	2024-11-27	NULL	NULL
2	27	321	2024-11-27	NULL	NULL
2	27	322	2024-11-27	NULL	NULL
2	27	323	2024-11-27	NULL	NULL
2	27	324	2024-11-27	NULL	NULL
2	27	325	2024-11-27	NULL	NULL
2	27	326	2024-11-27	NULL	NULL
2	27	447	2024-11-27	NULL	NULL
2	27	448	2024-11-27	NULL	NULL
2	27	449	2024-11-27	NULL	NULL
2	27	450	2024-11-27	NULL	NULL
2	27	451	2024-11-27	NULL	NULL
2	27	452	2024-11-27	NULL	NULL
2	27	453	2024-11-27	NULL	NULL
2	27	454	2024-11-27	NULL	NULL
2	27	455	2024-11-27	NULL	NULL
2	27	456	2024-11-27	NULL	NULL
2	25	317	2024-11-27	NULL	NULL
2	25	318	2024-11-27	NULL	NULL
2	25	319	2024-11-27	NULL	NULL
2	25	320	2024-11-27	NULL	NULL
2	25	321	2024-11-27	NULL	NULL
2	25	322	2024-11-27	NULL	NULL
2	25	323	2024-11-27	NULL	NULL
2	25	324	2024-11-27	NULL	NULL
2	25	325	2024-11-27	NULL	NULL
2	25	326	2024-11-27	NULL	NULL
2	25	447	2024-11-27	NULL	NULL
2	25	448	2024-11-27	NULL	NULL
2	25	449	2024-11-27	NULL	NULL
2	25	450	2024-11-27	NULL	NULL
2	25	451	2024-11-27	NULL	NULL
2	25	452	2024-11-27	NULL	NULL
2	25	453	2024-11-27	NULL	NULL
2	25	454	2024-11-27	NULL	NULL
2	25	455	2024-11-27	NULL	NULL
2	25	456	2024-11-27	NULL	NULL
2	4	317	2024-11-27	NULL	NULL
2	4	318	2024-11-27	NULL	NULL
2	4	319	2024-11-27	NULL	NULL
2	4	320	2024-11-27	NULL	NULL
2	4	321	2024-11-27	NULL	NULL
2	4	322	2024-11-27	NULL	NULL
2	4	323	2024-11-27	NULL	NULL
2	4	324	2024-11-27	NULL	NULL
2	4	325	2024-11-27	NULL	NULL
2	4	326	2024-11-27	NULL	NULL
2	4	447	2024-11-27	NULL	NULL
2	4	448	2024-11-27	NULL	NULL
2	4	449	2024-11-27	NULL	NULL
2	4	450	2024-11-27	NULL	NULL
2	4	451	2024-11-27	NULL	NULL
2	4	452	2024-11-27	NULL	NULL
2	4	453	2024-11-27	NULL	NULL
2	4	454	2024-11-27	NULL	NULL
2	4	455	2024-11-27	NULL	NULL
2	4	456	2024-11-27	NULL	NULL
2	24	327	2024-11-27	NULL	NULL
2	24	328	2024-11-27	NULL	NULL
2	24	329	2024-11-27	NULL	NULL
2	24	330	2024-11-27	NULL	NULL
2	24	331	2024-11-27	NULL	NULL
2	24	332	2024-11-27	NULL	NULL
2	24	333	2024-11-27	NULL	NULL
2	24	334	2024-11-27	NULL	NULL
2	24	335	2024-11-27	NULL	NULL
2	24	336	2024-11-27	NULL	NULL
2	24	457	2024-11-27	NULL	NULL
2	24	458	2024-11-27	NULL	NULL
2	24	459	2024-11-27	NULL	NULL
2	24	460	2024-11-27	NULL	NULL
2	24	461	2024-11-27	NULL	NULL
2	24	462	2024-11-27	NULL	NULL
2	24	463	2024-11-27	NULL	NULL
2	24	464	2024-11-27	NULL	NULL
2	24	465	2024-11-27	NULL	NULL
2	24	466	2024-11-27	NULL	NULL
2	5	327	2024-11-27	NULL	NULL
2	5	328	2024-11-27	NULL	NULL
2	5	329	2024-11-27	NULL	NULL
2	5	330	2024-11-27	NULL	NULL
2	5	331	2024-11-27	NULL	NULL
2	5	332	2024-11-27	NULL	NULL
2	5	333	2024-11-27	NULL	NULL
2	5	334	2024-11-27	NULL	NULL
2	5	335	2024-11-27	NULL	NULL
2	5	336	2024-11-27	NULL	NULL
2	5	457	2024-11-27	NULL	NULL
2	5	458	2024-11-27	NULL	NULL
2	5	459	2024-11-27	NULL	NULL
2	5	460	2024-11-27	NULL	NULL
2	5	461	2024-11-27	NULL	NULL
2	5	462	2024-11-27	NULL	NULL
2	5	463	2024-11-27	NULL	NULL
2	5	464	2024-11-27	NULL	NULL
2	5	465	2024-11-27	NULL	NULL
2	5	466	2024-11-27	NULL	NULL
2	25	327	2024-11-27	NULL	NULL
2	25	328	2024-11-27	NULL	NULL
2	25	329	2024-11-27	NULL	NULL
2	25	330	2024-11-27	NULL	NULL
2	25	331	2024-11-27	NULL	NULL
2	25	332	2024-11-27	NULL	NULL
2	25	333	2024-11-27	NULL	NULL
2	25	334	2024-11-27	NULL	NULL
2	25	335	2024-11-27	NULL	NULL
2	25	336	2024-11-27	NULL	NULL
2	25	457	2024-11-27	NULL	NULL
2	25	458	2024-11-27	NULL	NULL
2	25	459	2024-11-27	NULL	NULL
2	25	460	2024-11-27	NULL	NULL
2	25	461	2024-11-27	NULL	NULL
2	25	462	2024-11-27	NULL	NULL
2	25	463	2024-11-27	NULL	NULL
2	25	464	2024-11-27	NULL	NULL
2	25	465	2024-11-27	NULL	NULL
2	25	466	2024-11-27	NULL	NULL
2	26	327	2024-11-27	NULL	NULL
2	26	328	2024-11-27	NULL	NULL
2	26	329	2024-11-27	NULL	NULL
2	26	330	2024-11-27	NULL	NULL
2	26	331	2024-11-27	NULL	NULL
2	26	332	2024-11-27	NULL	NULL
2	26	333	2024-11-27	NULL	NULL
2	26	334	2024-11-27	NULL	NULL
2	26	335	2024-11-27	NULL	NULL
2	26	336	2024-11-27	NULL	NULL
2	26	457	2024-11-27	NULL	NULL
2	26	458	2024-11-27	NULL	NULL
2	26	459	2024-11-27	NULL	NULL
2	26	460	2024-11-27	NULL	NULL
2	26	461	2024-11-27	NULL	NULL
2	26	462	2024-11-27	NULL	NULL
2	26	463	2024-11-27	NULL	NULL
2	26	464	2024-11-27	NULL	NULL
2	26	465	2024-11-27	NULL	NULL
2	26	466	2024-11-27	NULL	NULL
2	4	327	2024-11-27	NULL	NULL
2	4	328	2024-11-27	NULL	NULL
2	4	329	2024-11-27	NULL	NULL
2	4	330	2024-11-27	NULL	NULL
2	4	331	2024-11-27	NULL	NULL
2	4	332	2024-11-27	NULL	NULL
2	4	333	2024-11-27	NULL	NULL
2	4	334	2024-11-27	NULL	NULL
2	4	335	2024-11-27	NULL	NULL
2	4	336	2024-11-27	NULL	NULL
2	4	457	2024-11-27	NULL	NULL
2	4	458	2024-11-27	NULL	NULL
2	4	459	2024-11-27	NULL	NULL
2	4	460	2024-11-27	NULL	NULL
2	4	461	2024-11-27	NULL	NULL
2	4	462	2024-11-27	NULL	NULL
2	4	463	2024-11-27	NULL	NULL
2	4	464	2024-11-27	NULL	NULL
2	4	465	2024-11-27	NULL	NULL
2	4	466	2024-11-27	NULL	NULL
2	3	327	2024-11-27	NULL	NULL
2	3	328	2024-11-27	NULL	NULL
2	3	329	2024-11-27	NULL	NULL
2	3	330	2024-11-27	NULL	NULL
2	3	331	2024-11-27	NULL	NULL
2	3	332	2024-11-27	NULL	NULL
2	3	333	2024-11-27	NULL	NULL
2	3	334	2024-11-27	NULL	NULL
2	3	335	2024-11-27	NULL	NULL
2	3	336	2024-11-27	NULL	NULL
2	3	457	2024-11-27	NULL	NULL
2	3	458	2024-11-27	NULL	NULL
2	3	459	2024-11-27	NULL	NULL
2	3	460	2024-11-27	NULL	NULL
2	3	461	2024-11-27	NULL	NULL
2	3	462	2024-11-27	NULL	NULL
2	3	463	2024-11-27	NULL	NULL
2	3	464	2024-11-27	NULL	NULL
2	3	465	2024-11-27	NULL	NULL
2	3	466	2024-11-27	NULL	NULL
2	24	467	2024-11-27	NULL	NULL
2	24	468	2024-11-27	NULL	NULL
2	24	469	2024-11-27	NULL	NULL
2	24	470	2024-11-27	NULL	NULL
2	24	471	2024-11-27	NULL	NULL
2	24	472	2024-11-27	NULL	NULL
2	24	473	2024-11-27	NULL	NULL
2	24	474	2024-11-27	NULL	NULL
2	24	475	2024-11-27	NULL	NULL
2	24	476	2024-11-27	NULL	NULL
2	5	467	2024-11-27	NULL	NULL
2	5	468	2024-11-27	NULL	NULL
2	5	469	2024-11-27	NULL	NULL
2	5	470	2024-11-27	NULL	NULL
2	5	471	2024-11-27	NULL	NULL
2	5	472	2024-11-27	NULL	NULL
2	5	473	2024-11-27	NULL	NULL
2	5	474	2024-11-27	NULL	NULL
2	5	475	2024-11-27	NULL	NULL
2	5	476	2024-11-27	NULL	NULL
2	25	467	2024-11-27	NULL	NULL
2	25	468	2024-11-27	NULL	NULL
2	25	469	2024-11-27	NULL	NULL
2	25	470	2024-11-27	NULL	NULL
2	25	471	2024-11-27	NULL	NULL
2	25	472	2024-11-27	NULL	NULL
2	25	473	2024-11-27	NULL	NULL
2	25	474	2024-11-27	NULL	NULL
2	25	475	2024-11-27	NULL	NULL
2	25	476	2024-11-27	NULL	NULL
2	26	467	2024-11-27	NULL	NULL
2	26	468	2024-11-27	NULL	NULL
2	26	469	2024-11-27	NULL	NULL
2	26	470	2024-11-27	NULL	NULL
2	26	471	2024-11-27	NULL	NULL
2	26	472	2024-11-27	NULL	NULL
2	26	473	2024-11-27	NULL	NULL
2	26	474	2024-11-27	NULL	NULL
2	26	475	2024-11-27	NULL	NULL
2	26	476	2024-11-27	NULL	NULL
2	4	467	2024-11-27	NULL	NULL
2	4	468	2024-11-27	NULL	NULL
2	4	469	2024-11-27	NULL	NULL
2	4	470	2024-11-27	NULL	NULL
2	4	471	2024-11-27	NULL	NULL
2	4	472	2024-11-27	NULL	NULL
2	4	473	2024-11-27	NULL	NULL
2	4	474	2024-11-27	NULL	NULL
2	4	475	2024-11-27	NULL	NULL
2	4	476	2024-11-27	NULL	NULL
2	3	467	2024-11-27	NULL	NULL
2	3	468	2024-11-27	NULL	NULL
2	3	469	2024-11-27	NULL	NULL
2	3	470	2024-11-27	NULL	NULL
2	3	471	2024-11-27	NULL	NULL
2	3	472	2024-11-27	NULL	NULL
2	3	473	2024-11-27	NULL	NULL
2	3	474	2024-11-27	NULL	NULL
2	3	475	2024-11-27	NULL	NULL
2	3	476	2024-11-27	NULL	NULL
2	28	257	2024-11-27	NULL	NULL
2	28	258	2024-11-27	NULL	NULL
2	28	259	2024-11-27	NULL	NULL
2	28	260	2024-11-27	NULL	NULL
2	28	261	2024-11-27	NULL	NULL
2	28	262	2024-11-27	NULL	NULL
2	28	263	2024-11-27	NULL	NULL
2	28	264	2024-11-27	NULL	NULL
2	28	265	2024-11-27	NULL	NULL
2	28	266	2024-11-27	NULL	NULL
2	28	477	2024-11-27	NULL	NULL
2	28	478	2024-11-27	NULL	NULL
2	28	479	2024-11-27	NULL	NULL
2	28	480	2024-11-27	NULL	NULL
2	28	481	2024-11-27	NULL	NULL
2	28	482	2024-11-27	NULL	NULL
2	28	483	2024-11-27	NULL	NULL
2	28	484	2024-11-27	NULL	NULL
2	28	485	2024-11-27	NULL	NULL
2	28	486	2024-11-27	NULL	NULL
2	27	267	2024-11-27	NULL	NULL
2	27	268	2024-11-27	NULL	NULL
2	27	269	2024-11-27	NULL	NULL
2	27	270	2024-11-27	NULL	NULL
2	27	271	2024-11-27	NULL	NULL
2	27	272	2024-11-27	NULL	NULL
2	27	273	2024-11-27	NULL	NULL
2	27	274	2024-11-27	NULL	NULL
2	27	275	2024-11-27	NULL	NULL
2	27	276	2024-11-27	NULL	NULL
2	4	267	2024-11-27	NULL	NULL
2	4	268	2024-11-27	NULL	NULL
2	4	269	2024-11-27	NULL	NULL
2	4	270	2024-11-27	NULL	NULL
2	4	271	2024-11-27	NULL	NULL
2	4	272	2024-11-27	NULL	NULL
2	4	273	2024-11-27	NULL	NULL
2	4	274	2024-11-27	NULL	NULL
2	4	275	2024-11-27	NULL	NULL
2	4	276	2024-11-27	NULL	NULL
2	27	277	2024-11-27	NULL	NULL
2	27	278	2024-11-27	NULL	NULL
2	27	279	2024-11-27	NULL	NULL
2	27	280	2024-11-27	NULL	NULL
2	27	281	2024-11-27	NULL	NULL
2	27	282	2024-11-27	NULL	NULL
2	27	283	2024-11-27	NULL	NULL
2	27	284	2024-11-27	NULL	NULL
2	27	285	2024-11-27	NULL	NULL
2	27	286	2024-11-27	NULL	NULL
2	27	497	2024-11-27	NULL	NULL
2	27	498	2024-11-27	NULL	NULL
2	27	499	2024-11-27	NULL	NULL
2	27	500	2024-11-27	NULL	NULL
2	27	501	2024-11-27	NULL	NULL
2	27	502	2024-11-27	NULL	NULL
2	27	503	2024-11-27	NULL	NULL
2	27	504	2024-11-27	NULL	NULL
2	27	505	2024-11-27	NULL	NULL
2	27	506	2024-11-27	NULL	NULL
2	25	277	2024-11-27	NULL	NULL
2	25	278	2024-11-27	NULL	NULL
2	25	279	2024-11-27	NULL	NULL
2	25	280	2024-11-27	NULL	NULL
2	25	281	2024-11-27	NULL	NULL
2	25	282	2024-11-27	NULL	NULL
2	25	283	2024-11-27	NULL	NULL
2	25	284	2024-11-27	NULL	NULL
2	25	285	2024-11-27	NULL	NULL
2	25	286	2024-11-27	NULL	NULL
2	25	497	2024-11-27	NULL	NULL
2	25	498	2024-11-27	NULL	NULL
2	25	499	2024-11-27	NULL	NULL
2	25	500	2024-11-27	NULL	NULL
2	25	501	2024-11-27	NULL	NULL
2	25	502	2024-11-27	NULL	NULL
2	25	503	2024-11-27	NULL	NULL
2	25	504	2024-11-27	NULL	NULL
2	25	505	2024-11-27	NULL	NULL
2	25	506	2024-11-27	NULL	NULL
2	4	277	2024-11-27	NULL	NULL
2	4	278	2024-11-27	NULL	NULL
2	4	279	2024-11-27	NULL	NULL
2	4	280	2024-11-27	NULL	NULL
2	4	281	2024-11-27	NULL	NULL
2	4	282	2024-11-27	NULL	NULL
2	4	283	2024-11-27	NULL	NULL
2	4	284	2024-11-27	NULL	NULL
2	4	285	2024-11-27	NULL	NULL
2	4	286	2024-11-27	NULL	NULL
2	4	497	2024-11-27	NULL	NULL
2	4	498	2024-11-27	NULL	NULL
2	4	499	2024-11-27	NULL	NULL
2	4	500	2024-11-27	NULL	NULL
2	4	501	2024-11-27	NULL	NULL
2	4	502	2024-11-27	NULL	NULL
2	4	503	2024-11-27	NULL	NULL
2	4	504	2024-11-27	NULL	NULL
2	4	505	2024-11-27	NULL	NULL
2	4	506	2024-11-27	NULL	NULL
2	24	287	2024-11-27	NULL	NULL
2	24	288	2024-11-27	NULL	NULL
2	24	289	2024-11-27	NULL	NULL
2	24	290	2024-11-27	NULL	NULL
2	24	291	2024-11-27	NULL	NULL
2	24	292	2024-11-27	NULL	NULL
2	24	293	2024-11-27	NULL	NULL
2	24	294	2024-11-27	NULL	NULL
2	24	295	2024-11-27	NULL	NULL
2	24	296	2024-11-27	NULL	NULL
2	24	507	2024-11-27	NULL	NULL
2	24	508	2024-11-27	NULL	NULL
2	24	509	2024-11-27	NULL	NULL
2	24	510	2024-11-27	NULL	NULL
2	24	511	2024-11-27	NULL	NULL
2	24	512	2024-11-27	NULL	NULL
2	24	513	2024-11-27	NULL	NULL
2	24	514	2024-11-27	NULL	NULL
2	24	515	2024-11-27	NULL	NULL
2	24	516	2024-11-27	NULL	NULL
2	5	287	2024-11-27	NULL	NULL
2	5	288	2024-11-27	NULL	NULL
2	5	289	2024-11-27	NULL	NULL
2	5	290	2024-11-27	NULL	NULL
2	5	291	2024-11-27	NULL	NULL
2	5	292	2024-11-27	NULL	NULL
2	5	293	2024-11-27	NULL	NULL
2	5	294	2024-11-27	NULL	NULL
2	5	295	2024-11-27	NULL	NULL
2	5	296	2024-11-27	NULL	NULL
2	5	507	2024-11-27	NULL	NULL
2	5	508	2024-11-27	NULL	NULL
2	5	509	2024-11-27	NULL	NULL
2	5	510	2024-11-27	NULL	NULL
2	5	511	2024-11-27	NULL	NULL
2	5	512	2024-11-27	NULL	NULL
2	5	513	2024-11-27	NULL	NULL
2	5	514	2024-11-27	NULL	NULL
2	5	515	2024-11-27	NULL	NULL
2	5	516	2024-11-27	NULL	NULL
2	25	287	2024-11-27	NULL	NULL
2	25	288	2024-11-27	NULL	NULL
2	25	289	2024-11-27	NULL	NULL
2	25	290	2024-11-27	NULL	NULL
2	25	291	2024-11-27	NULL	NULL
2	25	292	2024-11-27	NULL	NULL
2	25	293	2024-11-27	NULL	NULL
2	25	294	2024-11-27	NULL	NULL
2	25	295	2024-11-27	NULL	NULL
2	25	296	2024-11-27	NULL	NULL
2	25	507	2024-11-27	NULL	NULL
2	25	508	2024-11-27	NULL	NULL
2	25	509	2024-11-27	NULL	NULL
2	25	510	2024-11-27	NULL	NULL
2	25	511	2024-11-27	NULL	NULL
2	25	512	2024-11-27	NULL	NULL
2	25	513	2024-11-27	NULL	NULL
2	25	514	2024-11-27	NULL	NULL
2	25	515	2024-11-27	NULL	NULL
2	25	516	2024-11-27	NULL	NULL
2	26	287	2024-11-27	NULL	NULL
2	26	288	2024-11-27	NULL	NULL
2	26	289	2024-11-27	NULL	NULL
2	26	290	2024-11-27	NULL	NULL
2	26	291	2024-11-27	NULL	NULL
2	26	292	2024-11-27	NULL	NULL
2	26	293	2024-11-27	NULL	NULL
2	26	294	2024-11-27	NULL	NULL
2	26	295	2024-11-27	NULL	NULL
2	26	296	2024-11-27	NULL	NULL
2	26	507	2024-11-27	NULL	NULL
2	26	508	2024-11-27	NULL	NULL
2	26	509	2024-11-27	NULL	NULL
2	26	510	2024-11-27	NULL	NULL
2	26	511	2024-11-27	NULL	NULL
2	26	512	2024-11-27	NULL	NULL
2	26	513	2024-11-27	NULL	NULL
2	26	514	2024-11-27	NULL	NULL
2	26	515	2024-11-27	NULL	NULL
2	26	516	2024-11-27	NULL	NULL
2	4	287	2024-11-27	NULL	NULL
2	4	288	2024-11-27	NULL	NULL
2	4	289	2024-11-27	NULL	NULL
2	4	290	2024-11-27	NULL	NULL
2	4	291	2024-11-27	NULL	NULL
2	4	292	2024-11-27	NULL	NULL
2	4	293	2024-11-27	NULL	NULL
2	4	294	2024-11-27	NULL	NULL
2	4	295	2024-11-27	NULL	NULL
2	4	296	2024-11-27	NULL	NULL
2	4	507	2024-11-27	NULL	NULL
2	4	508	2024-11-27	NULL	NULL
2	4	509	2024-11-27	NULL	NULL
2	4	510	2024-11-27	NULL	NULL
2	4	511	2024-11-27	NULL	NULL
2	4	512	2024-11-27	NULL	NULL
2	4	513	2024-11-27	NULL	NULL
2	4	514	2024-11-27	NULL	NULL
2	4	515	2024-11-27	NULL	NULL
2	4	516	2024-11-27	NULL	NULL
2	3	287	2024-11-27	NULL	NULL
2	3	288	2024-11-27	NULL	NULL
2	3	289	2024-11-27	NULL	NULL
2	3	290	2024-11-27	NULL	NULL
2	3	291	2024-11-27	NULL	NULL
2	3	292	2024-11-27	NULL	NULL
2	3	293	2024-11-27	NULL	NULL
2	3	294	2024-11-27	NULL	NULL
2	3	295	2024-11-27	NULL	NULL
2	3	296	2024-11-27	NULL	NULL
2	3	507	2024-11-27	NULL	NULL
2	3	508	2024-11-27	NULL	NULL
2	3	509	2024-11-27	NULL	NULL
2	3	510	2024-11-27	NULL	NULL
2	3	511	2024-11-27	NULL	NULL
2	3	512	2024-11-27	NULL	NULL
2	3	513	2024-11-27	NULL	NULL
2	3	514	2024-11-27	NULL	NULL
2	3	515	2024-11-27	NULL	NULL
2	3	516	2024-11-27	NULL	NULL
2	28	337	2024-11-27	NULL	NULL
2	28	338	2024-11-27	NULL	NULL
2	28	339	2024-11-27	NULL	NULL
2	28	340	2024-11-27	NULL	NULL
2	28	341	2024-11-27	NULL	NULL
2	28	342	2024-11-27	NULL	NULL
2	28	343	2024-11-27	NULL	NULL
2	28	344	2024-11-27	NULL	NULL
2	28	345	2024-11-27	NULL	NULL
2	28	346	2024-11-27	NULL	NULL
2	28	517	2024-11-27	NULL	NULL
2	28	518	2024-11-27	NULL	NULL
2	28	519	2024-11-27	NULL	NULL
2	28	520	2024-11-27	NULL	NULL
2	28	521	2024-11-27	NULL	NULL
2	28	522	2024-11-27	NULL	NULL
2	28	523	2024-11-27	NULL	NULL
2	28	524	2024-11-27	NULL	NULL
2	28	525	2024-11-27	NULL	NULL
2	28	526	2024-11-27	NULL	NULL
2	27	347	2024-11-27	NULL	NULL
2	27	348	2024-11-27	NULL	NULL
2	27	349	2024-11-27	NULL	NULL
2	27	350	2024-11-27	NULL	NULL
2	27	351	2024-11-27	NULL	NULL
2	27	352	2024-11-27	NULL	NULL
2	27	353	2024-11-27	NULL	NULL
2	27	354	2024-11-27	NULL	NULL
2	27	355	2024-11-27	NULL	NULL
2	27	356	2024-11-27	NULL	NULL
2	27	527	2024-11-27	NULL	NULL
2	27	528	2024-11-27	NULL	NULL
2	27	529	2024-11-27	NULL	NULL
2	27	530	2024-11-27	NULL	NULL
2	27	531	2024-11-27	NULL	NULL
2	27	532	2024-11-27	NULL	NULL
2	27	533	2024-11-27	NULL	NULL
2	27	534	2024-11-27	NULL	NULL
2	27	535	2024-11-27	NULL	NULL
2	27	536	2024-11-27	NULL	NULL
2	4	347	2024-11-27	NULL	NULL
2	4	348	2024-11-27	NULL	NULL
2	4	349	2024-11-27	NULL	NULL
2	4	350	2024-11-27	NULL	NULL
2	4	351	2024-11-27	NULL	NULL
2	4	352	2024-11-27	NULL	NULL
2	4	353	2024-11-27	NULL	NULL
2	4	354	2024-11-27	NULL	NULL
2	4	355	2024-11-27	NULL	NULL
2	4	356	2024-11-27	NULL	NULL
2	4	527	2024-11-27	NULL	NULL
2	4	528	2024-11-27	NULL	NULL
2	4	529	2024-11-27	NULL	NULL
2	4	530	2024-11-27	NULL	NULL
2	4	531	2024-11-27	NULL	NULL
2	4	532	2024-11-27	NULL	NULL
2	4	533	2024-11-27	NULL	NULL
2	4	534	2024-11-27	NULL	NULL
2	4	535	2024-11-27	NULL	NULL
2	4	536	2024-11-27	NULL	NULL
2	27	357	2024-11-27	NULL	NULL
2	27	358	2024-11-27	NULL	NULL
2	27	359	2024-11-27	NULL	NULL
2	27	360	2024-11-27	NULL	NULL
2	27	361	2024-11-27	NULL	NULL
2	27	362	2024-11-27	NULL	NULL
2	27	363	2024-11-27	NULL	NULL
2	27	364	2024-11-27	NULL	NULL
2	27	365	2024-11-27	NULL	NULL
2	27	366	2024-11-27	NULL	NULL
2	25	357	2024-11-27	NULL	NULL
2	25	358	2024-11-27	NULL	NULL
2	25	359	2024-11-27	NULL	NULL
2	25	360	2024-11-27	NULL	NULL
2	25	361	2024-11-27	NULL	NULL
2	25	362	2024-11-27	NULL	NULL
2	25	363	2024-11-27	NULL	NULL
2	25	364	2024-11-27	NULL	NULL
2	25	365	2024-11-27	NULL	NULL
2	25	366	2024-11-27	NULL	NULL
2	4	357	2024-11-27	NULL	NULL
2	4	358	2024-11-27	NULL	NULL
2	4	359	2024-11-27	NULL	NULL
2	4	360	2024-11-27	NULL	NULL
2	4	361	2024-11-27	NULL	NULL
2	4	362	2024-11-27	NULL	NULL
2	4	363	2024-11-27	NULL	NULL
2	4	364	2024-11-27	NULL	NULL
2	4	365	2024-11-27	NULL	NULL
2	4	366	2024-11-27	NULL	NULL
2	24	367	2024-11-27	NULL	NULL
2	24	368	2024-11-27	NULL	NULL
2	24	369	2024-11-27	NULL	NULL
2	24	370	2024-11-27	NULL	NULL
2	24	371	2024-11-27	NULL	NULL
2	24	372	2024-11-27	NULL	NULL
2	24	373	2024-11-27	NULL	NULL
2	24	374	2024-11-27	NULL	NULL
2	24	375	2024-11-27	NULL	NULL
2	24	376	2024-11-27	NULL	NULL
2	24	547	2024-11-27	NULL	NULL
2	24	548	2024-11-27	NULL	NULL
2	24	549	2024-11-27	NULL	NULL
2	24	550	2024-11-27	NULL	NULL
2	24	551	2024-11-27	NULL	NULL
2	24	552	2024-11-27	NULL	NULL
2	24	553	2024-11-27	NULL	NULL
2	24	554	2024-11-27	NULL	NULL
2	24	555	2024-11-27	NULL	NULL
2	24	556	2024-11-27	NULL	NULL
2	5	367	2024-11-27	NULL	NULL
2	5	368	2024-11-27	NULL	NULL
2	5	369	2024-11-27	NULL	NULL
2	5	370	2024-11-27	NULL	NULL
2	5	371	2024-11-27	NULL	NULL
2	5	372	2024-11-27	NULL	NULL
2	5	373	2024-11-27	NULL	NULL
2	5	374	2024-11-27	NULL	NULL
2	5	375	2024-11-27	NULL	NULL
2	5	376	2024-11-27	NULL	NULL
2	5	547	2024-11-27	NULL	NULL
2	5	548	2024-11-27	NULL	NULL
2	5	549	2024-11-27	NULL	NULL
2	5	550	2024-11-27	NULL	NULL
2	5	551	2024-11-27	NULL	NULL
2	5	552	2024-11-27	NULL	NULL
2	5	553	2024-11-27	NULL	NULL
2	5	554	2024-11-27	NULL	NULL
2	5	555	2024-11-27	NULL	NULL
2	5	556	2024-11-27	NULL	NULL
2	25	367	2024-11-27	NULL	NULL
2	25	368	2024-11-27	NULL	NULL
2	25	369	2024-11-27	NULL	NULL
2	25	370	2024-11-27	NULL	NULL
2	25	371	2024-11-27	NULL	NULL
2	25	372	2024-11-27	NULL	NULL
2	25	373	2024-11-27	NULL	NULL
2	25	374	2024-11-27	NULL	NULL
2	25	375	2024-11-27	NULL	NULL
2	25	376	2024-11-27	NULL	NULL
2	25	547	2024-11-27	NULL	NULL
2	25	548	2024-11-27	NULL	NULL
2	25	549	2024-11-27	NULL	NULL
2	25	550	2024-11-27	NULL	NULL
2	25	551	2024-11-27	NULL	NULL
2	25	552	2024-11-27	NULL	NULL
2	25	553	2024-11-27	NULL	NULL
2	25	554	2024-11-27	NULL	NULL
2	25	555	2024-11-27	NULL	NULL
2	25	556	2024-11-27	NULL	NULL
2	26	367	2024-11-27	NULL	NULL
2	26	368	2024-11-27	NULL	NULL
2	26	369	2024-11-27	NULL	NULL
2	26	370	2024-11-27	NULL	NULL
2	26	371	2024-11-27	NULL	NULL
2	26	372	2024-11-27	NULL	NULL
2	26	373	2024-11-27	NULL	NULL
2	26	374	2024-11-27	NULL	NULL
2	26	375	2024-11-27	NULL	NULL
2	26	376	2024-11-27	NULL	NULL
2	26	547	2024-11-27	NULL	NULL
2	26	548	2024-11-27	NULL	NULL
2	26	549	2024-11-27	NULL	NULL
2	26	550	2024-11-27	NULL	NULL
2	26	551	2024-11-27	NULL	NULL
2	26	552	2024-11-27	NULL	NULL
2	26	553	2024-11-27	NULL	NULL
2	26	554	2024-11-27	NULL	NULL
2	26	555	2024-11-27	NULL	NULL
2	26	556	2024-11-27	NULL	NULL
2	4	367	2024-11-27	NULL	NULL
2	4	368	2024-11-27	NULL	NULL
2	4	369	2024-11-27	NULL	NULL
2	4	370	2024-11-27	NULL	NULL
2	4	371	2024-11-27	NULL	NULL
2	4	372	2024-11-27	NULL	NULL
2	4	373	2024-11-27	NULL	NULL
2	4	374	2024-11-27	NULL	NULL
2	4	375	2024-11-27	NULL	NULL
2	4	376	2024-11-27	NULL	NULL
2	4	547	2024-11-27	NULL	NULL
2	4	548	2024-11-27	NULL	NULL
2	4	549	2024-11-27	NULL	NULL
2	4	550	2024-11-27	NULL	NULL
2	4	551	2024-11-27	NULL	NULL
2	4	552	2024-11-27	NULL	NULL
2	4	553	2024-11-27	NULL	NULL
2	4	554	2024-11-27	NULL	NULL
2	4	555	2024-11-27	NULL	NULL
2	4	556	2024-11-27	NULL	NULL
2	3	367	2024-11-27	NULL	NULL
2	3	368	2024-11-27	NULL	NULL
2	3	369	2024-11-27	NULL	NULL
2	3	370	2024-11-27	NULL	NULL
2	3	371	2024-11-27	NULL	NULL
2	3	372	2024-11-27	NULL	NULL
2	3	373	2024-11-27	NULL	NULL
2	3	374	2024-11-27	NULL	NULL
2	3	375	2024-11-27	NULL	NULL
2	3	376	2024-11-27	NULL	NULL
2	3	547	2024-11-27	NULL	NULL
2	3	548	2024-11-27	NULL	NULL
2	3	549	2024-11-27	NULL	NULL
2	3	550	2024-11-27	NULL	NULL
2	3	551	2024-11-27	NULL	NULL
2	3	552	2024-11-27	NULL	NULL
2	3	553	2024-11-27	NULL	NULL
2	3	554	2024-11-27	NULL	NULL
2	3	555	2024-11-27	NULL	NULL
2	3	556	2024-11-27	NULL	NULL
1	22	557	2024-11-27	NULL	NULL
1	22	558	2024-11-27	NULL	NULL
1	22	559	2024-11-27	NULL	NULL
1	22	560	2024-11-27	NULL	NULL
1	22	561	2024-11-27	NULL	NULL
1	22	562	2024-11-27	NULL	NULL
1	29	563	2024-11-27	NULL	NULL
1	29	564	2024-11-27	NULL	NULL
1	29	565	2024-11-27	NULL	NULL
1	29	566	2024-11-27	NULL	NULL
1	29	567	2024-11-27	NULL	NULL
1	29	568	2024-11-27	NULL	NULL
1	4	563	2024-11-27	NULL	NULL
1	4	564	2024-11-27	NULL	NULL
1	4	565	2024-11-27	NULL	NULL
1	4	566	2024-11-27	NULL	NULL
1	4	567	2024-11-27	NULL	NULL
1	4	568	2024-11-27	NULL	NULL
1	2	569	2024-11-27	NULL	NULL
1	2	570	2024-11-27	NULL	NULL
1	2	571	2024-11-27	NULL	NULL
1	2	572	2024-11-27	NULL	NULL
1	2	573	2024-11-27	NULL	NULL
1	2	574	2024-11-27	NULL	NULL
1	3	569	2024-11-27	NULL	NULL
1	3	570	2024-11-27	NULL	NULL
1	3	571	2024-11-27	NULL	NULL
1	3	572	2024-11-27	NULL	NULL
1	3	573	2024-11-27	NULL	NULL
1	3	574	2024-11-27	NULL	NULL
1	4	569	2024-11-27	NULL	NULL
1	4	570	2024-11-27	NULL	NULL
1	4	571	2024-11-27	NULL	NULL
1	4	572	2024-11-27	NULL	NULL
1	4	573	2024-11-27	NULL	NULL
1	4	574	2024-11-27	NULL	NULL
1	22	557	2024-11-27	NULL	NULL
1	22	558	2024-11-27	NULL	NULL
1	22	559	2024-11-27	NULL	NULL
1	22	560	2024-11-27	NULL	NULL
1	22	561	2024-11-27	NULL	NULL
1	22	562	2024-11-27	NULL	NULL
1	22	575	2024-11-27	NULL	NULL
1	22	576	2024-11-27	NULL	NULL
1	22	577	2024-11-27	NULL	NULL
1	22	578	2024-11-27	NULL	NULL
1	22	579	2024-11-27	NULL	NULL
1	22	580	2024-11-27	NULL	NULL
1	29	563	2024-11-27	NULL	NULL
1	29	564	2024-11-27	NULL	NULL
1	29	565	2024-11-27	NULL	NULL
1	29	566	2024-11-27	NULL	NULL
1	29	567	2024-11-27	NULL	NULL
1	29	568	2024-11-27	NULL	NULL
1	29	581	2024-11-27	NULL	NULL
1	29	582	2024-11-27	NULL	NULL
1	29	583	2024-11-27	NULL	NULL
1	29	584	2024-11-27	NULL	NULL
1	29	585	2024-11-27	NULL	NULL
1	29	586	2024-11-27	NULL	NULL
1	4	563	2024-11-27	NULL	NULL
1	4	564	2024-11-27	NULL	NULL
1	4	565	2024-11-27	NULL	NULL
1	4	566	2024-11-27	NULL	NULL
1	4	567	2024-11-27	NULL	NULL
1	4	568	2024-11-27	NULL	NULL
1	4	581	2024-11-27	NULL	NULL
1	4	582	2024-11-27	NULL	NULL
1	4	583	2024-11-27	NULL	NULL
1	4	584	2024-11-27	NULL	NULL
1	4	585	2024-11-27	NULL	NULL
1	4	586	2024-11-27	NULL	NULL
3	22	587	2024-11-27	NULL	NULL
3	22	588	2024-11-27	NULL	NULL
3	22	589	2024-11-27	NULL	NULL
3	22	590	2024-11-27	NULL	NULL
3	22	591	2024-11-27	NULL	NULL
3	22	592	2024-11-27	NULL	NULL
3	29	593	2024-11-27	NULL	NULL
3	29	594	2024-11-27	NULL	NULL
3	29	595	2024-11-27	NULL	NULL
3	29	596	2024-11-27	NULL	NULL
3	29	597	2024-11-27	NULL	NULL
3	29	598	2024-11-27	NULL	NULL
3	4	593	2024-11-27	NULL	NULL
3	4	594	2024-11-27	NULL	NULL
3	4	595	2024-11-27	NULL	NULL
3	4	596	2024-11-27	NULL	NULL
3	4	597	2024-11-27	NULL	NULL
3	4	598	2024-11-27	NULL	NULL
3	22	587	2024-11-27	NULL	NULL
3	22	588	2024-11-27	NULL	NULL
3	22	589	2024-11-27	NULL	NULL
3	22	590	2024-11-27	NULL	NULL
3	22	591	2024-11-27	NULL	NULL
3	22	592	2024-11-27	NULL	NULL
3	22	599	2024-11-27	NULL	NULL
3	22	600	2024-11-27	NULL	NULL
3	22	601	2024-11-27	NULL	NULL
3	22	602	2024-11-27	NULL	NULL
3	29	593	2024-11-27	NULL	NULL
3	29	594	2024-11-27	NULL	NULL
3	29	595	2024-11-27	NULL	NULL
3	29	596	2024-11-27	NULL	NULL
3	29	597	2024-11-27	NULL	NULL
3	29	598	2024-11-27	NULL	NULL
3	29	603	2024-11-27	NULL	NULL
3	29	604	2024-11-27	NULL	NULL
3	29	605	2024-11-27	NULL	NULL
3	29	606	2024-11-27	NULL	NULL
3	29	607	2024-11-27	NULL	NULL
3	29	608	2024-11-27	NULL	NULL
3	4	593	2024-11-27	NULL	NULL
3	4	594	2024-11-27	NULL	NULL
3	4	595	2024-11-27	NULL	NULL
3	4	596	2024-11-27	NULL	NULL
3	4	597	2024-11-27	NULL	NULL
3	4	598	2024-11-27	NULL	NULL
3	4	603	2024-11-27	NULL	NULL
3	4	604	2024-11-27	NULL	NULL
3	4	605	2024-11-27	NULL	NULL
3	4	606	2024-11-27	NULL	NULL
3	4	607	2024-11-27	NULL	NULL
3	4	608	2024-11-27	NULL	NULL
1	22	557	2024-11-27	NULL	NULL
1	22	558	2024-11-27	NULL	NULL
1	22	559	2024-11-27	NULL	NULL
1	22	560	2024-11-27	NULL	NULL
1	22	561	2024-11-27	NULL	NULL
1	22	562	2024-11-27	NULL	NULL
1	22	575	2024-11-27	NULL	NULL
1	22	576	2024-11-27	NULL	NULL
1	22	577	2024-11-27	NULL	NULL
1	22	578	2024-11-27	NULL	NULL
1	22	579	2024-11-27	NULL	NULL
1	22	580	2024-11-27	NULL	NULL
1	22	609	2024-11-27	NULL	NULL
1	22	610	2024-11-27	NULL	NULL
1	22	611	2024-11-27	NULL	NULL
1	22	612	2024-11-27	NULL	NULL
1	22	613	2024-11-27	NULL	NULL
1	22	614	2024-11-27	NULL	NULL
1	29	563	2024-11-27	NULL	NULL
1	29	564	2024-11-27	NULL	NULL
1	29	565	2024-11-27	NULL	NULL
1	29	566	2024-11-27	NULL	NULL
1	29	567	2024-11-27	NULL	NULL
1	29	568	2024-11-27	NULL	NULL
1	29	581	2024-11-27	NULL	NULL
1	29	582	2024-11-27	NULL	NULL
1	29	583	2024-11-27	NULL	NULL
1	29	584	2024-11-27	NULL	NULL
1	29	585	2024-11-27	NULL	NULL
1	29	586	2024-11-27	NULL	NULL
1	29	615	2024-11-27	NULL	NULL
1	29	616	2024-11-27	NULL	NULL
1	29	617	2024-11-27	NULL	NULL
1	29	618	2024-11-27	NULL	NULL
1	29	619	2024-11-27	NULL	NULL
1	29	620	2024-11-27	NULL	NULL
1	4	563	2024-11-27	NULL	NULL
1	4	564	2024-11-27	NULL	NULL
1	4	565	2024-11-27	NULL	NULL
1	4	566	2024-11-27	NULL	NULL
1	4	567	2024-11-27	NULL	NULL
1	4	568	2024-11-27	NULL	NULL
1	4	581	2024-11-27	NULL	NULL
1	4	582	2024-11-27	NULL	NULL
1	4	583	2024-11-27	NULL	NULL
1	4	584	2024-11-27	NULL	NULL
1	4	585	2024-11-27	NULL	NULL
1	4	586	2024-11-27	NULL	NULL
1	4	615	2024-11-27	NULL	NULL
1	4	616	2024-11-27	NULL	NULL
1	4	617	2024-11-27	NULL	NULL
1	4	618	2024-11-27	NULL	NULL
1	4	619	2024-11-27	NULL	NULL
1	4	620	2024-11-27	NULL	NULL
1	22	557	2024-11-27	NULL	NULL
1	22	558	2024-11-27	NULL	NULL
1	22	559	2024-11-27	NULL	NULL
1	22	560	2024-11-27	NULL	NULL
1	22	561	2024-11-27	NULL	NULL
1	22	562	2024-11-27	NULL	NULL
1	22	575	2024-11-27	NULL	NULL
1	22	576	2024-11-27	NULL	NULL
1	22	577	2024-11-27	NULL	NULL
1	22	578	2024-11-27	NULL	NULL
1	22	579	2024-11-27	NULL	NULL
1	22	580	2024-11-27	NULL	NULL
1	22	609	2024-11-27	NULL	NULL
1	22	610	2024-11-27	NULL	NULL
1	22	611	2024-11-27	NULL	NULL
1	22	612	2024-11-27	NULL	NULL
1	22	613	2024-11-27	NULL	NULL
1	22	614	2024-11-27	NULL	NULL
1	22	621	2024-11-27	NULL	NULL
1	22	622	2024-11-27	NULL	NULL
1	22	623	2024-11-27	NULL	NULL
1	22	624	2024-11-27	NULL	NULL
1	22	625	2024-11-27	NULL	NULL
1	22	626	2024-11-27	NULL	NULL
1	29	563	2024-11-27	NULL	NULL
1	29	564	2024-11-27	NULL	NULL
1	29	565	2024-11-27	NULL	NULL
1	29	566	2024-11-27	NULL	NULL
1	29	567	2024-11-27	NULL	NULL
1	29	568	2024-11-27	NULL	NULL
1	29	581	2024-11-27	NULL	NULL
1	29	582	2024-11-27	NULL	NULL
1	29	583	2024-11-27	NULL	NULL
1	29	584	2024-11-27	NULL	NULL
1	29	585	2024-11-27	NULL	NULL
1	29	586	2024-11-27	NULL	NULL
1	29	615	2024-11-27	NULL	NULL
1	29	616	2024-11-27	NULL	NULL
1	29	617	2024-11-27	NULL	NULL
1	29	618	2024-11-27	NULL	NULL
1	29	619	2024-11-27	NULL	NULL
1	29	620	2024-11-27	NULL	NULL
1	29	627	2024-11-27	NULL	NULL
1	29	628	2024-11-27	NULL	NULL
1	29	629	2024-11-27	NULL	NULL
1	29	630	2024-11-27	NULL	NULL
1	29	631	2024-11-27	NULL	NULL
1	29	632	2024-11-27	NULL	NULL
1	4	563	2024-11-27	NULL	NULL
1	4	564	2024-11-27	NULL	NULL
1	4	565	2024-11-27	NULL	NULL
1	4	566	2024-11-27	NULL	NULL
1	4	567	2024-11-27	NULL	NULL
1	4	568	2024-11-27	NULL	NULL
1	4	581	2024-11-27	NULL	NULL
1	4	582	2024-11-27	NULL	NULL
1	4	583	2024-11-27	NULL	NULL
1	4	584	2024-11-27	NULL	NULL
1	4	585	2024-11-27	NULL	NULL
1	4	586	2024-11-27	NULL	NULL
1	4	615	2024-11-27	NULL	NULL
1	4	616	2024-11-27	NULL	NULL
1	4	617	2024-11-27	NULL	NULL
1	4	618	2024-11-27	NULL	NULL
1	4	619	2024-11-27	NULL	NULL
1	4	620	2024-11-27	NULL	NULL
1	4	627	2024-11-27	NULL	NULL
1	4	628	2024-11-27	NULL	NULL
1	4	629	2024-11-27	NULL	NULL
1	4	630	2024-11-27	NULL	NULL
1	4	631	2024-11-27	NULL	NULL
1	4	632	2024-11-27	NULL	NULL
1	22	557	2024-11-27	NULL	NULL
1	22	558	2024-11-27	NULL	NULL
1	22	559	2024-11-27	NULL	NULL
1	22	560	2024-11-27	NULL	NULL
1	22	561	2024-11-27	NULL	NULL
1	22	562	2024-11-27	NULL	NULL
1	22	575	2024-11-27	NULL	NULL
1	22	576	2024-11-27	NULL	NULL
1	22	577	2024-11-27	NULL	NULL
1	22	578	2024-11-27	NULL	NULL
1	22	579	2024-11-27	NULL	NULL
1	22	580	2024-11-27	NULL	NULL
1	22	609	2024-11-27	NULL	NULL
1	22	610	2024-11-27	NULL	NULL
1	22	611	2024-11-27	NULL	NULL
1	22	612	2024-11-27	NULL	NULL
1	22	613	2024-11-27	NULL	NULL
1	22	614	2024-11-27	NULL	NULL
1	22	621	2024-11-27	NULL	NULL
1	22	622	2024-11-27	NULL	NULL
1	22	623	2024-11-27	NULL	NULL
1	22	624	2024-11-27	NULL	NULL
1	22	625	2024-11-27	NULL	NULL
1	22	626	2024-11-27	NULL	NULL
1	22	633	2024-11-27	NULL	NULL
1	22	634	2024-11-27	NULL	NULL
1	22	635	2024-11-27	NULL	NULL
1	22	636	2024-11-27	NULL	NULL
1	22	637	2024-11-27	NULL	NULL
1	22	638	2024-11-27	NULL	NULL
1	29	563	2024-11-27	NULL	NULL
1	29	564	2024-11-27	NULL	NULL
1	29	565	2024-11-27	NULL	NULL
1	29	566	2024-11-27	NULL	NULL
1	29	567	2024-11-27	NULL	NULL
1	29	568	2024-11-27	NULL	NULL
1	29	581	2024-11-27	NULL	NULL
1	29	582	2024-11-27	NULL	NULL
1	29	583	2024-11-27	NULL	NULL
1	29	584	2024-11-27	NULL	NULL
1	29	585	2024-11-27	NULL	NULL
1	29	586	2024-11-27	NULL	NULL
1	29	615	2024-11-27	NULL	NULL
1	29	616	2024-11-27	NULL	NULL
1	29	617	2024-11-27	NULL	NULL
1	29	618	2024-11-27	NULL	NULL
1	29	619	2024-11-27	NULL	NULL
1	29	620	2024-11-27	NULL	NULL
1	29	627	2024-11-27	NULL	NULL
1	29	628	2024-11-27	NULL	NULL
1	29	629	2024-11-27	NULL	NULL
1	29	630	2024-11-27	NULL	NULL
1	29	631	2024-11-27	NULL	NULL
1	29	632	2024-11-27	NULL	NULL
1	29	639	2024-11-27	NULL	NULL
1	29	640	2024-11-27	NULL	NULL
1	29	641	2024-11-27	NULL	NULL
1	29	642	2024-11-27	NULL	NULL
1	29	643	2024-11-27	NULL	NULL
1	29	644	2024-11-27	NULL	NULL
1	4	563	2024-11-27	NULL	NULL
1	4	564	2024-11-27	NULL	NULL
1	4	565	2024-11-27	NULL	NULL
1	4	566	2024-11-27	NULL	NULL
1	4	567	2024-11-27	NULL	NULL
1	4	568	2024-11-27	NULL	NULL
1	4	581	2024-11-27	NULL	NULL
1	4	582	2024-11-27	NULL	NULL
1	4	583	2024-11-27	NULL	NULL
1	4	584	2024-11-27	NULL	NULL
1	4	585	2024-11-27	NULL	NULL
1	4	586	2024-11-27	NULL	NULL
1	4	615	2024-11-27	NULL	NULL
1	4	616	2024-11-27	NULL	NULL
1	4	617	2024-11-27	NULL	NULL
1	4	618	2024-11-27	NULL	NULL
1	4	619	2024-11-27	NULL	NULL
1	4	620	2024-11-27	NULL	NULL
1	4	627	2024-11-27	NULL	NULL
1	4	628	2024-11-27	NULL	NULL
1	4	629	2024-11-27	NULL	NULL
1	4	630	2024-11-27	NULL	NULL
1	4	631	2024-11-27	NULL	NULL
1	4	632	2024-11-27	NULL	NULL
1	4	639	2024-11-27	NULL	NULL
1	4	640	2024-11-27	NULL	NULL
1	4	641	2024-11-27	NULL	NULL
1	4	642	2024-11-27	NULL	NULL
1	4	643	2024-11-27	NULL	NULL
1	4	644	2024-11-27	NULL	NULL
1	22	557	2024-11-27	NULL	NULL
1	22	558	2024-11-27	NULL	NULL
1	22	559	2024-11-27	NULL	NULL
1	22	560	2024-11-27	NULL	NULL
1	22	561	2024-11-27	NULL	NULL
1	22	562	2024-11-27	NULL	NULL
1	22	575	2024-11-27	NULL	NULL
1	22	576	2024-11-27	NULL	NULL
1	22	577	2024-11-27	NULL	NULL
1	22	578	2024-11-27	NULL	NULL
1	22	579	2024-11-27	NULL	NULL
1	22	580	2024-11-27	NULL	NULL
1	22	609	2024-11-27	NULL	NULL
1	22	610	2024-11-27	NULL	NULL
1	22	611	2024-11-27	NULL	NULL
1	22	612	2024-11-27	NULL	NULL
1	22	613	2024-11-27	NULL	NULL
1	22	614	2024-11-27	NULL	NULL
1	22	621	2024-11-27	NULL	NULL
1	22	622	2024-11-27	NULL	NULL
1	22	623	2024-11-27	NULL	NULL
1	22	624	2024-11-27	NULL	NULL
1	22	625	2024-11-27	NULL	NULL
1	22	626	2024-11-27	NULL	NULL
1	22	633	2024-11-27	NULL	NULL
1	22	634	2024-11-27	NULL	NULL
1	22	635	2024-11-27	NULL	NULL
1	22	636	2024-11-27	NULL	NULL
1	22	637	2024-11-27	NULL	NULL
1	22	638	2024-11-27	NULL	NULL
1	22	645	2024-11-27	NULL	NULL
1	22	646	2024-11-27	NULL	NULL
1	22	647	2024-11-27	NULL	NULL
1	22	648	2024-11-27	NULL	NULL
1	22	649	2024-11-27	NULL	NULL
1	22	650	2024-11-27	NULL	NULL
1	29	563	2024-11-27	NULL	NULL
1	29	564	2024-11-27	NULL	NULL
1	29	565	2024-11-27	NULL	NULL
1	29	566	2024-11-27	NULL	NULL
1	29	567	2024-11-27	NULL	NULL
1	29	568	2024-11-27	NULL	NULL
1	29	581	2024-11-27	NULL	NULL
1	29	582	2024-11-27	NULL	NULL
1	29	583	2024-11-27	NULL	NULL
1	29	584	2024-11-27	NULL	NULL
1	29	585	2024-11-27	NULL	NULL
1	29	586	2024-11-27	NULL	NULL
1	29	615	2024-11-27	NULL	NULL
1	29	616	2024-11-27	NULL	NULL
1	29	617	2024-11-27	NULL	NULL
1	29	618	2024-11-27	NULL	NULL
1	29	619	2024-11-27	NULL	NULL
1	29	620	2024-11-27	NULL	NULL
1	29	627	2024-11-27	NULL	NULL
1	29	628	2024-11-27	NULL	NULL
1	29	629	2024-11-27	NULL	NULL
1	29	630	2024-11-27	NULL	NULL
1	29	631	2024-11-27	NULL	NULL
1	29	632	2024-11-27	NULL	NULL
1	29	639	2024-11-27	NULL	NULL
1	29	640	2024-11-27	NULL	NULL
1	29	641	2024-11-27	NULL	NULL
1	29	642	2024-11-27	NULL	NULL
1	29	643	2024-11-27	NULL	NULL
1	29	644	2024-11-27	NULL	NULL
1	29	651	2024-11-27	NULL	NULL
1	29	652	2024-11-27	NULL	NULL
1	29	653	2024-11-27	NULL	NULL
1	29	654	2024-11-27	NULL	NULL
1	29	655	2024-11-27	NULL	NULL
1	29	656	2024-11-27	NULL	NULL
1	4	563	2024-11-27	NULL	NULL
1	4	564	2024-11-27	NULL	NULL
1	4	565	2024-11-27	NULL	NULL
1	4	566	2024-11-27	NULL	NULL
1	4	567	2024-11-27	NULL	NULL
1	4	568	2024-11-27	NULL	NULL
1	4	581	2024-11-27	NULL	NULL
1	4	582	2024-11-27	NULL	NULL
1	4	583	2024-11-27	NULL	NULL
1	4	584	2024-11-27	NULL	NULL
1	4	585	2024-11-27	NULL	NULL
1	4	586	2024-11-27	NULL	NULL
1	4	615	2024-11-27	NULL	NULL
1	4	616	2024-11-27	NULL	NULL
1	4	617	2024-11-27	NULL	NULL
1	4	618	2024-11-27	NULL	NULL
1	4	619	2024-11-27	NULL	NULL
1	4	620	2024-11-27	NULL	NULL
1	4	627	2024-11-27	NULL	NULL
1	4	628	2024-11-27	NULL	NULL
1	4	629	2024-11-27	NULL	NULL
1	4	630	2024-11-27	NULL	NULL
1	4	631	2024-11-27	NULL	NULL
1	4	632	2024-11-27	NULL	NULL
1	4	639	2024-11-27	NULL	NULL
1	4	640	2024-11-27	NULL	NULL
1	4	641	2024-11-27	NULL	NULL
1	4	642	2024-11-27	NULL	NULL
1	4	643	2024-11-27	NULL	NULL
1	4	644	2024-11-27	NULL	NULL
1	4	651	2024-11-27	NULL	NULL
1	4	652	2024-11-27	NULL	NULL
1	4	653	2024-11-27	NULL	NULL
1	4	654	2024-11-27	NULL	NULL
1	4	655	2024-11-27	NULL	NULL
1	4	656	2024-11-27	NULL	NULL
1	22	657	2024-11-27	NULL	NULL
1	22	658	2024-11-27	NULL	NULL
1	22	659	2024-11-27	NULL	NULL
1	22	660	2024-11-27	NULL	NULL
1	22	661	2024-11-27	NULL	NULL
1	22	662	2024-11-27	NULL	NULL
1	22	663	2024-11-27	NULL	NULL
1	22	664	2024-11-27	NULL	NULL
1	22	665	2024-11-27	NULL	NULL
1	22	666	2024-11-27	NULL	NULL
1	22	667	2024-11-27	NULL	NULL
1	22	668	2024-11-27	NULL	NULL
1	29	669	2024-11-27	NULL	NULL
1	29	670	2024-11-27	NULL	NULL
1	29	671	2024-11-27	NULL	NULL
1	29	672	2024-11-27	NULL	NULL
1	29	673	2024-11-27	NULL	NULL
1	29	674	2024-11-27	NULL	NULL
1	29	675	2024-11-27	NULL	NULL
1	29	676	2024-11-27	NULL	NULL
1	29	677	2024-11-27	NULL	NULL
1	29	678	2024-11-27	NULL	NULL
1	29	679	2024-11-27	NULL	NULL
1	29	680	2024-11-27	NULL	NULL
1	4	669	2024-11-27	NULL	NULL
1	4	670	2024-11-27	NULL	NULL
1	4	671	2024-11-27	NULL	NULL
1	4	672	2024-11-27	NULL	NULL
1	4	673	2024-11-27	NULL	NULL
1	4	674	2024-11-27	NULL	NULL
1	4	675	2024-11-27	NULL	NULL
1	4	676	2024-11-27	NULL	NULL
1	4	677	2024-11-27	NULL	NULL
1	4	678	2024-11-27	NULL	NULL
1	4	679	2024-11-27	NULL	NULL
1	4	680	2024-11-27	NULL	NULL
1	2	681	2024-11-27	NULL	NULL
1	2	682	2024-11-27	NULL	NULL
1	2	683	2024-11-27	NULL	NULL
1	2	684	2024-11-27	NULL	NULL
1	2	685	2024-11-27	NULL	NULL
1	2	686	2024-11-27	NULL	NULL
1	3	681	2024-11-27	NULL	NULL
1	3	682	2024-11-27	NULL	NULL
1	3	683	2024-11-27	NULL	NULL
1	3	684	2024-11-27	NULL	NULL
1	3	685	2024-11-27	NULL	NULL
1	3	686	2024-11-27	NULL	NULL
1	4	681	2024-11-27	NULL	NULL
1	4	682	2024-11-27	NULL	NULL
1	4	683	2024-11-27	NULL	NULL
1	4	684	2024-11-27	NULL	NULL
1	4	685	2024-11-27	NULL	NULL
1	4	686	2024-11-27	NULL	NULL
1	27	126	2024-11-27	NULL	NULL
1	27	127	2024-11-27	NULL	NULL
1	27	128	2024-11-27	NULL	NULL
1	27	129	2024-11-27	NULL	NULL
1	27	130	2024-11-27	NULL	NULL
1	27	131	2024-11-27	NULL	NULL
1	27	132	2024-11-27	NULL	NULL
1	27	164	2024-11-27	NULL	NULL
1	27	165	2024-11-27	NULL	NULL
1	27	166	2024-11-27	NULL	NULL
1	27	167	2024-11-27	NULL	NULL
1	27	168	2024-11-27	NULL	NULL
1	27	169	2024-11-27	NULL	NULL
1	27	687	2024-11-27	NULL	NULL
1	27	688	2024-11-27	NULL	NULL
1	27	689	2024-11-27	NULL	NULL
1	27	690	2024-11-27	NULL	NULL
1	27	691	2024-11-27	NULL	NULL
1	27	692	2024-11-27	NULL	NULL
1	27	693	2024-11-27	NULL	NULL
1	23	126	2024-11-27	NULL	NULL
1	23	127	2024-11-27	NULL	NULL
1	23	128	2024-11-27	NULL	NULL
1	23	129	2024-11-27	NULL	NULL
1	23	130	2024-11-27	NULL	NULL
1	23	131	2024-11-27	NULL	NULL
1	23	132	2024-11-27	NULL	NULL
1	23	164	2024-11-27	NULL	NULL
1	23	165	2024-11-27	NULL	NULL
1	23	166	2024-11-27	NULL	NULL
1	23	167	2024-11-27	NULL	NULL
1	23	168	2024-11-27	NULL	NULL
1	23	169	2024-11-27	NULL	NULL
1	23	687	2024-11-27	NULL	NULL
1	23	688	2024-11-27	NULL	NULL
1	23	689	2024-11-27	NULL	NULL
1	23	690	2024-11-27	NULL	NULL
1	23	691	2024-11-27	NULL	NULL
1	23	692	2024-11-27	NULL	NULL
1	23	693	2024-11-27	NULL	NULL
1	27	133	2024-11-27	NULL	NULL
1	27	134	2024-11-27	NULL	NULL
1	27	135	2024-11-27	NULL	NULL
1	27	136	2024-11-27	NULL	NULL
1	27	137	2024-11-27	NULL	NULL
1	27	138	2024-11-27	NULL	NULL
1	27	170	2024-11-27	NULL	NULL
1	27	171	2024-11-27	NULL	NULL
1	27	172	2024-11-27	NULL	NULL
1	27	173	2024-11-27	NULL	NULL
1	27	174	2024-11-27	NULL	NULL
1	27	175	2024-11-27	NULL	NULL
1	27	694	2024-11-27	NULL	NULL
1	27	695	2024-11-27	NULL	NULL
1	27	696	2024-11-27	NULL	NULL
1	27	697	2024-11-27	NULL	NULL
1	27	698	2024-11-27	NULL	NULL
1	27	699	2024-11-27	NULL	NULL
1	25	133	2024-11-27	NULL	NULL
1	25	134	2024-11-27	NULL	NULL
1	25	135	2024-11-27	NULL	NULL
1	25	136	2024-11-27	NULL	NULL
1	25	137	2024-11-27	NULL	NULL
1	25	138	2024-11-27	NULL	NULL
1	25	170	2024-11-27	NULL	NULL
1	25	171	2024-11-27	NULL	NULL
1	25	172	2024-11-27	NULL	NULL
1	25	173	2024-11-27	NULL	NULL
1	25	174	2024-11-27	NULL	NULL
1	25	175	2024-11-27	NULL	NULL
1	25	694	2024-11-27	NULL	NULL
1	25	695	2024-11-27	NULL	NULL
1	25	696	2024-11-27	NULL	NULL
1	25	697	2024-11-27	NULL	NULL
1	25	698	2024-11-27	NULL	NULL
1	25	699	2024-11-27	NULL	NULL
1	4	133	2024-11-27	NULL	NULL
1	4	134	2024-11-27	NULL	NULL
1	4	135	2024-11-27	NULL	NULL
1	4	136	2024-11-27	NULL	NULL
1	4	137	2024-11-27	NULL	NULL
1	4	138	2024-11-27	NULL	NULL
1	4	170	2024-11-27	NULL	NULL
1	4	171	2024-11-27	NULL	NULL
1	4	172	2024-11-27	NULL	NULL
1	4	173	2024-11-27	NULL	NULL
1	4	174	2024-11-27	NULL	NULL
1	4	175	2024-11-27	NULL	NULL
1	4	694	2024-11-27	NULL	NULL
1	4	695	2024-11-27	NULL	NULL
1	4	696	2024-11-27	NULL	NULL
1	4	697	2024-11-27	NULL	NULL
1	4	698	2024-11-27	NULL	NULL
1	4	699	2024-11-27	NULL	NULL
1	24	139	2024-11-27	NULL	NULL
1	24	140	2024-11-27	NULL	NULL
1	24	141	2024-11-27	NULL	NULL
1	24	142	2024-11-27	NULL	NULL
1	24	143	2024-11-27	NULL	NULL
1	24	144	2024-11-27	NULL	NULL
1	24	145	2024-11-27	NULL	NULL
1	24	700	2024-11-27	NULL	NULL
1	24	701	2024-11-27	NULL	NULL
1	24	702	2024-11-27	NULL	NULL
1	24	703	2024-11-27	NULL	NULL
1	24	704	2024-11-27	NULL	NULL
1	24	705	2024-11-27	NULL	NULL
1	24	706	2024-11-27	NULL	NULL
1	5	139	2024-11-27	NULL	NULL
1	5	140	2024-11-27	NULL	NULL
1	5	141	2024-11-27	NULL	NULL
1	5	142	2024-11-27	NULL	NULL
1	5	143	2024-11-27	NULL	NULL
1	5	144	2024-11-27	NULL	NULL
1	5	145	2024-11-27	NULL	NULL
1	5	700	2024-11-27	NULL	NULL
1	5	701	2024-11-27	NULL	NULL
1	5	702	2024-11-27	NULL	NULL
1	5	703	2024-11-27	NULL	NULL
1	5	704	2024-11-27	NULL	NULL
1	5	705	2024-11-27	NULL	NULL
1	5	706	2024-11-27	NULL	NULL
1	25	139	2024-11-27	NULL	NULL
1	25	140	2024-11-27	NULL	NULL
1	25	141	2024-11-27	NULL	NULL
1	25	142	2024-11-27	NULL	NULL
1	25	143	2024-11-27	NULL	NULL
1	25	144	2024-11-27	NULL	NULL
1	25	145	2024-11-27	NULL	NULL
1	25	700	2024-11-27	NULL	NULL
1	25	701	2024-11-27	NULL	NULL
1	25	702	2024-11-27	NULL	NULL
1	25	703	2024-11-27	NULL	NULL
1	25	704	2024-11-27	NULL	NULL
1	25	705	2024-11-27	NULL	NULL
1	25	706	2024-11-27	NULL	NULL
1	26	139	2024-11-27	NULL	NULL
1	26	140	2024-11-27	NULL	NULL
1	26	141	2024-11-27	NULL	NULL
1	26	142	2024-11-27	NULL	NULL
1	26	143	2024-11-27	NULL	NULL
1	26	144	2024-11-27	NULL	NULL
1	26	145	2024-11-27	NULL	NULL
1	26	700	2024-11-27	NULL	NULL
1	26	701	2024-11-27	NULL	NULL
1	26	702	2024-11-27	NULL	NULL
1	26	703	2024-11-27	NULL	NULL
1	26	704	2024-11-27	NULL	NULL
1	26	705	2024-11-27	NULL	NULL
1	26	706	2024-11-27	NULL	NULL
1	4	139	2024-11-27	NULL	NULL
1	4	140	2024-11-27	NULL	NULL
1	4	141	2024-11-27	NULL	NULL
1	4	142	2024-11-27	NULL	NULL
1	4	143	2024-11-27	NULL	NULL
1	4	144	2024-11-27	NULL	NULL
1	4	145	2024-11-27	NULL	NULL
1	4	700	2024-11-27	NULL	NULL
1	4	701	2024-11-27	NULL	NULL
1	4	702	2024-11-27	NULL	NULL
1	4	703	2024-11-27	NULL	NULL
1	4	704	2024-11-27	NULL	NULL
1	4	705	2024-11-27	NULL	NULL
1	4	706	2024-11-27	NULL	NULL
1	3	139	2024-11-27	NULL	NULL
1	3	140	2024-11-27	NULL	NULL
1	3	141	2024-11-27	NULL	NULL
1	3	142	2024-11-27	NULL	NULL
1	3	143	2024-11-27	NULL	NULL
1	3	144	2024-11-27	NULL	NULL
1	3	145	2024-11-27	NULL	NULL
1	3	700	2024-11-27	NULL	NULL
1	3	701	2024-11-27	NULL	NULL
1	3	702	2024-11-27	NULL	NULL
1	3	703	2024-11-27	NULL	NULL
1	3	704	2024-11-27	NULL	NULL
1	3	705	2024-11-27	NULL	NULL
1	3	706	2024-11-27	NULL	NULL
1	28	146	2024-11-27	NULL	NULL
1	28	147	2024-11-27	NULL	NULL
1	28	148	2024-11-27	NULL	NULL
1	28	149	2024-11-27	NULL	NULL
1	28	150	2024-11-27	NULL	NULL
1	28	151	2024-11-27	NULL	NULL
1	28	707	2024-11-27	NULL	NULL
1	28	708	2024-11-27	NULL	NULL
1	28	709	2024-11-27	NULL	NULL
1	28	710	2024-11-27	NULL	NULL
1	28	711	2024-11-27	NULL	NULL
1	28	712	2024-11-27	NULL	NULL
1	31	713	2024-11-27	NULL	NULL
1	31	714	2024-11-27	NULL	NULL
1	31	715	2024-11-27	NULL	NULL
1	31	716	2024-11-27	NULL	NULL
1	31	717	2024-11-27	NULL	NULL
1	31	718	2024-11-27	NULL	NULL
1	31	719	2024-11-27	NULL	NULL
1	31	720	2024-11-27	NULL	NULL
1	31	721	2024-11-27	NULL	NULL
1	31	722	2024-11-27	NULL	NULL
1	31	723	2024-11-27	NULL	NULL
1	31	724	2024-11-27	NULL	NULL
1	31	725	2024-11-27	NULL	NULL
1	31	726	2024-11-27	NULL	NULL
1	31	727	2024-11-27	NULL	NULL
1	31	728	2024-11-27	NULL	NULL
1	31	729	2024-11-27	NULL	NULL
1	31	730	2024-11-27	NULL	NULL
1	32	731	2024-11-27	NULL	NULL
1	32	732	2024-11-27	NULL	NULL
1	32	733	2024-11-27	NULL	NULL
1	32	734	2024-11-27	NULL	NULL
1	32	735	2024-11-27	NULL	NULL
1	32	736	2024-11-27	NULL	NULL
1	32	737	2024-11-27	NULL	NULL
1	32	738	2024-11-27	NULL	NULL
1	32	739	2024-11-27	NULL	NULL
1	32	740	2024-11-27	NULL	NULL
1	32	741	2024-11-27	NULL	NULL
1	32	742	2024-11-27	NULL	NULL
1	32	743	2024-11-27	NULL	NULL
1	32	744	2024-11-27	NULL	NULL
1	32	745	2024-11-27	NULL	NULL
1	32	746	2024-11-27	NULL	NULL
1	32	747	2024-11-27	NULL	NULL
1	32	748	2024-11-27	NULL	NULL
1	34	731	2024-11-27	NULL	NULL
1	34	732	2024-11-27	NULL	NULL
1	34	733	2024-11-27	NULL	NULL
1	34	734	2024-11-27	NULL	NULL
1	34	735	2024-11-27	NULL	NULL
1	34	736	2024-11-27	NULL	NULL
1	34	737	2024-11-27	NULL	NULL
1	34	738	2024-11-27	NULL	NULL
1	34	739	2024-11-27	NULL	NULL
1	34	740	2024-11-27	NULL	NULL
1	34	741	2024-11-27	NULL	NULL
1	34	742	2024-11-27	NULL	NULL
1	34	743	2024-11-27	NULL	NULL
1	34	744	2024-11-27	NULL	NULL
1	34	745	2024-11-27	NULL	NULL
1	34	746	2024-11-27	NULL	NULL
1	34	747	2024-11-27	NULL	NULL
1	34	748	2024-11-27	NULL	NULL
1	41	731	2024-11-27	NULL	NULL
1	41	732	2024-11-27	NULL	NULL
1	41	733	2024-11-27	NULL	NULL
1	41	734	2024-11-27	NULL	NULL
1	41	735	2024-11-27	NULL	NULL
1	41	736	2024-11-27	NULL	NULL
1	41	737	2024-11-27	NULL	NULL
1	41	738	2024-11-27	NULL	NULL
1	41	739	2024-11-27	NULL	NULL
1	41	740	2024-11-27	NULL	NULL
1	41	741	2024-11-27	NULL	NULL
1	41	742	2024-11-27	NULL	NULL
1	41	743	2024-11-27	NULL	NULL
1	41	744	2024-11-27	NULL	NULL
1	41	745	2024-11-27	NULL	NULL
1	41	746	2024-11-27	NULL	NULL
1	41	747	2024-11-27	NULL	NULL
1	41	748	2024-11-27	NULL	NULL
1	37	731	2024-11-27	NULL	NULL
1	37	732	2024-11-27	NULL	NULL
1	37	733	2024-11-27	NULL	NULL
1	37	734	2024-11-27	NULL	NULL
1	37	735	2024-11-27	NULL	NULL
1	37	736	2024-11-27	NULL	NULL
1	37	737	2024-11-27	NULL	NULL
1	37	738	2024-11-27	NULL	NULL
1	37	739	2024-11-27	NULL	NULL
1	37	740	2024-11-27	NULL	NULL
1	37	741	2024-11-27	NULL	NULL
1	37	742	2024-11-27	NULL	NULL
1	37	743	2024-11-27	NULL	NULL
1	37	744	2024-11-27	NULL	NULL
1	37	745	2024-11-27	NULL	NULL
1	37	746	2024-11-27	NULL	NULL
1	37	747	2024-11-27	NULL	NULL
1	37	748	2024-11-27	NULL	NULL
1	42	731	2024-11-27	NULL	NULL
1	42	732	2024-11-27	NULL	NULL
1	42	733	2024-11-27	NULL	NULL
1	42	734	2024-11-27	NULL	NULL
1	42	735	2024-11-27	NULL	NULL
1	42	736	2024-11-27	NULL	NULL
1	42	737	2024-11-27	NULL	NULL
1	42	738	2024-11-27	NULL	NULL
1	42	739	2024-11-27	NULL	NULL
1	42	740	2024-11-27	NULL	NULL
1	42	741	2024-11-27	NULL	NULL
1	42	742	2024-11-27	NULL	NULL
1	42	743	2024-11-27	NULL	NULL
1	42	744	2024-11-27	NULL	NULL
1	42	745	2024-11-27	NULL	NULL
1	42	746	2024-11-27	NULL	NULL
1	42	747	2024-11-27	NULL	NULL
1	42	748	2024-11-27	NULL	NULL
1	32	749	2024-11-27	NULL	NULL
1	32	750	2024-11-27	NULL	NULL
1	32	751	2024-11-27	NULL	NULL
1	32	752	2024-11-27	NULL	NULL
1	32	753	2024-11-27	NULL	NULL
1	32	754	2024-11-27	NULL	NULL
1	32	755	2024-11-27	NULL	NULL
1	32	756	2024-11-27	NULL	NULL
1	32	757	2024-11-27	NULL	NULL
1	32	758	2024-11-27	NULL	NULL
1	32	759	2024-11-27	NULL	NULL
1	32	760	2024-11-27	NULL	NULL
1	32	761	2024-11-27	NULL	NULL
1	32	762	2024-11-27	NULL	NULL
1	32	763	2024-11-27	NULL	NULL
1	32	764	2024-11-27	NULL	NULL
1	32	765	2024-11-27	NULL	NULL
1	32	766	2024-11-27	NULL	NULL
1	34	749	2024-11-27	NULL	NULL
1	34	750	2024-11-27	NULL	NULL
1	34	751	2024-11-27	NULL	NULL
1	34	752	2024-11-27	NULL	NULL
1	34	753	2024-11-27	NULL	NULL
1	34	754	2024-11-27	NULL	NULL
1	34	755	2024-11-27	NULL	NULL
1	34	756	2024-11-27	NULL	NULL
1	34	757	2024-11-27	NULL	NULL
1	34	758	2024-11-27	NULL	NULL
1	34	759	2024-11-27	NULL	NULL
1	34	760	2024-11-27	NULL	NULL
1	34	761	2024-11-27	NULL	NULL
1	34	762	2024-11-27	NULL	NULL
1	34	763	2024-11-27	NULL	NULL
1	34	764	2024-11-27	NULL	NULL
1	34	765	2024-11-27	NULL	NULL
1	34	766	2024-11-27	NULL	NULL
1	35	749	2024-11-27	NULL	NULL
1	35	750	2024-11-27	NULL	NULL
1	35	751	2024-11-27	NULL	NULL
1	35	752	2024-11-27	NULL	NULL
1	35	753	2024-11-27	NULL	NULL
1	35	754	2024-11-27	NULL	NULL
1	35	755	2024-11-27	NULL	NULL
1	35	756	2024-11-27	NULL	NULL
1	35	757	2024-11-27	NULL	NULL
1	35	758	2024-11-27	NULL	NULL
1	35	759	2024-11-27	NULL	NULL
1	35	760	2024-11-27	NULL	NULL
1	35	761	2024-11-27	NULL	NULL
1	35	762	2024-11-27	NULL	NULL
1	35	763	2024-11-27	NULL	NULL
1	35	764	2024-11-27	NULL	NULL
1	35	765	2024-11-27	NULL	NULL
1	35	766	2024-11-27	NULL	NULL
1	36	749	2024-11-27	NULL	NULL
1	36	750	2024-11-27	NULL	NULL
1	36	751	2024-11-27	NULL	NULL
1	36	752	2024-11-27	NULL	NULL
1	36	753	2024-11-27	NULL	NULL
1	36	754	2024-11-27	NULL	NULL
1	36	755	2024-11-27	NULL	NULL
1	36	756	2024-11-27	NULL	NULL
1	36	757	2024-11-27	NULL	NULL
1	36	758	2024-11-27	NULL	NULL
1	36	759	2024-11-27	NULL	NULL
1	36	760	2024-11-27	NULL	NULL
1	36	761	2024-11-27	NULL	NULL
1	36	762	2024-11-27	NULL	NULL
1	36	763	2024-11-27	NULL	NULL
1	36	764	2024-11-27	NULL	NULL
1	36	765	2024-11-27	NULL	NULL
1	36	766	2024-11-27	NULL	NULL
1	37	749	2024-11-27	NULL	NULL
1	37	750	2024-11-27	NULL	NULL
1	37	751	2024-11-27	NULL	NULL
1	37	752	2024-11-27	NULL	NULL
1	37	753	2024-11-27	NULL	NULL
1	37	754	2024-11-27	NULL	NULL
1	37	755	2024-11-27	NULL	NULL
1	37	756	2024-11-27	NULL	NULL
1	37	757	2024-11-27	NULL	NULL
1	37	758	2024-11-27	NULL	NULL
1	37	759	2024-11-27	NULL	NULL
1	37	760	2024-11-27	NULL	NULL
1	37	761	2024-11-27	NULL	NULL
1	37	762	2024-11-27	NULL	NULL
1	37	763	2024-11-27	NULL	NULL
1	37	764	2024-11-27	NULL	NULL
1	37	765	2024-11-27	NULL	NULL
1	37	766	2024-11-27	NULL	NULL
1	38	749	2024-11-27	NULL	NULL
1	38	750	2024-11-27	NULL	NULL
1	38	751	2024-11-27	NULL	NULL
1	38	752	2024-11-27	NULL	NULL
1	38	753	2024-11-27	NULL	NULL
1	38	754	2024-11-27	NULL	NULL
1	38	755	2024-11-27	NULL	NULL
1	38	756	2024-11-27	NULL	NULL
1	38	757	2024-11-27	NULL	NULL
1	38	758	2024-11-27	NULL	NULL
1	38	759	2024-11-27	NULL	NULL
1	38	760	2024-11-27	NULL	NULL
1	38	761	2024-11-27	NULL	NULL
1	38	762	2024-11-27	NULL	NULL
1	38	763	2024-11-27	NULL	NULL
1	38	764	2024-11-27	NULL	NULL
1	38	765	2024-11-27	NULL	NULL
1	38	766	2024-11-27	NULL	NULL
1	39	749	2024-11-27	NULL	NULL
1	39	750	2024-11-27	NULL	NULL
1	39	751	2024-11-27	NULL	NULL
1	39	752	2024-11-27	NULL	NULL
1	39	753	2024-11-27	NULL	NULL
1	39	754	2024-11-27	NULL	NULL
1	39	755	2024-11-27	NULL	NULL
1	39	756	2024-11-27	NULL	NULL
1	39	757	2024-11-27	NULL	NULL
1	39	758	2024-11-27	NULL	NULL
1	39	759	2024-11-27	NULL	NULL
1	39	760	2024-11-27	NULL	NULL
1	39	761	2024-11-27	NULL	NULL
1	39	762	2024-11-27	NULL	NULL
1	39	763	2024-11-27	NULL	NULL
1	39	764	2024-11-27	NULL	NULL
1	39	765	2024-11-27	NULL	NULL
1	39	766	2024-11-27	NULL	NULL
1	40	749	2024-11-27	NULL	NULL
1	40	750	2024-11-27	NULL	NULL
1	40	751	2024-11-27	NULL	NULL
1	40	752	2024-11-27	NULL	NULL
1	40	753	2024-11-27	NULL	NULL
1	40	754	2024-11-27	NULL	NULL
1	40	755	2024-11-27	NULL	NULL
1	40	756	2024-11-27	NULL	NULL
1	40	757	2024-11-27	NULL	NULL
1	40	758	2024-11-27	NULL	NULL
1	40	759	2024-11-27	NULL	NULL
1	40	760	2024-11-27	NULL	NULL
1	40	761	2024-11-27	NULL	NULL
1	40	762	2024-11-27	NULL	NULL
1	40	763	2024-11-27	NULL	NULL
1	40	764	2024-11-27	NULL	NULL
1	40	765	2024-11-27	NULL	NULL
1	40	766	2024-11-27	NULL	NULL
4	31	767	2024-11-27	NULL	NULL
4	31	768	2024-11-27	NULL	NULL
4	31	769	2024-11-27	NULL	NULL
4	31	770	2024-11-27	NULL	NULL
4	31	771	2024-11-27	NULL	NULL
4	31	772	2024-11-27	NULL	NULL
4	31	773	2024-11-27	NULL	NULL
4	31	774	2024-11-27	NULL	NULL
4	31	775	2024-11-27	NULL	NULL
4	31	776	2024-11-27	NULL	NULL
4	31	777	2024-11-27	NULL	NULL
4	31	778	2024-11-27	NULL	NULL
4	31	779	2024-11-27	NULL	NULL
4	31	780	2024-11-27	NULL	NULL
4	31	781	2024-11-27	NULL	NULL
4	31	782	2024-11-27	NULL	NULL
4	31	783	2024-11-27	NULL	NULL
4	31	784	2024-11-27	NULL	NULL
4	33	785	2024-11-27	NULL	NULL
4	33	786	2024-11-27	NULL	NULL
4	33	787	2024-11-27	NULL	NULL
4	33	788	2024-11-27	NULL	NULL
4	33	789	2024-11-27	NULL	NULL
4	33	790	2024-11-27	NULL	NULL
4	33	791	2024-11-27	NULL	NULL
4	33	792	2024-11-27	NULL	NULL
4	33	793	2024-11-27	NULL	NULL
4	33	794	2024-11-27	NULL	NULL
4	33	795	2024-11-27	NULL	NULL
4	33	796	2024-11-27	NULL	NULL
4	33	797	2024-11-27	NULL	NULL
4	33	798	2024-11-27	NULL	NULL
4	33	799	2024-11-27	NULL	NULL
4	33	800	2024-11-27	NULL	NULL
4	33	801	2024-11-27	NULL	NULL
4	33	802	2024-11-27	NULL	NULL
4	34	785	2024-11-27	NULL	NULL
4	34	786	2024-11-27	NULL	NULL
4	34	787	2024-11-27	NULL	NULL
4	34	788	2024-11-27	NULL	NULL
4	34	789	2024-11-27	NULL	NULL
4	34	790	2024-11-27	NULL	NULL
4	34	791	2024-11-27	NULL	NULL
4	34	792	2024-11-27	NULL	NULL
4	34	793	2024-11-27	NULL	NULL
4	34	794	2024-11-27	NULL	NULL
4	34	795	2024-11-27	NULL	NULL
4	34	796	2024-11-27	NULL	NULL
4	34	797	2024-11-27	NULL	NULL
4	34	798	2024-11-27	NULL	NULL
4	34	799	2024-11-27	NULL	NULL
4	34	800	2024-11-27	NULL	NULL
4	34	801	2024-11-27	NULL	NULL
4	34	802	2024-11-27	NULL	NULL
4	41	785	2024-11-27	NULL	NULL
4	41	786	2024-11-27	NULL	NULL
4	41	787	2024-11-27	NULL	NULL
4	41	788	2024-11-27	NULL	NULL
4	41	789	2024-11-27	NULL	NULL
4	41	790	2024-11-27	NULL	NULL
4	41	791	2024-11-27	NULL	NULL
4	41	792	2024-11-27	NULL	NULL
4	41	793	2024-11-27	NULL	NULL
4	41	794	2024-11-27	NULL	NULL
4	41	795	2024-11-27	NULL	NULL
4	41	796	2024-11-27	NULL	NULL
4	41	797	2024-11-27	NULL	NULL
4	41	798	2024-11-27	NULL	NULL
4	41	799	2024-11-27	NULL	NULL
4	41	800	2024-11-27	NULL	NULL
4	41	801	2024-11-27	NULL	NULL
4	41	802	2024-11-27	NULL	NULL
4	37	785	2024-11-27	NULL	NULL
4	37	786	2024-11-27	NULL	NULL
4	37	787	2024-11-27	NULL	NULL
4	37	788	2024-11-27	NULL	NULL
4	37	789	2024-11-27	NULL	NULL
4	37	790	2024-11-27	NULL	NULL
4	37	791	2024-11-27	NULL	NULL
4	37	792	2024-11-27	NULL	NULL
4	37	793	2024-11-27	NULL	NULL
4	37	794	2024-11-27	NULL	NULL
4	37	795	2024-11-27	NULL	NULL
4	37	796	2024-11-27	NULL	NULL
4	37	797	2024-11-27	NULL	NULL
4	37	798	2024-11-27	NULL	NULL
4	37	799	2024-11-27	NULL	NULL
4	37	800	2024-11-27	NULL	NULL
4	37	801	2024-11-27	NULL	NULL
4	37	802	2024-11-27	NULL	NULL
4	42	785	2024-11-27	NULL	NULL
4	42	786	2024-11-27	NULL	NULL
4	42	787	2024-11-27	NULL	NULL
4	42	788	2024-11-27	NULL	NULL
4	42	789	2024-11-27	NULL	NULL
4	42	790	2024-11-27	NULL	NULL
4	42	791	2024-11-27	NULL	NULL
4	42	792	2024-11-27	NULL	NULL
4	42	793	2024-11-27	NULL	NULL
4	42	794	2024-11-27	NULL	NULL
4	42	795	2024-11-27	NULL	NULL
4	42	796	2024-11-27	NULL	NULL
4	42	797	2024-11-27	NULL	NULL
4	42	798	2024-11-27	NULL	NULL
4	42	799	2024-11-27	NULL	NULL
4	42	800	2024-11-27	NULL	NULL
4	42	801	2024-11-27	NULL	NULL
4	42	802	2024-11-27	NULL	NULL
4	33	803	2024-11-27	NULL	NULL
4	33	804	2024-11-27	NULL	NULL
4	33	805	2024-11-27	NULL	NULL
4	33	806	2024-11-27	NULL	NULL
4	33	807	2024-11-27	NULL	NULL
4	33	808	2024-11-27	NULL	NULL
4	34	803	2024-11-27	NULL	NULL
4	34	804	2024-11-27	NULL	NULL
4	34	805	2024-11-27	NULL	NULL
4	34	806	2024-11-27	NULL	NULL
4	34	807	2024-11-27	NULL	NULL
4	34	808	2024-11-27	NULL	NULL
4	35	803	2024-11-27	NULL	NULL
4	35	804	2024-11-27	NULL	NULL
4	35	805	2024-11-27	NULL	NULL
4	35	806	2024-11-27	NULL	NULL
4	35	807	2024-11-27	NULL	NULL
4	35	808	2024-11-27	NULL	NULL
4	36	803	2024-11-27	NULL	NULL
4	36	804	2024-11-27	NULL	NULL
4	36	805	2024-11-27	NULL	NULL
4	36	806	2024-11-27	NULL	NULL
4	36	807	2024-11-27	NULL	NULL
4	36	808	2024-11-27	NULL	NULL
4	37	803	2024-11-27	NULL	NULL
4	37	804	2024-11-27	NULL	NULL
4	37	805	2024-11-27	NULL	NULL
4	37	806	2024-11-27	NULL	NULL
4	37	807	2024-11-27	NULL	NULL
4	37	808	2024-11-27	NULL	NULL
4	38	803	2024-11-27	NULL	NULL
4	38	804	2024-11-27	NULL	NULL
4	38	805	2024-11-27	NULL	NULL
4	38	806	2024-11-27	NULL	NULL
4	38	807	2024-11-27	NULL	NULL
4	38	808	2024-11-27	NULL	NULL
4	39	803	2024-11-27	NULL	NULL
4	39	804	2024-11-27	NULL	NULL
4	39	805	2024-11-27	NULL	NULL
4	39	806	2024-11-27	NULL	NULL
4	39	807	2024-11-27	NULL	NULL
4	39	808	2024-11-27	NULL	NULL
4	40	803	2024-11-27	NULL	NULL
4	40	804	2024-11-27	NULL	NULL
4	40	805	2024-11-27	NULL	NULL
4	40	806	2024-11-27	NULL	NULL
4	40	807	2024-11-27	NULL	NULL
4	40	808	2024-11-27	NULL	NULL
5	31	809	2024-11-27	NULL	NULL
5	31	810	2024-11-27	NULL	NULL
5	31	811	2024-11-27	NULL	NULL
5	31	812	2024-11-27	NULL	NULL
5	31	813	2024-11-27	NULL	NULL
5	31	814	2024-11-27	NULL	NULL
5	31	815	2024-11-27	NULL	NULL
5	31	816	2024-11-27	NULL	NULL
5	31	817	2024-11-27	NULL	NULL
5	31	818	2024-11-27	NULL	NULL
5	31	819	2024-11-27	NULL	NULL
5	31	820	2024-11-27	NULL	NULL
5	31	821	2024-11-27	NULL	NULL
5	31	822	2024-11-27	NULL	NULL
5	31	823	2024-11-27	NULL	NULL
5	31	824	2024-11-27	NULL	NULL
5	31	825	2024-11-27	NULL	NULL
5	31	826	2024-11-27	NULL	NULL
5	33	827	2024-11-27	NULL	NULL
5	33	828	2024-11-27	NULL	NULL
5	33	829	2024-11-27	NULL	NULL
5	33	830	2024-11-27	NULL	NULL
5	33	831	2024-11-27	NULL	NULL
5	33	832	2024-11-27	NULL	NULL
5	33	833	2024-11-27	NULL	NULL
5	33	834	2024-11-27	NULL	NULL
5	33	835	2024-11-27	NULL	NULL
5	33	836	2024-11-27	NULL	NULL
5	33	837	2024-11-27	NULL	NULL
5	33	838	2024-11-27	NULL	NULL
5	33	839	2024-11-27	NULL	NULL
5	33	840	2024-11-27	NULL	NULL
5	33	841	2024-11-27	NULL	NULL
5	33	842	2024-11-27	NULL	NULL
5	33	843	2024-11-27	NULL	NULL
5	33	844	2024-11-27	NULL	NULL
5	34	827	2024-11-27	NULL	NULL
5	34	828	2024-11-27	NULL	NULL
5	34	829	2024-11-27	NULL	NULL
5	34	830	2024-11-27	NULL	NULL
5	34	831	2024-11-27	NULL	NULL
5	34	832	2024-11-27	NULL	NULL
5	34	833	2024-11-27	NULL	NULL
5	34	834	2024-11-27	NULL	NULL
5	34	835	2024-11-27	NULL	NULL
5	34	836	2024-11-27	NULL	NULL
5	34	837	2024-11-27	NULL	NULL
5	34	838	2024-11-27	NULL	NULL
5	34	839	2024-11-27	NULL	NULL
5	34	840	2024-11-27	NULL	NULL
5	34	841	2024-11-27	NULL	NULL
5	34	842	2024-11-27	NULL	NULL
5	34	843	2024-11-27	NULL	NULL
5	34	844	2024-11-27	NULL	NULL
5	41	827	2024-11-27	NULL	NULL
5	41	828	2024-11-27	NULL	NULL
5	41	829	2024-11-27	NULL	NULL
5	41	830	2024-11-27	NULL	NULL
5	41	831	2024-11-27	NULL	NULL
5	41	832	2024-11-27	NULL	NULL
5	41	833	2024-11-27	NULL	NULL
5	41	834	2024-11-27	NULL	NULL
5	41	835	2024-11-27	NULL	NULL
5	41	836	2024-11-27	NULL	NULL
5	41	837	2024-11-27	NULL	NULL
5	41	838	2024-11-27	NULL	NULL
5	41	839	2024-11-27	NULL	NULL
5	41	840	2024-11-27	NULL	NULL
5	41	841	2024-11-27	NULL	NULL
5	41	842	2024-11-27	NULL	NULL
5	41	843	2024-11-27	NULL	NULL
5	41	844	2024-11-27	NULL	NULL
5	37	827	2024-11-27	NULL	NULL
5	37	828	2024-11-27	NULL	NULL
5	37	829	2024-11-27	NULL	NULL
5	37	830	2024-11-27	NULL	NULL
5	37	831	2024-11-27	NULL	NULL
5	37	832	2024-11-27	NULL	NULL
5	37	833	2024-11-27	NULL	NULL
5	37	834	2024-11-27	NULL	NULL
5	37	835	2024-11-27	NULL	NULL
5	37	836	2024-11-27	NULL	NULL
5	37	837	2024-11-27	NULL	NULL
5	37	838	2024-11-27	NULL	NULL
5	37	839	2024-11-27	NULL	NULL
5	37	840	2024-11-27	NULL	NULL
5	37	841	2024-11-27	NULL	NULL
5	37	842	2024-11-27	NULL	NULL
5	37	843	2024-11-27	NULL	NULL
5	37	844	2024-11-27	NULL	NULL
5	42	827	2024-11-27	NULL	NULL
5	42	828	2024-11-27	NULL	NULL
5	42	829	2024-11-27	NULL	NULL
5	42	830	2024-11-27	NULL	NULL
5	42	831	2024-11-27	NULL	NULL
5	42	832	2024-11-27	NULL	NULL
5	42	833	2024-11-27	NULL	NULL
5	42	834	2024-11-27	NULL	NULL
5	42	835	2024-11-27	NULL	NULL
5	42	836	2024-11-27	NULL	NULL
5	42	837	2024-11-27	NULL	NULL
5	42	838	2024-11-27	NULL	NULL
5	42	839	2024-11-27	NULL	NULL
5	42	840	2024-11-27	NULL	NULL
5	42	841	2024-11-27	NULL	NULL
5	42	842	2024-11-27	NULL	NULL
5	42	843	2024-11-27	NULL	NULL
5	42	844	2024-11-27	NULL	NULL
5	32	845	2024-11-27	NULL	NULL
5	32	846	2024-11-27	NULL	NULL
5	32	847	2024-11-27	NULL	NULL
5	32	848	2024-11-27	NULL	NULL
5	32	849	2024-11-27	NULL	NULL
5	32	850	2024-11-27	NULL	NULL
5	32	851	2024-11-27	NULL	NULL
5	32	852	2024-11-27	NULL	NULL
5	32	853	2024-11-27	NULL	NULL
5	32	854	2024-11-27	NULL	NULL
5	32	855	2024-11-27	NULL	NULL
5	32	856	2024-11-27	NULL	NULL
5	32	857	2024-11-27	NULL	NULL
5	32	858	2024-11-27	NULL	NULL
5	32	859	2024-11-27	NULL	NULL
5	32	860	2024-11-27	NULL	NULL
5	32	861	2024-11-27	NULL	NULL
5	32	862	2024-11-27	NULL	NULL
5	34	845	2024-11-27	NULL	NULL
5	34	846	2024-11-27	NULL	NULL
5	34	847	2024-11-27	NULL	NULL
5	34	848	2024-11-27	NULL	NULL
5	34	849	2024-11-27	NULL	NULL
5	34	850	2024-11-27	NULL	NULL
5	34	851	2024-11-27	NULL	NULL
5	34	852	2024-11-27	NULL	NULL
5	34	853	2024-11-27	NULL	NULL
5	34	854	2024-11-27	NULL	NULL
5	34	855	2024-11-27	NULL	NULL
5	34	856	2024-11-27	NULL	NULL
5	34	857	2024-11-27	NULL	NULL
5	34	858	2024-11-27	NULL	NULL
5	34	859	2024-11-27	NULL	NULL
5	34	860	2024-11-27	NULL	NULL
5	34	861	2024-11-27	NULL	NULL
5	34	862	2024-11-27	NULL	NULL
5	35	845	2024-11-27	NULL	NULL
5	35	846	2024-11-27	NULL	NULL
5	35	847	2024-11-27	NULL	NULL
5	35	848	2024-11-27	NULL	NULL
5	35	849	2024-11-27	NULL	NULL
5	35	850	2024-11-27	NULL	NULL
5	35	851	2024-11-27	NULL	NULL
5	35	852	2024-11-27	NULL	NULL
5	35	853	2024-11-27	NULL	NULL
5	35	854	2024-11-27	NULL	NULL
5	35	855	2024-11-27	NULL	NULL
5	35	856	2024-11-27	NULL	NULL
5	35	857	2024-11-27	NULL	NULL
5	35	858	2024-11-27	NULL	NULL
5	35	859	2024-11-27	NULL	NULL
5	35	860	2024-11-27	NULL	NULL
5	35	861	2024-11-27	NULL	NULL
5	35	862	2024-11-27	NULL	NULL
5	36	845	2024-11-27	NULL	NULL
5	36	846	2024-11-27	NULL	NULL
5	36	847	2024-11-27	NULL	NULL
5	36	848	2024-11-27	NULL	NULL
5	36	849	2024-11-27	NULL	NULL
5	36	850	2024-11-27	NULL	NULL
5	36	851	2024-11-27	NULL	NULL
5	36	852	2024-11-27	NULL	NULL
5	36	853	2024-11-27	NULL	NULL
5	36	854	2024-11-27	NULL	NULL
5	36	855	2024-11-27	NULL	NULL
5	36	856	2024-11-27	NULL	NULL
5	36	857	2024-11-27	NULL	NULL
5	36	858	2024-11-27	NULL	NULL
5	36	859	2024-11-27	NULL	NULL
5	36	860	2024-11-27	NULL	NULL
5	36	861	2024-11-27	NULL	NULL
5	36	862	2024-11-27	NULL	NULL
5	37	845	2024-11-27	NULL	NULL
5	37	846	2024-11-27	NULL	NULL
5	37	847	2024-11-27	NULL	NULL
5	37	848	2024-11-27	NULL	NULL
5	37	849	2024-11-27	NULL	NULL
5	37	850	2024-11-27	NULL	NULL
5	37	851	2024-11-27	NULL	NULL
5	37	852	2024-11-27	NULL	NULL
5	37	853	2024-11-27	NULL	NULL
5	37	854	2024-11-27	NULL	NULL
5	37	855	2024-11-27	NULL	NULL
5	37	856	2024-11-27	NULL	NULL
5	37	857	2024-11-27	NULL	NULL
5	37	858	2024-11-27	NULL	NULL
5	37	859	2024-11-27	NULL	NULL
5	37	860	2024-11-27	NULL	NULL
5	37	861	2024-11-27	NULL	NULL
5	37	862	2024-11-27	NULL	NULL
5	38	845	2024-11-27	NULL	NULL
5	38	846	2024-11-27	NULL	NULL
5	38	847	2024-11-27	NULL	NULL
5	38	848	2024-11-27	NULL	NULL
5	38	849	2024-11-27	NULL	NULL
5	38	850	2024-11-27	NULL	NULL
5	38	851	2024-11-27	NULL	NULL
5	38	852	2024-11-27	NULL	NULL
5	38	853	2024-11-27	NULL	NULL
5	38	854	2024-11-27	NULL	NULL
5	38	855	2024-11-27	NULL	NULL
5	38	856	2024-11-27	NULL	NULL
5	38	857	2024-11-27	NULL	NULL
5	38	858	2024-11-27	NULL	NULL
5	38	859	2024-11-27	NULL	NULL
5	38	860	2024-11-27	NULL	NULL
5	38	861	2024-11-27	NULL	NULL
5	38	862	2024-11-27	NULL	NULL
5	39	845	2024-11-27	NULL	NULL
5	39	846	2024-11-27	NULL	NULL
5	39	847	2024-11-27	NULL	NULL
5	39	848	2024-11-27	NULL	NULL
5	39	849	2024-11-27	NULL	NULL
5	39	850	2024-11-27	NULL	NULL
5	39	851	2024-11-27	NULL	NULL
5	39	852	2024-11-27	NULL	NULL
5	39	853	2024-11-27	NULL	NULL
5	39	854	2024-11-27	NULL	NULL
5	39	855	2024-11-27	NULL	NULL
5	39	856	2024-11-27	NULL	NULL
5	39	857	2024-11-27	NULL	NULL
5	39	858	2024-11-27	NULL	NULL
5	39	859	2024-11-27	NULL	NULL
5	39	860	2024-11-27	NULL	NULL
5	39	861	2024-11-27	NULL	NULL
5	39	862	2024-11-27	NULL	NULL
5	40	845	2024-11-27	NULL	NULL
5	40	846	2024-11-27	NULL	NULL
5	40	847	2024-11-27	NULL	NULL
5	40	848	2024-11-27	NULL	NULL
5	40	849	2024-11-27	NULL	NULL
5	40	850	2024-11-27	NULL	NULL
5	40	851	2024-11-27	NULL	NULL
5	40	852	2024-11-27	NULL	NULL
5	40	853	2024-11-27	NULL	NULL
5	40	854	2024-11-27	NULL	NULL
5	40	855	2024-11-27	NULL	NULL
5	40	856	2024-11-27	NULL	NULL
5	40	857	2024-11-27	NULL	NULL
5	40	858	2024-11-27	NULL	NULL
5	40	859	2024-11-27	NULL	NULL
5	40	860	2024-11-27	NULL	NULL
5	40	861	2024-11-27	NULL	NULL
5	40	862	2024-11-27	NULL	NULL
CREATE TABLE "public"."start_command" (
	"image_id"            INTEGER       NOT NULL,
	"cmd_args"            VARCHAR(155),
	"cmd_envvars"         VARCHAR(155),
	"cmd_additional_args" VARCHAR(155)
);
CREATE TABLE "public"."network" (
	"id"       INTEGER       NOT NULL,
	"net_port" VARCHAR(155),
	"image_id" INTEGER,
	CONSTRAINT "network_id_pkey" PRIMARY KEY ("id")
);
CREATE TABLE "public"."rootfs" (
	"id"                INTEGER       NOT NULL,
	"diff_ids"          VARCHAR(155),
	"type"              VARCHAR(155),
	"volums"            VARCHAR(155),
	"size"              VARCHAR(155),
	"virtual_size"      VARCHAR(155),
	"graph_driver_name" VARCHAR(155),
	"layers"            VARCHAR(155),
	"image_id"          INTEGER,
	CONSTRAINT "rootfs_id_pkey" PRIMARY KEY ("id")
);
CREATE TABLE "public"."software" (
	"id"            INTEGER       NOT NULL,
	"name"          VARCHAR(155),
	"provider"      VARCHAR(155),
	"version"       VARCHAR(155),
	"optimized"     VARCHAR(155),
	"compatibility" VARCHAR(155),
	"image_id"      INTEGER,
	CONSTRAINT "software_id_pkey" PRIMARY KEY ("id")
);
CREATE TABLE "public"."io_stream" (
	"id"            INTEGER       NOT NULL,
	"image_id"      INTEGER,
	"type"          VARCHAR(155),
	"attach_stdin"  VARCHAR(155),
	"attach_stdout" VARCHAR(155),
	"attach_stderr" VARCHAR(155),
	"tty"           VARCHAR(155),
	"open_std_in"   VARCHAR(155),
	"std_in_once"   VARCHAR(155),
	CONSTRAINT "io_stream_id_pkey" PRIMARY KEY ("id")
);
CREATE TABLE "public"."env" (
	"id"    INTEGER       NOT NULL,
	"value" VARCHAR(155),
	CONSTRAINT "env_id_pkey" PRIMARY KEY ("id")
);
CREATE TABLE "public"."entrypoint" (
	"id"    INTEGER       NOT NULL,
	"value" VARCHAR(155),
	CONSTRAINT "entrypoint_id_pkey" PRIMARY KEY ("id")
);
CREATE TABLE "public"."cmd" (
	"id"    INTEGER       NOT NULL,
	"value" VARCHAR(155),
	CONSTRAINT "cmd_id_pkey" PRIMARY KEY ("id")
);
CREATE TABLE "public"."label" (
	"id"    INTEGER       NOT NULL,
	"value" VARCHAR(155),
	CONSTRAINT "label_id_pkey" PRIMARY KEY ("id")
);
CREATE TABLE "public"."configuration" (
	"id"            INTEGER       NOT NULL,
	"user"          VARCHAR(155),
	"env_id"        INTEGER,
	"EntryPoint_id" INTEGER,
	"cmd_id"        INTEGER,
	"label_id"      INTEGER,
	"image_id"      INTEGER,
	CONSTRAINT "configuration_id_pkey" PRIMARY KEY ("id")
);
CREATE TABLE "public"."workflow_execution" (
	"id"           INTEGER       NOT NULL,
	"wf_id"        INTEGER,
	"activity"     VARCHAR(155),
	"script"       VARCHAR(155),
	"image_id"     INTEGER,
	"exec_id"      INTEGER,
	"exec_command" VARCHAR(155),
	CONSTRAINT "workflow_execution_id_pkey" PRIMARY KEY ("id")
);
COPY 660 RECORDS INTO "public"."workflow_execution" FROM stdin USING DELIMITERS E'\t',E'\n','"';
2	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	63	"./sciphy_data.sif"
3	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	64	"./sciphy_data.sif"
4	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	65	"./sciphy_data.sif"
5	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	66	"./sciphy_data.sif"
6	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	67	"./sciphy_data.sif"
7	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	68	"./sciphy_data.sif"
8	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	108	"./sciphy_data.sif"
9	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	109	"./sciphy_data.sif"
10	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	110	"./sciphy_data.sif"
11	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	111	"./sciphy_data.sif"
12	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	112	"./sciphy_data.sif"
13	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	113	"./sciphy_data.sif"
14	1	"Sciphy Execution, provenance service"	NULL	28	114	"./sciphy.sif"
15	1	"Sciphy Execution, provenance service"	NULL	28	115	"./sciphy.sif"
16	1	"Sciphy Execution, provenance service"	NULL	28	116	"./sciphy.sif"
17	1	"Sciphy Execution, provenance service"	NULL	28	117	"./sciphy.sif"
18	1	"Sciphy Execution, provenance service"	NULL	28	118	"./sciphy.sif"
19	1	"Sciphy Execution, provenance service"	NULL	28	119	"./sciphy.sif"
20	1	"dataPersistence"	NULL	4	114	"./sciphy.sif"
21	1	"dataPersistence"	NULL	4	115	"./sciphy.sif"
22	1	"dataPersistence"	NULL	4	116	"./sciphy.sif"
23	1	"dataPersistence"	NULL	4	117	"./sciphy.sif"
24	1	"dataPersistence"	NULL	4	118	"./sciphy.sif"
25	1	"dataPersistence"	NULL	4	119	"./sciphy.sif"
26	1	"Sciphy Execution, dataPersistence"	NULL	28	120	"./sciphy_data.sif"
27	1	"Sciphy Execution, dataPersistence"	NULL	28	121	"./sciphy_data.sif"
28	1	"Sciphy Execution, dataPersistence"	NULL	28	122	"./sciphy_data.sif"
29	1	"Sciphy Execution, dataPersistence"	NULL	28	123	"./sciphy_data.sif"
30	1	"Sciphy Execution, dataPersistence"	NULL	28	124	"./sciphy_data.sif"
31	1	"Sciphy Execution, dataPersistence"	NULL	28	125	"./sciphy_data.sif"
32	1	"Provenance service"	NULL	25	120	"./java.sif"
33	1	"Provenance service"	NULL	25	121	"./java.sif"
34	1	"Provenance service"	NULL	25	122	"./java.sif"
35	1	"Provenance service"	NULL	25	123	"./java.sif"
36	1	"Provenance service"	NULL	25	124	"./java.sif"
37	1	"Provenance service"	NULL	25	125	"./java.sif"
38	1	"Sciphy Execution"	NULL	27	126	"./sciphy.sif"
39	1	"Sciphy Execution"	NULL	27	127	"./sciphy.sif"
40	1	"Sciphy Execution"	NULL	27	128	"./sciphy.sif"
41	1	"Sciphy Execution"	NULL	27	129	"./sciphy.sif"
42	1	"Sciphy Execution"	NULL	27	130	"./sciphy.sif"
43	1	"Sciphy Execution"	NULL	27	131	"./sciphy.sif"
44	1	"Sciphy Execution"	NULL	27	132	"./sciphy.sif"
45	1	"Provenance service, Data persistence"	NULL	23	126	"./java_monetdb.sif"
46	1	"Provenance service, Data persistence"	NULL	23	127	"./java_monetdb.sif"
47	1	"Provenance service, Data persistence"	NULL	23	128	"./java_monetdb.sif"
48	1	"Provenance service, Data persistence"	NULL	23	129	"./java_monetdb.sif"
49	1	"Provenance service, Data persistence"	NULL	23	130	"./java_monetdb.sif"
50	1	"Provenance service, Data persistence"	NULL	23	131	"./java_monetdb.sif"
51	1	"Provenance service, Data persistence"	NULL	23	132	"./java_monetdb.sif"
52	1	"Sciphy Execution"	NULL	27	133	"./sciphy.sif"
53	1	"Sciphy Execution"	NULL	27	134	"./sciphy.sif"
54	1	"Sciphy Execution"	NULL	27	135	"./sciphy.sif"
55	1	"Sciphy Execution"	NULL	27	136	"./sciphy.sif"
56	1	"Sciphy Execution"	NULL	27	137	"./sciphy.sif"
57	1	"Sciphy Execution"	NULL	27	138	"./sciphy.sif"
58	1	"Provenance service"	NULL	25	133	"./java.sif"
59	1	"Provenance service"	NULL	25	134	"./java.sif"
60	1	"Provenance service"	NULL	25	135	"./java.sif"
61	1	"Provenance service"	NULL	25	136	"./java.sif"
62	1	"Provenance service"	NULL	25	137	"./java.sif"
63	1	"Provenance service"	NULL	25	138	"./java.sif"
64	1	"DataPersistence"	NULL	4	133	"./monetdb.sif"
65	1	"DataPersistence"	NULL	4	134	"./monetdb.sif"
66	1	"DataPersistence"	NULL	4	135	"./monetdb.sif"
67	1	"DataPersistence"	NULL	4	136	"./monetdb.sif"
68	1	"DataPersistence"	NULL	4	137	"./monetdb.sif"
69	1	"DataPersistence"	NULL	4	138	"./monetdb.sif"
70	1	"Mafft Execution"	NULL	24	139	"./mafft.sif"
71	1	"Mafft Execution"	NULL	24	140	"./mafft.sif"
72	1	"Mafft Execution"	NULL	24	141	"./mafft.sif"
73	1	"Mafft Execution"	NULL	24	142	"./mafft.sif"
74	1	"Mafft Execution"	NULL	24	143	"./mafft.sif"
75	1	"Mafft Execution"	NULL	24	144	"./mafft.sif"
76	1	"Mafft Execution"	NULL	24	145	"./mafft.sif"
77	1	"ReadSeq execution"	NULL	5	139	"./readseq.sif"
78	1	"ReadSeq execution"	NULL	5	140	"./readseq.sif"
79	1	"ReadSeq execution"	NULL	5	141	"./readseq.sif"
80	1	"ReadSeq execution"	NULL	5	142	"./readseq.sif"
81	1	"ReadSeq execution"	NULL	5	143	"./readseq.sif"
82	1	"ReadSeq execution"	NULL	5	144	"./readseq.sif"
83	1	"ReadSeq execution"	NULL	5	145	"./readseq.sif"
84	1	"ModelGenerator"	NULL	25	139	"./java.sif"
85	1	"ModelGenerator"	NULL	25	140	"./java.sif"
86	1	"ModelGenerator"	NULL	25	141	"./java.sif"
87	1	"ModelGenerator"	NULL	25	142	"./java.sif"
88	1	"ModelGenerator"	NULL	25	143	"./java.sif"
89	1	"ModelGenerator"	NULL	25	144	"./java.sif"
90	1	"ModelGenerator"	NULL	25	145	"./java.sif"
91	1	"RaXML Execution"	NULL	26	139	"./raxml.sif"
92	1	"RaXML Execution"	NULL	26	140	"./raxml.sif"
93	1	"RaXML Execution"	NULL	26	141	"./raxml.sif"
94	1	"RaXML Execution"	NULL	26	142	"./raxml.sif"
95	1	"RaXML Execution"	NULL	26	143	"./raxml.sif"
96	1	"RaXML Execution"	NULL	26	144	"./raxml.sif"
97	1	"RaXML Execution"	NULL	26	145	"./raxml.sif"
98	1	"DataPersistence"	NULL	4	139	"./monetdb.sif"
99	1	"DataPersistence"	NULL	4	140	"./monetdb.sif"
100	1	"DataPersistence"	NULL	4	141	"./monetdb.sif"
101	1	"DataPersistence"	NULL	4	142	"./monetdb.sif"
102	1	"DataPersistence"	NULL	4	143	"./monetdb.sif"
103	1	"DataPersistence"	NULL	4	144	"./monetdb.sif"
104	1	"DataPersistence"	NULL	4	145	"./monetdb.sif"
105	1	"Provenance service"	NULL	3	139	"./dfanalyzer.sif"
106	1	"Provenance service"	NULL	3	140	"./dfanalyzer.sif"
107	1	"Provenance service"	NULL	3	141	"./dfanalyzer.sif"
108	1	"Provenance service"	NULL	3	142	"./dfanalyzer.sif"
109	1	"Provenance service"	NULL	3	143	"./dfanalyzer.sif"
110	1	"Provenance service"	NULL	3	144	"./dfanalyzer.sif"
111	1	"Provenance service"	NULL	3	145	"./dfanalyzer.sif"
112	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	146	"./sciphy_data.sif"
113	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	147	"./sciphy_data.sif"
114	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	148	"./sciphy_data.sif"
115	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	149	"./sciphy_data.sif"
116	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	150	"./sciphy_data.sif"
117	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	151	"./sciphy_data.sif"
118	1	"Sciphy Execution, dataPersistence"	NULL	28	120	"./sciphy_data.sif"
119	1	"Sciphy Execution, dataPersistence"	NULL	28	121	"./sciphy_data.sif"
120	1	"Sciphy Execution, dataPersistence"	NULL	28	122	"./sciphy_data.sif"
121	1	"Sciphy Execution, dataPersistence"	NULL	28	123	"./sciphy_data.sif"
122	1	"Sciphy Execution, dataPersistence"	NULL	28	124	"./sciphy_data.sif"
123	1	"Sciphy Execution, dataPersistence"	NULL	28	125	"./sciphy_data.sif"
124	1	"Sciphy Execution, dataPersistence"	NULL	28	158	"./sciphy_data.sif"
125	1	"Sciphy Execution, dataPersistence"	NULL	28	159	"./sciphy_data.sif"
126	1	"Sciphy Execution, dataPersistence"	NULL	28	160	"./sciphy_data.sif"
127	1	"Sciphy Execution, dataPersistence"	NULL	28	161	"./sciphy_data.sif"
128	1	"Sciphy Execution, dataPersistence"	NULL	28	162	"./sciphy_data.sif"
129	1	"Sciphy Execution, dataPersistence"	NULL	28	163	"./sciphy_data.sif"
130	1	"Sciphy Execution, dataPersistence"	NULL	28	192	"./sciphy_data.sif"
131	1	"Sciphy Execution, dataPersistence"	NULL	28	193	"./sciphy_data.sif"
132	1	"Sciphy Execution, dataPersistence"	NULL	28	194	"./sciphy_data.sif"
133	1	"Sciphy Execution, dataPersistence"	NULL	28	195	"./sciphy_data.sif"
134	1	"Sciphy Execution, dataPersistence"	NULL	28	196	"./sciphy_data.sif"
135	1	"Provenance service"	NULL	25	120	"./java.sif"
136	1	"Provenance service"	NULL	25	121	"./java.sif"
137	1	"Provenance service"	NULL	25	122	"./java.sif"
138	1	"Provenance service"	NULL	25	123	"./java.sif"
139	1	"Provenance service"	NULL	25	124	"./java.sif"
140	1	"Provenance service"	NULL	25	125	"./java.sif"
141	1	"Provenance service"	NULL	25	158	"./java.sif"
142	1	"Provenance service"	NULL	25	159	"./java.sif"
143	1	"Provenance service"	NULL	25	160	"./java.sif"
144	1	"Provenance service"	NULL	25	161	"./java.sif"
145	1	"Provenance service"	NULL	25	162	"./java.sif"
146	1	"Provenance service"	NULL	25	163	"./java.sif"
147	1	"Provenance service"	NULL	25	192	"./java.sif"
148	1	"Provenance service"	NULL	25	193	"./java.sif"
149	1	"Provenance service"	NULL	25	194	"./java.sif"
150	1	"Provenance service"	NULL	25	195	"./java.sif"
151	1	"Provenance service"	NULL	25	196	"./java.sif"
152	1	"Sciphy Execution"	NULL	27	126	"./sciphy.sif"
153	1	"Sciphy Execution"	NULL	27	127	"./sciphy.sif"
154	1	"Sciphy Execution"	NULL	27	128	"./sciphy.sif"
155	1	"Sciphy Execution"	NULL	27	129	"./sciphy.sif"
156	1	"Sciphy Execution"	NULL	27	130	"./sciphy.sif"
157	1	"Sciphy Execution"	NULL	27	131	"./sciphy.sif"
158	1	"Sciphy Execution"	NULL	27	132	"./sciphy.sif"
159	1	"Sciphy Execution"	NULL	27	164	"./sciphy.sif"
160	1	"Sciphy Execution"	NULL	27	165	"./sciphy.sif"
161	1	"Sciphy Execution"	NULL	27	166	"./sciphy.sif"
162	1	"Sciphy Execution"	NULL	27	167	"./sciphy.sif"
163	1	"Sciphy Execution"	NULL	27	168	"./sciphy.sif"
164	1	"Sciphy Execution"	NULL	27	169	"./sciphy.sif"
165	1	"Sciphy Execution"	NULL	27	197	"./sciphy.sif"
166	1	"Sciphy Execution"	NULL	27	198	"./sciphy.sif"
167	1	"Sciphy Execution"	NULL	27	199	"./sciphy.sif"
168	1	"Sciphy Execution"	NULL	27	200	"./sciphy.sif"
169	1	"Sciphy Execution"	NULL	27	201	"./sciphy.sif"
170	1	"Sciphy Execution"	NULL	27	687	"./sciphy.sif"
171	1	"Sciphy Execution"	NULL	27	688	"./sciphy.sif"
172	1	"Sciphy Execution"	NULL	27	689	"./sciphy.sif"
173	1	"Sciphy Execution"	NULL	27	690	"./sciphy.sif"
174	1	"Sciphy Execution"	NULL	27	691	"./sciphy.sif"
175	1	"Sciphy Execution"	NULL	27	692	"./sciphy.sif"
176	1	"Sciphy Execution"	NULL	27	693	"./sciphy.sif"
177	1	"Provenance service, Data persistence"	NULL	23	126	"./java_monetdb.sif"
178	1	"Provenance service, Data persistence"	NULL	23	127	"./java_monetdb.sif"
179	1	"Provenance service, Data persistence"	NULL	23	128	"./java_monetdb.sif"
180	1	"Provenance service, Data persistence"	NULL	23	129	"./java_monetdb.sif"
181	1	"Provenance service, Data persistence"	NULL	23	130	"./java_monetdb.sif"
182	1	"Provenance service, Data persistence"	NULL	23	131	"./java_monetdb.sif"
183	1	"Provenance service, Data persistence"	NULL	23	132	"./java_monetdb.sif"
184	1	"Provenance service, Data persistence"	NULL	23	164	"./java_monetdb.sif"
185	1	"Provenance service, Data persistence"	NULL	23	165	"./java_monetdb.sif"
186	1	"Provenance service, Data persistence"	NULL	23	166	"./java_monetdb.sif"
187	1	"Provenance service, Data persistence"	NULL	23	167	"./java_monetdb.sif"
188	1	"Provenance service, Data persistence"	NULL	23	168	"./java_monetdb.sif"
189	1	"Provenance service, Data persistence"	NULL	23	169	"./java_monetdb.sif"
190	1	"Provenance service, Data persistence"	NULL	23	197	"./java_monetdb.sif"
191	1	"Provenance service, Data persistence"	NULL	23	198	"./java_monetdb.sif"
192	1	"Provenance service, Data persistence"	NULL	23	199	"./java_monetdb.sif"
193	1	"Provenance service, Data persistence"	NULL	23	200	"./java_monetdb.sif"
194	1	"Provenance service, Data persistence"	NULL	23	201	"./java_monetdb.sif"
195	1	"Provenance service, Data persistence"	NULL	23	687	"./java_monetdb.sif"
196	1	"Provenance service, Data persistence"	NULL	23	688	"./java_monetdb.sif"
197	1	"Provenance service, Data persistence"	NULL	23	689	"./java_monetdb.sif"
198	1	"Provenance service, Data persistence"	NULL	23	690	"./java_monetdb.sif"
199	1	"Provenance service, Data persistence"	NULL	23	691	"./java_monetdb.sif"
200	1	"Provenance service, Data persistence"	NULL	23	692	"./java_monetdb.sif"
201	1	"Provenance service, Data persistence"	NULL	23	693	"./java_monetdb.sif"
202	1	"Sciphy Execution"	NULL	27	133	"./sciphy.sif"
203	1	"Sciphy Execution"	NULL	27	134	"./sciphy.sif"
204	1	"Sciphy Execution"	NULL	27	135	"./sciphy.sif"
205	1	"Sciphy Execution"	NULL	27	136	"./sciphy.sif"
206	1	"Sciphy Execution"	NULL	27	137	"./sciphy.sif"
207	1	"Sciphy Execution"	NULL	27	138	"./sciphy.sif"
208	1	"Sciphy Execution"	NULL	27	170	"./sciphy.sif"
209	1	"Sciphy Execution"	NULL	27	171	"./sciphy.sif"
210	1	"Sciphy Execution"	NULL	27	172	"./sciphy.sif"
211	1	"Sciphy Execution"	NULL	27	173	"./sciphy.sif"
212	1	"Sciphy Execution"	NULL	27	174	"./sciphy.sif"
213	1	"Sciphy Execution"	NULL	27	175	"./sciphy.sif"
214	1	"Sciphy Execution"	NULL	27	202	"./sciphy.sif"
215	1	"Sciphy Execution"	NULL	27	203	"./sciphy.sif"
216	1	"Sciphy Execution"	NULL	27	204	"./sciphy.sif"
217	1	"Sciphy Execution"	NULL	27	205	"./sciphy.sif"
218	1	"Sciphy Execution"	NULL	27	206	"./sciphy.sif"
219	1	"Sciphy Execution"	NULL	27	227	"./sciphy.sif"
220	1	"Sciphy Execution"	NULL	27	228	"./sciphy.sif"
221	1	"Sciphy Execution"	NULL	27	229	"./sciphy.sif"
222	1	"Sciphy Execution"	NULL	27	230	"./sciphy.sif"
223	1	"Sciphy Execution"	NULL	27	231	"./sciphy.sif"
224	1	"Sciphy Execution"	NULL	27	232	"./sciphy.sif"
225	1	"Sciphy Execution"	NULL	27	233	"./sciphy.sif"
226	1	"Sciphy Execution"	NULL	27	234	"./sciphy.sif"
227	1	"Sciphy Execution"	NULL	27	235	"./sciphy.sif"
228	1	"Sciphy Execution"	NULL	27	236	"./sciphy.sif"
229	1	"Sciphy Execution"	NULL	27	277	"./sciphy.sif"
230	1	"Sciphy Execution"	NULL	27	278	"./sciphy.sif"
231	1	"Sciphy Execution"	NULL	27	279	"./sciphy.sif"
232	1	"Sciphy Execution"	NULL	27	280	"./sciphy.sif"
233	1	"Sciphy Execution"	NULL	27	281	"./sciphy.sif"
234	1	"Sciphy Execution"	NULL	27	282	"./sciphy.sif"
235	1	"Sciphy Execution"	NULL	27	283	"./sciphy.sif"
236	1	"Sciphy Execution"	NULL	27	284	"./sciphy.sif"
237	1	"Sciphy Execution"	NULL	27	285	"./sciphy.sif"
238	1	"Sciphy Execution"	NULL	27	286	"./sciphy.sif"
239	1	"Sciphy Execution"	NULL	27	317	"./sciphy.sif"
240	1	"Sciphy Execution"	NULL	27	318	"./sciphy.sif"
241	1	"Sciphy Execution"	NULL	27	319	"./sciphy.sif"
242	1	"Sciphy Execution"	NULL	27	320	"./sciphy.sif"
243	1	"Sciphy Execution"	NULL	27	321	"./sciphy.sif"
244	1	"Sciphy Execution"	NULL	27	322	"./sciphy.sif"
245	1	"Sciphy Execution"	NULL	27	323	"./sciphy.sif"
246	1	"Sciphy Execution"	NULL	27	324	"./sciphy.sif"
247	1	"Sciphy Execution"	NULL	27	325	"./sciphy.sif"
248	1	"Sciphy Execution"	NULL	27	326	"./sciphy.sif"
249	1	"Sciphy Execution"	NULL	27	357	"./sciphy.sif"
250	1	"Sciphy Execution"	NULL	27	358	"./sciphy.sif"
251	1	"Sciphy Execution"	NULL	27	359	"./sciphy.sif"
252	1	"Sciphy Execution"	NULL	27	360	"./sciphy.sif"
253	1	"Sciphy Execution"	NULL	27	361	"./sciphy.sif"
254	1	"Sciphy Execution"	NULL	27	362	"./sciphy.sif"
255	1	"Sciphy Execution"	NULL	27	363	"./sciphy.sif"
256	1	"Sciphy Execution"	NULL	27	364	"./sciphy.sif"
257	1	"Sciphy Execution"	NULL	27	365	"./sciphy.sif"
258	1	"Sciphy Execution"	NULL	27	366	"./sciphy.sif"
259	1	"Sciphy Execution"	NULL	27	397	"./sciphy.sif"
260	1	"Sciphy Execution"	NULL	27	398	"./sciphy.sif"
261	1	"Sciphy Execution"	NULL	27	399	"./sciphy.sif"
262	1	"Sciphy Execution"	NULL	27	400	"./sciphy.sif"
263	1	"Sciphy Execution"	NULL	27	401	"./sciphy.sif"
264	1	"Sciphy Execution"	NULL	27	402	"./sciphy.sif"
265	1	"Sciphy Execution"	NULL	27	403	"./sciphy.sif"
266	1	"Sciphy Execution"	NULL	27	404	"./sciphy.sif"
267	1	"Sciphy Execution"	NULL	27	405	"./sciphy.sif"
268	1	"Sciphy Execution"	NULL	27	406	"./sciphy.sif"
269	1	"Sciphy Execution"	NULL	27	447	"./sciphy.sif"
270	1	"Sciphy Execution"	NULL	27	448	"./sciphy.sif"
271	1	"Sciphy Execution"	NULL	27	449	"./sciphy.sif"
272	1	"Sciphy Execution"	NULL	27	450	"./sciphy.sif"
273	1	"Sciphy Execution"	NULL	27	451	"./sciphy.sif"
274	1	"Sciphy Execution"	NULL	27	452	"./sciphy.sif"
275	1	"Sciphy Execution"	NULL	27	453	"./sciphy.sif"
276	1	"Sciphy Execution"	NULL	27	454	"./sciphy.sif"
277	1	"Sciphy Execution"	NULL	27	455	"./sciphy.sif"
278	1	"Sciphy Execution"	NULL	27	456	"./sciphy.sif"
279	1	"Sciphy Execution"	NULL	27	497	"./sciphy.sif"
280	1	"Sciphy Execution"	NULL	27	498	"./sciphy.sif"
281	1	"Sciphy Execution"	NULL	27	499	"./sciphy.sif"
282	1	"Sciphy Execution"	NULL	27	500	"./sciphy.sif"
283	1	"Sciphy Execution"	NULL	27	501	"./sciphy.sif"
284	1	"Sciphy Execution"	NULL	27	502	"./sciphy.sif"
285	1	"Sciphy Execution"	NULL	27	503	"./sciphy.sif"
286	1	"Sciphy Execution"	NULL	27	504	"./sciphy.sif"
287	1	"Sciphy Execution"	NULL	27	505	"./sciphy.sif"
288	1	"Sciphy Execution"	NULL	27	506	"./sciphy.sif"
289	1	"Sciphy Execution"	NULL	27	694	"./sciphy.sif"
290	1	"Sciphy Execution"	NULL	27	695	"./sciphy.sif"
291	1	"Sciphy Execution"	NULL	27	696	"./sciphy.sif"
292	1	"Sciphy Execution"	NULL	27	697	"./sciphy.sif"
293	1	"Sciphy Execution"	NULL	27	698	"./sciphy.sif"
294	1	"Sciphy Execution"	NULL	27	699	"./sciphy.sif"
295	1	"Provenance service"	NULL	25	133	"./java.sif"
296	1	"Provenance service"	NULL	25	134	"./java.sif"
297	1	"Provenance service"	NULL	25	135	"./java.sif"
298	1	"Provenance service"	NULL	25	136	"./java.sif"
299	1	"Provenance service"	NULL	25	137	"./java.sif"
300	1	"Provenance service"	NULL	25	138	"./java.sif"
301	1	"Provenance service"	NULL	25	170	"./java.sif"
302	1	"Provenance service"	NULL	25	171	"./java.sif"
303	1	"Provenance service"	NULL	25	172	"./java.sif"
304	1	"Provenance service"	NULL	25	173	"./java.sif"
305	1	"Provenance service"	NULL	25	174	"./java.sif"
306	1	"Provenance service"	NULL	25	175	"./java.sif"
307	1	"Provenance service"	NULL	25	202	"./java.sif"
308	1	"Provenance service"	NULL	25	203	"./java.sif"
309	1	"Provenance service"	NULL	25	204	"./java.sif"
310	1	"Provenance service"	NULL	25	205	"./java.sif"
311	1	"Provenance service"	NULL	25	206	"./java.sif"
312	1	"Provenance service"	NULL	25	227	"./java.sif"
313	1	"Provenance service"	NULL	25	228	"./java.sif"
314	1	"Provenance service"	NULL	25	229	"./java.sif"
315	1	"Provenance service"	NULL	25	230	"./java.sif"
316	1	"Provenance service"	NULL	25	231	"./java.sif"
317	1	"Provenance service"	NULL	25	232	"./java.sif"
318	1	"Provenance service"	NULL	25	233	"./java.sif"
319	1	"Provenance service"	NULL	25	234	"./java.sif"
320	1	"Provenance service"	NULL	25	235	"./java.sif"
321	1	"Provenance service"	NULL	25	236	"./java.sif"
322	1	"Provenance service"	NULL	25	277	"./java.sif"
323	1	"Provenance service"	NULL	25	278	"./java.sif"
324	1	"Provenance service"	NULL	25	279	"./java.sif"
325	1	"Provenance service"	NULL	25	280	"./java.sif"
326	1	"Provenance service"	NULL	25	281	"./java.sif"
327	1	"Provenance service"	NULL	25	282	"./java.sif"
328	1	"Provenance service"	NULL	25	283	"./java.sif"
329	1	"Provenance service"	NULL	25	284	"./java.sif"
330	1	"Provenance service"	NULL	25	285	"./java.sif"
331	1	"Provenance service"	NULL	25	286	"./java.sif"
332	1	"Provenance service"	NULL	25	317	"./java.sif"
333	1	"Provenance service"	NULL	25	318	"./java.sif"
334	1	"Provenance service"	NULL	25	319	"./java.sif"
335	1	"Provenance service"	NULL	25	320	"./java.sif"
336	1	"Provenance service"	NULL	25	321	"./java.sif"
337	1	"Provenance service"	NULL	25	322	"./java.sif"
338	1	"Provenance service"	NULL	25	323	"./java.sif"
339	1	"Provenance service"	NULL	25	324	"./java.sif"
340	1	"Provenance service"	NULL	25	325	"./java.sif"
341	1	"Provenance service"	NULL	25	326	"./java.sif"
342	1	"Provenance service"	NULL	25	357	"./java.sif"
343	1	"Provenance service"	NULL	25	358	"./java.sif"
344	1	"Provenance service"	NULL	25	359	"./java.sif"
345	1	"Provenance service"	NULL	25	360	"./java.sif"
346	1	"Provenance service"	NULL	25	361	"./java.sif"
347	1	"Provenance service"	NULL	25	362	"./java.sif"
348	1	"Provenance service"	NULL	25	363	"./java.sif"
349	1	"Provenance service"	NULL	25	364	"./java.sif"
350	1	"Provenance service"	NULL	25	365	"./java.sif"
351	1	"Provenance service"	NULL	25	366	"./java.sif"
352	1	"Provenance service"	NULL	25	397	"./java.sif"
353	1	"Provenance service"	NULL	25	398	"./java.sif"
354	1	"Provenance service"	NULL	25	399	"./java.sif"
355	1	"Provenance service"	NULL	25	400	"./java.sif"
356	1	"Provenance service"	NULL	25	401	"./java.sif"
357	1	"Provenance service"	NULL	25	402	"./java.sif"
358	1	"Provenance service"	NULL	25	403	"./java.sif"
359	1	"Provenance service"	NULL	25	404	"./java.sif"
360	1	"Provenance service"	NULL	25	405	"./java.sif"
361	1	"Provenance service"	NULL	25	406	"./java.sif"
362	1	"Provenance service"	NULL	25	447	"./java.sif"
363	1	"Provenance service"	NULL	25	448	"./java.sif"
364	1	"Provenance service"	NULL	25	449	"./java.sif"
365	1	"Provenance service"	NULL	25	450	"./java.sif"
366	1	"Provenance service"	NULL	25	451	"./java.sif"
367	1	"Provenance service"	NULL	25	452	"./java.sif"
368	1	"Provenance service"	NULL	25	453	"./java.sif"
369	1	"Provenance service"	NULL	25	454	"./java.sif"
370	1	"Provenance service"	NULL	25	455	"./java.sif"
371	1	"Provenance service"	NULL	25	456	"./java.sif"
372	1	"Provenance service"	NULL	25	497	"./java.sif"
373	1	"Provenance service"	NULL	25	498	"./java.sif"
374	1	"Provenance service"	NULL	25	499	"./java.sif"
375	1	"Provenance service"	NULL	25	500	"./java.sif"
376	1	"Provenance service"	NULL	25	501	"./java.sif"
377	1	"Provenance service"	NULL	25	502	"./java.sif"
378	1	"Provenance service"	NULL	25	503	"./java.sif"
379	1	"Provenance service"	NULL	25	504	"./java.sif"
380	1	"Provenance service"	NULL	25	505	"./java.sif"
381	1	"Provenance service"	NULL	25	506	"./java.sif"
382	1	"Provenance service"	NULL	25	694	"./java.sif"
383	1	"Provenance service"	NULL	25	695	"./java.sif"
384	1	"Provenance service"	NULL	25	696	"./java.sif"
385	1	"Provenance service"	NULL	25	697	"./java.sif"
386	1	"Provenance service"	NULL	25	698	"./java.sif"
387	1	"Provenance service"	NULL	25	699	"./java.sif"
388	1	"DataPersistence"	NULL	4	133	"./monetdb.sif"
389	1	"DataPersistence"	NULL	4	134	"./monetdb.sif"
390	1	"DataPersistence"	NULL	4	135	"./monetdb.sif"
391	1	"DataPersistence"	NULL	4	136	"./monetdb.sif"
392	1	"DataPersistence"	NULL	4	137	"./monetdb.sif"
393	1	"DataPersistence"	NULL	4	138	"./monetdb.sif"
394	1	"DataPersistence"	NULL	4	170	"./monetdb.sif"
395	1	"DataPersistence"	NULL	4	171	"./monetdb.sif"
396	1	"DataPersistence"	NULL	4	172	"./monetdb.sif"
397	1	"DataPersistence"	NULL	4	173	"./monetdb.sif"
398	1	"DataPersistence"	NULL	4	174	"./monetdb.sif"
399	1	"DataPersistence"	NULL	4	175	"./monetdb.sif"
400	1	"DataPersistence"	NULL	4	202	"./monetdb.sif"
401	1	"DataPersistence"	NULL	4	203	"./monetdb.sif"
402	1	"DataPersistence"	NULL	4	204	"./monetdb.sif"
403	1	"DataPersistence"	NULL	4	205	"./monetdb.sif"
404	1	"DataPersistence"	NULL	4	206	"./monetdb.sif"
405	1	"DataPersistence"	NULL	4	227	"./monetdb.sif"
406	1	"DataPersistence"	NULL	4	228	"./monetdb.sif"
407	1	"DataPersistence"	NULL	4	229	"./monetdb.sif"
408	1	"DataPersistence"	NULL	4	230	"./monetdb.sif"
409	1	"DataPersistence"	NULL	4	231	"./monetdb.sif"
410	1	"DataPersistence"	NULL	4	232	"./monetdb.sif"
411	1	"DataPersistence"	NULL	4	233	"./monetdb.sif"
412	1	"DataPersistence"	NULL	4	234	"./monetdb.sif"
413	1	"DataPersistence"	NULL	4	235	"./monetdb.sif"
414	1	"DataPersistence"	NULL	4	236	"./monetdb.sif"
415	1	"DataPersistence"	NULL	4	277	"./monetdb.sif"
416	1	"DataPersistence"	NULL	4	278	"./monetdb.sif"
417	1	"DataPersistence"	NULL	4	279	"./monetdb.sif"
418	1	"DataPersistence"	NULL	4	280	"./monetdb.sif"
419	1	"DataPersistence"	NULL	4	281	"./monetdb.sif"
420	1	"DataPersistence"	NULL	4	282	"./monetdb.sif"
421	1	"DataPersistence"	NULL	4	283	"./monetdb.sif"
422	1	"DataPersistence"	NULL	4	284	"./monetdb.sif"
423	1	"DataPersistence"	NULL	4	285	"./monetdb.sif"
424	1	"DataPersistence"	NULL	4	286	"./monetdb.sif"
425	1	"DataPersistence"	NULL	4	317	"./monetdb.sif"
426	1	"DataPersistence"	NULL	4	318	"./monetdb.sif"
427	1	"DataPersistence"	NULL	4	319	"./monetdb.sif"
428	1	"DataPersistence"	NULL	4	320	"./monetdb.sif"
429	1	"DataPersistence"	NULL	4	321	"./monetdb.sif"
430	1	"DataPersistence"	NULL	4	322	"./monetdb.sif"
431	1	"DataPersistence"	NULL	4	323	"./monetdb.sif"
432	1	"DataPersistence"	NULL	4	324	"./monetdb.sif"
433	1	"DataPersistence"	NULL	4	325	"./monetdb.sif"
434	1	"DataPersistence"	NULL	4	326	"./monetdb.sif"
435	1	"DataPersistence"	NULL	4	357	"./monetdb.sif"
436	1	"DataPersistence"	NULL	4	358	"./monetdb.sif"
437	1	"DataPersistence"	NULL	4	359	"./monetdb.sif"
438	1	"DataPersistence"	NULL	4	360	"./monetdb.sif"
439	1	"DataPersistence"	NULL	4	361	"./monetdb.sif"
440	1	"DataPersistence"	NULL	4	362	"./monetdb.sif"
441	1	"DataPersistence"	NULL	4	363	"./monetdb.sif"
442	1	"DataPersistence"	NULL	4	364	"./monetdb.sif"
443	1	"DataPersistence"	NULL	4	365	"./monetdb.sif"
444	1	"DataPersistence"	NULL	4	366	"./monetdb.sif"
445	1	"DataPersistence"	NULL	4	397	"./monetdb.sif"
446	1	"DataPersistence"	NULL	4	398	"./monetdb.sif"
447	1	"DataPersistence"	NULL	4	399	"./monetdb.sif"
448	1	"DataPersistence"	NULL	4	400	"./monetdb.sif"
449	1	"DataPersistence"	NULL	4	401	"./monetdb.sif"
450	1	"DataPersistence"	NULL	4	402	"./monetdb.sif"
451	1	"DataPersistence"	NULL	4	403	"./monetdb.sif"
452	1	"DataPersistence"	NULL	4	404	"./monetdb.sif"
453	1	"DataPersistence"	NULL	4	405	"./monetdb.sif"
454	1	"DataPersistence"	NULL	4	406	"./monetdb.sif"
455	1	"DataPersistence"	NULL	4	447	"./monetdb.sif"
456	1	"DataPersistence"	NULL	4	448	"./monetdb.sif"
457	1	"DataPersistence"	NULL	4	449	"./monetdb.sif"
458	1	"DataPersistence"	NULL	4	450	"./monetdb.sif"
459	1	"DataPersistence"	NULL	4	451	"./monetdb.sif"
460	1	"DataPersistence"	NULL	4	452	"./monetdb.sif"
461	1	"DataPersistence"	NULL	4	453	"./monetdb.sif"
462	1	"DataPersistence"	NULL	4	454	"./monetdb.sif"
463	1	"DataPersistence"	NULL	4	455	"./monetdb.sif"
464	1	"DataPersistence"	NULL	4	456	"./monetdb.sif"
465	1	"DataPersistence"	NULL	4	497	"./monetdb.sif"
466	1	"DataPersistence"	NULL	4	498	"./monetdb.sif"
467	1	"DataPersistence"	NULL	4	499	"./monetdb.sif"
468	1	"DataPersistence"	NULL	4	500	"./monetdb.sif"
469	1	"DataPersistence"	NULL	4	501	"./monetdb.sif"
470	1	"DataPersistence"	NULL	4	502	"./monetdb.sif"
471	1	"DataPersistence"	NULL	4	503	"./monetdb.sif"
472	1	"DataPersistence"	NULL	4	504	"./monetdb.sif"
473	1	"DataPersistence"	NULL	4	505	"./monetdb.sif"
474	1	"DataPersistence"	NULL	4	506	"./monetdb.sif"
475	1	"DataPersistence"	NULL	4	694	"./monetdb.sif"
476	1	"DataPersistence"	NULL	4	695	"./monetdb.sif"
477	1	"DataPersistence"	NULL	4	696	"./monetdb.sif"
478	1	"DataPersistence"	NULL	4	697	"./monetdb.sif"
479	1	"DataPersistence"	NULL	4	698	"./monetdb.sif"
480	1	"DataPersistence"	NULL	4	699	"./monetdb.sif"
481	1	"Mafft Execution"	NULL	24	139	"./mafft.sif"
482	1	"Mafft Execution"	NULL	24	140	"./mafft.sif"
483	1	"Mafft Execution"	NULL	24	141	"./mafft.sif"
484	1	"Mafft Execution"	NULL	24	142	"./mafft.sif"
485	1	"Mafft Execution"	NULL	24	143	"./mafft.sif"
486	1	"Mafft Execution"	NULL	24	144	"./mafft.sif"
487	1	"Mafft Execution"	NULL	24	145	"./mafft.sif"
488	1	"Mafft Execution"	NULL	24	700	"./mafft.sif"
489	1	"Mafft Execution"	NULL	24	701	"./mafft.sif"
490	1	"Mafft Execution"	NULL	24	702	"./mafft.sif"
491	1	"Mafft Execution"	NULL	24	703	"./mafft.sif"
492	1	"Mafft Execution"	NULL	24	704	"./mafft.sif"
493	1	"Mafft Execution"	NULL	24	705	"./mafft.sif"
494	1	"Mafft Execution"	NULL	24	706	"./mafft.sif"
495	1	"ReadSeq execution"	NULL	5	139	"./readseq.sif"
496	1	"ReadSeq execution"	NULL	5	140	"./readseq.sif"
497	1	"ReadSeq execution"	NULL	5	141	"./readseq.sif"
498	1	"ReadSeq execution"	NULL	5	142	"./readseq.sif"
499	1	"ReadSeq execution"	NULL	5	143	"./readseq.sif"
500	1	"ReadSeq execution"	NULL	5	144	"./readseq.sif"
501	1	"ReadSeq execution"	NULL	5	145	"./readseq.sif"
502	1	"ReadSeq execution"	NULL	5	700	"./readseq.sif"
503	1	"ReadSeq execution"	NULL	5	701	"./readseq.sif"
504	1	"ReadSeq execution"	NULL	5	702	"./readseq.sif"
505	1	"ReadSeq execution"	NULL	5	703	"./readseq.sif"
506	1	"ReadSeq execution"	NULL	5	704	"./readseq.sif"
507	1	"ReadSeq execution"	NULL	5	705	"./readseq.sif"
508	1	"ReadSeq execution"	NULL	5	706	"./readseq.sif"
509	1	"ModelGenerator"	NULL	25	139	"./java.sif"
510	1	"ModelGenerator"	NULL	25	140	"./java.sif"
511	1	"ModelGenerator"	NULL	25	141	"./java.sif"
512	1	"ModelGenerator"	NULL	25	142	"./java.sif"
513	1	"ModelGenerator"	NULL	25	143	"./java.sif"
514	1	"ModelGenerator"	NULL	25	144	"./java.sif"
515	1	"ModelGenerator"	NULL	25	145	"./java.sif"
516	1	"ModelGenerator"	NULL	25	700	"./java.sif"
517	1	"ModelGenerator"	NULL	25	701	"./java.sif"
518	1	"ModelGenerator"	NULL	25	702	"./java.sif"
519	1	"ModelGenerator"	NULL	25	703	"./java.sif"
520	1	"ModelGenerator"	NULL	25	704	"./java.sif"
521	1	"ModelGenerator"	NULL	25	705	"./java.sif"
522	1	"ModelGenerator"	NULL	25	706	"./java.sif"
523	1	"RaXML Execution"	NULL	26	139	"./raxml.sif"
524	1	"RaXML Execution"	NULL	26	140	"./raxml.sif"
525	1	"RaXML Execution"	NULL	26	141	"./raxml.sif"
526	1	"RaXML Execution"	NULL	26	142	"./raxml.sif"
527	1	"RaXML Execution"	NULL	26	143	"./raxml.sif"
528	1	"RaXML Execution"	NULL	26	144	"./raxml.sif"
529	1	"RaXML Execution"	NULL	26	145	"./raxml.sif"
530	1	"RaXML Execution"	NULL	26	700	"./raxml.sif"
531	1	"RaXML Execution"	NULL	26	701	"./raxml.sif"
532	1	"RaXML Execution"	NULL	26	702	"./raxml.sif"
533	1	"RaXML Execution"	NULL	26	703	"./raxml.sif"
534	1	"RaXML Execution"	NULL	26	704	"./raxml.sif"
535	1	"RaXML Execution"	NULL	26	705	"./raxml.sif"
536	1	"RaXML Execution"	NULL	26	706	"./raxml.sif"
537	1	"DataPersistence"	NULL	4	139	"./monetdb.sif"
538	1	"DataPersistence"	NULL	4	140	"./monetdb.sif"
539	1	"DataPersistence"	NULL	4	141	"./monetdb.sif"
540	1	"DataPersistence"	NULL	4	142	"./monetdb.sif"
541	1	"DataPersistence"	NULL	4	143	"./monetdb.sif"
542	1	"DataPersistence"	NULL	4	144	"./monetdb.sif"
543	1	"DataPersistence"	NULL	4	145	"./monetdb.sif"
544	1	"DataPersistence"	NULL	4	700	"./monetdb.sif"
545	1	"DataPersistence"	NULL	4	701	"./monetdb.sif"
546	1	"DataPersistence"	NULL	4	702	"./monetdb.sif"
547	1	"DataPersistence"	NULL	4	703	"./monetdb.sif"
548	1	"DataPersistence"	NULL	4	704	"./monetdb.sif"
549	1	"DataPersistence"	NULL	4	705	"./monetdb.sif"
550	1	"DataPersistence"	NULL	4	706	"./monetdb.sif"
551	1	"Provenance service"	NULL	3	139	"./dfanalyzer.sif"
552	1	"Provenance service"	NULL	3	140	"./dfanalyzer.sif"
553	1	"Provenance service"	NULL	3	141	"./dfanalyzer.sif"
554	1	"Provenance service"	NULL	3	142	"./dfanalyzer.sif"
555	1	"Provenance service"	NULL	3	143	"./dfanalyzer.sif"
556	1	"Provenance service"	NULL	3	144	"./dfanalyzer.sif"
557	1	"Provenance service"	NULL	3	145	"./dfanalyzer.sif"
558	1	"Provenance service"	NULL	3	700	"./dfanalyzer.sif"
559	1	"Provenance service"	NULL	3	701	"./dfanalyzer.sif"
560	1	"Provenance service"	NULL	3	702	"./dfanalyzer.sif"
561	1	"Provenance service"	NULL	3	703	"./dfanalyzer.sif"
562	1	"Provenance service"	NULL	3	704	"./dfanalyzer.sif"
563	1	"Provenance service"	NULL	3	705	"./dfanalyzer.sif"
564	1	"Provenance service"	NULL	3	706	"./dfanalyzer.sif"
565	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	146	"./sciphy_data.sif"
566	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	147	"./sciphy_data.sif"
567	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	148	"./sciphy_data.sif"
568	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	149	"./sciphy_data.sif"
569	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	150	"./sciphy_data.sif"
570	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	151	"./sciphy_data.sif"
571	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	182	"./sciphy_data.sif"
572	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	183	"./sciphy_data.sif"
573	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	184	"./sciphy_data.sif"
574	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	185	"./sciphy_data.sif"
575	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	186	"./sciphy_data.sif"
576	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	207	"./sciphy_data.sif"
577	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	208	"./sciphy_data.sif"
578	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	209	"./sciphy_data.sif"
579	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	210	"./sciphy_data.sif"
580	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	211	"./sciphy_data.sif"
581	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	212	"./sciphy_data.sif"
582	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	213	"./sciphy_data.sif"
583	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	214	"./sciphy_data.sif"
584	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	215	"./sciphy_data.sif"
585	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	216	"./sciphy_data.sif"
586	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	257	"./sciphy_data.sif"
587	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	258	"./sciphy_data.sif"
588	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	259	"./sciphy_data.sif"
589	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	260	"./sciphy_data.sif"
590	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	261	"./sciphy_data.sif"
591	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	262	"./sciphy_data.sif"
592	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	263	"./sciphy_data.sif"
593	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	264	"./sciphy_data.sif"
594	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	265	"./sciphy_data.sif"
595	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	266	"./sciphy_data.sif"
596	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	297	"./sciphy_data.sif"
597	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	298	"./sciphy_data.sif"
598	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	299	"./sciphy_data.sif"
599	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	300	"./sciphy_data.sif"
600	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	301	"./sciphy_data.sif"
601	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	302	"./sciphy_data.sif"
602	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	303	"./sciphy_data.sif"
603	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	304	"./sciphy_data.sif"
604	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	305	"./sciphy_data.sif"
605	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	306	"./sciphy_data.sif"
606	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	337	"./sciphy_data.sif"
607	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	338	"./sciphy_data.sif"
608	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	339	"./sciphy_data.sif"
609	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	340	"./sciphy_data.sif"
610	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	341	"./sciphy_data.sif"
611	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	342	"./sciphy_data.sif"
612	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	343	"./sciphy_data.sif"
613	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	344	"./sciphy_data.sif"
614	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	345	"./sciphy_data.sif"
615	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	346	"./sciphy_data.sif"
616	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	377	"./sciphy_data.sif"
617	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	378	"./sciphy_data.sif"
618	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	379	"./sciphy_data.sif"
619	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	380	"./sciphy_data.sif"
620	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	381	"./sciphy_data.sif"
621	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	382	"./sciphy_data.sif"
622	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	383	"./sciphy_data.sif"
623	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	384	"./sciphy_data.sif"
624	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	385	"./sciphy_data.sif"
625	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	386	"./sciphy_data.sif"
626	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	427	"./sciphy_data.sif"
627	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	428	"./sciphy_data.sif"
628	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	429	"./sciphy_data.sif"
629	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	430	"./sciphy_data.sif"
630	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	431	"./sciphy_data.sif"
631	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	432	"./sciphy_data.sif"
632	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	433	"./sciphy_data.sif"
633	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	434	"./sciphy_data.sif"
634	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	435	"./sciphy_data.sif"
635	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	436	"./sciphy_data.sif"
636	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	477	"./sciphy_data.sif"
637	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	478	"./sciphy_data.sif"
638	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	479	"./sciphy_data.sif"
639	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	480	"./sciphy_data.sif"
640	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	481	"./sciphy_data.sif"
641	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	482	"./sciphy_data.sif"
642	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	483	"./sciphy_data.sif"
643	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	484	"./sciphy_data.sif"
644	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	485	"./sciphy_data.sif"
645	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	486	"./sciphy_data.sif"
646	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	517	"./sciphy_data.sif"
647	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	518	"./sciphy_data.sif"
648	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	519	"./sciphy_data.sif"
649	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	520	"./sciphy_data.sif"
650	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	521	"./sciphy_data.sif"
651	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	522	"./sciphy_data.sif"
652	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	523	"./sciphy_data.sif"
653	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	524	"./sciphy_data.sif"
654	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	525	"./sciphy_data.sif"
655	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	526	"./sciphy_data.sif"
656	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	707	"./sciphy_data.sif"
657	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	708	"./sciphy_data.sif"
658	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	709	"./sciphy_data.sif"
659	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	710	"./sciphy_data.sif"
660	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	711	"./sciphy_data.sif"
661	1	"Sciphy Execution, provenance service, dataPersistence"	NULL	28	712	"./sciphy_data.sif"
CREATE TABLE "public"."cpu_usage" (
	"id"       INTEGER       NOT NULL,
	"exec_id"  INTEGER       NOT NULL,
	"cpu_node" VARCHAR(100)  NOT NULL,
	"puser"    DECIMAL(18,3),
	"pnice"    DECIMAL(18,3),
	"psystem"  DECIMAL(18,3),
	"piowait"  DECIMAL(18,3),
	"psteal"   DECIMAL(18,3),
	"pidle"    DECIMAL(18,3),
	CONSTRAINT "cpu_usage_id_pkey" PRIMARY KEY ("id")
);
CREATE TABLE "public"."disk_usage" (
	"id"      INTEGER       NOT NULL,
	"exec_id" INTEGER       NOT NULL,
	"device"  VARCHAR(100)  NOT NULL,
	"tps"     DECIMAL(18,3),
	"rkbs"    DECIMAL(18,3),
	"wkbs"    DECIMAL(18,3),
	"dkbs"    DECIMAL(18,3),
	"areqsz"  DECIMAL(18,3),
	"aqusz"   DECIMAL(18,3),
	"await"   DECIMAL(18,3),
	"putil"   DECIMAL(18,3),
	CONSTRAINT "disk_usage_id_pkey" PRIMARY KEY ("id")
);
CREATE TABLE "public"."memory_usage" (
	"id"        INTEGER       NOT NULL,
	"exec_id"   BIGINT        NOT NULL,
	"kbmemfree" INTEGER       NOT NULL,
	"kbavail"   DECIMAL(18,3),
	"kbmemused" DECIMAL(18,3),
	"pmemused"  DECIMAL(18,3),
	"kbbuffers" DECIMAL(18,3),
	"kbcached"  DECIMAL(18,3),
	"kbcommit"  DECIMAL(18,3),
	"pcommit"   DECIMAL(18,3),
	"kbactive"  DECIMAL(18,3),
	"kbinact"   DECIMAL(18,3),
	"kbdirty"   DECIMAL(18,3),
	CONSTRAINT "memory_usage_id_pkey" PRIMARY KEY ("id")
);
CREATE TABLE "public"."network_usage" (
	"id"      INTEGER       NOT NULL,
	"exec_id" BIGINT        NOT NULL,
	"IFACE"   VARCHAR(100)  NOT NULL,
	"rxppcks" DECIMAL(18,3),
	"txppcks" DECIMAL(18,3),
	"rxkbs"   DECIMAL(18,3),
	"txkbs"   DECIMAL(18,3),
	"rxcmps"  DECIMAL(18,3),
	"txcmps"  DECIMAL(18,3),
	"rxmcsts" DECIMAL(18,3),
	"pifutil" DECIMAL(18,3),
	CONSTRAINT "network_usage_id_pkey" PRIMARY KEY ("id")
);
ALTER TABLE "public"."environment" ALTER COLUMN "id" SET DEFAULT next value for "public"."enviroment_id_seq";
ALTER TABLE "public"."image" ALTER COLUMN "id" SET DEFAULT next value for "public"."image_id_seq";
ALTER TABLE "public"."workflow" ALTER COLUMN "id" SET DEFAULT next value for "public"."wf_id_seq";
ALTER TABLE "public"."env_partition" ALTER COLUMN "id" SET DEFAULT next value for "public"."partition_id_seq";
ALTER TABLE "public"."execution" ALTER COLUMN "id" SET DEFAULT next value for "public"."execution_id_seq";
ALTER TABLE "public"."network" ALTER COLUMN "id" SET DEFAULT next value for "public"."network_id_seq";
ALTER TABLE "public"."rootfs" ALTER COLUMN "id" SET DEFAULT next value for "public"."root_id_seq";
ALTER TABLE "public"."software" ALTER COLUMN "id" SET DEFAULT next value for "public"."software_id_seq";
ALTER TABLE "public"."io_stream" ALTER COLUMN "id" SET DEFAULT next value for "public"."iostream_id_seq";
ALTER TABLE "public"."env" ALTER COLUMN "id" SET DEFAULT next value for "public"."env_id_seq";
ALTER TABLE "public"."entrypoint" ALTER COLUMN "id" SET DEFAULT next value for "public"."entrypoint_id_seq";
ALTER TABLE "public"."cmd" ALTER COLUMN "id" SET DEFAULT next value for "public"."cmd_id_seq";
ALTER TABLE "public"."label" ALTER COLUMN "id" SET DEFAULT next value for "public"."label_id_seq";
ALTER TABLE "public"."configuration" ALTER COLUMN "id" SET DEFAULT next value for "public"."config_id_seq";
ALTER TABLE "public"."workflow_execution" ALTER COLUMN "id" SET DEFAULT next value for "public"."wf_desc_seq";
ALTER TABLE "public"."cpu_usage" ALTER COLUMN "id" SET DEFAULT next value for "public"."cpu_usage_seq";
ALTER TABLE "public"."disk_usage" ALTER COLUMN "id" SET DEFAULT next value for "public"."disk_usage_seq";
ALTER TABLE "public"."memory_usage" ALTER COLUMN "id" SET DEFAULT next value for "public"."memory_usage_seq";
ALTER TABLE "public"."network_usage" ALTER COLUMN "id" SET DEFAULT next value for "public"."network_usage_seq";
ALTER TABLE "public"."configuration" ADD CONSTRAINT "configuration_EntryPoint_id_fkey" FOREIGN KEY ("EntryPoint_id") REFERENCES "public"."entrypoint" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."configuration" ADD CONSTRAINT "configuration_cmd_id_fkey" FOREIGN KEY ("cmd_id") REFERENCES "public"."cmd" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."configuration" ADD CONSTRAINT "configuration_env_id_fkey" FOREIGN KEY ("env_id") REFERENCES "public"."env" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."configuration" ADD CONSTRAINT "configuration_image_id_fkey" FOREIGN KEY ("image_id") REFERENCES "public"."image" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."configuration" ADD CONSTRAINT "configuration_label_id_fkey" FOREIGN KEY ("label_id") REFERENCES "public"."label" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."container" ADD CONSTRAINT "container_execution_id_fkey" FOREIGN KEY ("execution_id") REFERENCES "public"."execution" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."container" ADD CONSTRAINT "container_host_environment_id_fkey" FOREIGN KEY ("host_environment_id") REFERENCES "public"."environment" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."container" ADD CONSTRAINT "container_image_id_fkey" FOREIGN KEY ("image_id") REFERENCES "public"."image" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."cpu_usage" ADD CONSTRAINT "cpu_usage_exec_id_fkey" FOREIGN KEY ("exec_id") REFERENCES "public"."execution" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."disk_usage" ADD CONSTRAINT "disk_usage_exec_id_fkey" FOREIGN KEY ("exec_id") REFERENCES "public"."execution" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."env_partition" ADD CONSTRAINT "env_partition_environment_id_fkey" FOREIGN KEY ("environment_id") REFERENCES "public"."environment" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."execution" ADD CONSTRAINT "execution_partition_id_fkey" FOREIGN KEY ("partition_id") REFERENCES "public"."env_partition" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."image" ADD CONSTRAINT "image_base_image_id_fkey" FOREIGN KEY ("base_image_id") REFERENCES "public"."image" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."image" ADD CONSTRAINT "image_build_environment_id_fkey" FOREIGN KEY ("build_environment_id") REFERENCES "public"."environment" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."image" ADD CONSTRAINT "image_original_image_id_fkey" FOREIGN KEY ("original_image_id") REFERENCES "public"."image" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."io_stream" ADD CONSTRAINT "io_stream_image_id_fkey" FOREIGN KEY ("image_id") REFERENCES "public"."image" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."memory_usage" ADD CONSTRAINT "memory_usage_exec_id_fkey" FOREIGN KEY ("exec_id") REFERENCES "public"."execution" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."network" ADD CONSTRAINT "network_image_id_fkey" FOREIGN KEY ("image_id") REFERENCES "public"."image" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."network_usage" ADD CONSTRAINT "network_usage_exec_id_fkey" FOREIGN KEY ("exec_id") REFERENCES "public"."execution" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."rootfs" ADD CONSTRAINT "rootfs_image_id_fkey" FOREIGN KEY ("image_id") REFERENCES "public"."image" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."software" ADD CONSTRAINT "software_image_id_fkey" FOREIGN KEY ("image_id") REFERENCES "public"."image" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."start_command" ADD CONSTRAINT "start_command_image_id_fkey" FOREIGN KEY ("image_id") REFERENCES "public"."image" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."workflow_execution" ADD CONSTRAINT "workflow_execution_exec_id_fkey" FOREIGN KEY ("exec_id") REFERENCES "public"."execution" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."workflow_execution" ADD CONSTRAINT "workflow_execution_image_id_fkey" FOREIGN KEY ("image_id") REFERENCES "public"."image" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."workflow_execution" ADD CONSTRAINT "workflow_execution_wf_id_fkey" FOREIGN KEY ("wf_id") REFERENCES "public"."workflow" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
