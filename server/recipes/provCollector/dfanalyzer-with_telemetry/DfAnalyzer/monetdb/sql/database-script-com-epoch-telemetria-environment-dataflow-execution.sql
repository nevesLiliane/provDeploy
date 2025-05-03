START TRANSACTION;

-- sequences
CREATE SEQUENCE "df_id_seq" as integer START WITH 1;
CREATE SEQUENCE "df_exec_id_seq" as integer START WITH 1;
CREATE SEQUENCE "dt_exec_id_seq" as integer START WITH 1;
CREATE SEQUENCE "file_dt_id_seq" as integer START WITH 1;
CREATE SEQUENCE "version_id_seq" as integer START WITH 1;
CREATE SEQUENCE "dt_id_seq" as integer START WITH 1;
CREATE SEQUENCE "program_id_seq" as integer START WITH 1;
CREATE SEQUENCE "ds_id_seq" as integer START WITH 1;
CREATE SEQUENCE "dd_id_seq" as integer START WITH 1;
CREATE SEQUENCE "extractor_id_seq" as integer START WITH 1;
CREATE SEQUENCE "ecombination_id_seq" as integer START WITH 1;
CREATE SEQUENCE "att_id_seq" as integer START WITH 1;
CREATE SEQUENCE "task_id_seq" as integer START WITH 1;
CREATE SEQUENCE "file_id_seq" as integer START WITH 1;
CREATE SEQUENCE "performance_id_seq" as integer START WITH 1;
CREATE SEQUENCE "epoch_id_seq" as integer START WITH 1;
CREATE SEQUENCE "telemetry_id_seq" as integer START WITH 1;
CREATE SEQUENCE "telemetry_cpu_id_seq" as integer START WITH 1;
CREATE SEQUENCE "telemetry_disk_id_seq" as integer START WITH 1;
CREATE SEQUENCE "telemetry_network_id_seq" as integer START WITH 1;
CREATE SEQUENCE "telemetry_memory_id_seq" as integer START WITH 1;
CREATE SEQUENCE "user_id_seq" as integer START WITH 1;
CREATE SEQUENCE "physical_machine_id_seq" as integer START WITH 1;
CREATE SEQUENCE "virtual_machine_id_seq" as integer START WITH 1;
CREATE SEQUENCE "file_type_id_seq" as integer START WITH 1;

-- tables
CREATE TABLE user_table(
	id INTEGER DEFAULT NEXT VALUE FOR "user_id_seq" NOT NULL,
	name VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL,
	PRIMARY KEY ("id")
);

