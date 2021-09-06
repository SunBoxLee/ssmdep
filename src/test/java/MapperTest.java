import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import ssm.bean.Department;
import ssm.bean.Employee;
import ssm.dao.DepartmentMapper;
import ssm.dao.EmployeeMapper;

import java.net.Socket;
import java.util.UUID;

//使用spring的单元测试
//1.导入springTest
//2.@ContextConfiguration指定spring配置文件的位置
//3.直接Autowired要使用的组件即可
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})

//测试dao层
public class MapperTest {
    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;
    @Test
    //测试departmentMapper
    public void testCRUD()
    {
//    //1.创建springIOC容器
//        ApplicationContext ioc=new ClassPathXmlApplicationContext("applicationContext.xml");
//    //2.从容器中获取mapper
//        DepartmentMapper bean=ioc.getBean(DepartmentMapper.class);
        System.out.println(departmentMapper);
        //插入几个部门
//        departmentMapper.insertSelective(new Department(null,"开发部"));
//        departmentMapper.insertSelective(new Department(null,"测试部"));
        //生成员工数据,测试员工插入
//        employeeMapper.insertSelective(new Employee(null,"jerry","M","jerry@sina.com",1));
        //批量插入多个员工,使用可以批量执行的sqlSession
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i=0;i<1000;i++)
        {
            String uid = UUID.randomUUID().toString().substring(0, 5)+i;
            mapper.insertSelective(new Employee(null,uid,"M",uid+"@sina.com",1));
        }
    }
}
