const { mongoose } = require("mongoose");
const playerSchema = require("./player");

const roomSchema = new mongoose.Schema({
  roomId: {
    type: String,
    unique: true,
  },
  players: [playerSchema],
  turn: {
    type: Number,
    default: 0,
  },
  drawPile: [],
  discardPile: [],
  direction: {
    type: String,
    enum: ["clockwise", "counter-clockwise"],
    default: "clockwise",
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
  canJoin: {
    type: Boolean,
    default: true,
  }
});

const roomModel = mongoose.model("Room", roomSchema);
module.exports = roomModel