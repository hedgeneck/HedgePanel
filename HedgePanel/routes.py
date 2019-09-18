from flask import render_template
from HedgePanel import app
from HedgePanel.models import CDI_CETIP
import numpy as np
from datetime import datetime, date

@app.route("/")
@app.route("/home")
def home():
	return render_template('home.html')

@app.route("/about")
def about():
	return render_template('about.html')


@app.route("/cdi_media_cetip")
def cdi_media_cetip(chartID = 'char_id', chart_type = 'line', chart_height = 400):
	z = CDI_CETIP.query.all()
	n = len(z)

	dados = [[0,0] for i in range(n)]

	for i in range(n):
		dt = datetime.strptime(z[i].data, "%Y-%m-%d").date()
		dt = int(datetime.combine(dt, datetime.min.time()).timestamp())*1000
		dados[i][0] = dt
		dados[i][1] = z[i].valor

	chart = {"renderTo": chartID, "type": chart_type, "height": chart_height,}
	series = [{"name": 'CDI', "data": dados}]
	title = {"text": 'CDI média diária (%)'}
	xAxis = {"type": 'datetime'}
	yAxis = {"title": {"text": 'CDI média diária (%)'}}
	return render_template('cdi_media_cetip.html', chartID=chartID, chart=chart, series=series, title=title, xAxis=xAxis, yAxis=yAxis)