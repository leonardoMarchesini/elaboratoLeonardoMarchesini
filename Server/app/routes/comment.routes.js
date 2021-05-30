module.exports = app => {
    const comment = require("../controllers/comment.controller.js");
  
    app.post("/comment", comment.create);
  
    app.get("/comment", comment.findAll);
  
    app.get("/comment/:refPostId", comment.findOne);
  
    app.put("/comment/:commentId", comment.update);
  
    app.delete("/comment/:commentId", comment.delete);
  
    app.delete("/comment", comment.deleteAll);
  };