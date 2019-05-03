var models = require('../config');
var express = require('express');
var router = express();
var multer = require('multer');
var UUID = require('uuid')
var path = require('path')

var util=require('./util')


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

// by 司徒正美
class Hash{
    constructor(){
        this.table = new Array(1024);
    }
    hash(data) {
    //就将字符串中的每个字符的ASCLL码值相加起来，再对数组的长度取余
        var total = 0;
        for(var i = 0; i < data.length; i++) {
            total += data.charCodeAt(i);
        }
        console.log("Hash Value: " +data+ " -> " +total);
        return total % this.table.length;
    }
    insert(key, val,req, res){
        var pos = this.hash(key.toString());
        this.table[pos] = val;
        if (pos<512) {
            insert({key:key,value:val,hash:pos},'eladmin_new',req, res)
        }else{
            insert({key:key,value:val,hash:pos},'test',req, res)
        }
    }
    get(key,req, res){
        var pos = this.hash(key.toString());
        var table=''
        if (pos<512) {
           table= 'eladmin_new.hash'
        }else{
            table='test.hash'
        }
        var sql='select * from '+table+' where `key`="?"'
        sql=sql.replace('?',key)
        conn.query(sql, [], function (err, result) {
            if (err) {
                console.log(err);
            }
            if (result) {
                jsonWrite(res, result);
            }
        })
        return this.table[pos] 
    }
    delete(key,req, res){
        var pos = this.hash(key.toString());
        var table=''
        if (pos<512) {
           table= 'eladmin_new.hash'
        }else{
            table='test.hash'
        }
        var sql='delete from '+table+' where `key`="?" AND `id`=?'
        sql=sql.replace('?',key).replace('?',req.body.id)
        conn.query(sql, [], function (err, result) {
            if (err) {
                console.log(err);
            }
            if (result) {
                jsonWrite(res, result);
            }
        })
      
    }
    show(){
        for(var i = 0; i < this.table.length; i++) {
            if(this.table[i] != undefined) {
                console.log(i + ":" +this.table[i]);
            }
        }
    }
}

var space = ' '
var eq = '='
router.post('/insert_hash', (req, res) => {
    var p = req.body;
    //不同key
    var hash=new Hash()
    hash.insert(p.key,p.value,req, res)
});

function insert(p,database,req, res) {
    var sql = "INSERT INTO "+database+".hash" ;
    var param = []
    var d = p
    if (d != undefined) {
        var property = ' ('
        var val = ' ('
        for (const key in d) {
            property = property +'`'+ key +'`'+ ','
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
}

router.post('/get_hash', (req, res) => {
    var p = req.body;
    var hash=new Hash()
    hash.get(p.key,req, res)  
});

router.post('/delete_hash', (req, res) => {
    var p = req.body;
    var hash=new Hash()
    hash.delete(p.key,req, res)  
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
var mqtt = require('mqtt')
var client = mqtt.connect('mqtt://127.0.0.1')

client.on('message', function (topic, message) {
    console.log(message.toString())
    // client.end()
})
client.on('connect', function () {
    client.subscribe('presence')
})

router.post('/mqtt', (req, res) => {
    var p = req.body;

    client.publish('presence', JSON.stringify(p))
    jsonWrite(res, 'success');

});

router.get('/code', (req, res) => {
    let img =util.makeCapcha()
  res.setHeader('Content-Type', 'image/bmp')
  res.end(img.getFileData())

});

router.get('/getcode', (req, res) => {
    res.end(util.getCode())
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
        if (item.pid == pid) {
            tree.push(item)
        }
    })
    var d = dep + 1
    var tree = tree.map(item => {
        var children = buildTree(result, item.id, d)
        if (dep == 1 && children.length != 0) {
            item.alwaysShow = true
            item.children = children
            item.component = 'Layout'
            var meta = { title: item.name, icon: item.icon }
            item.meta = meta
            item.path = '/' + item.path
            item.redirect = 'noredirect'
        } else if (dep == 1 && children.length == 0) {
            item.component = 'Layout'
            var childrenList = []
            var child = {}
            child.path = '/' + item.path
            child.meta = { title: item.name, icon: item.icon }
            childrenList.push(child)
            item.children = childrenList
        } else {
            var meta = { title: item.name, icon: item.icon }
            item.meta = meta
            if (children.length != 0) {
                item.children = children
            }
        }
        return item
    })
    return tree
}



module.exports = router;
