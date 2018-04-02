package com.crud.bean;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Email;

public class Employee {
    private Integer empId;
    @Pattern(regexp="(^[A-Za-z0-9]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)"
    		,message="名字必须是2-5个中文或者6-16位英文数字组合")
    private String empName;

    private String gender;
    @Email(message="邮箱格式不正确")
    private String email;

    private Integer dId;
    //用于查询员工的时候根据员工的d_id查询显示出部门名称
    private Department department;
    
    public Employee() {
		super();
	}

	public Employee(Integer empId, String empName, String gender, String email, Integer dId) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.gender = gender;
		this.email = email;
		this.dId = dId;
	}

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender == null ? null : gender.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }

	@Override
	public String toString() {
		return "Employee [empName=" + empName + ", gender=" + gender + ", email=" + email + ", dId=" + dId + "]";
	}
    
}