CREATE TABLE physical_machine(
	id INTEGER DEFAULT NEXT VALUE FOR "physical_machine_id_seq" NOT NULL,
	name VARCHAR(50) NOT NULL,
	ip VARCHAR(50) NOT NULL,
	mac VARCHAR(50) NOT NULL,
	owner_user_id INTEGER,
	ram INTEGER NOT NULL,
	disk INTEGER NOT NULL,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("owner_user_id") REFERENCES user_table("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE virtual_machine(
	id INTEGER DEFAULT NEXT VALUE FOR "virtual_machine_id_seq" NOT NULL,
	name VARCHAR(50) NOT NULL,
	ram INTEGER NOT NULL,
	disk INTEGER NOT NULL,
	physical_machine_id INTEGER NOT NULL,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("physical_machine_id") REFERENCES physical_machine("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE dataflow(
	id INTEGER DEFAULT NEXT VALUE FOR "df_id_seq" NOT NULL,
	tag VARCHAR(50) NOT NULL,
	user_id INTEGER,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("user_id") REFERENCES user_table("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE program(
	id INTEGER DEFAULT NEXT VALUE FOR "program_id_seq" NOT NULL,
	name VARCHAR(200) NOT NULL,
	version VARCHAR(50) NOT NULL,
	PRIMARY KEY ("id")
);

CREATE TABLE data_transformation(
	id INTEGER DEFAULT NEXT VALUE FOR "dt_id_seq" NOT NULL,
	df_id INTEGER NOT NULL,
	tag VARCHAR(50) NOT NULL,
	program_id INTEGER,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("df_id") REFERENCES dataflow("id") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ("program_id") REFERENCES program("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE dataflow_version(
	version INTEGER DEFAULT NEXT VALUE FOR "version_id_seq" NOT NULL,
	df_id INTEGER NOT NULL,
	PRIMARY KEY ("version"),
	FOREIGN KEY ("df_id") REFERENCES dataflow("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE use_program(
	dt_id INTEGER NOT NULL,
	program_id INTEGER NOT NULL,
	PRIMARY KEY ("dt_id","program_id"),
	FOREIGN KEY ("dt_id") REFERENCES data_transformation("id") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ("program_id") REFERENCES program("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE data_set(
	id INTEGER DEFAULT NEXT VALUE FOR "ds_id_seq" NOT NULL,
	df_id INTEGER NOT NULL,
	tag VARCHAR(50) NOT NULL,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("df_id") REFERENCES dataflow("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE data_dependency(
	id INTEGER DEFAULT NEXT VALUE FOR "dd_id_seq" NOT NULL,
	previous_dt_id INTEGER,
	next_dt_id INTEGER,
	ds_id INTEGER NOT NULL,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("previous_dt_id") REFERENCES data_transformation("id") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ("next_dt_id") REFERENCES data_transformation("id") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ("ds_id") REFERENCES data_set("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE extractor(
	id INTEGER DEFAULT NEXT VALUE FOR "extractor_id_seq" NOT NULL,
	ds_id INTEGER NOT NULL,
	tag VARCHAR(20) NOT NULL,
	cartridge VARCHAR(20) NOT NULL,
	extension VARCHAR(20) NOT NULL,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("ds_id") REFERENCES data_set("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE extractor_combination(
	id INTEGER DEFAULT NEXT VALUE FOR "ecombination_id_seq" NOT NULL,
	ds_id INTEGER NOT NULL,
	outer_ext_id INTEGER NOT NULL,
	inner_ext_id INTEGER NOT NULL,
	keys VARCHAR(100) NOT NULL,
	key_types VARCHAR(100) NOT NULL,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("ds_id") REFERENCES data_set("id") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ("outer_ext_id") REFERENCES extractor("id") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ("inner_ext_id") REFERENCES extractor("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE attribute(
	id INTEGER DEFAULT NEXT VALUE FOR "att_id_seq" NOT NULL,
	ds_id INTEGER NOT NULL,
	extractor_id INTEGER,
	name VARCHAR(30),
	type VARCHAR(15),
	PRIMARY KEY ("id"),
	FOREIGN KEY ("ds_id") REFERENCES data_set("id") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ("extractor_id") REFERENCES extractor("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE task(
	id INTEGER DEFAULT NEXT VALUE FOR "task_id_seq" NOT NULL,
	identifier INTEGER NOT NULL,
	df_version INTEGER NOT NULL,
	dt_id INTEGER NOT NULL,
	status VARCHAR(10),
	workspace VARCHAR(500),
	computing_resource VARCHAR(100),
	output_msg TEXT,
	error_msg TEXT,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("df_version") REFERENCES dataflow_version("version") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ("dt_id") REFERENCES data_transformation("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE file_type(
	id INTEGER DEFAULT NEXT VALUE FOR "file_type_id_seq" NOT NULL,
	name VARCHAR(200) NOT NULL,
	PRIMARY KEY ("id")
);


CREATE TABLE file(
	id INTEGER DEFAULT NEXT VALUE FOR "file_id_seq" NOT NULL,
	name VARCHAR(200) NOT NULL,
	path VARCHAR(500) NOT NULL,
	id_file_type INTEGER NOT NULL,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("id_file_type") REFERENCES file_type("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE performance(
	id INTEGER DEFAULT NEXT VALUE FOR "performance_id_seq" NOT NULL,
	task_id INTEGER NOT NULL,	
	subtask_id INTEGER,	
	method VARCHAR(30) NOT NULL,
	description VARCHAR(200),
	starttime VARCHAR(30),
	endtime VARCHAR(30),
	invocation TEXT,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("task_id") REFERENCES task("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE dataflow_execution(
	id INTEGER DEFAULT NEXT VALUE FOR "df_exec_id_seq" NOT NULL,
	execution_datetime VARCHAR(30) NOT NULL,
	df_id INTEGER NOT NULL,
	physical_machine_id INTEGER,
	virtual_machine_id INTEGER,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("df_id") REFERENCES dataflow("id") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ("physical_machine_id") REFERENCES physical_machine("id") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ("virtual_machine_id") REFERENCES virtual_machine("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE data_transformation_execution(
	id INTEGER DEFAULT NEXT VALUE FOR "dt_exec_id_seq" NOT NULL,
	dataflow_execution_id INTEGER NOT NULL,
	data_transformation_id INTEGER NOT NULL,
	execution_datetime VARCHAR(30) NOT NULL,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("dataflow_execution_id") REFERENCES dataflow_execution("id") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ("data_transformation_id") REFERENCES data_transformation("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE file_transformation_execution(
	id INTEGER DEFAULT NEXT VALUE FOR "file_dt_id_seq" NOT NULL,
	file_id INTEGER NOT NULL,
	generation_datetime VARCHAR(30) NOT NULL,
	last_modification_datetime VARCHAR(30) NOT NULL,
	data_transformation_execution_id INTEGER NOT NULL,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("file_id") REFERENCES file("id") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ("data_transformation_execution_id") REFERENCES data_transformation_execution("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE epoch ( 
	id INTEGER DEFAULT NEXT VALUE FOR "epoch_id_seq" NOT NULL,
	value               varchar(100)  NOT NULL ,
	elapsed_time		decimal(10,2),
	loss				decimal(10,2),
	accuracy 			decimal(10,2),
	epoch_timestamp VARCHAR(30) NOT NULL,
	task_id   			integer   , 
	data_transformation_execution_id INTEGER NOT NULL,	
	PRIMARY KEY ("id"),
	FOREIGN KEY ("task_id") REFERENCES task("id") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ("data_transformation_execution_id") REFERENCES data_transformation_execution("id") ON DELETE CASCADE ON UPDATE CASCADE	
 );

CREATE TABLE telemetry(
	id INTEGER DEFAULT NEXT VALUE FOR "telemetry_id_seq" NOT NULL,
	task_id INTEGER NOT NULL,		
	captured_timestamp VARCHAR(30),
	captured_interval VARCHAR(30),
	data_transformation_execution_id INTEGER NOT NULL,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("task_id") REFERENCES task("id") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ("data_transformation_execution_id") REFERENCES data_transformation_execution("id") ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE telemetry_cpu(
	id INTEGER DEFAULT NEXT VALUE FOR "telemetry_cpu_id_seq" NOT NULL,
	telemetry_id INTEGER NOT NULL,	
	consumption_timestamp VARCHAR(30),
	scputimes_user VARCHAR(30),
	scputimes_system VARCHAR(30),
	scputimes_idle VARCHAR(30),
	scputimes_steal VARCHAR(30),
	PRIMARY KEY ("id"),
	FOREIGN KEY ("telemetry_id") REFERENCES telemetry("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE telemetry_disk(
	id INTEGER DEFAULT NEXT VALUE FOR "telemetry_disk_id_seq" NOT NULL,
	telemetry_id INTEGER NOT NULL,	
	consumption_timestamp VARCHAR(30),
	sdiskio_read_bytes VARCHAR(30),
	sdiskio_write_bytes VARCHAR(30),
	sdiskio_busy_time VARCHAR(30),
	sswap_total VARCHAR(30),
	sswap_used VARCHAR(30),
	PRIMARY KEY ("id"),
	FOREIGN KEY ("telemetry_id") REFERENCES telemetry("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE telemetry_network(
	id INTEGER DEFAULT NEXT VALUE FOR "telemetry_network_id_seq" NOT NULL,
	telemetry_id INTEGER NOT NULL,	
	consumption_timestamp VARCHAR(30),
	consumption_value VARCHAR(30),
	PRIMARY KEY ("id"),
	FOREIGN KEY ("telemetry_id") REFERENCES telemetry("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE telemetry_memory(
	id INTEGER DEFAULT NEXT VALUE FOR "telemetry_memory_id_seq" NOT NULL,
	telemetry_id INTEGER NOT NULL,	
	consumption_timestamp VARCHAR(30),
	svmem_total VARCHAR(30),
	svmem_available VARCHAR(30),
	svmem_used VARCHAR(30),
	PRIMARY KEY ("id"),
	FOREIGN KEY ("telemetry_id") REFERENCES telemetry("id") ON DELETE CASCADE ON UPDATE CASCADE
);
-- procedures
-- DROP FUNCTION insertUser;
CREATE FUNCTION insertUser (vname VARCHAR(50), vemail VARCHAR(50))
RETURNS INTEGER
BEGIN
	DECLARE vid INTEGER;
    SELECT id INTO vid FROM user_table WHERE name=vname AND email=vemail;
    IF(vid IS NULL) THEN
    	SELECT NEXT VALUE FOR "user_id_seq" into vid;
    	INSERT INTO user_table(id,name,email) VALUES (vid,vname,vemail);
	END IF;
	RETURN vid;
END;

-- DROP FUNCTION insertPhysicalMachine;
CREATE FUNCTION insertPhysicalMachine (vname VARCHAR(50), vip VARCHAR(50), vmac VARCHAR(50), vowner_user_id INTEGER, vram INTEGER, vdisk INTEGER)
RETURNS INTEGER
BEGIN
	DECLARE vid INTEGER;
    SELECT id INTO vid FROM physical_machine WHERE name=vname AND ip=vip;
    IF(vid IS NULL) THEN
    	SELECT NEXT VALUE FOR "physical_machine_id_seq" into vid;
    	INSERT INTO physical_machine(id,name,ip,mac,owner_user_id,ram,disk) VALUES (vid,vname,vip,vmac,vowner_user_id,vram,vdisk);
	END IF;
	RETURN vid;
END;

-- DROP FUNCTION insertVirtualMachine;
CREATE FUNCTION insertVirtualMachine (vname VARCHAR(50), vram INTEGER, vdisk INTEGER, vphysical_machine_id INTEGER)
RETURNS INTEGER
BEGIN
	DECLARE vid INTEGER;
    SELECT id INTO vid FROM virtual_machine WHERE name=vname AND physical_machine_id=vphysical_machine_id;
    IF(vid IS NULL) THEN
    	SELECT NEXT VALUE FOR "virtual_machine_id_seq" into vid;
    	INSERT INTO virtual_machine(id,name,ram,disk,physical_machine_id) VALUES (vid,vname,vram,vdisk,vphysical_machine_id);
	END IF;
	RETURN vid;
END;


-- DROP FUNCTION insertDataflow;
CREATE FUNCTION insertDataflow (v_tag VARCHAR(50), vuser_id INTEGER)
RETURNS INTEGER
BEGIN
	DECLARE v_df_id INTEGER;
    SELECT df.id INTO v_df_id FROM dataflow df WHERE df.tag=v_tag AND df.user_id=vuser_id;
    IF(v_df_id IS NULL) THEN
    	SELECT NEXT VALUE FOR "df_id_seq" into v_df_id;
    	INSERT INTO dataflow(id,tag,user_id) VALUES (v_df_id,v_tag,vuser_id);
	END IF;
	RETURN v_df_id;
END;

-- DROP FUNCTION insertProgram;
CREATE FUNCTION insertProgram (vdt_id INTEGER, vname VARCHAR(200), vversion VARCHAR(50))
RETURNS INTEGER
BEGIN
	DECLARE vprogram_id INTEGER;
    SELECT id INTO vprogram_id FROM program p WHERE name = vname AND version = vversion;

    IF(vprogram_id IS NULL) THEN
    	SELECT NEXT VALUE FOR "program_id_seq" into vprogram_id;
    	INSERT INTO program(id,name,version) VALUES (vprogram_id,vname,vversion);
	END IF;
	RETURN vprogram_id;
END;

-- DROP FUNCTION insertDataTransformation;
CREATE FUNCTION insertDataTransformation (vtag VARCHAR(50), vdf_id INTEGER, vprogram_id INTEGER)
RETURNS INTEGER
BEGIN
	DECLARE vid INTEGER;
    SELECT id INTO vid FROM data_transformation WHERE df_id = vdf_id AND tag = vtag;
    IF(vid IS NULL) THEN
    	SELECT NEXT VALUE FOR "dt_id_seq" into vid;
    	INSERT INTO data_transformation(id,tag,df_id,program_id) VALUES (vid,vtag,vdf_id,vprogram_id);
	END IF;
	RETURN vid;
END;

-- DROP FUNCTION insertDataflowVersion;
CREATE FUNCTION insertDataflowVersion (vdf_id INTEGER)
RETURNS INTEGER
BEGIN
	DECLARE version_id INTEGER;
	SELECT NEXT VALUE FOR "version_id_seq" into version_id;
    INSERT INTO dataflow_version(version,df_id) VALUES (version_id,vdf_id);
	RETURN version_id;
END;

-- DROP FUNCTION insertDataSet;
CREATE FUNCTION insertDataSet (vdf_id INTEGER, vdt_id INTEGER, vdep_dt_id INTEGER, vtag VARCHAR(500), vtype VARCHAR(10))
RETURNS INTEGER
BEGIN
	DECLARE vds_id INTEGER;
    SELECT id INTO vds_id FROM data_set ds WHERE df_id = vdf_id AND tag = vtag;

    IF(vds_id IS NULL) THEN
    	SELECT NEXT VALUE FOR "ds_id_seq" into vds_id;
    	INSERT INTO data_set(id,df_id,tag) VALUES (vds_id,vdf_id,vtag);
	END IF;

	IF(vdep_dt_id IS NOT NULL) THEN
		DECLARE vdd_id INTEGER;
		SELECT ds_id INTO vdd_id FROM data_dependency
		WHERE previous_dt_id = vdep_dt_id AND next_dt_id = vdt_id AND ds_id = vds_id;

		DECLARE vid INTEGER;
		SELECT id INTO vid FROM data_dependency WHERE previous_dt_id = vdep_dt_id AND next_dt_id IS NULL;

		IF(vid IS NULL) THEN
			IF(vdd_id IS NULL) THEN
				DECLARE vdd_id INTEGER;
				SELECT NEXT VALUE FOR "dd_id_seq" into vdd_id;

				INSERT INTO data_dependency(id,previous_dt_id,next_dt_id,ds_id) VALUES (vdd_id,vdep_dt_id,vdt_id,vds_id);
			END IF;
		ELSE
			UPDATE data_dependency SET next_dt_id = vdt_id WHERE id = vid;
		END IF;
	ELSE
		DECLARE vdd_id INTEGER;
		SELECT NEXT VALUE FOR "dd_id_seq" into vdd_id;

		IF(vtype LIKE 'INPUT') THEN
			INSERT INTO data_dependency(id,previous_dt_id,next_dt_id,ds_id) VALUES (vdd_id,null,vdt_id,vds_id);
		ELSE
			INSERT INTO data_dependency(id,previous_dt_id,next_dt_id,ds_id) VALUES (vdd_id,vdt_id,null,vds_id);
		END IF;
	END IF;

	RETURN vds_id;
END;

-- DROP FUNCTION insertAttribute;
CREATE FUNCTION insertAttribute (dds_id INTEGER, vextractor_id INTEGER, vname VARCHAR(30), vtype VARCHAR(15))
RETURNS INTEGER
BEGIN
	DECLARE vid INTEGER;
    SELECT id INTO vid FROM attribute WHERE ds_id=dds_id AND name=vname;
    IF(vid IS NULL) THEN
    	SELECT NEXT VALUE FOR "att_id_seq" into vid;
    	INSERT INTO attribute(id,ds_id,extractor_id,name,type) VALUES (vid,dds_id,vextractor_id,vname,vtype);
	END IF;
	RETURN vid;
END;

-- DROP FUNCTION insertTask;
CREATE FUNCTION insertTask (videntifier INTEGER, vdf_tag VARCHAR(50), vdt_tag VARCHAR(50), vstatus VARCHAR(10), vworkspace VARCHAR(500), 
	vcomputing_resource VARCHAR(100), voutput_msg TEXT, verror_msg TEXT)
RETURNS INTEGER
BEGIN
	DECLARE vid INTEGER;
	DECLARE vvstatus VARCHAR(10);
	DECLARE vdf_version INTEGER;
	DECLARE vdt_id INTEGER;

	SELECT dfv.version, dt.id INTO vdf_version, vdt_id
	FROM dataflow df, data_transformation dt, dataflow_version as dfv
	WHERE df.id = dt.df_id AND dfv.df_id = df.id AND df.tag = vdf_tag AND dt.tag = vdt_tag;

	IF((vdf_version IS NOT NULL) AND (vdt_id IS NOT NULL)) THEN
		SELECT t.id, t.status INTO vid, vvstatus
		FROM task t
		WHERE t.df_version = vdf_version AND t.dt_id = vdt_id AND t.identifier = videntifier;

		IF(vid IS NULL) THEN
		    SELECT NEXT VALUE FOR "task_id_seq" into vid;
		    INSERT INTO task(id,identifier,df_version,dt_id,status,workspace,computing_resource,output_msg,error_msg) 
		    VALUES (vid,videntifier,vdf_version,vdt_id,vstatus,vworkspace,vcomputing_resource,voutput_msg,verror_msg);
	    ELSE
	    	UPDATE task
	    	SET status = vstatus, output_msg = voutput_msg, error_msg = verror_msg
	    	WHERE identifier = videntifier AND df_version = vdf_version AND dt_id = vdt_id;
		END IF;
    END IF;
	RETURN vid;
END;

-- DROP FUNCTION insertFile;
CREATE FUNCTION insertFile (vname VARCHAR(200), vpath VARCHAR(500), vid_file_type INTEGER)
RETURNS INTEGER
BEGIN
	DECLARE vid INTEGER;
    SELECT id INTO vid FROM file WHERE name=vname AND path=vpath;
    IF(vid IS NULL) THEN
    	SELECT NEXT VALUE FOR "file_id_seq" into vid;
    	INSERT INTO file(id,name,path,id_file_type) VALUES (vid,vname,vpath,vid_file_type);
	END IF;
	RETURN vid;
END;

-- DROP FUNCTION insertFileType;
CREATE FUNCTION insertFileType (vname VARCHAR(200))
RETURNS INTEGER
BEGIN
	DECLARE vid INTEGER;
	SELECT id INTO vid FROM file_type WHERE name=vname;
	IF(vid IS NULL) THEN
		SELECT NEXT VALUE FOR "file_type_id_seq" into vid;
		INSERT INTO file_type(id, name) VALUES (vid, vname);
	END IF;
	RETURN vid;
END;

-- DROP FUNCTION insertPerformance;
CREATE FUNCTION insertPerformance (vtask_id INTEGER, vsubtask_id INTEGER, vmethod VARCHAR(30), vdescription VARCHAR(200), vstarttime VARCHAR(30), vendtime VARCHAR(30), vinvocation TEXT)
RETURNS INTEGER
BEGIN
	DECLARE vid INTEGER;
	IF(vsubtask_id IS NULL) THEN
		SELECT id INTO vid FROM performance WHERE method=vmethod and task_id=vtask_id;
	ELSE
		SELECT id INTO vid FROM performance WHERE method=vmethod and task_id=vtask_id and subtask_id=vsubtask_id;
	END IF;
    
    IF(vid IS NULL) THEN
    	SELECT NEXT VALUE FOR "performance_id_seq" into vid;
    	INSERT INTO performance(id,task_id,subtask_id,method,description,starttime,endtime,invocation) VALUES (vid,vtask_id,vsubtask_id,vmethod,vdescription,vstarttime,vendtime,vinvocation);
	ELSE
    	UPDATE performance
    	SET endtime = vendtime, invocation = vinvocation
    	WHERE id = vid and endtime = 'null';
	END IF;
	RETURN vid;
END;

-- DROP FUNCTION insertExtractor;
CREATE FUNCTION insertExtractor (vtag VARCHAR(20), vds_id INTEGER, vcartridge VARCHAR(20), vextension VARCHAR(20))
RETURNS INTEGER
BEGIN
	DECLARE vid INTEGER;
    SELECT id INTO vid FROM extractor WHERE tag = vtag AND ds_id = vds_id AND cartridge = vcartridge AND extension = vextension;
    IF(vid IS NULL) THEN
    	SELECT NEXT VALUE FOR "extractor_id_seq" into vid;
    	INSERT INTO extractor(id,ds_id,tag,cartridge,extension) VALUES (vid,vds_id,vtag,vcartridge,vextension);
	END IF;
	RETURN vid;
END;

-- DROP FUNCTION insertExtractorCombination;
CREATE FUNCTION insertExtractorCombination (vouter_ext_id INTEGER, vinner_ext_id INTEGER, vds_id INTEGER, vkeys VARCHAR(100), vkey_types VARCHAR(100))
RETURNS INTEGER
BEGIN
	DECLARE vid INTEGER;
    SELECT id INTO vid FROM extractor_combination WHERE outer_ext_id = vouter_ext_id AND inner_ext_id = vinner_ext_id AND ds_id = vds_id;
    IF(vid IS NULL) THEN
    	SELECT NEXT VALUE FOR "ecombination_id_seq" into vid;
    	INSERT INTO extractor_combination(outer_ext_id,inner_ext_id,keys,key_types,ds_id) VALUES (vouter_ext_id,vinner_ext_id,vkeys,vkey_types,vds_id);
	END IF;
	RETURN vid;
END;

-- DROP FUNCTION insertEpoch;
CREATE FUNCTION insertEpoch (vvalue INTEGER, velapsed_time decimal(10,2), vloss decimal(10,2), vaccuracy decimal(10,2), vepoch_timestamp VARCHAR(30), vtask_id INTEGER, vdata_transformation_execution_id INTEGER)
RETURNS INTEGER
BEGIN
	DECLARE vid INTEGER;
	SELECT id INTO vid FROM epoch WHERE value=vvalue AND task_id =vtask_id;
	IF(vid IS NULL) THEN
		SELECT NEXT VALUE FOR "epoch_id_seq" into vid;
		INSERT INTO epoch(id,value,elapsed_time,loss, accuracy, epoch_timestamp, task_id, data_transformation_execution_id) VALUES (vid,vvalue, velapsed_time, vloss, vaccuracy, vepoch_timestamp, vtask_id, vdata_transformation_execution_id);
	END IF;
	RETURN vid;
END;

-- DROP FUNCTION insertDataflowExecution;
CREATE FUNCTION insertDataflowExecution (vexecution_datetime VARCHAR(30), vdf_id INTEGER, vphysical_machine_id INTEGER, vvirtual_machine_id INTEGER)
RETURNS INTEGER
BEGIN
	DECLARE vid INTEGER;
    SELECT id INTO vid FROM dataflow_execution WHERE execution_datetime=vexecution_datetime AND df_id=vdf_id AND physical_machine_id=vphysical_machine_id AND virtual_machine_id=vvirtual_machine_id;
    IF(vid IS NULL) THEN
    	SELECT NEXT VALUE FOR "df_exec_id_seq" into vid;
    	INSERT INTO dataflow_execution(id,execution_datetime,df_id,physical_machine_id,virtual_machine_id) VALUES (vid,vexecution_datetime,vdf_id,vphysical_machine_id,vvirtual_machine_id);
	END IF;
	RETURN vid;
END;

-- DROP FUNCTION insertDataTransformationExecution;
CREATE FUNCTION insertDataTransformationExecution (vdataflow_execution_id INTEGER, vdata_transformation_tag VARCHAR(50), vexecution_datetime VARCHAR(30))
RETURNS INTEGER
BEGIN
	DECLARE vid INTEGER;
	DECLARE vdt_id INTEGER;

	SELECT dt.id INTO vdt_id
	FROM dataflow_execution dfe, data_transformation dt
	WHERE dfe.df_id = dt.df_id AND dt.tag = vdata_transformation_tag AND dfe.id = vdataflow_execution_id;

	IF(vdt_id IS NOT NULL) THEN
	    SELECT id INTO vid FROM data_transformation_execution WHERE dataflow_execution_id=vdataflow_execution_id AND data_transformation_id=vdt_id AND execution_datetime=vexecution_datetime;
	    IF(vid IS NULL) THEN
	    	SELECT NEXT VALUE FOR "dt_exec_id_seq" into vid;
	    	INSERT INTO data_transformation_execution(id,dataflow_execution_id,data_transformation_id,execution_datetime) VALUES (vid,vdataflow_execution_id,vdt_id,vexecution_datetime);
		END IF;
	END IF;
	RETURN vid;
END;

-- DROP FUNCTION insertFileTransformationExecution;
CREATE FUNCTION insertFileTransformationExecution (vfile_id INTEGER, vgeneration_datetime VARCHAR(30), vlast_modification_datetime VARCHAR(30), vdata_transformation_execution_id INTEGER)
RETURNS INTEGER
BEGIN
	DECLARE vid INTEGER;
    SELECT id INTO vid FROM file_transformation_execution WHERE file_id=vfile_id AND generation_datetime=vgeneration_datetime;
    IF(vid IS NULL) THEN
    	SELECT NEXT VALUE FOR "file_dt_id_seq" into vid;
    	INSERT INTO file_transformation_execution(id,file_id,generation_datetime,last_modification_datetime,data_transformation_execution_id) VALUES (vid,vfile_id,vgeneration_datetime,vlast_modification_datetime,vdata_transformation_execution_id);
	END IF;
	RETURN vid;
END;

-- DROP FUNCTION insertTelemetry;
CREATE FUNCTION insertTelemetry (vtask_id INTEGER, vcaptured_timestamp VARCHAR(30), vcaptured_interval VARCHAR(30), vdata_transformation_execution_id INTEGER)
RETURNS INTEGER
BEGIN
	DECLARE vid INTEGER;
	SELECT id INTO vid FROM telemetry WHERE captured_timestamp=vcaptured_timestamp AND task_id =vtask_id;
	IF(vid IS NULL) THEN
		SELECT NEXT VALUE FOR "telemetry_id_seq" into vid;
		INSERT INTO telemetry(id, task_id,  captured_timestamp, captured_interval, data_transformation_execution_id) VALUES (vid, vtask_id, vcaptured_timestamp, vcaptured_interval, vdata_transformation_execution_id);
	END IF;
	RETURN vid;
END;

-- DROP FUNCTION insertTelemetryCpu;
CREATE FUNCTION insertTelemetryCpu (vtelemetry_id INTEGER, vconsumption_timestamp VARCHAR(30), vscputimes_user VARCHAR(30), vscputimes_system VARCHAR(30), vscputimes_idle VARCHAR(30), vscputimes_steal VARCHAR(30))
RETURNS INTEGER
BEGIN
	DECLARE vid INTEGER;
	SELECT id INTO vid FROM telemetry_cpu WHERE consumption_timestamp=vconsumption_timestamp ;
	IF(vid IS NULL) THEN
		SELECT NEXT VALUE FOR "telemetry_cpu_id_seq" into vid;
		INSERT INTO telemetry_cpu(id, telemetry_id, consumption_timestamp, scputimes_user, scputimes_system, scputimes_idle, scputimes_steal) VALUES (vid, vtelemetry_id, vconsumption_timestamp, vscputimes_user, vscputimes_system, vscputimes_idle, vscputimes_steal);
	END IF;
	RETURN vid;
END;

-- DROP FUNCTION insertTelemetryDisk;
CREATE FUNCTION insertTelemetryDisk (vtelemetry_id INTEGER, vconsumption_timestamp VARCHAR(30), vsdiskio_read_bytes VARCHAR(30), vsdiskio_write_bytes VARCHAR(30), vsdiskio_busy_time VARCHAR(30), vsswap_total VARCHAR(30), vsswap_used VARCHAR(30))
RETURNS INTEGER
BEGIN
	DECLARE vid INTEGER;
	SELECT id INTO vid FROM telemetry_disk WHERE consumption_timestamp=vconsumption_timestamp;
	IF(vid IS NULL) THEN
		SELECT NEXT VALUE FOR "telemetry_disk_id_seq" into vid;
		INSERT INTO telemetry_disk(id, telemetry_id, consumption_timestamp, sdiskio_read_bytes, sdiskio_write_bytes, sdiskio_busy_time, sswap_total, sswap_used) VALUES (vid, vtelemetry_id, vconsumption_timestamp, vsdiskio_read_bytes, vsdiskio_write_bytes, vsdiskio_busy_time, vsswap_total, vsswap_used);
	END IF;
	RETURN vid;
END;

-- DROP FUNCTION insertTelemetryMemory;
CREATE FUNCTION insertTelemetryMemory (vtelemetry_id INTEGER, vconsumption_timestamp VARCHAR(30), vsvmem_total VARCHAR(30), vsvmem_available VARCHAR(30), vsvmem_used VARCHAR(30))
RETURNS INTEGER
BEGIN
	DECLARE vid INTEGER;
	SELECT id INTO vid FROM telemetry_memory WHERE consumption_timestamp=vconsumption_timestamp;
	IF(vid IS NULL) THEN
		SELECT NEXT VALUE FOR "telemetry_memory_id_seq" into vid;
		INSERT INTO telemetry_memory(id, telemetry_id, consumption_timestamp, svmem_total , svmem_available, svmem_used) VALUES (vid, vtelemetry_id, vconsumption_timestamp, vsvmem_total , vsvmem_available, vsvmem_used);
	END IF;
	RETURN vid;
END;

-- DROP FUNCTION insertTelemetryNetwork;
CREATE FUNCTION insertTelemetryNetwork (vtelemetry_id INTEGER, vconsumption_timestamp VARCHAR(30), vconsumption_value VARCHAR(30))
RETURNS INTEGER
BEGIN
	DECLARE vid INTEGER;
	SELECT id INTO vid FROM telemetry_network WHERE consumption_timestamp=vconsumption_timestamp;
	IF(vid IS NULL) THEN
		SELECT NEXT VALUE FOR "telemetry_network_id_seq" into vid;
		INSERT INTO telemetry_network(id, telemetry_id, consumption_timestamp, consumption_value) VALUES (vid, vtelemetry_id, vconsumption_timestamp, vconsumption_value);
	END IF;
	RETURN vid;
END;


COMMIT;
