#import requests
#from provutils import application


def call_next(script, workflow):
	'''import requests
	r = requests.post("http://localhost:5000/post", data={'script': script, 'workflow':workflow})
	
	#application.run_next(script);
	print(r.text)'''
	from urllib import request, parse
	data = parse.urlencode({'script': script, 'workflow':workflow}).encode()
	req =  request.Request('http://localhost:5000/post', data=data) # this will make the method "POST"
	resp = request.urlopen(req)
	
	
	
#call_next('test')




# And done.


