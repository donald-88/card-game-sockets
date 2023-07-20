const express = require("express");
const http = require("http");
const app = express();
const port = process.env.PORT || 3000;
var server = http.createServer(app);
const mongoose = require("mongoose");
const roomModel = require("./models/room");
var io = require("socket.io")(server);

const gameLogic = require("./gameLogic");

//middleware
app.use(express.json());

const DB =
  "mongodb+srv://nambamcdonald:wEl285EwpjN24T4N@cluster0.5evajmx.mongodb.net/";

io.on("connection", (socket) => {
  console.log("User connected");
  socket.on("createRoom", async ({ creatorId }) => {
    console.log(creatorId);

    let room = new roomModel();
    let player = {
      playerId: creatorId,
      roomId: socket.id,
    };
    room.players.push(player);
    await room.save();
    console.log(room);
    const roomId = room._id.toString();

    socket.join(roomId);

    io.to(roomId).emit("roomCreated", room);
  });

  socket.on("joinRoom", async ({ playerId, roomId }) => {
    try {
      if (!roomId.match(/^[0-9a-fA-F]{24}$/)) {
        socket.emit("errorOccured", "please enter a valid room Id");
        return;
      }
      let room = await roomModel.findById(roomId);

      console.log(room);

      if (room.canJoin) {
        let player = {
          playerId,
          roomId: socket.id,
        };
        socket.join(roomId);
        room.players.push(player);
        room.canJoin = false;

        ranks = [
          "2",
          "3",
          "4",
          "5",
          "6",
          "7",
          "8",
          "9",
          "10",
          "J",
          "Q",
          "K",
          "A",
        ];
        suits = ["♣", "♦", "♥", "♠"];

        deck = [];

        for (const suit of suits) {
          for (const rank of ranks) {
            deck.push({ suit, rank });
          }
        }

        gameLogic.shuffleDeck(deck);

        const playerHands = gameLogic.dealPlayerHands(
          deck,
          room.players.length
        );
        room.players.forEach((roomPlayer, index) => {
          roomPlayer.hand = playerHands[index];
        });
        room.discardPile = [deck.pop()];
        room.drawPile = deck;

        room = await room.save();
        io.to(roomId).emit("roomJoined", room);
        io.to(roomId).emit("updatePlayers", room.players);
        io.to(roomId).emit("updateRoom", room.players);
      } else {
        socket.emit(
          "errorOccured",
          "the game is in progress, try again later."
        );
      }
    } catch (e) {
      console.log(e);
    }
  });


  socket.on('playCard', async ({index, playerId, roomId}) => {
    try {
      let room = await roomModel.findById(roomId);
      console.log(room);
      let player = room.players.find(player => player.playerId === playerId);
      console.log(player);
      let card = player.hand[index];
      room.discardPile.push(card);
        player.hand.splice(index, 1);
        room = await room.save();
        io.to(roomId).emit('updateRoom', room);
        io.to(roomId).emit("updatePlayers", room.players);
    } catch (error) {
      console.log(error);
    }
  })
});

mongoose
  .connect(DB)
  .then(() => {
    console.log("Connected to MongoDB");
  })
  .catch((err) => {
    console.log(err);
  });

server.listen(port, "0.0.0.0", () => {
  console.log("Server started and running on port: " + port);
});
