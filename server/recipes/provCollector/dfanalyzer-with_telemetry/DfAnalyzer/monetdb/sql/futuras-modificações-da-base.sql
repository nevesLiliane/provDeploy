CREATE TABLE user(
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
	owner_user_id INTEGER NOT NULL,
	ram INTEGER NOT NULL,
	disk INTEGER NOT NULL,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("owner_user_id") REFERENCES user("id") ON DELETE CASCADE ON UPDATE CASCADE
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

-- DROP FUNCTION insertUser;
CREATE FUNCTION insertUser (vname VARCHAR(50), vemail INTEGER)
RETURNS INTEGER
BEGIN
	DECLARE vid INTEGER;
    SELECT id INTO vid FROM user WHERE name=vname AND email=vemail;
    IF(vid IS NULL) THEN
    	SELECT NEXT VALUE FOR "user_id_seq" into vid;
    	INSERT INTO user(id,name,email) VALUES (vid,vname,vemail);
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
    	INSERT INTO virtual_machine(id,name,ram,disk,physical_machine_id) VALUES (vid,vname,vram,vdisk,vphysical_machine_id;
	END IF;
	RETURN vid;
END;

###################################################################################

CREATE TABLE dataflow(
	id INTEGER DEFAULT NEXT VALUE FOR "df_id_seq" NOT NULL,
	tag VARCHAR(50) NOT NULL,
	user_id INTEGER NOT NULL,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("user_id") REFERENCES user("id") ON DELETE CASCADE ON UPDATE CASCADE
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
	program_id INTEGER NOT NULL,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("df_id") REFERENCES dataflow("id") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ("program_id") REFERENCES program("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- DROP FUNCTION insertDataflow;
CREATE FUNCTION insertDataflow (v_tag VARCHAR(50), user_id INTEGER)
RETURNS INTEGER
BEGIN
	DECLARE v_df_id INTEGER;
    SELECT df.id INTO v_df_id FROM dataflow df WHERE df.tag=v_tag AND df.user_id=v_user_id;
    IF(v_df_id IS NULL) THEN
    	SELECT NEXT VALUE FOR "df_id_seq" into v_df_id;
    	INSERT INTO dataflow(id,tag,user_id) VALUES (v_df_id,v_tag,vuser_id);
	END IF;
	RETURN v_df_id;
END;

-- DROP FUNCTION insertProgram;
CREATE FUNCTION insertProgram (dt_id INTEGER, vname VARCHAR(200), vversion VARCHAR(50))
RETURNS INTEGER
BEGIN
	DECLARE vprogram_id INTEGER;
    SELECT id INTO vprogram_id FROM program p WHERE name = vname AND version = vversion;

    IF(vprogram_id IS NULL) THEN
    	SELECT NEXT VALUE FOR "program_id_seq" into vprogram_id;
    	INSERT INTO program(id,name,version) VALUES (vprogram_id,vname,vversion);
	END IF;
	INSERT INTO use_program(dt_id,program_id) VALUES (vdt_id,vprogram_id);
	RETURN vprogram_id;
END;

-- DROP FUNCTION insertDataTransformation;
CREATE FUNCTION insertDataTransformation (vdt_id INTEGER, vtag VARCHAR(50), vdf_id INTEGER, vprogram_id INTEGER)
RETURNS INTEGER
BEGIN
	DECLARE vdt_id INTEGER;
    SELECT id INTO vdt_id FROM data_transformation WHERE df_id = vdf_id AND tag = vtag;
    IF(vdt_id IS NULL) THEN
    	SELECT NEXT VALUE FOR "dt_id_seq" into vdt_id;
    	INSERT INTO data_transformation(id,tag,df_id,program_id) VALUES (vdt_id,vtag,vdf_id,vprogram_id);
	END IF;
	RETURN vdt_id;
END;

###################################################################################

CREATE TABLE dataflow_execution(
	id INTEGER DEFAULT NEXT VALUE FOR "df_exec_id_seq" NOT NULL,
	execution_datetime VARCHAR(30) NOT NULL,
	df_id INTEGER NOT NULL,
	physical_machine_id INTEGER NOT NULL,
	virtual_machine_id INTEGER NOT NULL,
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
	input_schema_id INTEGER NOT NULL,
	output_schema_id INTEGER NOT NULL,
	epoch_id INTEGER NOT NULL,
	data_transformation_execution_id INTEGER NOT NULL,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("file_id") REFERENCES file("id") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ("epoch_id") REFERENCES epoch("id") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ("data_transformation_execution_id") REFERENCES data_transformation_execution("id") ON DELETE CASCADE ON UPDATE CASCADE
);

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
CREATE FUNCTION insertDataTransformationExecution (vdataflow_execution_id INTEGER, vdata_transformation_id INTEGER, vexecution_datetime VARCHAR(30))
RETURNS INTEGER
BEGIN
	DECLARE vid INTEGER;
    SELECT id INTO vid FROM data_transformation_execution WHERE dataflow_execution_id=vdataflow_execution_id AND data_transformation_id=vdata_transformation_id AND execution_datetime=vexecution_datetime;
    IF(vid IS NULL) THEN
    	SELECT NEXT VALUE FOR "dt_exec_id_seq" into vid;
    	INSERT INTO data_transformation_execution(id,dataflow_execution_id,data_transformation_id,execution_datetime) VALUES (vid,vdataflow_execution_id,vdata_transformation_id,vexecution_datetime);
	END IF;
	RETURN vid;
END;

-- DROP FUNCTION insertFileTransformationExecution;
CREATE FUNCTION insertFileTransformationExecution (vfile_id INTEGER, vgeneration_datetime VARCHAR(30), vlast_modification_datetime VARCHAR(30), vinput_schema_id INTEGER, voutput_schema_id INTEGER, vepoch_id INTEGER,	vdata_transformation_execution_id INTEGER)
RETURNS INTEGER
BEGIN
	DECLARE vid INTEGER;
    SELECT id INTO vid FROM file_transformation_execution WHERE file_id=vfile_id AND generation_datetime=vgeneration_datetime AND last_modification_datetime=vlast_modification_datetime;
    IF(vid IS NULL) THEN
    	SELECT NEXT VALUE FOR "file_dt_id_seq" into vid;
    	INSERT INTO file_transformation_execution(id,file_id,generation_datetime,last_modification_datetime,input_schema_id,output_schema_id,epoch_id,data_transformation_execution_id) VALUES (vid,vfile_id,vgeneration_datetime,vlast_modification_datetime,vinput_schema_id,voutput_schema_id,vepoch_id,vdata_transformation_execution_id);
	END IF;
	RETURN vid;
END;

###################################################################################
