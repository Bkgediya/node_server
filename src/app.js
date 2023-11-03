const express = require("express")
const path = require("path")
const app = express()

app.use(express.static("public"))

app.get("/test", (req,res) => {
    res.status(200).send("Hello")
})

app.get("/", (req,res) => {
    res.sendFile(path.join(__dirname,"public","index.html"))
})

module.exports = app