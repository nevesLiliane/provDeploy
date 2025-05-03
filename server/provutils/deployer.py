import os, subprocess, time, shutil
from . import connection, config, database

import json, shutil

codes = []
images=[]
exec_commands=[]

def start_prov_collector():

    if not connection.isPortInUse(config.MONETPORT):
        start_database(config.MONETPORT)
    if not connection.isPortInUse(config.DFANALYZER_PORT):
        path, run_line = database.get_default_provCollector()
        print("Starting provCollector")
        #print(run_line)
        start(path, run_line, "&" )
        #time.sleep(22)
        # teste de status code pra colocar no start geral https://stackoverflow.com/questions/20867184/how-to-check-whether-my-server-is-up-and-running-using-python  
  
    

def start_application(configuration, application, exec_command):
    path, run_line = database.get_configuration_path(configuration)
    if not run_line=='':
        exec_command=run_line
    start(path, exec_command, application)

# esta versão da start_application prioriza a chamada do usuário
def start_application2(configuration, application, exec_command):
    path, run_line = database.get_configuration_path(configuration)
    if exec_command=='':
        exec_command=run_line
    else: exec_command = run_line.split(" ")[0]+ " " + exec_command # concatenando os comandos pois o usuário não sabe onde ficam guardadas as imagens
    start(path, exec_command, application)

def start(path, run_line,arguments=""):
    old_path = os.path.dirname(__file__)

    os.chdir(config.HOME_PROV_DEPLOY)
    print(run_line +" "+ arguments + path + "")    
    #os.system(run_line +" "+ arguments)
    #python3 Example_provDeploy/script1.pyrecipes/application/readSeq-ModelGenerator-py
    p = subprocess.call(run_line +" "+ arguments, shell=True)
    

    os.chdir(config.HOME_PROV_DEPLOY)

def start_database(port=config.MONETPORT):

    if not connection.isPortInUse():
        path= "recipes/database/DfAnalyzer"
        run_line =" singularity run ./recipes/database/database.sif ./recipes/database/DfAnalyzer/start-provdeploy-database.sh"         
    else:
        path, run_line = database.get_default_database(port)
    start(path, run_line)
    time.sleep(31) 

def add_new_configuration(input_file):
    with open(input_file) as json_file:
        data = json.load(json_file)
        for p in data['new_conf']:
            path = p['path']

            image_name = p['filename']
            name = p['name']

            description = p['description']      
            run_line = p['runcommand']  
            tag = p['tag']  

            recipes_path = "/recipes/application/"
            
            if 'prov' in p:
                recipes_path = "/recipes/provCollector/" #terminar, diferenciando banco de dados e inserindo no banco com typos diferents
            if 'db' in p:
                recipes_path = "/recipes/database/"

            creation_path = config.HOME_PROV_DEPLOY+recipes_path+name.strip()
            if not(os.path.exists(creation_path) and os.path.isdir(creation_path)):
                os.mkdir(creation_path)
            
            if not(os.path.isfile(path+image_name)):
                pull_image(tag, creation_path, p['vendor'])
            else:
                shutil.copy2(path+image_name, creation_path)
            
            
            if p['vendor'] =="singularity" :
                inspect= subprocess.getoutput("singularity inspect " + creation_path+ "/"+image_name)
                
                arch, creation_date, version_schema, library, origin, eversion = inspect.split("\n")
                #print(arch, creation_date, version_schema, library, origin, eversion)
                
                from datetime import datetime 
                date_str = creation_date.split(":",1)[1].strip()+'00'

                # Formato personalizado
                date_format = "%A_%d_%B_%Y_%H:%M:%S_%z"

                # Converter a string para um objeto datetime
                build_date = datetime.strptime(date_str, date_format)

             
                if not connection.isPortInUse():
                        start_database()       
                database.add_configuration_path(name, recipes_path+name.strip(), description, run_line, arch.split(":")[1], build_date, version_schema.split(":")[1], 
                                                library.split(":")[1], origin.split(":")[1], eversion.split(":")[1], p['vendor'])
            elif p['vendor'] == "docker":
                inspect= subprocess.getoutput("docker inspect " + image_name)
                print(inspect)

                hash=inspect['Id']
                tag=inspect['RepoTags']
                base_image=inspect['Parent']
                configuration=inspect['Config']
                arch= inspect['Architecture']
                os= inspect['Os']
                rootfs= inspect['RootFS']
                creation_date= inspect['Created']
                user=inspect['author']

                if not connection.isPortInUse():
                    start_database()  
                database.add_configuration_path(name, recipes_path+name.strip(), description, run_line, arch.split(":")[1], creation_date, version_schema.split(":")[1],
                                                library.split(":")[1], origin.split(":")[1], eversion.split(":")[1], p['vendor'])


