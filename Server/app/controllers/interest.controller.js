const Interest = require("../models/interest.model.js");

exports.create = (req, res) => {
    if (!req.body) {
      res.status(400).send({
        message: "Content can not be empty!"
      });
    }
  
    const interest = new Interest({
      userId: req.body.userId,
      classicDance: req.body.classicDance,
      comedy: req.body.comedy,
      modernDance: req.body.modernDance,
      neomelodica: req.body.neomelodica,
      pop: req.body.neomelodica,
      rock: req.body.rock,
    });
  
    Interest.create(interest, (err, data) => {
      if (err)
        res.status(500).send({
          message:
            err.message || "Some error occurred while creating the Interest."
        });
      else res.send(data);
    });
  };

exports.findAll = (req, res) => {
    Interest.getAll((err, data) => {
      if (err)
        res.status(500).send({
          message:
            err.message || "Some error occurred while retrieving customers."
        });
      else res.send(data);
    });
  };

exports.findOne = (req, res) => {
    Interest.findByEmail(req.params.email, (err, data) => {
      if (err) {
        if (err.kind === "not_found") {
          res.status(404).send({
            message: `Not found Interest with id ${req.params.email}.`
          });
        } else {
          res.status(500).send({
            message: "Error retrieving Interest with id " + req.params.email
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
  
    Interest.updateById(
      req.params.codInterest,
      new Interest(req.body),
      (err, data) => {
        if (err) {
          if (err.kind === "not_found") {
            res.status(404).send({
              message: `Not found Interest with id ${req.params.codInterest}.`
            });
          } else {
            res.status(500).send({
              message: "Error updating Interest with id " + req.params.codInterest
            });
          }
        } else res.send(data);
      }
    );
  };

exports.delete = (req, res) => {
    Interest.remove(req.params.codInterest, (err, data) => {
      if (err) {
        if (err.kind === "not_found") {
          res.status(404).send({
            message: `Not found Interest with id ${req.params.codInterest}.`
          });
        } else {
          res.status(500).send({
            message: "Could not delete Interest with id " + req.params.codInterest
          });
        }
      } else res.send({ message: `Interest was deleted successfully!` });
    });
  };

exports.deleteAll = (req, res) => {
    Interest.removeAll((err, data) => {
      if (err)
        res.status(500).send({
          message:
            err.message || "Some error occurred while removing all interest."
        });
      else res.send({ message: `All Interest were deleted successfully!` });
    });
  };