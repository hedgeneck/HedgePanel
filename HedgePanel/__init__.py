from flask import Flask

app = Flask(__name__)
app.config['SECRET_KEY'] = 'dbfd46992a739efa9b8f10ebc97338b4'

from HedgePanel import routes