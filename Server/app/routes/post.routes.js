module.exports = app => {
    const post = require("../controllers/post.controller.js");
  
    app.post("/post", post.create);
  
    app.get("/post", post.findAll);

    app.get("/post/:email", post.findOneByOwnerId);

    app.get("/post/:cap", post.findOneByCap);
  
    app.put("/post/:postId", post.update);
  
    app.delete("/post/:postId", post.delete);
  
    app.delete("/post", post.deleteAll);
  };