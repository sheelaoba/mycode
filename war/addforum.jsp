<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 <%@ page import="java.util.*" %>
    <%@ page import="java.io.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link href="kindeditor/themes/default/default.css" rel="stylesheet" />
<script src="kindeditor/kindeditor-all-min.js"></script>
<link rel="stylesheet" type="text/css" href="datepickr_2.1/datepickr.css">
<script language="JavaScript" type="text/javascript" src="datepickr_2.1/datepickr.js"></script>

<script>
    KindEditor.ready(function(K) {
        window.editor = K.create('#editor_id');
        html = document.getElementById('editor_id').value;
        html = editor.html();
        editor.sync();
        editor.html("");
    });
    
</script>
<script>
function closewindow()
    {
        //window.opener.close();
        window.location="mainpage.jsp";
    	
    }
   
</script>
</head>
<body>

<img width="990" src="images/forum-banner.jpg"></img>
<br><br>

<div align="left">

<form method="get" action="/Addforumservlet" target="_self">


Forum Name:<input type="text" id="fname" name="forumname" cols="50" rows="2"></input><br><br>
Posted Date:<input id="datepick1" name="datepick" cols="50" rows="2"></input><br><br><script type="text/javascript">new datepickr('datepick1')</script>
Description:<br>
<textarea id="editor_id" name="content" cols="70" rows="8"></textarea>
<input type="button" value="cancel" onclick="closewindow()"/>
<input type="submit" value="submit"/>
</form>

</div>
</body>
</html>