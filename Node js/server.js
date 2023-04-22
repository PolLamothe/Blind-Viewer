var express = require('express');
const app = express()
var server = require('http').Server(app)


const bodyParser = require('body-parser')
app.use(bodyParser.urlencoded({extended : true}))
app.use(express.json());

app.post('/Learn', (req,res) =>{
    console.log(req.body.letter)
})

server.listen(3000)