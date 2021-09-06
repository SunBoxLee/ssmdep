package ssm.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import ssm.bean.Employee;
import ssm.bean.Message;
import ssm.service.EmployeeService;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;

    @RequestMapping(value = "/emp/{id}",method = RequestMethod.DELETE)
    @ResponseBody
    public Message deleteEmployeeById(@PathVariable("id") String ids)
    {
        if(ids.contains("-"))
        {
            List<Integer> del_ids=new ArrayList<>();
            String[] str_ids = ids.split("-");
            for(String str:str_ids)
            {
                del_ids.add(Integer.parseInt(str));
            }
            employeeService.deleteBatch(del_ids);
        }
        else
        {
            int id = Integer.parseInt(ids);
            employeeService.deleteEmployeeById(id);
        }

        return Message.success();
    }


    @RequestMapping(value = "/emp/{id}",method = RequestMethod.PUT)
    @ResponseBody
    public Message saveEmp(Employee employee)
    {
        System.out.println("将要更新的员工数据:"+employee.toString());
        employeeService.updateEmp(employee);
        return Message.success();
    }

    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Message getEmp(@PathVariable("id")Integer id)
    {
        Employee employee = employeeService.getEmp(id);
        return Message.success().add("emp",employee);
    }

    @RequestMapping("/checkuser")
    @ResponseBody
    public Message checkUser(@RequestParam("name")String name)
    {
        //先判断用户名是否是合法的表达式
        String regx="(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]+$)";
        if(!name.matches(regx))
        {
            return Message.fail().add("validate_message","用户名可以是2-5位中文或者6-16位英文和数字的组合!");
        }
        //数据库用户名重复校验
        boolean b = employeeService.checkUser(name);
        if(b)
        {
            return Message.success();
        }
        else
        {
            return Message.fail().add("validate_message","用户名不可用");
        }
    }

    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Message saveEmp(@Valid Employee employee, BindingResult result)
    {
        if(result.hasErrors())
        {
            Map<String,Object> map=new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError:errors)
            {
                System.out.println("错误的字段名:"+fieldError.getField());
                System.out.println("错误信息:"+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Message.fail().add("errorField",map);
        }
        else {
            employeeService.saveEmployee(employee);
            return Message.success();
        }
    }

    @RequestMapping("/emps")
    //该注解需要导入jackson
    @ResponseBody
    public Message getEmpsWithJson(@RequestParam(value = "pageNo",defaultValue = "1")Integer pageNo, Model model)
    {
        //引入pageHelper分页插件
        //在查询之前调用,传入页码,以及每页的大小
        PageHelper.startPage(pageNo,5);
        //startPage之后紧跟的查询就是分页查询
        List<Employee> emps = employeeService.getAll();
        //使用pageInfo包装查询后的结果,只需要将pageInfo交给页面
        //封装了详细的分页信息,包括查询出来的数据,传入连续显示的页数
        PageInfo page = new PageInfo(emps,5);
        return Message.success().add("pageInfo",page);
    }

   // @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pageNo",defaultValue = "1")Integer pageNo, Model model)
    {
//        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
//        EmployeeService employeeService = context.getBean(EmployeeService.class);
        //引入pageHelper分页插件
        //在查询之前调用,传入页码,以及每页的大小
        PageHelper.startPage(pageNo,5);
        //startPage之后紧跟的查询就是分页查询
        List<Employee> emps = employeeService.getAll();
        //使用pageInfo包装查询后的结果,只需要将pageInfo交给页面
        //封装了详细的分页信息,包括查询出来的数据,传入连续显示的页数
        PageInfo page = new PageInfo(emps,5);
        model.addAttribute("pageInfo",page);
        return "list";
    }
}
