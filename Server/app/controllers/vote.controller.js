const Vote = require("../models/vote.model.js");

exports.create = (req, res) => {
    if (!req.body) {
      res.status(400).send({
        message: "Content can not be empty!"
      });
    }
  
    const vote = new Vote({
      postId: req.body.postId,
      userId: req.body.userId,
      vote: req.body.vote,
    });
  
    Vote.create(vote, (err, data) => {
      if (err)
        res.status(500).send({
          message:
            err.message || "Some error occurred while creating the Vote."
        });
      else res.send(data);
    });
  };

exports.findByPostId = (req, res) => {
  Vote.findByPostId(req.params.postId, (err, data) => {
    if (err) {
      if (err.kind === "not_found") {
        res.status(404).send({
          message: `Not found Vote with postId ${req.params.postId}.`
        });
      } else {
        res.status(500).send({
          message: "Error retrieving Vote with postId " + req.params.postId
        });
      }
    } else res.send(data);
  });
};

exports.findAll = (req, res) => {
    Vote.getAll((err, data) => {
      if (err)
        res.status(500).send({
          message:
            err.message || "Some error occurred while retrieving customers."
        });
      else res.send(data);
    });
  };

exports.update = (req, res) => {
    if (!req.body) {
      res.status(400).send({
        message: "Content can not be empty!"
      });
    }
  
    Vote.updateById(
      req.params.postId,
      new Vote(req.body),
      (err, data) => {
        if (err) {
          if (err.kind === "not_found") {
            res.status(404).send({
              message: `Not found Vote with postId ${req.params.postId}.`
            });
          } else {
            res.status(500).send({
              message: "Error updating Vote with postIdid " + req.params.postId
            });
          }
        } else res.send(data);
      }
    );
  };
