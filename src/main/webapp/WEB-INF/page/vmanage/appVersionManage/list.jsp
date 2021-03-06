<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>   
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="row">
	<div class="col-xs-12">
		<form class="form-inline search_form" method="post" action="${pageContext.request.contextPath}/vmanage/appVersionManage/list">
			<shiro:hasPermission name="M0000006:list">
				<label>版本号:</label>
				<input type="text" name="versionNumber" value="${requestScope.PARAMS.versionNumber}"> 
				<label>类型:</label>
				<select id="type" name="type" class="form-control">
					<option value="" >全部</option>
					<c:forEach var="item" items="${requestScope.types}">
						<option value="${item}" <c:if test="${item == requestScope.PARAMS.type}"> selected="selected"</c:if> >${item.name}</option>
					</c:forEach>
				</select>
				<label>是否可用:</label>
				<select id="isShow" name="isShow" class="form-control">
					<option value="" >全部</option>
					<c:forEach var="item" items="${requestScope.yesOrNos}">
						<option value="${item}" <c:if test="${item == requestScope.PARAMS.isShow}"> selected="selected"</c:if> >${item.name}</option>
					</c:forEach>
				</select>
				<label>是否强制:</label>
				<select id="updateInstall" name="updateInstall" class="form-control">
					<option value="" >全部</option>
					<c:forEach var="item" items="${requestScope.yesOrNos}">
						<option value="${item}" <c:if test="${item == requestScope.PARAMS.updateInstall}"> selected="selected"</c:if> >${item.name}</option>
					</c:forEach>
				</select>
				<label>分类:</label>
				<select id="category" name="category" class="form-control">
					<option value="" >全部</option>
					<c:forEach var="item" items="${requestScope.categorys}">
						<option value="${item}" <c:if test="${item == requestScope.PARAMS.category}"> selected="selected"</c:if> >${item.name}</option>
					</c:forEach>
				</select>
				<button type="button" class="btn btn-success btn-sm tooltip-success list">
					<i class="ace-icon glyphicon glyphicon-search"></i>查询
				</button>
				<button type="button" class="btn btn-purple btn-sm tooltip-success add">
					<i class="ace-icon glyphicon glyphicon-plus"></i>新增
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
	          <th>版本号</th>
	          <th>类型</th>
	          <th>分类</th>
	          <th>强制更新</th>
	          <th>可用</th>
	          <th>更新时间</th>
	          <th>主文件路径</th>
	          <th></th>
	        </tr>
	      </thead>
	      <tbody>
	      	<c:forEach var="item" items="${PAGE.records}" varStatus="vs">
	      	<tr rowid="${item.id}">
				<td>
					<span class="label label-success arrowed">${item.versionNumber}</span>
				</td>
				<td>
					<c:forEach var="item2" items="${requestScope.types}">
						<c:if test="${item.type == item2}"> ${item2.name}</c:if>
					</c:forEach>
				</td>
				<td>
					<c:forEach var="item2" items="${requestScope.categorys}">
						<c:if test="${item.category == item2}"> ${item2.name}</c:if>
					</c:forEach>
				</td>
				<td>
					<c:forEach var="item2" items="${requestScope.yesOrNos}">
						<c:if test="${item.updateInstall == item2}"> ${item2.name}</c:if>
					</c:forEach>
				</td>
				<td>
					<c:forEach var="item2" items="${requestScope.yesOrNos}">
						<c:if test="${item.isShow == item2}"> ${item2.name}</c:if>
					</c:forEach>
				</td>
				<td>
					<fmt:formatDate value="${item.updateTime}" pattern="yyyy-MM-dd HH:mm:ss"/>  
				</td>
				<td>
					${item.type == 'ANDROID' ? androidFix : iosFix }${item.filePath}
				</td>
				<td>
					<shiro:hasPermission name="M0000006:edit">
			          	<button class="btn btn-sm btn-info edit">
							<i class="ace-icon fa fa-trash-o bigger-120"></i>编辑
						</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="M0000006:remove">
			            <button class="btn btn-sm btn-danger remove">
							<i class="ace-icon fa fa-trash-o bigger-120"></i>删除
						</button>
					</shiro:hasPermission>
	          	</td>
	        </tr>
	        </c:forEach>
	      </tbody>
	    </table>
	</div>
</div>
<tiles:insertDefinition name="vmanage.base.page"></tiles:insertDefinition>

<script type="text/javascript">
	$(function(){
		$(".add").on("click", function(){
			action("vmanage/appVersionManage/add");
		});
		//删除
		$(".remove").on("click", function(){
			var id = $(this).parent().parent().attr("rowid");
			$.messager.confirm(
					"您确认要删除该条数据吗",
					//回调函数
					function(r) {
						//r是返回的信息，点击确认的时候为true 取消的时候为false
						if(r) {
							//当点击确认时触发
							$.businAjax(
								"${pageContext.request.contextPath}/vmanage/appVersionManage/remove/exec",
								{"id": id},
								function(res) {
									$.messager.alert(res.msg, function() {
										if(res.code) {
											//提交成功,跳转回查询页面
											action("vmanage/appVersionManage/list");
										}
									});
								}
							)
						} else {
							//点击取消时触发
						}
					}
			);
		});
		
		//跳转到编辑页面
		$(".edit").on("click", function(){
			var id = $(this).parent().parent().attr("rowid");
			action("vmanage/appVersionManage/edit?id=" + id);
		});
	});
</script>