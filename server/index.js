const express = require('express')
const http = require('http')
const app = express()
const port = process.env.PORT || 3000
var server = http.createServer(app)
const mongoose = require('mongoose')
var io = require('socket.io')(server)

//middleware
app.use(express.json())

const DB = "mongodb+srv://nambamcdonald:wEl285EwpjN24T4N@cluster0.5evajmx.mongodb.net/"


io.on('connection', (socket) => {
    console.log("User connected")
    socket.on('createRoom', ({creatorId}) => {
        console.log(creatorId)
    })
})


mongoose.connect(DB).then(() => {
    console.log("Connected to MongoDB")
}).catch((err) => {
    console.log(err)
})


server.listen(port, '0.0.0.0', () => {
    console.log("Server started and running on port: " + port)
})