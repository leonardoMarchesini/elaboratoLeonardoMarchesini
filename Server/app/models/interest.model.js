const sql = require("./db.js");

const Interest = function (interest) {
    this.userId = interest.userId;
    this.classicDance = interest.classicDance;
    this.comedy = interest.comedy;
    this.sport = interest.sport;
    this.neomelodica = interest.neomelodica;
    this.pop = interest.pop;
    this.rock = interest.rock;
};

Interest.create = (newInterest, result) => {
    sql.query("INSERT INTO interest SET ?", newInterest, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }

        console.log("created interest: ", { id: res.insertId, ...newInterest });
        result(null, { id: res.insertId, ...newInterest });
    });
};

Interest.findByEmail = (email, result) => {
    sql.query(`SELECT * FROM interest WHERE userId = ( SELECT id FROM account WHERE email = '${email}')`, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }

        if (res.length) {
            console.log("found interest: ", res[0]);
            result(null, res[0]);
            return;
        }

        result({ kind: "not_found" }, null);
    });
};

Interest.getAll = result => {
    sql.query("SELECT * FROM interest", (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
            return;
        }

        console.log("interest: ", res);
        result(null, res);
    });
};

Interest.updateById = (id, interest, result) => {
    sql.query(
        "UPDATE interest SET codInterest = ?, userId = ?, classicDance = ?, comedy = ?, modernDance = ?, neomelodica = ?, pop = ?, rock = ?, WHERE refId = ?",
        [interest.codInterest, interest.userId, interest.classicDance, interest.comedy, interest.modernDance, interest.neomelodica, interest.pop, interest.rock],
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

            console.log("updated interest: ", { id: id, ...interest });
            result(null, { id: id, ...interest });
        }
    );
};

Interest.remove = (id, result) => {
    sql.query("DELETE FROM interest WHERE codInterest = ?", id, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
            return;
        }

        if (res.affectedRows == 0) {
            result({ kind: "not_found" }, null);
            return;
        }

        console.log("deleted interest with id: ", id);
        result(null, res);
    });
};

Interest.removeAll = result => {
    sql.query("DELETE FROM interest", (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
            return;
        }

        console.log(`deleted ${res.affectedRows} interest`);
        result(null, res);
    });
};

module.exports = Interest;