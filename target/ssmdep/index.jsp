<%@ page language="java" contentType="text/html;charset=UTF-8"  pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <meta http-equiv="content-type" content="text/html;charset=UTF-8">
    <title>员工列表</title>
    <% pageContext.setAttribute("APP_PATH",request.getContextPath()); %>
    <script src="${APP_PATH}/static/js/jquery-2.1.4.min.js"></script>
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%--员工修改的模态框--%>
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="name_add_input" class="col-sm-2 control-label">Name</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="name_update_static"></p>
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_update_input" placeholder="Email@sina.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label   class="col-sm-2 control-label">Gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <%--                                value取值为多字母时报SQL错误,无法提交ajax请求--%>
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label   class="col-sm-2 control-label">DeptName</label>
                        <div class="col-sm-4">
                            <%--                            提交部门ID即可--%>
                            <select  class="form-control" name="dId" id="dept_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update">更新</button>
            </div>
        </div>
    </div>
</div>

<%--员工添加的模态框--%>
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="name_add_input" class="col-sm-2 control-label">Name</label>
                        <div class="col-sm-10">
                            <input type="text" name="name" class="form-control" id="name_add_input" placeholder="Name">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_add_input" placeholder="Email@sina.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label   class="col-sm-2 control-label">Gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
<%--                                value取值为多字母时报SQL错误,无法提交ajax请求--%>
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label   class="col-sm-2 control-label">DeptName</label>
                        <div class="col-sm-4">
<%--                            提交部门ID即可--%>
                            <select  class="form-control" name="dId" id="dept_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save">保存</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_model">添加</button>
            <button class="btn btn-danger" id="emp_delete_model">删除</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover"id="emps_table">
                <thead>
                    <tr>
                        <th><input type="checkbox" id="check-all"></th>
                        <th>ID</th>
                        <th>姓名</th>
                        <th>邮箱</th>
                        <th>性别</th>
                        <th>部门</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6" id="pageInfoArea"></div>
        <div class="col-md-6" id="pageInfoNavigate"></div>
    </div>
</div>

</body>
<script>
    var totalPages,currentPage;
    //1.页面加载完成以后,直接发送ajax请求,要到分页数据
    $(function (){
        toPage(1);
    });

    function toPage(pageNo)
    {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pageNo="+pageNo,
            type:"GET",
            success:function (result) {
                // console.log(result);
                //解析并显示员工信息
                build_emps_table(result);
                //解析显示分页信息
                build_pageInfo(result);
                //解析显示导航条
                build_page_navigation(result);
            }
        });
    }

    function build_emps_table(result)
    {
        //清空表格
        $("#emps_table tbody").empty();
        var emps=result.extend.pageInfo.list;
        $.each(emps,function (index,item){
            // alert(item.name);
            var checkBox=$("<td><input type='checkbox' class='check_item'/></td>");
            var empId=$("<td></td>").append(item.id);
            var empName=$("<td></td>>").append(item.name);
            var empEmail=$("<td></td>").append(item.email);
            var empGender=$("<td></td>>").append(item.gender=="M"?"男":"女");
            var empDept=$("<td></td>").append(item.department.deptName);
            var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                        .append($("<span></span>")).addClass("glyphicon glyphicon-plus")
                        .append("编辑");
            //为编辑按钮添加一个自定义属性,来表示当前员工Id
            editBtn.attr("edit-id",item.id);
            var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                        .append($("<span></span>")).addClass("glyphicon glyphicon-trash")
                        .append("删除");
            var button=$("<td></td>").append(editBtn).append(" ").append(delBtn);
            //为删除按钮添加一个自定义属性,来表示当前员工Id
            delBtn.attr("delete-id",item.id);
            //append方法执行完成以后还是返回原来的元素
            $("<tr></tr>").append(checkBox)
                .append(empId)
                .append(empName)
                .append(empEmail)
                .append(empGender)
                .append(empDept)
                .append(button)
                .appendTo("#emps_table tbody");
        })

    }

    function build_pageInfo(result)
    {
        $("#pageInfoArea").empty();
        $("#pageInfoArea").append("当前第"+result.extend.pageInfo.pageNum+"页,共"+result.extend.pageInfo.pages+"页,总共"+result.extend.pageInfo.total+"条记录");
        totalPages=result.extend.pageInfo.pages;
        currentPage=result.extend.pageInfo.pageNum;
    }

    function build_page_navigation(result)
    {
        $("#pageInfoNavigate").empty();
        var ul=$("<ul></ul>").addClass("pagination");
        //构建元素
        var firstPage=$("<li></li>").append($("<a></a>").append("首页"));
        var prevPage=$("<li></li>").append($("<a></a>").append("&laquo;"));
        if(result.extend.pageInfo.hasPreviousPage==false)
        {
            firstPage.addClass("disabled");
            prevPage.addClass("disabled");
        }
        //绑定单击事件
        else
        {
            firstPage.click(function () {
                toPage(1);
            })
            prevPage.click(function () {
                toPage(result.extend.pageInfo.pageNum-1);
            })
        }

        var nextPage=$("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPage=$("<li></li>").append($("<a></a>").append("末页"));
        if(result.extend.pageInfo.hasNextPage==false)
        {
            nextPage.addClass("disabled");
            lastPage.addClass("disabled");
        }
        else
        {
            nextPage.click(function () {
                toPage(result.extend.pageInfo.pageNum+1);
            })
            lastPage.click(function () {
                toPage(result.extend.pageInfo.pages);

            })
        }



        ul.append(firstPage).append(prevPage);
        $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
            var num=$("<li></li>").append($("<a></a>").append(item));
            if(result.extend.pageInfo.pageNum==item)
            {
                num.addClass("active");
            }
            num.click(function () {
                toPage(item);
            })
            ul.append(num);
        })
        ul.append(nextPage).append(lastPage);
        var nav=$("<nav></nav>").append(ul);
        nav.appendTo("#pageInfoNavigate");
    }
