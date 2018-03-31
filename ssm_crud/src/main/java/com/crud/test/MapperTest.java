package com.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.crud.bean.Employee;
import com.crud.dao.DepartmentMapper;
import com.crud.dao.EmployeeMapper;

/**
 * 测试DAO层
 * @author copywang
 * 1. 导入springtest模块-pom.xml配置
 * 2. @ContextConfiguration指定spring配置文件的位置
 * 3. 直接autowired找对象
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:applicationContext.xml"})
public class MapperTest {
	@Autowired
	private DepartmentMapper dept;
	@Autowired
	private EmployeeMapper emp;
	@Autowired
	SqlSession sqlSession;
	/**
	 * 测试DepartmentMapper.xml
	 */
	@Test
	public void testprepareData() {
		//System.out.println(dept);
		//1. 插入部门
		//dept.insertSelective(new Department(null,"开发部"));
		//dept.insertSelective(new Department(null,"测试部"));
		//2. 生成一个员工数据
		//emp.insertSelective(new Employee(null,"jack","M","jack@126.com",1));
		//3. 批量插入员工，使用可以执行批量操作的sqlSession操作
/*
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int i = 0;i<1000;i++) {
			String name = UUID.randomUUID().toString().substring(0, 5) + i;
			mapper.insert(new Employee(null,name,"M",name+"@126.com",1));
		}
		for(int i = 0;i<1000;i++) {
			String name = UUID.randomUUID().toString().substring(0, 5) + i;
			mapper.insert(new Employee(null,name,"F",name+"@163.com",2));
		}
		*/
	}
}
