from threading import Thread
from . import connection, config, deployer
import datetime, numpy as np

def async_thread(f):
    def wrapper(*args, **kwargs):
        thr = Thread(target=f, args=args, kwargs=kwargs)
        thr.start()
    return wrapper

def monet_db_connection(instance,port=config.MONETPORT):

        import pymonetdb
        connection = pymonetdb.connect(username="monetdb", password="monetdb", hostname="localhost", database=instance, port=port)
        return connection

def get_db_cursor(instance, port=config.MONETPORT):
    monetdb_connection = monet_db_connection(instance)
    cursor = monetdb_connection.cursor()
    return cursor

@async_thread
def list_configurations():

	if not connection.isPortInUse():
		deployer.start_database(config.MONETPORT)
	cursor = get_db_cursor(config.CONTAINER_PROVENANCE)
	cursor.execute("SELECT name, description FROM image;")
	for n in cursor.fetchall() :
        	print("Flag: " + n[0], ", Description: " + n[1])

def get_configuration_path(config_name):
    cursor = get_db_cursor(config.CONTAINER_PROVENANCE)
    #cursor.execute("SELECT image_path, execution_command FROM config where name='{}';".format(config_name))
    cursor.execute("SELECT image_path, execution_command FROM container_image where name='{}';".format(config_name))
    result = cursor.fetchone()
   
    if result is None :
        print( "There is no configuration by the name {}, if you want to, you can add it up".format(config_name) )
        return
    else :
        return result[0], result[1]

def add_configuration_path(name, path, description,run_line, arch, creation_date="", schemaversion="", library="", origin="", engine_version="", engine=""):
    cursor = get_db_cursor(config.CONTAINER_PROVENANCE)
   # query = "INSERT INTO config (name, image_path, description, default_provData, type, execution_command, shub_url) VALUES ('{}', '{}', '{}', 0, 'a', '{}', '{}');".format(name, path, description, run_line, shub)
    #query = "INSERT INTO container_image (name, image_path, description, default_prov, image_type, execution_command, arch, created, schema_version, lib_origin, base_image_id, engine_version, vendor) VALUES ('{}', '{}', '{}', 0, 'a', '{}', '{}', '{}', '{}', '{}', (select id from container_image where execution_command like '%{}%'), '{}' , '{}');".format(name, path, description, run_line, arch, creation_date, schemaversion,library, origin.strip() , engine_version, engine )
    
    query = "INSERT INTO container_image (name, image_path, description, default_prov, image_type, execution_command, arch, created, schema_version, lib_origin, base_image_id, engine_version, vendor) "    
    query += "select '{}', '{}', '{}', 0, 'a', '{}', '{}', '{}', '{}', '{}', id , '{}' , '{}' from container_image where execution_command like '%{}%' limit 1;".format(name, path, description, run_line, arch, creation_date, schemaversion,library, engine_version, engine, origin.strip() )

    print(query)
    cursor.execute(query)
    cursor.execute("COMMIT;")
    
def insert_workflow(name):
    cursor = get_db_cursor(config.CONTAINER_PROVENANCE)
    query = "INSERT INTO workflow (workflow) VALUES ('{}');".format(name)
    cursor.execute(query)
    cursor.execute("COMMIT;")
    
def get_last_workflow_id():
    cursor = get_db_cursor(config.CONTAINER_PROVENANCE)
    query = "Select max(id) from workflow;"
    cursor.execute(query)
    
    return np.asarray(cursor.fetchone())[0]

def insert_execution(strategy,workflow_id):
    cursor = get_db_cursor(config.CONTAINER_PROVENANCE)
    
    query = "INSERT INTO execution (timestamp,composition, wf_id) VALUES ('{}','{}', '{}');".format(datetime.datetime.now(), config.composition[strategy],workflow_id)
    #print(query)
    cursor.execute(query)
    cursor.execute("COMMIT;")
    
def get_last_execution_id():
    cursor = get_db_cursor(config.CONTAINER_PROVENANCE)
    query = "Select max(id) from execution;"
    cursor.execute(query)
    
    return np.asarray(cursor.fetchone())[0]

def get_image_id_by_name(name):
    cursor = get_db_cursor(config.CONTAINER_PROVENANCE)
    #print("SELECT id FROM image where name='{}';".format(name))
    cursor.execute("SELECT id FROM container_image where name='{}';".format(name))
    result = cursor.fetchone()
    return np.asarray(result)[0]  

