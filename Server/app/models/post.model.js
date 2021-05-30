const sql = require("./db.js");

const Post = function(post) {
  this.postId = post.postId;
  this.userId = post.userId;
  this.title = post.title;
  this.place = post.place;
  this.date = post.date;
  this.timestamp = post.timestamp;
  this.likes = post.likes;
  this.img = post.img;
};

Post.create = (newPost, result) => {
  sql.query("INSERT INTO post SET ?", newPost, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(err, null);
      return;
    }

    console.log("created post: ", { id: res.insertId, ...newPost });
    result(null, { id: res.insertId, ...newPost });
  });
};

Post.findById = (postId, result) => {
  sql.query(`SELECT * FROM post WHERE postId = ${postId}`, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(err, null);
      return;
    }

    if (res.length) {
      console.log("found post: ", res[0]);
      result(null, res[0]);
      return;
    }

    result({ kind: "not_found" }, null);
  });
};

Post.getByOwnerId = (email, result) => {
  sql.query(`SELECT * FROM post WHERE userId = ( SELECT id FROM account WHERE email = '${email}')`, (err, res) => {
    if(err) {
      console.log("error: ", err);
      result(err, null);
      return;
    }

    if(res.length) {
      console.log("found post: ", res[0]);
      result(null, res[0]);
      return;
    }

    result(null, res[0]);
  });
};

Post.getPostByCap = (cap, currentUserId, result) => {
  sql.query(`SELECT * FROM post WHERE place = (SELECT ${cap} FROM account WHERE id = ${currentUserId})`, (err, res) => {
    if(err) {
      console.log("error: ", err);
      result(err, null);
      return;
    }

    if(res.length) {
      console.log("found post: ", res[0]);
      result(null, res[0]);
      return;
    }

    result(null, res[0]);
  });
};

Post.getAll = result => {
  sql.query("SELECT * FROM post", (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    console.log("post: ", res);
    result(null, res);
  });
};

Post.updateById = (id, post, result) => {
  sql.query(
    "UPDATE post SET likes = ? WHERE postId = ?",
    [post.postId, post.userId, post.title, post.place, post.date, post.timestamp, post.likes, post.vote, post.img],
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

      console.log("updated post: ", { id: id, ...post });
      result(null, { id: id, ...post });
    }
  );
};

Post.remove = (id, result) => {
  sql.query("DELETE FROM post WHERE postId = ?", id, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    if (res.affectedRows == 0) {
      result({ kind: "not_found" }, null);
      return;
    }

    console.log("deleted post with id: ", id);
    result(null, res);
  });
};

Post.removeAll = result => {
  sql.query("DELETE FROM post", (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    console.log(`deleted ${res.affectedRows} post`);
    result(null, res);
  });
};

module.exports = Post;