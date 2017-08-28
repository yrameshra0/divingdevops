import os
import socket
from flask import Flask
from flask.ext.sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SALALCHEMY_DATABASE_URI'] = os.environ['DATABASE_URI']
db = SQLAlchemy(app)
hostname = socket.gethostname()


@app.route('/')
def index():
    return 'Hello from sunny, %s!\n' % hostname


@app.route('/db')
def dbtest():
    try:
        db.create_all()
    except Exception as e:
        return e.message + '\n'
    return 'Database connected from %s!\n' + hostname


if __name__ == '__main__':
    app.run()