//点击新增按钮弹出模态框
    $("#emp_add_model").click(function () {
        //清除表单数据
        $("#empAddModal form ")[0].reset();
        //清除表单样式以及提示信息
        $("#empAddModal form").find("*").removeClass("has-error has-success");
        $("#empAddModal form").find(".help-block").text("");
        //发送ajax请求,查出部门信息,显示在下拉列表中
        $("#empAddModal select").empty();
        getDepts("#empAddModal select");
        //弹出模态框
        $("#empAddModal").modal({
            backdrop:"static"
        });
    });

    function getDepts(element) {
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success:function (result) {
                // console.log(result);
                $.each(result.extend.depts,function () {
                    var department=$("<option></option>").append(this.deptName).attr("value",this.id);
                    department.appendTo(element);
                });
            }
        });
        
    }

    $("#emp_save").click(function () {
        //模态框中填写的表单数据提交给服务器保存
        if(!validate_add_form())
        {
            return false;
        }
        //判断之前的ajax用户名校验是否成功
        if($(this).attr("ajax-validate")=="error")
        {
            return false;
        }
        //发送ajax请求保存员工
        // alert($("#empAddModal form").serialize());
        $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data:$("#empAddModal form").serialize(),
            success:function (result) {
                // alert(result.message);
                if(result.code==100)
                {
                    //员工保存成功
                    //1.关闭模态框
                    $("#empAddModal").modal("hide");
                    //2.来到最后一页
                    toPage(totalPages+1);
                }
                //后端校验
                else
                {
                    // console.log(result);
                    // alert(result.extend.errorField.email);
                    // alert(result.extend.errorField.name);
                    if(undefined!=result.extend.errorField.email)
                    {
                        $("#email_add_input").parent().addClass("has-error");
                        $("#email_add_input").next("span").text("邮箱格式非法!");
                        return false;
                    }
                    if(undefined!=result.extend.errorField.name)
                    {
                        $("#name_add_input").parent().addClass("has-error");
                        $("#name_add_input").next("span").text("用户名可以是2-5位中文或者6-16位英文和数字的组合!");
                        return false;
                    }
                }

            }
        })
    })

    //校验表单数据
    function validate_add_form()
    {
        //清除当前元素的校验状态
        $("#name_add_input").parent().removeClass("has-success has-error");
        $("#email_add_input").parent().removeClass("has-success has-error");
        var name=$("#name_add_input").val();
        var regName=/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]+$)/;
        if(!regName.test(name))
        {
            // alert("用户名可以是2-5为中文或者6-16位英文和数字的组合!");
            $("#name_add_input").parent().addClass("has-error");
            $("#name_add_input").next("span").text("用户名可以是2-5位中文或者6-16位英文和数字的组合!");
            return false;
        }
        else
        {
            if($("#emp_save").attr("ajax-validate")=="error")
            {
                $("#name_add_input").parent().addClass("has-error");
                $("#name_add_input").next("span").text("用户名不可用");
                return false;
            }
            else
            {
                $("#name_add_input").parent().addClass("has-success");
                $("#name_add_input").next("span").text("");
            }

        }
        var email=$("#email_add_input").val();
        var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email))
        {
            // alert("邮箱格式非法!");
            $("#email_add_input").parent().addClass("has-error");
            $("#email_add_input").next("span").text("邮箱格式非法!");
            return false;
        }
        else
        {
            $("#email_add_input").parent().addClass("has-success");
            $("#email_add_input").next("span").text("");
        }
        return true;
    }

    //校验用户名是否可用
    $("#name_add_input").change(function () {
        var name=this.value;
        $.ajax({
            url:"${APP_PATH}/checkuser",
            data:"name="+name,
            type:"POST",
            success:function (result) {
                if(result.code==100)
                {
                    $("#name_add_input").parent().removeClass("has-success has-error");
                    $("#name_add_input").parent().addClass("has-success");
                    $("#name_add_input").next("span").text("用户名可用");
                    $("#emp_save").attr("ajax-validate","success");
                }
                else
                {
                    $("#name_add_input").parent().removeClass("has-success has-error");
                    $("#name_add_input").parent().addClass("has-error");
                    $("#name_add_input").next("span").text(result.extend.validate_message);
                    $("#emp_save").attr("ajax-validate","error");
                }
            }
        });
    });
