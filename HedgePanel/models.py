from HedgePanel import db

class CDI_CETIP(db.Model):
	__tablename__ = "CDI_CETIP"

	id = db.Column(db.Integer, primary_key=True)
	data = db.Column(db.String, unique=True, nullable=False)
	valor = db.Column(db.String, nullable=False)

	def __repr__(self):
		return f"CDI_CETIP('{self.data}': '{self.valor}')"