
const express = require("express");
const bodyParser = require("body-parser")
const app = express();

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended:false}))
app.use(express.static('public'))


app.use('/css', express.static(__dirname + '/public/assets/css'));
app.use('/js', express.static(__dirname + '/public/assets/js'));
app.use('/fonts', express.static(__dirname + '/public/assets/fonts'));
app.use('/sass', express.static(__dirname + '/public/assets/sass'));
app.use('/images', express.static(__dirname + '/public/images'));


app.listen(3020,(err)=>{
    console.log("Check port 3020 ")
})
