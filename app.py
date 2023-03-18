# Impotação das bibliotecas
import sqlite3
from flask import Flask, render_template, request, redirect, url_for, jsonify

# Instancía o FLask
app = Flask(__name__)

# Função que pega os valores da tabela do arquivo db e retorna as posições
def getTable():
    db = sqlite3.connect("RoboDB.db")
    cursor = db.cursor()
    cursor.execute('SELECT * FROM Robo')
    rows = cursor.fetchall()
    db.close()

    # Armazena os valores das coordenas
    positions = []
    for row in rows:
        cod = {}
        cod['X'] = row[0]
        cod['Y'] = row[1]
        cod['Z'] = row[2]
        positions.append(cod)
    print(positions)

    return positions

@app.route("/", methods=['GET'])
# Retorna os valores da tabela para uma página html
def RobotPage():
    positions = getTable()
    return render_template(
        "robotPage.html",
        positions=positions,
        )

# Rota para adcionar posições
@app.route("/postPosition", methods=['POST'])
# Função que posta na tabela os valores fornecidos no formulário
def addPosition():
    X = request.form["X"]
    Y = request.form["Y"]
    Z = request.form["Z"]
    
    db = sqlite3.connect("RoboDB.db")
    cursor = db.cursor()
    cursor.execute('INSERT INTO Robo (X,Y,Z) VALUES (?,?,?)', (X,Y,Z))
    db.commit()
    db.close()

    return redirect(url_for('RobotPage'))

# Rota para o Godot obter as posições
@app.route("/positions", methods=['GET'])
# Função que retorna as posições em JSON
def getPosition():
    positions = getTable()
    return jsonify(positions)

# Roda a api
if __name__ == "__main__":
    app.run(debug=True)