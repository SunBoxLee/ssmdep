package ssm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import ssm.bean.Department;
import ssm.bean.Message;
import ssm.service.DepartmentService;

import java.util.List;

@Controller
public class DepartmentController {
    @Autowired
    DepartmentService departmentService;
    @RequestMapping("/depts")
    @ResponseBody
    public Message getDepts()
    {
        List<Department> depts = departmentService.getDepts();
        return Message.success().add("depts",depts);
    }
}
