module.exports = app => {
    const vote = require("../controllers/vote.controller.js");
  
    app.post("/vote", vote.create);
  
    app.get("/vote/:refPostId", vote.findByPostId);

    app.get("/vote", vote.findAll);
  
    app.put("/vote/:refPostId", vote.update);
  
  };