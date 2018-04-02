<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工管理系统</title>
<!-- Bootstrap -->
<link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<!-- JQuery -->
<script type="text/javascript" src="static/js/jquery-1.11.0.min.js"></script>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!-- web路径：
	不以/开始的相对路径，以当前资源的路径为基准，容易出现问题
	以/开始的相对路径，资源以服务器的路径为标准
	比如(http://localhost:3360):需要加上项目名
	http://localhost:3306/crud
 -->
 <!-- 增加登录功能 -->
 <!-- 设置访问人数 -->

 
<!-- Bootstrap -->
<link
	href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="${APP_PATH}/static/js/jquery-1.11.0.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script
	src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- 新增员工的模态框 -->
	<!-- Modal -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">添加员工</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="inputEmpName" class="col-sm-2 control-label">姓名</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="empName_add_input"
									name="empName" placeholder="张三"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="email_add_input"
									name="email" placeholder="xxx@163.com"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="inputGender" name="gender"
								class="col-sm-2 control-label">性别</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_add_input" value="M"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_add_input" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label for="inputdept" class="col-sm-2 control-label">部门</label>
							<div class="col-sm-4">
								<select class="form-control" name="dId" id="dept_add_area">
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 员工修改的模态框 -->
	<!-- Modal -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工信息修改</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="inputEmpName" class="col-sm-2 control-label">姓名</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="empName_update_static"></p>
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="email_update_input"
									name="email" placeholder="xxx@163.com"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="inputGender" name="gender"
								class="col-sm-2 control-label">性别</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_update_input" value="M"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_update_input" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label for="inputdept" class="col-sm-2 control-label">部门</label>
							<div class="col-sm-4">
								<select class="form-control" name="dId" id="dept_update_area">
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="emp_update_btn">保存</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>员工信息管理系统</h1>
			</div>
		</div>
		<!-- 新增 删除 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				
				<button type="button" class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button type="button" class="btn btn-danger" id="emp_delete_all_btn">删除</button>
				<!-- 增加一个高级搜索的按钮 -->
				<!-- 跳转到高级搜索的界面query.jsp -->
				<button type="button" class="btn btn-info" id="emp_query_btn">高级搜索</button>
			</div>
		</div>
		
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-striped" id="emps_table">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check-all"/>
							</th>
							<th>ID</th>
							<th>员工姓名</th>
							<th>性别</th>
							<th>电子邮箱</th>
							<th>部门</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>
			</div>
		</div>
		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info_area"></div>
			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
	</div>
	<script type="text/javascript">
		var totalRecord;
		var currentPage;
		//页面加载完成后，发送ajax请求，获取分页数据
		$(function() {
			to_page(1);
		})

		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/emps",
				data : "pn=" + pn,
				type : "GET",
				success : function(result) {
					//console.log(result);
					//1. 解析JSON 显示员工数据
					build_emps_table(result);
					//2. 显示分页信息
					build_page_info(result);
					//3. 显示分页条
					build_page_nav(result);
				}
			});
		}

		function build_emps_table(result) {
			var emps = result.extend.pageInfo.list;
			//清空table表格
			$("#emps_table tbody").empty();
			$.each(emps, function(index, item) {
				//alert(item.empName);
				var checkBoxTd = $("<td><input type='checkbox' class='check_item'></input></td>");
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(
						item.gender == 'M' ? "男" : "女");
				var EmailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>")
						.append(item.department.deptName);
				/**
				<button type="button" class="btn btn-primary btn-sm">
					修改 <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
				</button>
				<button type="button" class="btn btn-danger btn-sm">
					删除 <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
				 */
				var editbtn = $("<button></button>").addClass(
						"btn btn-primary btn-sm edit_btn").append(
						$("<span></span>").addClass(
								"glyphicon glyphicon-pencil")).append("编辑");
				editbtn.attr("edit-id", item.empId);
				var delbtn = $("<button></button>").addClass(
						"btn btn-danger btn-sm delete_btn").append(
						$("<span></span>").addClass(
								"glyphicon glyphicon-remove")).append("删除");
				delbtn.attr("delete-id", item.empId);
				var btntd = $("<td></td>").append(editbtn).append(" ").append(
						delbtn)
				$("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(
						genderTd).append(EmailTd).append(deptNameTd).append(
						btntd).appendTo("#emps_table tbody");
			});
		}
		//分页条
		function build_page_nav(result) {
			//page_nav_area
			$("#page_nav_area").empty();

			var ul = $("<ul></ul>").addClass("pagination");
			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;").attr("href", "#"));
			if (result.extend.pageInfo.hasPreviousPage == false) {
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			} else {
				//添加翻页事件
				firstPageLi.click(function() {
					to_page(1);
				});
				prePageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum - 1);
				});
			}

			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;").attr("href", "#"));
			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#"));
			if (result.extend.pageInfo.hasNextPage == false) {
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			} else {
				//添加翻页事件
				lastPageLi.click(function() {
					to_page(result.extend.pageInfo.pages);
				});
				nextPageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum + 1);
				});
			}

			ul.append(firstPageLi).append(prePageLi);
			var navNum = result.extend.pageInfo.navigatepageNums;
			$.each(navNum, function(index, item) {
				var pageLi = $("<li></li>").append(
						$("<a></a>").append(item).attr("href", "#"));
				if (result.extend.pageInfo.pageNum == item) {
					pageLi.addClass("active");
				}
				//绑定单击事件
				pageLi.click(function() {
					to_page(item);
				})
				ul.append(pageLi);
			});
			ul.append(nextPageLi).append(lastPageLi);
			var navEle = $("<nav></nav>").append(ul);
			$("#page_nav_area").append(navEle);
		}
		//分页信息
		function build_page_info(result) {

			$("#page_info_area").empty();

			$("#page_info_area").append(
					"当前第 " + result.extend.pageInfo.pageNum + " 页" + " 总 "
							+ result.extend.pageInfo.pages + " 页" + " 总 "
							+ result.extend.pageInfo.total + " 条记录");
			totalRecord = result.extend.pageInfo.total;
			currentPage = result.extend.pageInfo.pageNum;
		}
		
		//新增按钮
		$("#emp_add_modal_btn").click(function() {
			//清除表单数据和样式
			reset_form("#empAddModal form")
			//发送ajax请求，查出部门信息，显示在下拉列表中
			getDepts("#dept_add_area");
			//弹出新增模态框
			$("#empAddModal").modal({
				backdrop : "static"
			});
		});
		function reset_form(ele) {
			$(ele)[0].reset();
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}

		//查出所有部门名称
		function getDepts(ele) {
			$(ele).empty();
			$.ajax({
				url : "${APP_PATH}/depts",
				type : "GET",
				success : function(result) {

					//{"code":100,"msg":"处理成功","extend":{"depts":[{"deptId":1,"deptName":"开发部"},{"deptId":2,"deptName":"测试部"},{"deptId":3,"deptName":"财务部"},{"deptId":4,"deptName":"秘书部"},{"deptId":5,"deptName":"后勤部"},{"deptId":6,"deptName":"总务处"}]}}
					//console.log(result);
					//提取部门信息显示在下拉列表中
					var deptInfo = result.extend.depts;
					$.each(deptInfo, function(index, item) {
						var option = $("<option></option>").append(
								item.deptName).attr("value", item.deptId);
						option.appendTo(ele);
					});
				}
			});
		}

		//员工姓名输入框的校验
		$("#empName_add_input").change(
				function() {
					//发送ajax校验用户名是否可用
					var empName = this.value;
					//alert(empName);
					$.ajax({
						url : "${APP_PATH}/checkuser",
						type : "POST",
						data : "empName=" + empName,
						success : function(result) {
							if (result.code == 100) {
								show_validate_msg("#empName_add_input",
										"success", "用户名可用");
								$("#emp_save_btn").attr("ajax-va", "success");
							} else {
								show_validate_msg("#empName_add_input",
										"error", result.extend.va_msg);
								$("#emp_save_btn").attr("ajax-va", "error");
							}
						}
					});
				});

		//保存新增员工信息
		$("#emp_save_btn").click(function() {
							if ($("#emp_save_btn").attr("ajax-va") == "error") {
								return false;
							} 
							else if (!validate_add_form()) {
								return false;
							}
							else {
								//模态框中填写的表单数据提交给服务器进行保存
								//alert($("#empAddModal form").serialize());
								$.ajax({
										url : "${APP_PATH}/emp",
										type : "POST",
										data : $("#empAddModal form").serialize(),
										success : function(result) {
										if (result.code == 100) {
										//保存成功
										//alert(result.msg);
										//关闭模态框
										$("#empAddModal").modal("hide");
										//到最后一页，发送ajax请求即可
											to_page(totalRecord);
										} else {
											//{"code":200,"msg":"处理失败","extend":{"errorFields":{"empName":"名字必须是2-5个中文或者6-16位英文数字组合"}}}
											if (result.extend.errorFields.email != undefined) {
											//显示邮箱错误信息
												show_validate_msg("#empName_add_input","error",result.extend.errorFields.email);
											} else if (result.extend.errorFields.empName != undefined) {
														//显示员工名字错误信息
														show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
													}
												}
											}
										});
							}
						});

		//校验表单数据
		//名字
		//邮箱
		function validate_add_form() {

			//正则表达式
			var empName = $("#empName_add_input").val();
			//alert(empName);
			var regName = /(^[A-Za-z0-9]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
			//alert(regName.test(empName));
			if (!regName.test(empName)) {
				//alert("名字必须是2-5个中文或者6-16位英文数字组合");
				show_validate_msg("#empName_add_input", "error",
						"名字必须是2-5个中文或者6-16位英文数字组合");
				/*
				$("#empName_add_input").parent().addClass("has-error");
				$("#empName_add_input").next("span").text("名字必须是2-5个中文或者6-16位英文数字组合");
				 */
				return false;
			} else {
				show_validate_msg("#empName_add_input", "success", "");
				//$("#empName_add_input").parent().addClass("has-success");
				//$("#empName_add_input").next("span").text("");
			}
			//校验邮箱
			var email = $("#email_add_input").val();
			//alert(email);
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				//alert("邮箱格式输入错误");
				show_validate_msg("#email_add_input", "error", "邮箱格式输入错误");
				//$("#email_add_input").parent().addClass("has-error");
				//$("#email_add_input").next("span").text("邮箱格式输入错误");
				return false;
			} else {
				show_validate_msg("#email_add_input", "success", "");
				//$("#email_add_input").parent().addClass("has-success");
				//$("#email_add_input").next("span").text("");
			}
			return true;
		}

		//正则校验，代码抽取
		function show_validate_msg(ele, status, msg) {
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if ("success" == status) {
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text("");
			} else if ("error" == status) {
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
		

		
		//新版本jquery使用
		$(document).on("click", ".edit_btn", function() {
			//查出部门信息
			getDepts("#dept_update_area");
			//查出员工信息
			getEmp($(this).attr("edit-id"));

			//弹出框,把员工ID传递给更新按钮
			$("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));
			$("#empUpdateModal").modal({
				backdrop : "static"
			});
		});

		function getEmp(id) {
			$.ajax({
				url : "${APP_PATH}/emp/" + id,
				type : "GET",
				success : function(result) {
					var empData = result.extend.emp;
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					//type=radio
					$("#empUpdateModal input[name=gender]").val(
							[ empData.gender ]);
					$("#empUpdateModal select").val([ empData.dId ]);
				}
			})
		}

		//点击更新员工信息
		$("#emp_update_btn").click(function() {
			//校验邮箱
			var email = $("#email_update_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				show_validate_msg("#email_update_input", "error", "邮箱格式输入错误");
				return false;
			} else {
				show_validate_msg("#email_update_input", "success", "");
			}
			//保存员工数据
			$.ajax({
				url : "${APP_PATH}/emp/" + $(this).attr("edit-id"),
				type : "PUT",
				data : $("#empUpdateModal form").serialize(),
				success : function(result) {
					if (result.code == 100) {
						//保存成功
						//alert(result.msg);
						//关闭模态框
						$("#empUpdateModal").modal("hide");
						//alert(result.msg);
						//回到本页面
						to_page(currentPage);
					} else {
						alert("更新失败");
					}
				}
			});
		});
		
		//单个删除
		$(document).on("click", ".delete_btn", function() {
			//弹出是否删除对话框
			var delName = $(this).parents("tr").find("td:eq(2)").text();
			//alert(delName);
			if(confirm("确认删除"+delName+"?")){
				//确定，发送删除请求
				$.ajax({
					url:"${APP_PATH}/emp/" + $(this).attr("delete-id"),
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						to_page(currentPage);
					}
				});
			}
		});
		//批量删除
		//全选功能
		
		$("#check-all").click(function(){
			//使用prop修改和读取dom原生属性，不使用attr
			//alert($(this).prop("checked"));
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		//单选点满，全选按钮也要勾上
		$(document).on("click",".check_item",function(){
			//判断是否全部勾选
			var flag = $(".check_item:checked").length==$(".check_item").length;
			$("#check-all").prop("checked",flag);
		});
		
		//点击全部删除
		$("#emp_delete_all_btn").click(function(){
			var empNames = "";
			var del_idstr = "";
			$.each($(".check_item:checked"),function(index,item){
				empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
				del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";
			});
			empNames = empNames.substring(0,empNames.length-1);
			del_idstr = del_idstr.substring(0,del_idstr.length-1);
			if(confirm("确认删除"+empNames+"?")){
				$.ajax({
					url:"${APP_PATH}/emp/" + del_idstr,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						to_page(currentPage);
					}
				});
			}
		});
		
		//定义一个高级搜索按钮的跳转事件
		
		$("#emp_query_btn").click(function(){
			window.location.href = "${APP_PATH}/emp/query/";
		});
	</script>
</body>
</html>