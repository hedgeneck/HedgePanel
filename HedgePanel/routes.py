from flask import render_template
from HedgePanel import app
from HedgePanel.models import CDI_CETIP

posts = [
	{
		'author': 'Gustavo Comerlatto',
		'title': 'Blog Post 1',
		'content': 'First post content',
		'date_posted': 'April 20, 2018'
	},
	{
		'author': 'Mariana Mendes',
		'title': 'Blog Post 2',
		'content': 'Second post content',
		'date_posted': 'April 21, 2018'
	}
]

@app.route("/")
@app.route("/home")
def home():
	return render_template('home.html')

@app.route("/about")
def about():
	return render_template('about.html')

@app.route("/highcharts_example")
def highcharts_example(chartID = 'char_id', chart_type = 'bar', chart_height = 500):
	chart = {"renderTo": chartID, "type": chart_type, "height": chart_height,}
	series = [{"name": 'Label1', "data": [1,2,3]}, {"name": 'Label2', "data": [4, 5, 6]}]
	title = {"text": 'My Title'}
	xAxis = {"categories": ['xAxis Data1', 'xAxis Data2', 'xAxis Data3']}
	yAxis = {"title": {"text": 'yAxis Label'}}
	return render_template('highcharts_example.html', chartID=chartID, chart=chart, series=series, title=title, xAxis=xAxis, yAxis=yAxis)

import numpy as np

def random_walk(start=0, n=10, sigma=2):
	rw = [start]

	for i in range(1,n):
		rw.append(rw[-1]+np.random.normal(0, sigma)) 

	return rw

x = random_walk(100,20,1)

# é basicamente o primeiro grafico que tu fez, o eixo X tava avacalhado
# usava categories do xAxis
@app.route("/grafico_1")
def grafico_1(chartID = 'char_id', chart_type = 'line', chart_height = 400):
	chart = {"renderTo": chartID, "type": chart_type, "height": chart_height,}
	series = [{"name": 'Label1', "data": x}]
	title = {"text": 'CDI média diária'}
	xAxis = {"categories": ['xAxis Data1', 'xAxis Data2', 'xAxis Data3']}
	yAxis = {"title": {"text": 'yAxis Label'}}
	return render_template('grafico_1.html', chartID=chartID, chart=chart, series=series, title=title, xAxis=xAxis, yAxis=yAxis)

y = [
	[
		1167609600000,
		0.7537
	],
	[
		1167696000000,
		0.7537
	],
	[
		1167782400000,
		0.7559
	],
	[
		1167868800000,
		0.7631
	],
	[
		1167955200000,
		0.7644
	],
	[
		1168214400000,
		0.769
	],
	[
		1168300800000,
		0.7683
	],
	[
		1168387200000,
		0.77
	],
	[
		1168473600000,
		0.7703
	],
	[
		1168560000000,
		0.7757
	],
	[
		1168819200000,
		0.7728
	],
	[
		1168905600000,
		0.7721
	]
]

# é basicamente um gráfico mas trabalhando com o eixo X como datetime
# os dados tem que ser passados como array of arrays
@app.route("/grafico_2")
def grafico_2(chartID = 'char_id', chart_type = 'line', chart_height = 400):
	chart = {"renderTo": chartID, "type": chart_type, "height": chart_height,}
	series = [{"name": 'Label1', "data": y}]
	title = {"text": 'CDI média diária'}
	xAxis = {"type": 'datetime'}
	yAxis = {"title": {"text": 'yAxis Label'}}
	return render_template('grafico_2.html', chartID=chartID, chart=chart, series=series, title=title, xAxis=xAxis, yAxis=yAxis)

# preciso fazer o python ler o banco de dados e devolver um array of arrays

from datetime import datetime, date

z = CDI_CETIP.query.all()
n = len(z)

dados = [[0,0] for i in range(n)]

for i in range(n):
	dt = datetime.strptime(z[i].data, "%Y-%m-%d").date()
	dt = int(datetime.combine(dt, datetime.min.time()).timestamp())*1000
	dados[i][0] = dt
	dados[i][1] = z[i].valor

@app.route("/grafico_3")
def grafico_3(chartID = 'char_id', chart_type = 'line', chart_height = 400):
	chart = {"renderTo": chartID, "type": chart_type, "height": chart_height,}
	series = [{"name": 'Label1', "data": dados}]
	title = {"text": 'CDI média diária'}
	xAxis = {"type": 'datetime'}
	yAxis = {"title": {"text": 'yAxis Label'}}
	return render_template('grafico_3.html', chartID=chartID, chart=chart, series=series, title=title, xAxis=xAxis, yAxis=yAxis)