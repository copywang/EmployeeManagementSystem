package com.crud.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.crud.bean.Employee;
import com.github.pagehelper.PageInfo;

/**
 * 使用Spring测试模块提供的测试请求功能，测试crud的正确性
 * Spring4测试需要servlet3.0支持
 * @author copywang
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations= {"classpath:applicationContext.xml",
		"classpath:spring-mvc.xml"})
public class MvcTest {
	//传入SpringMVC的IOC
	@Autowired
	WebApplicationContext context;
	//虚拟MVC请求，获取到处理结果
	MockMvc mockMvc;
	
	@Before
	public void initMockMvc() {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	@Test
	public void testPage() throws Exception {
		//模拟请求拿到返回值
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).andReturn();
		//请求成功后，请求域中会有pageInfo
		PageInfo pi = (PageInfo) result.getRequest().getAttribute("pageInfo");
		System.out.println("当前页码：" + pi.getPageNum() 
		+ "总记录数：" + pi.getTotal() 
		+ "总页码: " + pi.getPages());
		System.out.println("页面需要连续显示的页码： ");
		int[] nums = pi.getNavigatepageNums();
		for (int i : nums) {
			System.out.println(" " + i);
		}
		
		//获取员工数据
		List<Employee> list = pi.getList();
		for (Employee emp : list) {
			System.out.println(emp.getEmpName());
		}
	}
}
