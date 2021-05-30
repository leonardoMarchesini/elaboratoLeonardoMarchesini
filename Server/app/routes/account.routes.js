module.exports = app => {
    const account = require("../controllers/account.controller.js");
  
    app.post("/account", account.create);
  
    app.get("/account/:email", account.findByEmail);

    app.get("/account", account.findAll);
  
    app.get("/account/:accountId", account.findOne);

    app.get("/account/comment", account.findOneByNoComment);

    app.get("/account/maxpost", account.findOneByMaxPost);
  
    app.put("/account/:accountId", account.update);
  
    app.delete("/account/:accountId", account.delete);
  
    app.delete("/account", account.deleteAll);
  };