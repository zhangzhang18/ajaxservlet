<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

  <title>search</title>
<style type="text/css">
  /*#mydiv{*/
    /*position: absolute;*/
    /*left:50%;*/
    /*top:50%;*/
    /*margin-left: -200px;*/
    /*margin-top: -50px;*/
  /*}*/
  .mouseover{
    background:#708090;
    color: #000000;
  }

</style>
  <script type="text/javascript">

    var xmlhttp;
    function getMoreContents() {
      //获取用户输入
      var content = document.getElementById("keyword");
      if (content.value == "") {
        clearContent();
        return;
      }
      //alert(content.value);
      xmlhttp = creatXml();
      //alert(xmlhttp);

//        alert(xmlhttp);
      var url = "search?keyword=" + content.value;
      //  alert(url);
      xmlhttp.open("GET", url, true);
      //   alert(xmlhttp.open("GET", url, true))
      //true表示js脚本会在send（）方法后执行，不会等待服务器的响应
//xmlhttp 绑定回调方法，这个回调方法会在xmlhttp状态改变的时候调用
      //xmlhttp有四种状态  4（complete）完成
      //当完成后在调用回调方法
//xml绑定回调方法，当xmlhttp 状态改变的时候被调用
      //alert(content.value);
      xmlhttp.onreadystatechange=function()
      {
       // alert(xmlhttp.readyState);
       // alert(xmlhttp.status);
        if (xmlhttp.readyState == 4) {
          if (xmlhttp.status == 200) {
            //200服务器响应成功
            //400资源未找到 500服务器内部错误
            var result = xmlhttp.responseText;
            //解析数据
            var json = eval('(' + result + ')');//json数据
          //  alert(json);
            setContent(json);

          }
        }
      };
      xmlhttp.send(null);

    }

    //        function callback() {
    //            if (xmlhttp.readyState == 4) {
    //                if (xmlhttp.status == 200) {
    //                    //200服务器响应成功
    //                    //400资源未找到 500服务器内部错误
    //                    var result = xmlhttp.responseText;
    //                    //解析数据
    //                    var json = eval("(" + result + ")");//json数据
    //                }
    //            }
    //
    //        }

    function setContent(contents) {
      setLocation();
      clearContent();
      //获得关联数据长度，生成tr
      var size = contents.length;
      for (var i = 0; i < size; i++) {
        var nextNode = contents[i];//代表json格式数据第i个元素
        var tr = document.createElement("tr");
        var td = document.createElement("td");
        td.setAttribute("border", 0);
        td.setAttribute("bgcolor", "#fffafa");
        td.onmouseover = function () {
          this.className = 'mouseover';
        };
        td.onmouseout = function () {
          this.className = 'mouseout'
        };

        td.onclick = function () {
          //
        };
        var text = document.createTextNode(nextNode);
        td.appendChild(text);
        tr.appendChild(td);
        document.getElementById("contenttbody").appendChild(tr);
      }

    }
    //获取xml对象信息
    function creatXml() {
      var xmlhttp;
      if (window.XMLHttpRequest) {
        xmlhttp = new XMLHttpRequest()
      }
      if (window.ActiveXObject) {
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        if (!xmlhttp) {
          xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
        }
      }
      return xmlhttp;
    }

function clearContent(){
  var contentTableBody=document.getElementById("contenttbody");
  var size =contentTableBody.childNodes.length;
  for(var i=size-1;i>=0;i--){
    contentTableBody.removeChild(contentTableBody.childNodes[i]);
  }
  document.getElementById("contenttable").style.border="none";
}
//失去焦点时
function keywordBlur() {
  clearContent();
}
function setLocation() {
  //关联信息位置
  var content =document.getElementById("keyword");
  var width=content.offsetWidth;
  var left =content.offsetLeft;
  var top =content.offsetTop+content.offsetHeight;
  var popdiv=document.getElementById("popdiv");
  popdiv.style.border="black 1px solid";
  popdiv.style.left=left+"px";
  popdiv.style.top=top+"px";
  popdiv.style.width=width+"px";
  document.getElementById("contenttable").style.width=width+"px";

}
  </script>
</head>
<body>

<div id="mydiv">

  <input type="text" size="50" id="keyword" onkeyup=" getMoreContents()" onblur="keywordBlur()" onfocus="getMoreContents()"/>
  <input type="button" value="search" width="50px">
</div>
<div id="popdiv">

  <table id="contenttable" bgcolor="#fffafa" border=0 cellpadding="0">

    <tbody id="contenttbody">
    //动态查询数据显示
    </tbody>

  </table>


</div>
</body>
</html>