def pull_image(image_tag, path_name, vendor):
        if vendor=="singularity" :
                os.system("singularity pull " + image_tag + " "+ path_name)

def start_submit(input_file):
    
    with open(input_file) as json_file:
        data = json.load(json_file)

        #app = data['application']
        #name_config = data['config_alias']
        #ler o json
        path = data['path']
        exec_path= "./"
        print(exec_path)
        workflow_name = data['workflow']
        activities = data['act']
        location = data['machine']
        
        #shutil.copytree(path, exec_path, dirs_exist_ok=True)
        #shutil.copy('provutils/provdeploy.py', '.')
        
        imagec =''
        strategy='F'
        
        if 'image' in data.keys() and data['machine']: #se o primeiro nivel do wf description tem uma imagem associada
            #print("It is coarse!")
            strategy='C'
            if not('exec_command' in data.keys()) :
                print("Please provide a execution command in the submit file")

            else: 
                imagec= data['image']
                single_execution(workflow_name,activities, location, path, imagec, data['exec_command']);
        
        else:
            
            for a in activities:
                codes.append(a['code'])
                images.append(a['image'])
                exec_commands.append(a['exec_command'])
                
            for code in codes:
            
                if len(codes) > codes.index(code)+1:

                    atual = code
                    prox = codes[codes.index(code)+1]
                    if isinstance(atual, list): #se é hibrido
                        strategy='H'
                        atual = atual[-1] # é apenas o ultimo script de um bloco e o primeiro do proximo bloco que serão olhados e alterados em busca do gancho de um pro outro
                    if isinstance(prox, list):    
                        prox = prox[0]
                        strategy='H'
                    #print("n:" + path + "a:" + atual) 
                    if not(search_str(path+atual, prox)):
                        print("The workflow is not well descripted in the configuration file, please review the description file and the scripts provided.")
                        exit();
                    else:
                        replace_call(exec_path, atual, prox, workflow_name)
            database.save_workflow_description(workflow_name, activities, strategy, imagec)
            single_execution(workflow_name,activities, location, exec_path, images[0],exec_commands[0],strategy)    
        
                
        '''    
        if location == 'local':
            start_prov_collector()
            start_application(name_config, app)
        else:
            start_remote_submit(name_config, app, location)
        
        
        if isinstance(app, dict): #dict marca o 
        else:
        '''
        
        
def start_submit_detached(input_file):
    
    with open(input_file) as json_file:
        data = json.load(json_file)

        #app = data['application']
        #name_config = data['config_alias']
        #ler o json
        path = data['path']
        exec_path= data['act'][0]['lpath']
        print(exec_path)
        workflow_name = data['workflow']
        activities = data['act']
        location = data['machine']
        
        #shutil.copytree(path, exec_path, dirs_exist_ok=True)
        #shutil.copy('provutils/provdeploy.py', '.')
        
        imagec =''
        strategy='F'
        
        if 'image' in data.keys() and data['machine']: #se o primeiro nivel do wf description tem uma imagem associada
            #print("It is coarse!")
            strategy='C'
            if not('exec_command' in data.keys()) :
                print("Please provide a execution command in the submit file")

            else: 
                imagec= data['image']
                single_execution(workflow_name,activities, location, path, imagec, data['exec_command']);
        
        else:
            
            for a in activities:
                codes.append(a['code'])
                images.append(a['image'])
                exec_commands.append(a['exec_command'])
            
                single_execution(workflow_name,activities, location, a['lpath'], a['image'],a['exec_command'])
                
            for code in codes:
            
                if len(codes) > codes.index(code)+1:

                    atual = code
                    prox = codes[codes.index(code)+1]
                    if isinstance(atual, list): #se é hibrido
                        strategy='H'
                        atual = atual[-1] # é apenas o ultimo script de um bloco e o primeiro do proximo bloco que serão olhados e alterados em busca do gancho de um pro outro
                    if isinstance(prox, list):    
                        prox = prox[0]
                        strategy='H'
            database.save_workflow_description(workflow_name, activities, strategy, imagec)
            
            
