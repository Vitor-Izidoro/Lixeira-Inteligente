from models.db import db
from datetime import datetime

class Lixeira(db.Model):
    __tablename__ = 'lixeira'
    id_lixeira = db.Column(db.Integer, primary_key=True, autoincrement=True)
    estado = db.Column(db.Integer, nullable=False)
    localizacao = db.Column(db.String(145), nullable=False)
    capacidade = db.Column(db.Integer, nullable=False)
    atuadores = db.relationship('Atuador', backref='lixeira', lazy=True)
    sensores = db.relationship('Sensor', backref='lixeira', lazy=True)
    data_hora_registro = db.Column(db.DateTime, default=datetime.now, nullable=False)


    def save_lixeira(estado, localizacao, capacidade):
        lixeira = Lixeira(estado=estado, localizacao=localizacao, capacidade=capacidade)
        db.session.add(lixeira)
        db.session.commit()


    def get_lixeiras():
        return Lixeira.query.all()


    def get_single_lixeira(id):
        return Lixeira.query.filter_by(id_lixeira=id).first()


    def update_lixeira(id, estado, localizacao, capacidade):
        lixeira = Lixeira.query.filter_by(id_lixeira=id).first()
        if lixeira:
            lixeira.estado = estado
            lixeira.localizacao = localizacao
            lixeira.capacidade = capacidade
            db.session.commit()
            return lixeira


    def delete_lixeira(id):
        lixeira = Lixeira.query.filter_by(id_lixeira=id).first()
        if lixeira:
            db.session.delete(lixeira)
            db.session.commit()
