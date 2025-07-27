from provutils import database, deployer
import argparse

parser = argparse.ArgumentParser(description='ProvDeploy: an automatic deployment tool for provenance data capture.')
parser.add_argument('-l', dest='list',help='list the available configurations', action='store_true')
parser.add_argument('-s', dest='run', help='run application with default provenance data capture application')
parser.add_argument('-n', dest='new', help='enter new configuration/provCollector if you want to run in a different machine, provide a \
	server.json file with the server information')
parser.add_argument('-a', dest='access', help='access database')
parser.add_argument('-w', dest='wrap', help='wrap execution, you have to provide the workflow name ')
args = parser.parse_args()

if args.list is True :
	database.list_configurations()
elif args.run is not None :
	deployer.start_submit(args.run)
elif args.new is not None :
	deployer.add_new_configuration(args.new)
elif args.access is not None :
	deployer.access_database(args.access)
elif args.wrap is not None :
	deployer.wrap(args.wrap)
