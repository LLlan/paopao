<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
%>
<h3 class="header smaller lighter blue">基本信息</h3>
<!-- /.page-header -->

<div class="row">
	<div class="col-xs-12">
		<!-- PAGE CONTENT BEGINS -->
		<form class="form-horizontal data-form" role="form" valid = "true" action="${pageContext.request.contextPath}/vmanage/userManage/edit/exec" method="post">

			<input type="hidden" id="id" name="id" value="${PAGE_DATA.id }">
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="username"> 用户名 </label>
				<div class="col-sm-9">
					<input type="text" id="username" placeholder="用户名" class="col-xs-10 col-sm-5" name="username" value="${PAGE_DATA.username }" disabled />
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="password"> 密码 </label>

				<div class="col-sm-9">
					<div class="clearfix">
						<input type="password" id="password" placeholder="密码" name="password" class="col-xs-10 col-sm-5" value="${PAGE_DATA.password }" />
					</div>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="password2"> 二次密码 </label>

				<div class="col-sm-9">
					<div class="clearfix">
						<input type="password" id="password2" placeholder="二次密码" name="password2" class="col-xs-10 col-sm-5" value="${PAGE_DATA.password }" />
					</div>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="roleId"> 角色 </label>
				<div class="col-sm-9">
					<div class="clearfix">
						<select id="roleId" name="roleId">
							<c:forEach var="item" items="${requestScope.roles}">
								<option value="${item.id}"  <c:if test="${item.id == PAGE_DATA.roleId}"> selected="selected"</c:if>> ${item.name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<div class="clearfix form-actions">
				<div class="col-md-offset-3 col-md-9">
					<button class="btn btn-info save" type="button">
						<i class="ace-icon fa fa-check bigger-110"></i> 提交
					</button>

					&nbsp; &nbsp; &nbsp;
					<button class="btn reset" type="reset">
						<i class="ace-icon fa fa-refresh bigger-110"></i> 重置
					</button>

					&nbsp; &nbsp; &nbsp;
					<button class="btn btn-danger cancel" type="button">
						<i class="ace-icon fa fa-undo bigger-110"></i> 取消
					</button>
				</div>
			</div>
		</form>
	</div>
</div>
<script type="text/javascript">
	$(function() {
		$(".data-form").validate({
			errorElement : 'div',
			errorClass : 'help-block',
			focusInvalid : false,
			ignore : "",
			rules : {
				username : {
					required : true,
					maxlength : 11,
					minlength : 6
				},
				password : {
					required : true,
					minlength : 6,
					maxlength : 11
				},
				password2 : {
					required : true,
					minlength : 6,
					maxlength : 11,
					equalTo: "#password"
				},
				roleId : {
					required : true
				}
			},
			highlight : function(e) {
				$(e).closest('.form-group').removeClass(
						'has-info').addClass('has-error');
			},
			success : function(e) {
				$(e).closest('.form-group').removeClass(
						'has-error');//.addClass('has-info');
				$(e).remove();
			},
			errorPlacement : function(error, element) {
				if (element.is('input[type=checkbox]')
						|| element.is('input[type=radio]')) {
					var controls = element.closest('div[class*="col-"]');
					if (controls.find(':checkbox,:radio').length > 1)
						controls.append(error);
					else
						error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
				} else if (element.is('.select2')) {
					error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
				} else if (element.is('.chosen-select')) {
					error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
				} else
					error.insertAfter(element.parent());
			},
			submitHandler : function(form) {
			},
			invalidHandler : function(form) {
			}
		});
		
		
		$(".save").on("click", function() {
			$(".data-form").form({
				success : function(res) {
					//弹窗提示
					$.messager.alert(res.msg, function() {
						if (res) {
							//提交成功,跳转回查询页面
							action("vmanage/userManage/list");
						}
					});
				}
			});
		});

		$(".reset").on("click", function() {
			$(".data-form").formClear();
		});

		$(".cancel").on("click", function() {
			action("vmanage/userManage/list");
		});
	});
</script>