var models = require('../config');
var express = require('express');
var router = express();
var multer = require('multer');
var UUID = require('uuid')
var path = require('path')

var storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, path.join(__dirname, '../public'))
    },
    filename: function (req, file, cb) {

        var str = file.originalname.split('.');
        cb(null, UUID.v1() + '.' + str[1]);
    }
})
var upload = multer({ storage: storage })


// var router = express.Router();
router.all('*', function (req, res, next) {
    const ori = req.get('Origin');
    if (!(ori != undefined && req.get('Origin').endsWith('8089'))) {

    }
    res.header("Origin", "*");
    res.header("Access-Control-Allow-Credentials", "true")
    res.header("Access-Control-Allow-Origin", "*");
    // res.header("Access-Control-Allow-Headers", "X-Requested-With");
    res.header("Access-Control-Allow-Methods", "PUT,POST,GET,DELETE,OPTIONS");
    // res.header("X-Powered-By",' 3.2.1')
    // res.header("Content-Type", "application/json;charset=utf-8");
    res.header("Access-Control-Allow-Headers", "Content-Type,application/x-www-form-urlencoded");
    // res.setHeader("Access-Control-Allow-Headers", "x-requested-with,application/x-www-form-urlencoded");
    next();
});
var mysql = require('mysql');


// 连接数据库
var conn = mysql.createConnection(models.mysql);
conn.connect();

var query = function (sql, values) {
    // 返回一个 Promise
    return new Promise((resolve, reject) => {

        conn.query(sql, values, (err, rows) => {

            if (err) {
                reject(err)
            } else {
                resolve(rows)
            }
        })
    })
}

var jsonWrite = function (res, ret) {
    if (typeof ret === 'undefined') {
        res.json({
            code: '1',
            msg: '操作失败'
        });
    } else {
        res.json(ret);
    }
};



var space = ' '
var eq = '='
router.post('/insert', (req, res) => {
    var p = req.body;
    var sql = "INSERT INTO " + p.table;
    var param = []
    var d = p.data
    if (d != undefined) {
        var property = ' ('
        var val = ' ('
        for (const key in d) {
            property = property + key + ','
            val = val + '?,'
            if (d.hasOwnProperty(key)) {
                const element = d[key];
                param.push(element)
            }
        }
        property = property.substring(0, property.lastIndexOf(','))
        val = val.substring(0, val.lastIndexOf(','))
        property += ')'
        val += ')'
        sql = sql + property + ' VALUES ' + val
    }

    conn.query(sql, param, function (err, result) {
        if (err) {
            console.log(err);
        }
        if (result) {
            jsonWrite(res, result);
        }
    })
});

router.post('/search', (req, res) => {
    var p = req.body;
    var sql = "select * from " + p.table;
    var param = []
    var d = p.data
    if (d != undefined) {
        var where = ' where '
        for (const key in d) {
            where = where + ' ' + key + ' like ? AND '
            if (d.hasOwnProperty(key)) {
                const element = d[key];
                param.push(element)
            }
        }
        where = where.substring(0, where.lastIndexOf('AND'))
        sql = sql + where
    }
    conn.query(sql, param, function (err, result) {
        if (err) {
            console.log(err);
        }
        if (result) {
            jsonWrite(res, result);
        }
    })
});

router.post('/action', (req, res) => {
    var p = req.body;
    conn.query(p.sql, [], function (err, result) {
        if (err) {
            console.log(err);
        }
        if (result) {
            jsonWrite(res, result);
        }
    })
});



router.post('/upload', upload.array('file', 10), async (req, res, next) => {

    var sql = 'insert into resource(filePath,fileName,originalname) values(?,?,?)'
    let fileIdList = []
    for (var i = 0; i < req.files.length; i++) {
        var file = req.files[i]
        // goods_picture += req.files[i].filename+'#'
        var result = await query(sql, [file.path, file.filename, file.originalname])

        fileIdList.push(result.insertId)

    }
    jsonWrite(res, fileIdList);

})

router.post('/build', (req, res) => {
    var p = req.body;
    var sql = 'SELECT m.* FROM `user` u LEFT JOIN users_roles ur ON ur.user_id=u.id LEFT JOIN role r ON r.id=ur.role_id LEFT JOIN  roles_menus rm ON rm.role_id=r.id LEFT JOIN menu m ON m.id=rm.menu_id WHERE u.id=? '
    conn.query(sql, [p.id], function (err, result) {
        if (err) {
            console.log(err);
        }
        jsonWrite(res, buildTree(result, 0, 1));
    })
})

function buildTree(result, pid, dep) {
    var tree = []
    result.forEach(item => {
        var children = []
        if (item.pid == pid) {
            tree.push(item)
        }
    })
    var d = dep + 1

    tree = tree.map(element => {
        // console.log(element)
        var node = {}
        var children = buildTree(result, element.id, d)
        if (dep == 1) {
            if (children.length != 0) {
                node.redirect = 'noredirect'
                node.component = 'Layout'
                node.alwaysShow = true
                node.meta = {}
                node.meta.title = element.name
                node.meta.icon = element.icon
                node.path = element.path
                node.name = element.name
                node.children=children
            } else {
                node.component = 'Layout'
                node.path = element.path
                var child = {}
                child.component = element.component
                child.name = element.name
                child.path = element.path
                child.meta = {}
                child.meta.title = element.name
                child.meta.icon = element.icon
                node.children = [child]
            }

        } else {
            if (children.length!=0) {
                node.children = children
            }
            node.component = element.component
            node.meta = {}
            node.meta.title = element.name
            node.meta.icon = element.icon
            node.path = element.path
            node.name = element.name
        }
        return node
    })
    return tree
}



module.exports = router;
