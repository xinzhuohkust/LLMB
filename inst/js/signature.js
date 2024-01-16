//const CryptoJS = require("C:/node_global/node_modules/crypto-js");
const Md5 = CryptoJS.MD5;

var e = "/v2/threads/search?sortType=0";
var c = "a2eb17f65d6f4b3f";
var a = ""

const h = function (t) {
    return CryptoJS.MD5(t).toString(CryptoJS.enc.Hex);
}

const generate_signature = function (t) {
    var t = JSON.parse(t);
    var n = e.indexOf("?"); n > 0 && (e = e.substring(0, n)); var s = e + JSON.stringify(t) + c; return a && (s += a), h(s)
}

//console.log(generate_signature(t = '{"position":0,"keywords":"烂尾","fid":null,"domainId":null,"typeId":null,"timeRange":null,"ansChecked":false,"stTime":null,"sortType":"0","page":3,"rows":10}'))

//var e = "/v1/forum/rank/c";

//console.log(general_signature(t = '{"fid":38}'))
