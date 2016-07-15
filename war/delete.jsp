<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script>
function getuser()
{
 
 var user='<%=request.getAttribute("uname")%>';
 
 document.getElementById("user").value=user;
}
</script>
</head>
<body onload="getuser()">
<div align="center">
Successfully Deleted
<form action="/mainpage.jsp">
<input type="hidden" value="" name="user" id="user"></input>
<input type="submit" title="please click on continue to Go back" value="continue"></input>
</form>
</div>
</body>
</html>