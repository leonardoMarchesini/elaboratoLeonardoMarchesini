const Account = require("../models/account.model.js");

exports.create = (req, res) => {
    if (!req.body) {
      res.status(400).send({
        message: "Content can not be empty!"
      });
    }
  
    const account = new Account({
      id: req.body.id,
      codInterest: req.body.codInterest,
      email: req.body.email,
      username: req.body.username,
      photoUrl: req.body.photoUrl,
      bio: req.body.bio,
      displayName: req.body.displayName,
      countComment: req.body.countComment,
      countPost: req.body.countPost,
      cap: req.body.cap,
      getNewsLetter: req.body.getNewsLetter,
    });
  
    Account.create(account, (err, data) => {
      if (err)
        res.status(500).send({
          message:
            err.message || "Some error occurred while creating the Account."
        });
      else res.send(data);
    });
  };

exports.findByEmail = (req, res) => {
  Account.findByEmail(req.params.email, (err, data) => {
    if (err) {
      if (err.kind === "not_found") {
        res.status(404).send({
          message: `Not found Account with email ${req.params.email}.`
        });
      } else {
        res.status(500).send({
          message: "Error retrieving Account with email " + req.params.email
        });
      }
    } else res.send(data);
  });
};

exports.findAll = (req, res) => {
    Account.getAll((err, data) => {
      if (err)
        res.status(500).send({
          message:
            err.message || "Some error occurred while retrieving account."
        });
      else res.send(data);
    });
  };

exports.findOneByNoComment = (req, res) => {
    Account.getUserByNoComment((err, data) => {
      if (err) {
        if (err.kind === "not_found") {
          res.status(404).send({
            message: `Not found Account with no comment.`
          });
        } else {
          res.status(500).send({
            message: "Error retrieving Account with no comment"
          });
        }
      } else res.send(data);
    });
  };

  exports.findOne = (req, res) => {
    Account.findById(req.params.accountId, (err, data) => {
      if (err) {
        if (err.kind === "not_found") {
          res.status(404).send({
            message: `Not found Account with id ${req.params.accountId}.`
          });
        } else {
          res.status(500).send({
            message: "Error retrieving Account with id " + req.params.accountId
          });
        }
      } else res.send(data);
    });
  };

  exports.findOneByMaxPost = (req, res) => {
    Account.getUserMaxPost((err, data) => {
      if (err) {
        if (err.kind === "not_found") {
          res.status(404).send({
            message: `Not found Account with max post.`
          });
        } else {
          res.status(500).send({
            message: "Error retrieving Account with max post"
          });
        }
      } else res.send(data);
    });
  };

exports.update = (req, res) => {
    if (!req.body) {
      res.status(400).send({
        message: "Content can not be empty!"
      });
    }
  
    Account.updateById(
      req.params.accountId,
      new Account(req.body),
      (err, data) => {
        if (err) {
          if (err.kind === "not_found") {
            res.status(404).send({
              message: `Not found Account with id ${req.params.accountId}.`
            });
          } else {
            res.status(500).send({
              message: "Error updating Account with id " + req.params.accountId
            });
          }
        } else res.send(data);
      }
    );
    
  };

exports.delete = (req, res) => {
    Account.remove(req.params.accountId, (err, data) => {
      if (err) {
        if (err.kind === "not_found") {
          res.status(404).send({
            message: `Not found Account with id ${req.params.accountId}.`
          });
        } else {
          res.status(500).send({
            message: "Could not delete Account with id " + req.params.accountId
          });
        }
      } else res.send({ message: `Account was deleted successfully!` });
    });
  };

exports.deleteAll = (req, res) => {
    Account.removeAll((err, data) => {
      if (err)
        res.status(500).send({
          message:
            err.message || "Some error occurred while removing all account."
        });
      else res.send({ message: `All Account were deleted successfully!` });
    });
  };