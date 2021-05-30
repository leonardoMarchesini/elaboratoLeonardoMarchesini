const sql = require("./db.js");

const Comment = function(comment) {
  this.userId = comment.userId;
  this.postId = comment.postId;
  this.text = comment.text;
};

Comment.create = (newComment, result) => {
  sql.query("INSERT INTO comment SET ?", newComment, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(err, null);
      return;
    }

    console.log("created comment: ", { id: res.insertId, ...newComment });
    result(null, { id: res.insertId, ...newComment });
  });
};

Comment.findById = (postId, result) => {
  sql.query(`SELECT * FROM comment WHERE postId = '${postId}'`, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(err, null);
      return;
    }

    if (res.length) {
      console.log("found comment: ", res[0]);
      result(null, res[0]);
      return;
    }

    result({ kind: "not_found" }, null);
  });
};

Comment.getAll = result => {
  sql.query("SELECT * FROM comment", (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    console.log("comment: ", res);
    result(null, res);
  });
};

Comment.updateById = (id, comment, result) => {
  sql.query(
    "UPDATE comment SET  commentId = ?, userId = ?, postId = ?, text = ?, WHERE commentId = ?",
    [comment.commentId, comment.userId, comment.postId, comment.text],
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

      console.log("updated comment: ", { id: id, ...comment });
      result(null, { id: id, ...comment });
    }
  );
};

Comment.remove = (id, result) => {
  sql.query("DELETE FROM comment WHERE commentId = ?", id, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    if (res.affectedRows == 0) {
      result({ kind: "not_found" }, null);
      return;
    }

    console.log("deleted comment with id: ", id);
    result(null, res);
  });
};

Comment.removeAll = result => {
  sql.query("DELETE FROM comment", (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    console.log(`deleted ${res.affectedRows} comment`);
    result(null, res);
  });
};

module.exports = Comment;