const sql = require("./db.js");

const Account = function(account) {
  this.id = account.id,
  this.codInterest = account.codInterest,
  this.email = account.email;
  this.username = account.username;
  this.photoUrl = account.photoUrl;
  this.bio = account.bio;
  this.displayName = account.displayName;
  this.countComment = account.countComment;
  this.countPost = account.countPost;
  this.cap = account.cap;
  this.getNewsLetter = account.getNewsLetter;
};

Account.create = (newAccount, result) => {
  sql.query("INSERT INTO account SET ?", newAccount, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(err, null);
      return;
    }

    console.log("created account: ", { id: res.insertId, ...newAccount });
    result(null, { id: res.insertId, ...newAccount });
  });
};

Account.findByEmail = (email, result) => {
  sql.query(`SELECT * FROM account WHERE email = '${email}'`, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(err, null);
      return;
    }

    if (res.length) {
      console.log("found account: ", res[0]);
      result(null, res[0]);
      return;
    }

    result({ kind: "not_found" }, null);
  });
};


Account.findById = (accountId, result) => {
  sql.query(`SELECT * FROM account WHERE id = ${accountId}`, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(err, null);
      return;
    }

    if (res.length) {
      console.log("found account: ", res[0]);
      result(null, res[0]);
      return;
    }

    result({ kind: "not_found" }, null);
  });
};

Account.getUserByNoComment = (result) => {
  sql.query(`SELECT * FROM account LEFT JOIN comment ON account.id = comment.userId WHERE text IS NULL`, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(err, null);
      return;
    }

    if (res.length) {
      console.log("found account: ", res[0]);
      result(null, res[0]);
      return;
    }

    result({ kind: "not_found" }, null);
  });
};

Account.getUserMaxPost = (result) => {
  sql.query(`SELECT * FROM account, post WHERE account.id = post.ownerId GROUP BY post.ownerId HAVING MAX(post.ownerId)`, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(err, null);
      return;
    }

    if (res.length) {
      console.log("found account: ", res[0]);
      result(null, res[0]);
      return;
    }

    result({ kind: "not_found" }, null);
  });
};

Account.getAll = result => {
  sql.query("SELECT * FROM account", (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    console.log("account: ", res);
    result(null, res);
  });
};

Account.updateById = (id, account, result) => {
  sql.query(
    "UPDATE account SET id = ?, codInterest = ?, email = ?, username = ?, photoUrl = ?, bio = ?, displayName = ?, countComment = ?, countPost = ?, cap = ?, getNewsLetter = ?, WHERE id = ?",
    [account.id, account.codInterest, account.email, account.username, account.photoUrl, account.bio, account.displayName, account.countComment, account.countPost, account.cap, account.getNewsLetter],
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

      console.log("updated account: ", { id: id, ...account });
      result(null, { id: id, ...account });
    }
  );
};

Account.remove = (id, result) => {
  sql.query("DELETE FROM account WHERE id = ?", id, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    if (res.affectedRows == 0) {
      result({ kind: "not_found" }, null);
      return;
    }

    console.log("deleted account with id: ", id);
    result(null, res);
  });
};

Account.removeAll = result => {
  sql.query("DELETE FROM account", (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    console.log(`deleted ${res.affectedRows} account`);
    result(null, res);
  });
};

module.exports = Account;