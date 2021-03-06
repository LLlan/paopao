<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="row">
	<div class="col-xs-12">
		<form class="form-inline search_form" method="post" action="${pageContext.request.contextPath}/vmanage/opinionManage/list">
			<shiro:hasPermission name="M0000008:list">
				<label>账号:</label>
				<input type="text" name="account" value="${requestScope.PARAMS.account}"> 
				<label>昵称:</label>
				<input type="text" name="nickname" value="${requestScope.PARAMS.nickname}"> 
				<label>类型:</label>
				<select id="appuserType" name="appuserType" class="form-control">
					<option value="" >全部</option>
					<c:forEach var="item" items="${requestScope.appuserTypeList}">
						<option value="${item}" <c:if test="${item == requestScope.PARAMS.appuserType}"> selected="selected"</c:if> >${item.name}</option>
					</c:forEach>
				</select>
				<button type="button" class="btn btn-success btn-sm tooltip-success list">
					<i class="ace-icon glyphicon glyphicon-search"></i>查询
				</button>
			</shiro:hasPermission>
		</form>
	</div>
</div>
<div class="row">
	<div class="col-xs-12">
		<table class="table table-bordered">
	      <thead>
	        <tr>
	          <th>账号</th>
	          <th>昵称</th>
	          <th>类型</th>
	          <th>意见</th>
	        </tr>
	      </thead>
	      <tbody>
	      	<c:forEach var="item" items="${PAGE.records}" varStatus="vs">
	      	<tr rowid="${item.id}">
				<td>${item.account}</td>
				<td>${item.nickname}</td>
				<td>
					<c:forEach var="i" items="${requestScope.appuserTypeList}">
						<c:if test="${i == item.appuserType}">${i.name}</c:if>
					</c:forEach>
				</td>
				<td>${item.content}</td>
	        </tr>
	        </c:forEach>
	      </tbody>
	    </table>
	</div>
</div>
<tiles:insertDefinition name="vmanage.base.page"></tiles:insertDefinition>

<script type="text/javascript">
</script>