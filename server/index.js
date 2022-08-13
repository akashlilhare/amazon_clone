// IMPORTS FROM PACKAGES
const express = require("express");
const mongoose = require("mongoose");

// IMPORTS FROM OTHER FILES
const authRouter = require("./routes/auth")

//INIT
const PORT = 3000;
const app = express();
const DB = "mongodb+srv://akash:Mx3iV5FBs85TEQNI@cluster0.vofksfj.mongodb.net/?retryWrites=true&w=majority"

// middleware
app.use(express.json());
app.use(authRouter);

// Connections
mongoose.connect(DB).then(()=>{
    console.log("connection successful");
}).catch(e=>{
    console.log(e);
})

app.listen(PORT,()=>{
    console.log(`connected at port ${PORT}`);
})