def save_workflow_description(name, activities, strategy,image=''):
	if not connection.isPortInUse():
		deployer.start_database(config.MONETPORT)
	insert_workflow(name)
	id_wf = get_last_workflow_id()
	insert_execution(strategy,id_wf)
	id_exec = get_last_execution_id()
	
	cursor = get_db_cursor(config.CONTAINER_PROVENANCE)
	
	for a in activities:
		if isinstance(a['code'], list):#this is hybrid hell
			for code in a['code']:
				query = "INSERT INTO workflow_execution(wf_id,activity, script, exec_command,image_id,exec_id ) VALUES ('{}','{}','{}','{}','{}','{}');".format(id_wf, code, code, a['exec_command'], get_image_id_by_name(a['image'] if image=='' else image),id_exec)
				cursor.execute(query)
		else: 
			query = "INSERT INTO workflow_execution(wf_id,activity, script, exec_command,image_id,exec_id ) VALUES ('{}','{}','{}','{}','{}','{}');".format(id_wf, a['code'],a['code'], a['exec_command'], get_image_id_by_name(a['image'] if image=='' else image),id_exec) 
			cursor.execute(query)
		#print(query)
		
		cursor.execute("COMMIT;")

def get_workflow_activity(script, workflow):
	
	cursor = get_db_cursor(config.CONTAINER_PROVENANCE)

	query="SELECT activity, script, exec_command, image.name FROM workflow_execution JOIN container_image on image_id=image.id where script='{}' and wf_id=(select max(id) from workflow where workflow='{}');".format(script, workflow)
	#print(query)
	cursor.execute(query)
	result = cursor.fetchone()
	#print(result)
	
	return result  

def get_default_provCollector():
    if not connection.isPortInUse():
        os.system(get_default_database())

    cursor = get_db_cursor(config.CONTAINER_PROVENANCE)
    cursor.execute("SELECT image_path, execution_command FROM container_image where default_prov=1 and image_type='provCollector';")
    result = cursor.fetchone()
    if result is None :
        print( "There is no default provenance collector registered")
    else:
        return result[0], result[1]

@async_thread
def add_provCollector_path(name, path):
    cursor = get_db_cursor()
    cursor.execute("INSERT INTO image(name, image_path, description, image_type) VALUES ({}, {}, 'hybrid data collection application','h');".format(name, path))
    cursor.execute("COMMIT;")

def get_default_database(port=config.MONETPORT):
    cursor = get_db_cursor(config.CONTAINER_PROVENANCE)
    cursor.execute("SELECT image_path, execution_command FROM container_image where type='database' and default_prov=1;")
    result = cursor.fetchone()
    return result[0], result[1]

def get_config_by_id(id):
    cursor = get_db_cursor()
    cursor.execute("SELECT id, name, image_path, description, default_prov, type, url, execution_command, config_file FROM container_image where id={};".format(id))
    result = cursor.fetchone()
    return result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8]
    	
def get_id_images_last_execution():
	configs=[]
	cursor = get_db_cursor()
	cursor.execute("SELECT image_id FROM container where execution_id=(SELECT max(id) FROM execution);")
	for n in cursor.fetchall() :
		id, name, image_path, description, default_prov_data, image_type, shub_url , execution_command, recipe_path = get_config_by_id(n)
		configs.append(recipe_path)
		return configs

def get_recipe_images_last_execution():
	configs=[]
	cursor = get_db_cursor(config.CONTAINER_PROVENANCE)
	cursor.execute("SELECT config_file, image_path FROM container c join container_image ci on c.image_id=ci.id where execution_id=(SELECT max(id) FROM execution);")
	for n in cursor.fetchall() :
		#recipe, image_path = n
		configs.append(n)
		return configs

def get_recipe_images_by_execution_id(key):
    # todo
	configs=[]
	cursor = get_db_cursor(config.CONTAINER_PROVENANCE)
	cursor.execute("SELECT config_file, image_path FROM container c join container_image ci on c.image_id=ci.id where execution_id=(SELECT max(id) FROM execution);")
	for n in cursor.fetchall() :
		#recipe, image_path = n
		configs.append(n)
		return configs

def get_recipe_images_by_execution_workflow_name(key):
	#todo
	configs=[]
	cursor = get_db_cursor(config.CONTAINER_PROVENANCE)
	cursor.execute("SELECT config_file, image_path FROM container c join container_image ci on c.image_id=ci.id where execution_id=(SELECT max(id) FROM execution);")
	for n in cursor.fetchall() :
		#recipe, image_path = n
		configs.append(n)
		return configs

'''    if strategy='F' or strategy='C'
	for a in activities:
    		query = "INSERT INTO workflow_execution(wf_id,activity, script, exec_command,image_id,exec_id ) VALUES ('{}','{}','{}','{}','{}','{}');".format(id_wf, a['code'],a['code'], a['exec_command'], get_image_id_by_name(a['image'] if image=='' else image),id_exec) 
    else''' 
