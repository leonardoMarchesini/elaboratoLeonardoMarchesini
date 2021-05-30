const Comment = require("../models/comment.model.js");

exports.create = (req, res) => {
    if (!req.body) {
      res.status(400).send({
        message: "Content can not be empty!"
      });
    }

    const comment = new Comment({
      userId: req.body.userId,
      postId: req.body.postId,
      text: req.body.text,
    });
  
    Comment.create(comment, (err, data) => {
      if (err)
        res.status(500).send({
          message:
            err.message || "Some error occurred while creating the Comment."
        });
      else res.send(data);
    });
  };

exports.findAll = (req, res) => {
    Comment.getAll((err, data) => {
      if (err)
        res.status(500).send({
          message:
            err.message || "Some error occurred while retrieving customers."
        });
      else res.send(data);
    });
  };

exports.findOne = (req, res) => {
    Comment.findById(req.params.postId, (err, data) => {
      if (err) {
        if (err.kind === "not_found") {
          res.status(404).send({
            message: `Not found Comment with id ${req.params.postId}.`
          });
        } else {
          res.status(500).send({
            message: "Error retrieving Comment with id " + req.params.postId
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
  
    Comment.updateById(
      req.params.commentId,
      new Comment(req.body),
      (err, data) => {
        if (err) {
          if (err.kind === "not_found") {
            res.status(404).send({
              message: `Not found Comment with id ${req.params.commentId}.`
            });
          } else {
            res.status(500).send({
              message: "Error updating Comment with id " + req.params.commentId
            });
          }
        } else res.send(data);
      }
    );
  };

exports.delete = (req, res) => {
    Comment.remove(req.params.commentId, (err, data) => {
      if (err) {
        if (err.kind === "not_found") {
          res.status(404).send({
            message: `Not found Comment with id ${req.params.commentId}.`
          });
        } else {
          res.status(500).send({
            message: "Could not delete Comment with id " + req.params.commentId
          });
        }
      } else res.send({ message: `Comment was deleted successfully!` });
    });
  };
  
exports.deleteAll = (req, res) => {
    Comment.removeAll((err, data) => {
      if (err)
        res.status(500).send({
          message:
            err.message || "Some error occurred while removing all comment."
        });
      else res.send({ message: `All Comment were deleted successfully!` });
    });
  };