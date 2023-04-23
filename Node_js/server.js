var express = require('express');
const app = express()
var server = require('http').Server(app)
const {spawn} = require('child_process');


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
app.get('/Learn', (req,res) =>{
    console.log('get received')
})

server.listen(3000)