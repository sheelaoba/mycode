<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 <%@ page import="java.util.*" %>
    <%@ page import="java.io.*" %>
    <%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.PreparedQuery"%>
<%@ page import="com.google.appengine.api.datastore.Query.SortDirection"%>
<%@ page import="com.google.appengine.api.datastore.Query.FilterOperator"%>
<%@ page import="com.google.appengine.api.datastore.Query.FilterPredicate"%>
<%@ page import="com.google.appengine.api.datastore.Query.Filter"%> 
<%@ page import="javax.persistence.EntityNotFoundException" %>
<html>
<head>
<!-- <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">-->
<title>main page</title>
<link rel="stylesheet" type="text/css" href="datepickr_2.1/datepickr.css">
<script language="JavaScript" type="text/javascript" src="datepickr_2.1/datepickr.js"></script>
<script language="JavaScript1.1" src="js/search.js"></script>  

</head>
<style>
#maincontainer
{
    padding: 5px;
    border: 1px solid gray;
    margin:2px;
    border-radius:10px;
    height:700px;
    width:990px;
    align:center;
}

</style>

<script>
// This code Dynamically creates the table of forums with forum name, description and number
//of posts and replies
function addforum()
{
		
<%String luser=request.getParameter("loggeduser");

	session.setAttribute("luser",luser);%>
	var luser='<%=session.getAttribute("luser")%>';

if(luser=='null')
{
	<%String user=request.getParameter("user");System.out.println(user);
	session.setAttribute("user",user);%>
	var user='<%=session.getAttribute("user")%>';

	document.getElementById("luser1").value=user;
	document.getElementById("luser2").value=user;

}
else
{
	document.getElementById("luser1").value=luser;
	document.getElementById("luser2").value=luser;
}

	

	<%DatastoreService ds=DatastoreServiceFactory.getDatastoreService();%>
	
	<%Query q = new Query("forums").addSort("forumid", SortDirection.ASCENDING);

	//.setFilter(heightRangeFilter);
	 List<Entity> forums = ds.prepare(q).asList(FetchOptions.Builder.withDefaults());
	//PreparedQuery pq = ds.prepare(q);
	
     for (Entity result : forums) {%>
    
         var fid='<%=result.getProperty("forumid").toString()%>';
         <%String fid=result.getProperty("forumid").toString();%>
		 
		 var fname='<%=(String)result.getProperty("forumname")%>';
		 
		 //  String pdate = (String) result.getProperty("datepick");
		 var pdate='<%=(String)result.getProperty("datepick")%>';
	
		  
		  var fdata='<%=(String)result.getProperty("content")%>';
		  
	 
       <% Filter propertyFilter =new FilterPredicate("fid",FilterOperator.EQUAL,fid);
	
	
	      Query q1 = new Query("posts").setFilter(propertyFilter);
	      int count=ds.prepare(q1).countEntities(FetchOptions.Builder.withDefaults());
	   %>
	      var pcount='<%=ds.prepare(q1).countEntities(FetchOptions.Builder.withDefaults())%>';
	
		<%Query q2 = new Query("replies").setFilter(propertyFilter);
	      int count1=ds.prepare(q2).countEntities(FetchOptions.Builder.withDefaults());
	    %>
	     var rcount='<%=ds.prepare(q2).countEntities(FetchOptions.Builder.withDefaults())%>';
	
	 	var table=document.getElementById("mainforum");
    	
    	var row=document.createElement("tr");
    	row.id=fid;
    	//var line=document.createElement("hr");
    	var but=document.createElement("button");
    	but.id="deleteid";
    
    	but.onclick=function(){ removeforum(this);}
    	var image=document.createElement("img");
    	var img=document.createElement("img");
        var a=document.createElement('a');a.href="#";
        a.onclick=function(){sendfid(this);}
        var bk=document.createElement("br");
		

    	for(var i=0;i<=4;i++)
    		{
    		   var cell=document.createElement("td");
    		   
    		  if(i==0)
    		   {
    			  
   			       img.src="images/forum-image.png";
    			   cell.appendChild(img);
    			   a.innerHTML=fname;
    			   
        		   
        		   cell.appendChild(a);
        		   cell.appendChild(bk);
        		   var textnode=document.createTextNode(fdata);
        		   cell.appendChild(textnode);
        		   //cell.innerHTML="hello";
        		   //alert("i000");
    			
    		   }
    		   if(i==1)
    		   {cell.innerHTML=pcount;cell.align="center";}
    		   if(i==2)
    		   {cell.innerHTML=rcount;cell.align="center";}
    		   if(i==3)
    			  {cell.innerHTML=pdate;cell.align="center";}
    		   if(i==4)
    			   {
    			   image.src="images/delete.png";
    			   but.appendChild(image);
    			   cell.appendChild(but);}
    			
    	cell.setAttribute("style","background-color:#CCCCCC");
    		
    		   row.appendChild(cell);
    		}
	  

    	table.appendChild(row);
   <% }%>
	}