//在按钮创建之前绑定click,所以绑定不上
$(document).on("click",".edit_btn",function () {
    // alert("edit");
    //查出员工信息,显示员工信息
    getEmp($(this).attr("edit-id"));
    //查出部门信息,显示部门列表
    $("#empUpdateModal select").empty();
    //把员工的id传递给模态框的更新按钮,方便后续修改员工信息
    $("#emp_update").attr("edit-id",$(this).attr("edit-id"));
    getDepts("#empUpdateModal select");

    $("#empUpdateModal").modal({
        backdrop:"static"
    });
});

function getEmp(id){
    $.ajax({
        url:"${APP_PATH}/emp/"+id,
        type:"GET",
        success:function (result) {
            // console.log(result);
            var empData=result.extend.emp;
            $("#name_update_static").text(empData.name);
            $("#email_update_input").val(empData.email);
            $("#empUpdateModal input[name=gender]").val([empData.gender]);
            $("#empUpdateModal select").val([empData.dId])
        }
    });
}

//点击更新,更新员工信息
    $("#emp_update").click(function () {
        //验证邮箱信息是否合法
        var email=$("#email_update_input").val();
        var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email))
        {
            // alert("邮箱格式非法!");
            $("#email_update_input").parent().addClass("has-error");
            $("#email_update_input").next("span").text("邮箱格式非法!");
            return false;
        }
        else
        {
            $("#email_update_input").parent().addClass("has-success");
            $("#email_update_input").next("span").text("");
        }
        //发送ajax请求保存更新的员工数据
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
            type:"PUT",
            data:$("#empUpdateModal form").serialize(),
            success:function (result){
                // alert(result.message);
                //关闭模态框
                $("#empUpdateModal").modal("hide");
                //回到本页面
                toPage(currentPage);
            }

        });

    })

    $(document).on("click",".delete_btn",function () {
        //弹出是否删除确认对话框
        // alert($(this).parents("tr").find("td:eq(1)").text());
        var name=$(this).parents("tr").find("td:eq(2)").text();
        var id=$(this).attr("delete-id");
        if(confirm("确认删除["+name+"]吗?")){
            //确认后,发送ajax请求
            $.ajax({
                url:"${APP_PATH}/emp/"+id,
                type:"DELETE",
                success:function (result) {
                    alert(result.message);
                    //回到本页
                    toPage(currentPage);
                }
            });
        };
    })
    //完成全选或全部选
    $("#check-all").click(function () {
        //attr获取checked数undefined
        //prop获取dom原生属性,attribute获取自定义属性
        // alert($(this).prop("checked"));
        // $(this).prop("checked");
        $(".check_item").prop("checked",$(this).prop("checked"));
    });

    $(document).on("click",".check_item",function () {
        //判断当前选择的元素是否为5个
        var flag=$(".check_item:checked").length==$(".check_item").length;
        $("#check-all").prop("checked",flag);
    })

    //点击批量删除
    $("#emp_delete_model").click(function () {
        var empNames="";
        var empIds="";
        $.each($(".check_item:checked"),function () {
            empNames+=$(this).parents("tr").find("td:eq(2)").text()+",";
            empIds+=$(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        //去除empNames多余的,号
        empNames=empNames.substring(0,empNames.length-1);
        empIds=empIds.substring(0,empIds.length-1);
        if(confirm("确认删除["+empNames+"]吗?")){
            //发送ajax请求删除
            $.ajax({
                url:"${APP_PATH}/emp/"+empIds,
                type:"DELETE",
                success:function (result) {
                    alert(result.message);
                    //回到当前页面
                    toPage(currentPage);
                }
            })
        }
    })

</script>
</html>