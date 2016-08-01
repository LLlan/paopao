<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<div class="anchor-point">
  <div class="loginbox ">
      <img class="logo shadow" src="${pageContext.request.contextPath}/themes/login/vestate/img/SHOP-LOGO.png">
      <div class="login-out shadow">
	      <div class="info"></div>
           <input class="username text-style" value="" id="username" name="username" placeholder="用户名">
           <input class="password text-style" type="password" value="" id="password" name="password" placeholder="密码">
           <button class="login">登 录</button>
        </div>
  </div>
</div>
<script src="${pageContext.request.contextPath}/js/login.js"></script>
<script type="text/javascript">
	$(function() {
		$(".login").on("click", function() {
			login();
		})		
		
		$(".username , .password").on("focus", function() {
			onActive(this);
		})
		$(".username , .password").on("blur", function() {
			onUnActive(this);
		})
		
	})
	
	function onActive(o) {
		$(o).css("border","#ff6e6e 2px solid");
	}
	
	
	function onUnActive(o) {
		$(o).css("border","#e7e7e7 2px solid");
	}

	function login() {
		$.businAjax(
				"${pageContext.request.contextPath}/vhousekeeping/loginManage/login", 
				{username : $("#username").val(), password:$("#password").val(), roleCode: "HOUSEKEEPING"}, 
				function(res) {
					if(res.code == 'R0000000') {
						$(".info").text("");
						action("vhousekeeping/loginManage/index/list");
					} else {
						$(".info").text(res.msg);
					}
				}
		);
	}
</script>
