from flask import Flask, request
import socket

app = Flask(__name__)

@app.route("/")
def getIpAddress():
    host_name = socket.gethostname()

    ip_address = socket.gethostbyname(host_name)
    return '<h1> Your IP address: ' + ip_address


if __name__ == '__main__':
    app.run(debug=True)


from flask import Flask, request
import socket

app = Flask(__name__)

@app.route("/")
def hello_world():
	ip_addr = socket.gethostbyname(socket.gethostname())
    return "<h1>Your IP address is: {}</h1>".format(ip_addr)

if __name__ == "__main__":
    app.run(debug=True)
    
from flask import Flask, request
import socket

app = Flask(__name__)

@app.route('/')
def hello_world():
    host_name = socket.gethostname()
    
    ip_address = socket.gethostbyname(host_name)
    return '<h1> Your IP address is:' + ip_address


if __name__ == '__main__':
    app.run(debug=True)

