var request = require('request');
var options = {
  method: 'get',
  url: "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wx198b88fe077a35f5&secret=8932116570708aa856178473077bc676",
};
var getToken = function () {
  request(options, function (err, res, body) {
    if (err) {
      console.log(err)
    } else {
      token = body.access_token
      console.log(body);
    }
  })
}
var token = ''

// setInterval(function () {
//   console.log('scheduleCronstyle:' + new Date());
// }, 3000)
getToken()
setInterval(getToken, 1000 * 60 * (60 + 59))


module.exports = {
  mysql: {
    // host: '192.168.0.105',
    host: 'yangzailang.mysql.rds.aliyuncs.com',  // 新建数据库连接时的 主机名或ID地址 内容
    user: 'yzl',
    password: '#$ERDFCV5tgb', // root 密码
    database: 'school', // 数据库名
    port: '3306'
  },
  port: '3000',
  token: token,
  env:'yzl-f9lur'
}