function removeforum(x)
{

	var table=document.getElementById("mainforum");
	
	var row=x.parentNode.parentNode;
	var index=row.id;
	
	
	document.getElementById("fid1").value=index;
	
	//table.deleteRow(index);
	document.getElementById("fid1submit").click();
	
	
	}
	
function sendfid(x)
{
  var table=document.getElementById("mainforum");
	
	var rowid=x.parentNode.parentNode.id;
	
	document.getElementById("fid").value=rowid;
	//alert(document.getElementById("fid").value);
	document.getElementById("fidsubmit").click();
	
	
	
}
</script>
<body onload="addforum()">
<input type="hidden" id="tt" value=""></input>

<!-- document.getElementById("text").value=session.getAttribute("newforum");}-->
<div id="maincontainer" align="center" style="position:relative;background-color:#f2f2f2;">
<div align="center"><img width="990" align="middle" src="images/forum-banner.jpg"></img></div>


<div style="float:right;position:relative">
<P>
 <TABLE BORDER=0 BGCOLOR="" VALIGN="TOP">

 <TR>
 <TD WIDTH="150"><FONT COLOR=""></FONT></TD>
 <TD WIDTH="350">
 <FONT COLOR="" SIZE=2>Enter search words below and then click Search.</FONT><BR>
 </TR></TD>
 <FORM NAME="formular" onsubmit="suche(document.formular.eingabe.value);return false;">
 <TR><TD>
 <P ALIGN="RIGHT">
 <FONT COLOR="" SIZE=5><B>Search</B></FONT> 
 </P></TD><TD>
 <INPUT TYPE="text" NAME="eingabe" SIZE="25"> 
 <INPUT TYPE="button" VALUE="Search" onClick="suche(document.formular.eingabe.value)">
 </TD></TR>
 </FORM>
 <FORM NAME="ra">
 <tr><TD><P ALIGN="RIGHT"><B><FONT SIZE=2 COLOR="">Search Options:</FONT></B>
 <BR><FONT COLOR=""></FONT></P></TD>
 <td align=left>
 <font face="Arial,Helvetica,Sans-Serif" size="1">
 <input type=radio checked name="r" value="or"><FONT COLOR="">Matches on any word (OR)</FONT>
 <BR>
 <input type=radio name="r" value="and"><FONT COLOR="">Matches on all words (AND)</FONT>
 </FONT></TD></TR></P></TABLE></P></P></FORM> 


</div>





 
 
 
 <div align="left"><a href="#" onClick="window.open('addforum.jsp','_self','width=750,height=30,scrollbar=yes,toolbar=no,menubar=0,left=0,top=0,resizable=yes,status=no');">AddForum</a></div> 
 <br><br><br>
 <br>
 <div id="tabledata" style="position:relative;align:center">
<table id="mainforum"  bgcolor="white" width="980" border="0" >
  <tr bgcolor="#e0e0f8" style="color:#0099cc">
    
    <th>Discussion Forum</th>
    <th width="70" align="center">Total Posts</th>
    <th width="70" align="center">Total Replies</th>
    <th align="center">Posted Date</th>
    <th>Delete</th>
  </tr>
 
  
</table>
</div>
</div>
<form method="get" action="openforum.jsp">
<input id="fid" value="" type="hidden" name="fid"></input>
<input id="luser1" value="" type="hidden" name="luser"></input>
<button id="fidsubmit" type="submit" style="display:none" value="submit"></button>
</form>
<form method="get" action="/deleteservlet">
<input id="fid1" value="" type="hidden" name="fid1"></input>
<input id="luser2" value="" type="hidden" name="luser"></input>
<input id="fid1submit" type="submit" style="display:none" value="submit"></input>

</form>
</body>
</html>