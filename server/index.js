// IMPORTS FROM PACKAGES
const express = require("express");
const mongoose = require("mongoose");
const dotenv = require("dotenv");
dotenv.config();


// IMPORTS FROM OTHER FILES
const authRouter = require("./routes/auth")

//INIT
const PORT = 3000;
const app = express();
const DB = process.env.CONNECTIONSTRING;

// middleware
app.use(express.json());
app.use(authRouter);

// Connections
mongoose.connect(DB).then(()=>{
    console.log("connection successful");
}).catch(e=>{
    console.log(e);
})

app.listen(PORT, "0.0.0.0", ()=>{
    console.log(`connected at port ${PORT}`);
})