const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
const port = 3000;

app.use(cors());
app.use(bodyParser.json());

const db = mysql.createConnection({
  host: '127.0.0.1',
  user: 'root',
  password: 'root',
  database: 'veterinaria_pbd'
});

db.connect((err) => {
  if (err) {
    console.error('Error al conectar a la base de datos:', err);
    return;
  }
  console.log('Conectado a la base de datos MySQL.');
});

app.post('/login', (req, res) => {
  const { nombre, password } = req.body;

  db.query(
    'SELECT * FROM propietarios WHERE nombre = ? AND password = ?',
    [nombre, password],
    (error, results) => {
      if (error) {
        return res.status(500).json({ error: 'Error en la base de datos' });
      }
      if (results.length > 0) {
        res.status(200).json({ nombre: results[0].nombre });
      } else {
        res.status(401).json({ error: 'Usuario o contraseña incorrectos' });
      }
    }
  );
});


app.listen(port, () => {
  console.log(`Servidor escuchando en http://localhost:${port}`);
});
