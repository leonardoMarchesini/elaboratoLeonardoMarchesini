const sql = require("./db.js");

const Vote = function(vote) {
  this.postId = vote.postId;
  this.userId = vote.userId;
  this.vote = vote.vote;
};

Vote.create = (newVote, result) => {
  sql.query("INSERT INTO vote SET ?", newVote, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(err, null);
      return;
    }

    console.log("created vote: ", { id: res.insertId, ...newVote });
    result(null, { id: res.insertId, ...newVote });
  });
};

Vote.findByPostId = (postId, result) => {
  sql.query(`SELECT * FROM vote WHERE postId = '${postId}'`, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(err, null);
      return;
    }

    if (res.length) {
      console.log("found vote: ", res[0]);
      result(null, res[0]);
      return;
    }

    result({ kind: "not_found" }, null);
  });
};

Vote.getAll = result => {
  sql.query("SELECT * FROM vote", (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    console.log("vote: ", res);
    result(null, res);
  });
};

Vote.updateById = (id, vote, result) => {
  sql.query(
    "UPDATE vote SET postId = ?, userId = ?, vote = ?",
    [vote.postId, vote.userId, vote.vote],
    (err, res) => {
      if (err) {
        console.log("error: ", err);
        result(null, err);
        return;
      }

      if (res.affectedRows == 0) {
        result({ kind: "not_found" }, null);
        return;
      }

      console.log("updated vote: ", { id: id, ...vote });
      result(null, { id: id, ...vote });
    }
  );
};

module.exports = Vote;