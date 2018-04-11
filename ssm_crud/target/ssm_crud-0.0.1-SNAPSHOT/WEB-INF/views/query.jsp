<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工查询页面</title>
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
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>查询员工</h1>
			</div>
		</div>
		<!-- 定义一个搜索的表格 -->

		<form class="form-horizontal" id="query_area">
			<div class="form-group">
				<label for="inputEmpName" class="col-sm-2 control-label">姓名</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="empName_query" name="empName"
						placeholder="张三">
				</div>
			</div>
			<div class="form-group">
				<label for="inputEmail" class="col-sm-2 control-label">邮箱</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="empEmail_query" name="email"
						placeholder="xxx@126.com">
				</div>
			</div>
			<div class="form-group">
				<label for="inputGender" name="gender"
					class="col-sm-2 control-label">性别</label>
				<div class="col-sm-10">
					<label class="radio-inline"> <input type="radio"
						name="gender" id="gender1_add_input" value="M" checked="checked">
						男
					</label> <label class="radio-inline"> <input type="radio"
						name="gender" id="gender2_add_input" value="F"> 女
					</label>
				</div>
			</div>
			<div class="form-group">
							<label for="inputdept" class="col-sm-2 control-label">部门</label>
							<div class="col-sm-2">
								<select class="form-control" name="dId" id="dept_add_area">
								</select>
							</div>
						</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-2">
					<button type="button" class="btn btn-info" id="query_emp_btn">查询</button>
				</div>
			</div>
		</form>
		
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-striped" id="emps_table">
					<thead>
						<tr>
							<th>ID</th>
							<th>员工姓名</th>
							<th>性别</th>
							<th>电子邮箱</th>
							<th>部门</th>
						</tr>
					</thead>
					<tbody>
						<!-- 用于显示查询出来的员工信息 -->
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
		
		//页面一加载完成,回显部门信息到下拉框
		$(function() {
			getDepts("#dept_add_area");
		})
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
		
		//定义Ajax提交查询员工信息
		$("#query_emp_btn").click(function(){
			//alert($("#query_area").serialize());
			$.ajax({
				url:"${APP_PATH}/queryEmps",
				type:"POST",
				data:$("#query_area").serialize(),
				success:function(result){
					//1. 显示员工信息
					build_emps_table(result);
					//2. 显示分页信息
					build_page_info(result);
					//3. 显示分页条
					build_page_nav(result);
				}
			});
			
		});
		
		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/queryEmps",
				data : "pn="+pn+"&"+$("#query_area").serialize(),
				type : "POST",
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
				
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(
						item.gender == 'M' ? "男" : "女");
				var EmailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>")
						.append(item.department.deptName);
			
				$("<tr></tr>").append(empIdTd).append(empNameTd).append(
						genderTd).append(EmailTd).append(deptNameTd).appendTo("#emps_table tbody");
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
		
	</script>
</body>
</html>