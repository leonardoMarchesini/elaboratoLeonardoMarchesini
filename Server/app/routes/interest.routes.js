module.exports = app => {
    const interest = require("../controllers/interest.controller.js");
  
    app.post("/interest", interest.create);
  
    app.get("/interest", interest.findAll);
  
    app.get("/interest/:email", interest.findOne);
  
    app.put("/interest/:refId", interest.update);

  };