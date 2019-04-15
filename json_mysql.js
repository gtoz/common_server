var models = require('./config');
const { port } = require('./config');
const fs = require('fs');
const path = require('path');
var mysql = require('mysql');


// 连接数据库
var conn = mysql.createConnection(models.mysql);
conn.connect();

var table='hotCities'

fs.readFile('./mock/city.json', function (err, data) {
    if (err) {
        return console.error(err);
    }
    var person = data.toString();//将二进制的数据转换为字符串

    person = JSON.parse(person);//将字符串转换为json对象
    //console.log('success listen at port:' + person.data.iconsMenuList);

    
    var array=person.data[table]
	console.log(array)
    for (let index = 0; index < array.length; index++) {
        const element = array[index];
        var d = element,sql = "INSERT INTO "+table,param = [];
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
        //console.log(sql,param)
        conn.query(sql, param, function (err, result) {
             console.log(err)
        })
    }

    // person.data.push(params);//将传来的对象push进数组对象中
    // person.total = person.data.length;//定义一下总条数，为以后的分页打基础
    // console.log(person.data);
    // var str = JSON.stringify(person);//因为nodejs的写入文件只认识字符串或者二进制数，所以把json对象转换成字符串重新写入json文件中
    // fs.writeFile('./mock/person.json',str,function(err){
    //     if(err){
    //         console.error(err);
    //     }
    //     console.log('----------新增成功-------------');
    // })
})
