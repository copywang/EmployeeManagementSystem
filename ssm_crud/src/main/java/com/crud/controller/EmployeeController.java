package com.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.crud.bean.Employee;
import com.crud.bean.Msg;
import com.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 处理员工信息CRUD请求
 * 
 * @author copywang
 *
 */
@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;

	/**
	 * 导入jackson包 把对象转换成JSON字符串 第二稿 支持移动设备
	 * 
	 * @param pn
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
		// 引入PageHelper分页插件
		// 查询前调用，传入页码和记录数
		PageHelper.startPage(pn, 5);
		// startPage紧跟着的这个查询就是一个分页查询
		List<Employee> emps = employeeService.getAll();
		// PageInfo包装查询结果，封装了详细的分页信息和详细数据
		// 连续显示5页
		PageInfo pageInfo = new PageInfo(emps, 5);

		return Msg.success().add("pageInfo", pageInfo);
	}

	/**
	 * 展示list.jsp页面 查询员工数据（分页查询） 第一稿 用静态方法刷新的页面，支持浏览器
	 * 
	 * @return
	 */
	// @RequestMapping("/emps")
	public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
		// 引入PageHelper分页插件
		// 查询前调用，传入页码和记录数
		PageHelper.startPage(pn, 5);
		// startPage紧跟着的这个查询就是一个分页查询
		List<Employee> emps = employeeService.getAll();
		// PageInfo包装查询结果，封装了详细的分页信息和详细数据
		// 连续显示5页
		PageInfo pageInfo = new PageInfo(emps, 5);
		// 把PageInfo交给页面即可
		model.addAttribute("pageInfo", pageInfo);

		return "list";
	}

	/**
	 * 校验用户名是否被占用
	 * 
	 * @param empName
	 * @return
	 */
	@RequestMapping(value = "/checkuser", method = RequestMethod.POST)
	@ResponseBody
	public Msg checkuser(@RequestParam("empName") String empName) {
		// 判断用户名是否符合正则表达式

		String regex = "(^[A-Za-z0-9]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
		if (!empName.matches(regex)) {
			// System.out.println(empName.matches(regex));
			return Msg.fail().add("va_msg", "名字必须是2-5个中文或者6-16位英文数字组合");
		}

		if (employeeService.checkuser(empName)) {
			return Msg.success();
		} else {
			return Msg.fail().add("va_msg", "用户名不可用");
		}
	}

	/**
	 * 保存员工信息
	 * 
	 */
	@RequestMapping(value = "/emp", method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee, BindingResult result) {
		if (result.hasErrors()) {
			Map<String, Object> map = new HashMap<String, Object>();
			List<FieldError> fieldErrors = result.getFieldErrors();
			for (FieldError fieldError : fieldErrors) {
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		} else {
			employeeService.saveEmp(employee);
			return Msg.success();
		}
	}

	/**
	 * 查询员工信息
	 * 
	 */
	@RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id") Integer id) {
		Employee emp = employeeService.getEmp(id);
		return Msg.success().add("emp", emp);
	}

	/**
	 * 修改员工ID
	 */
	@RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
	@ResponseBody
	public Msg getEmp(Employee employee) {
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	/*
	 * //单个删除员工信息
	 * 
	 * @RequestMapping(value="/emp/{id}",method=RequestMethod.DELETE)
	 * 
	 * @ResponseBody public Msg deleteEmpById(@PathVariable("id")Integer id) {
	 * employeeService.deleteEmp(id); return Msg.success(); }
	 */

	/**
	 * 批量删除员工信息:1-2-3 单个：1
	 */
	@RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmpById(@PathVariable("ids") String ids) {
		if (ids.contains("-")) {
			String[] strIds = ids.split("-");
			/*
			 * 一种实现 for (String str : strIds) {
			 * employeeService.deleteEmp(Integer.parseInt(str)); }
			 */
			// 另一种实现
			List<Integer> del_ids = new ArrayList<Integer>();
			for (String str : strIds) {
				del_ids.add(Integer.parseInt(str));
			}
			employeeService.deleteBatchEmp(del_ids);

		} else {
			employeeService.deleteEmp(Integer.parseInt(ids));
		}
		return Msg.success();
	}

	@RequestMapping("/emp/query")
	public String toQueryPage() {
		return "query";
	}

	/**
	 * 查询功能的查询员工信息 查询出来的员工数据分页显示
	 */
	@RequestMapping(value = "/queryEmps", method = RequestMethod.POST)
	@ResponseBody
	public Msg queryEmp(@RequestParam(value = "pn", defaultValue = "1") Integer pn, 
			Employee employee) {
		// System.out.println(employee);
		PageHelper.startPage(pn, 20);
		List<Employee> emplist = employeeService.queryEmp(employee);
		// PageInfo包装查询结果，封装了详细的分页信息和详细数据
		// 连续显示5页
		PageInfo pageInfo = new PageInfo(emplist, 5);
		return Msg.success().add("pageInfo", pageInfo);
	}
}
