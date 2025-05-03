from flask import Flask, request
from provutils import deployer

app = Flask(__name__)

@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"


@app.route('/post', methods=['POST'])
def result():
	print("O flask de milhões vi fazer sua mágica")
	deployer.run_next(request.form['script'],request.form['workflow'])
	'''print(request.form['script'])
	print(request.form['workflow']) # should display '''
	
	return 'Received! '# response to your request.


# como matar o flask , descobrir o processo com netstat -tulnp | grep :5000 e depois dar kill no processo, cuidado para não matar o monetdb