def single_execution(workflow_name,activities, location, path, image, exec_command,strategy=''):
    
    primeiro_script = activities[0]['code']
    if isinstance(activities[0]['code'],list):
        #aqui Activity é um array de códigos
        primeiro_script = activities[0]['code'][0]
        start_server()
    elif strategy=='F':
        start_server()
        
    #
    if location == 'local':
        start_prov_collector()
        start_application2( image, path+primeiro_script, exec_command) #(configuration, application, exec_command
    else:
        start_remote_submit(primeiro_script, image, location, exec_command)

def start_server():
    if not connection.isPortInUse(config.FLASKPORT):
        p = os.system("export FLASK_APP=server.py && flask run & ")
    

def search_str(file_path, word):

    with open(file_path, 'r') as file:
        # read all content of a file
        content = file.read()
        # check if string present in a file
        if word in content:
            #print('string exist in a file')
            return True;
        else:
            print('The code '+word + ' is not being called in file ' + file_path)


def replace_call(path, file_name, next_file, workflow_name):
    
    import sys
    import fileinput

    # replace all occurrences of 'sit' with 'SIT' and insert a line after the 5th
    #print(path+file_name)
    for i, line in enumerate(fileinput.input(path+file_name, inplace=1)):
        if next_file in line: 
            #line='from provutils import deployer \ndeployer.run_next(\''+ next_file +'\', \''+ workflow_name+'\')'
            line='import provdeploy \nprovdeploy.call_next(\''+ next_file +'\', \''+ workflow_name+'\')'
            #line = 'import requests \nr = requests.post("http://localhost:'+str(config.FLASKPORT)+'/post", data={\'script\': \''+next_file+'\', \'workflow\':\''+ workflow_name +'\'})'
            #print('depois')
        sys.stdout.write(line )  # replace 'sit' and write
            #if i == 4: sys.stdout.write('\n')  # write a blank line after the 5th line
        
    
    #print(file_name)
    '''with open(path+file_name, 'r+') as file:
        # read all content of a file
        content = file.read()
        # check if string present in a file
        if next_file in content:
            print('string existtt in a file')
            return True;    
            '''

    #criar o research object
    #create_ro(database.get_default_database_recipe(),database.get_default_provCollector_recipe(),database.get_configuration_recipe(configuration), path)


def start_remote_submit(name_config, app, location, exec_command):
    
    with open('server.json') as json_file:
        data = json.load(json_file)
        for p in data['machine']:
            if p['name']==location :
                user = p['user']
                server = p['server']
                port = p['port']
                password = p['password']
                if password== 'empty' :
                    con = connection.connect(server, port)
                elif password== 'interactive' :
                    con= connection.connect(server, port, user)
                else:
                    con= connection.connect(server, port, user, password)

                chan = con.open_session(timeout=10)
                chan.exec_command(start_prov_collector())
                chan.exec_command(start_application2(name_config, app,exec_command))

                break;
                
def run_next(script, workflow):
    indice = 0
    print("Script " + script+ "Workflow" + workflow)
    activity, script, exec_command, image_name= database.get_workflow_activity(script, workflow)
    
    print(activity, script, exec_command, image_name)
    start_application2( image_name, script, exec_command)
                

def wrap(key):
    recipes = database.get_recipe_images_execution()
    create_ro_recipes(recipes)

def create_ro_recipes(recipes):

#    headers = ['%post', '%environment', '%runscript', '%labels', '%files', '%setup']
    sections = []

    for file in recipes:
        section_index = 0
        mb = False
        with open(file) as f:
            for line in f:
                if ('%' in line):
                    mb = True
                if (mb == True):
                    sections.append(line)
               
    print(sections)

    f = open("result.def", "w")
    f.write("BootStrap: library \n")
    f.write("From:dtrudg/linux/ubuntu:18.04 \n")
    for s in sections:
        f.write(s)

    f.close() 
    
def access_database(database):
    if database=="container":
        instance="contprov"
    
    elif database=="provenance":
        instance="dataprov"
    else: print(database + " is not a valid option, please define if you want to access the workflow provenance database or the container provenance database")

    if not connection.isPortInUse():
        start_database();         
    
    os.system("singularity run ./recipes/database/database.sif mclient -d " + instance + " -p "+ str(config.MONETPORT)) 
    

# Testando o flask direto no deployer

from flask import Flask, request
from provutils import deployer

app = Flask(__name__)

@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"


@app.route('/post', methods=['POST'])
def result():
    print("O flask de milhões vai fazer sua mágica")
    deployer.run_next(request.form['script'],request.form['workflow'])
    '''print(request.form['script'])
    print(request.form['workflow']) # should display '''
    
    return 'Received! '# response to your request.    
