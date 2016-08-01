<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!-- 自定义样式 -->
<h3 class="header smaller lighter blue">基本信息</h3>

<div class="row">
	<div class="col-xs-12">
		<!-- PAGE CONTENT BEGINS -->
		<form class="form-horizontal data-form" role="form" action="${pageContext.request.contextPath}/vmanage/core/informationCategoryManage/add/exec" method="post" enctype="multipart/form-data" valid="true" >
			<!-- #section:elements.form -->
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="name"> 名称 </label>
			
				<div class="col-sm-9">
					<div class="clearfix">
						<input type="text"  placeholder="名称" class="col-xs-10 col-sm-5" id="name" name="name"/>
					</div>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="file"> 首页图标 </label>
			
				<div class="col-sm-9">
					<div class="clearfix">
						<input type="file" id="file" name="file"/>
					</div>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="file2"> 列表图标 </label>
			
				<div class="col-sm-9">
					<div class="clearfix">
						<input type="file" id="file2" name="file2"/>
					</div>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="isShow"> 是否显示 </label>
			
				<div class="col-sm-9">
					<div class="clearfix">
						<select id="isShow" name="isShow" class="col-xs-10 col-sm-5">
							<c:forEach var="item" items="${requestScope.isShows}">
							<option value="${item}" >${item.name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="weight"> 排序权重 </label>
			
				<div class="col-sm-9">
					<div class="clearfix">
						<input type="text"  class="col-xs-10 col-sm-5" id="weight" name="weight"/>
					</div>
				</div>
			</div>
			
			<div class="clearfix form-actions">
				<div class="col-md-offset-3 col-md-9">
					<button class="btn btn-info save" type="button">
						<i class="ace-icon fa fa-check bigger-110"></i>
						提交
					</button>
			
					&nbsp; &nbsp; &nbsp;
					<button class="btn reset" type="button">
						<i class="ace-icon fa fa-refresh bigger-110"></i>
						重置
					</button>
					
					&nbsp; &nbsp; &nbsp;
					<button class="btn btn-danger cancel" type="button">
						<i class="ace-icon fa fa-undo bigger-110"></i>
						取消
					</button>
				</div>
			</div>
		</form>
	</div>
</div>
<script type="text/javascript">
	$(function() {
		$(".data-form").validate({
			errorElement: 'div',
			errorClass: 'help-block',
			focusInvalid: false,
			ignore: "",
			rules: {
				name: {
					required: true,
					maxlength: 16
				},
				weight: {
					required: true,
					digits: true,
					maxlength: 11			
				},
				file: {
					required: true			
				}
			},
			highlight: function (e) {
				$(e).closest('.form-group').removeClass('has-info').addClass('has-error');
			},
			success: function (e) {
				$(e).closest('.form-group').removeClass('has-error');//.addClass('has-info');
				$(e).remove();
			},
			errorPlacement: function (error, element) {
				if(element.is('input[type=checkbox]') || element.is('input[type=radio]')) {
					var controls = element.closest('div[class*="col-"]');
					if(controls.find(':checkbox,:radio').length > 1) controls.append(error);
					else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
				}
				else if(element.is('.select2')) {
					error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
				}
				else if(element.is('.chosen-select')) {
					error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
				}
				else if(element.is('#file')) {
					error.insertAfter(element.parent().parent());
				}
				else error.insertAfter(element.parent());
			},
			submitHandler: function (form) {
			},
			invalidHandler: function (form) {
			}
		});
		
		$('input[type="file"]').ace_file_input({
			style: 'well',
			btn_choose: '点击或将图片拖拽至此上传!',
			btn_change: null,
			no_icon: 'ace-icon fa fa-cloud-upload',
			droppable: true,
			thumbnail: 'small', //large | fit,
			allowExt:  ['jpg', 'jpeg', 'png', 'gif', 'tif', 'tiff', 'bmp'],
			allowMime: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif', 'image/tif', 'image/tiff', 'image/bmp'],
			maxSize: 10000000,
			before_remove: function() {
				return true;
			},
			preview_error: function(filename, error_code) {
				console.log(error_code)
			}
		});
		$(".ace-file-input").addClass("col-xs-10 col-sm-5");
		
		$(".save").on("click",function(){
			$(".data-form").form({
				success:function(res) {
					//弹窗提示
					$.messager.alert(res.msg, function() {
						if(res.code) {
							//提交成功,跳转回查询页面
							action("vmanage/core/informationCategoryManage/list");
						}
					});
				}
			})
		});
		
		$(".reset").on("click", function() {
			$(".data-form").formClear();
		});
		
		$(".cancel").on("click", function() {
			action("vmanage/core/informationCategoryManage/list");
		});
	});
</script>