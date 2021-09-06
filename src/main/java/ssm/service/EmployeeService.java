package ssm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ssm.bean.Employee;
import ssm.bean.EmployeeExample;
import ssm.dao.EmployeeMapper;
import java.util.List;

@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;

    public void deleteBatch(List<Integer> ids)
    {
        EmployeeExample example=new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andIdIn(ids);
        employeeMapper.deleteByExample(example);
    }

    public void deleteEmployeeById(Integer id)
    {
        employeeMapper.deleteByPrimaryKey(id);
    }

    public void updateEmp(Employee employee)
    {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    public Employee getEmp(Integer id)
    {
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    public boolean checkUser(String name)
    {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andNameEqualTo(name);
        long count = employeeMapper.countByExample(employeeExample);
        return count==0;
    }

    public List<Employee> getAll()
    {
        return employeeMapper.selectByExampleWithDept(null);
    }
    public void saveEmployee(Employee employee)
    {
        employeeMapper.insertSelective(employee);
    }
}
