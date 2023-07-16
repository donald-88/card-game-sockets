const mongoose = require("mongoose");

const playerSchema = new mongoose.Schema({
    playerId: {
        type: String,
        unique: true,
        trim: true,
    },
    roomId: {
        type: String,
    },
})

module.exports = playerSchema