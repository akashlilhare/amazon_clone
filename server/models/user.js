const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true
    },
    email: {
        required: true,
        type: String,
        trim: true,
        validator: {
            validator: (value) => {
                const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re)
            },
            message: "Please enter a vaild email address",
        },
    },
    password: {
        required: true,
        type: String,
        validator: {
            validator: (value) => {
                return value.length > 6;
            },
            message: "Please enter a lone password",
        },
    },
    address: {
        type: String,
        default: "",
    },
    type: {
        type: String,
        default: "user",
    }
})

const User = mongoose.model("User", userSchema);
module.exports =User;