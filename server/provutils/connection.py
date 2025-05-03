import socket, errno
from . import config


'''def isPortInUse(PORT):
	s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

	try:
	    s.connect_ex(("127.0.0.1", PORT))
	except socket.error as e:
	    if e.errno == errno.EADDRINUSE:
	    	print("Porta em uso")
	    	return True;
	    else:
	        # something else raised the socket.error exception
	        print("Porta vazia")
	        return False;

	s.close() '''

def isPortInUse(port=config.MONETPORT):
    import socket
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        return s.connect_ex(('localhost', port)) == 0


def connect(server,port):
	from paramiko import SSHClient
	client = SSHClient()
	client.load_system_host_keys()
	client.connect(server, port)
	#stdin, stdout, stderr = client.exec_command('ls -l')

	return client;

def connect(server,port,user):
	print("If you do not provide a password you will do the interactive login")
	s = paramiko.Transport((server, port))
	ts.start_client()
	ts.auth_interactive_dumb(username=user, handler='', submethods="")

	chan = ts.open_session(timeout=10)
	return chan
    # print("aqui")

    # print (chan.exec_command("ls -l"))
    # chan.exec_command("touch ~/paramikotestfile")

    # ts.close()


def connect(server,port,user,password):
	ssh = SSHClient()
	ssh.load_system_host_keys()
	ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
	ssh.connect(hostname=server,username=user,password=password, port=port)

	return ssh;


