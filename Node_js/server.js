var express = require('express');
const app = express()
var server = require('http').Server(app)
const {spawn} = require('child_process');
const io = require("socket.io")(server);

const bodyParser = require('body-parser')
app.use(bodyParser.urlencoded({extended : true}))
app.use(express.json());

app.post('/Learn', (req,res) =>{
    console.log(req.body.letter)
    const python = spawn('python', ['../extract_text/text_manipulation.py'])
    python.stdout.on('data', function (data) {
        dataToSend = data.toString();
        console.log(dataToSend)
    }); 
})
app.get('/waitPressedKey', (req, res) =>{
    console.log('received')
    const python = spawn('python', ['../extract_text/testNodeJS.py'])
    python.stdout.on('data', function (data) {
        dataToSend = data.toString();
        res.json(dataToSend)
    }); 
})

server.listen(3000)