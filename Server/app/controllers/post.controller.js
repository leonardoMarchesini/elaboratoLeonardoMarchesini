const Post = require("../models/post.model.js");

exports.create = (req, res) => {
    if (!req.body) {
      res.status(400).send({
        message: "Content can not be empty!"
      });
    }
  
    const post = new Post({
      postId: req.body.postId,
      userId: req.body.userId,
      title: req.body.title,
      place: req.body.place,
      date: req.body.date,
      timestamp: req.body.timestamp,
      likes: req.body.likes,
      vote: req.body.vote,
      img: req.body.img,
    });
  
    Post.create(post, (err, data) => {
      if (err)
        res.status(500).send({
          message:
            err.message || "Some error occurred while creating the Post."
        });
      else res.send(data);
    });
  };

exports.findAll = (req, res) => {
    Post.getAll((err, data) => {
      if (err)
        res.status(500).send({
          message:
            err.message || "Some error occurred while retrieving customers."
        });
      else res.send(data);
    });
  };

exports.findOne = (req, res) => {
    Post.findById(req.params.postId, (err, data) => {
      if (err) {
        if (err.kind === "not_found") {
          res.status(404).send({
            message: `Not found Post with id ${req.params.postId}.`
          });
        } else {
          res.status(500).send({
            message: "Error retrieving Post with id " + req.params.postId
          });
        }
      } else res.send(data);
    });
  };

  exports.findOneByOwnerId = (req, res) => {
    Post.getByOwnerId(req.params.email, (err, data) => {
      if (err) {
        if (err.kind === "not_found") {
          res.status(404).send({
            message: `Not found Post with owner email ${req.params.email}.`
          });
        } else {
          res.status(500).send({
            message: "Error retrieving Post with owner email " + req.params.email
          });
        }
      } else res.send(data);
    });
  };

  exports.findOneByCap = (req, res) => {
    Post.getPostByCap(req.params.cap, (err, data) => {
      if (err) {
        if (err.kind === "not_found") {
          res.status(404).send({
            message: `Not found Post with owner cap ${req.params.cap}.`
          });
        } else {
          res.status(500).send({
            message: "Error retrieving Post with owner cap " + req.params.cap
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
  
    Post.updateById(
      req.params.postId,
      new Post(req.body),
      (err, data) => {
        if (err) {
          if (err.kind === "not_found") {
            res.status(404).send({
              message: `Not found Post with id ${req.params.postId}.`
            });
          } else {
            res.status(500).send({
              message: "Error updating Post with id " + req.params.postId
            });
          }
        } else res.send(data);
      }
    );
  };

exports.delete = (req, res) => {
    Post.remove(req.params.postId, (err, data) => {
      if (err) {
        if (err.kind === "not_found") {
          res.status(404).send({
            message: `Not found Post with id ${req.params.postId}.`
          });
        } else {
          res.status(500).send({
            message: "Could not delete Post with id " + req.params.postId
          });
        }
      } else res.send({ message: `Post was deleted successfully!` });
    });
  };

exports.deleteAll = (req, res) => {
    Post.removeAll((err, data) => {
      if (err)
        res.status(500).send({
          message:
            err.message || "Some error occurred while removing all posts."
        });
      else res.send({ message: `All Post were deleted successfully!` });
    });
  };