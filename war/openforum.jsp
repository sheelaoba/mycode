<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
 <%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.PreparedQuery"%>
<%@ page import="com.google.appengine.api.datastore.Query.FilterOperator"%>
<%@ page import="com.google.appengine.api.datastore.Query.FilterPredicate"%>
<%@ page import="com.google.appengine.api.datastore.Query.Filter"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>open forum</title>
<link href="kindeditor/themes/default/default.css" rel="stylesheet"/>
<script src="kindeditor/kindeditor-all-min.js"></script>
<script charset="utf-8" src="/kindeditor/lang/en.js"></script>

<script>
  /*  KindEditor.ready(function(K) {
        window.editor = K.create('#editor_id', {
            langType : 'en'
        });
        
    });*/
</script>

<style>
#maincontainer {
    padding: 1px;
    display:block;
    border: 1px solid gray;
    margin:auto;
    border-radius:3px;
    height:350px;
    width:1130px;
    background-color:#e0e0f8;
    position:relative;
    align:center;
}
#container {
    background-color:white;
    width:700px;
    padding: 5px;
   
    margin:auto;
    border-radius:20px;
    display:block;
    position:relative;
    align:center;
}
hr { 
    display: block;
    margin-top: 0.5em;
    margin-bottom: 0.5em;
    margin-left: auto;
    margin-right: auto;
    border-style: inset;
    border-width: 2px;
    background-color:#00c;
} 
</style>

<script>
// Dynamically loads posted messages on page load with dynamically created facebook buttons uses
// facebook SDK
function getposts()
	{
	//document.getElementById("rybut").disabled=true;
	
	<%String luser=request.getParameter("luser");session.setAttribute("luser",luser);%>
	var luser='<%=session.getAttribute("luser")%>';

	document.getElementById("uname1").value=luser;
	document.getElementById("uname2").value=luser;
	//alert(document.getElementById("uname").value);
	<%String fid=request.getParameter("fid");
	session.setAttribute("fid",fid);%>
	var fid='<%=session.getAttribute("fid")%>';

	document.getElementById("fid").value=fid;
	
	<%
	DatastoreService ds=DatastoreServiceFactory.getDatastoreService();%>
	
	<%Filter propertyFilter =new FilterPredicate("fid",FilterOperator.EQUAL,fid);
	System.out.println(propertyFilter);
	
	Query q = new Query("posts").setFilter(propertyFilter);
	//.setFilter(heightRangeFilter);
	 List<Entity> posts = ds.prepare(q).asList(FetchOptions.Builder.withDefaults());
	//PreparedQuery pq = ds.prepare(q);
	
    for (Entity result : posts) {%>

         var fid='<%=result.getProperty("fid").toString()%>';
          var postid='<%=result.getProperty("pid").toString()%>';
          <%String pid=result.getProperty("pid").toString();%>
		// document.getElementById("pid").value=pid;
		 var uname='<%=(String)result.getProperty("uname")%>';

		 //  String pdate = (String) result.getProperty("datepick");
		 var message='<%=(String)result.getProperty("message")%>';
	     var posteddate='<%=result.getProperty("posteddate")%>';
		 var postcount='<%=result.getProperty("pcount").toString()%>';
		 var divele=document.createElement("div");
		 divele.id="container";
//divele.class="container";

		 var textbox2=document.createElement("textarea");
		 textbox2.id="loginname";
		 textbox2.cols="14";
		 textbox2.rows="2";
		 textbox2.value="Posted message by:" +uname;
		 textbox2.editable=false;
		 textbox2.style="background-color:transparent;border-color:transparent;resize:none;color:#8A0829";

		 var textbox3=document.createElement("textarea");
		 textbox3.style="float:right;positive:absolute;border-color:transparent;background-color:transparent;rows:2;cols:200;resize:none";
		 textbox3.wrap=true;/**chnged**/

		 textbox3.value="Posted on:"+posteddate;

		 var tx3=document.createElement("div");
		 tx3.id="content";

		 tx3.style="overflow:scroll;width:680px;padding:2px;border:1px solid gray;height:150px;display:block";
		 tx3.innerHTML=message;

		 divele.appendChild(textbox2);
		 divele.appendChild(textbox3);
	//divele.appendChild(textbox);
		 divele.appendChild(tx3);
//-------------------------------
//fb-like button
//-------------------------
	var divfb=document.createElement("div");
	divfb.style="position:absolute;float:left";
	
	var fb=document.createElement("fb:like");

	fb.setAttribute('data-href','https://apps.facebook.com/sheeladomain/'+'#'+postid);
	fb.setAttribute('data-layout','standard');
	fb.setAttribute('data-action','like');
	fb.setAttribute('data-show-faces','false');
	fb.setAttribute('share','true');
	divfb.appendChild(fb);
	divele.appendChild(fb);
/*------------------------------------------		  
reply button
------------------------------*/
var link=document.createElement("a");
	link.class="nounderline";
	//link.innerHTML="Reply to this Post";
	link.id=postid;
	link.style="position:relative;float:right;text-decoration:none;color:'navy blue'";

	link.href="#";
	link.onclick=function(){replytopost(postid,luser);}
	link.onclick=function(){replytopost(this,luser,fid);}
	divele.appendChild(link);

	var br=document.createElement("br");

/*----------------------------------------
fb comments button
--------------------------------------------*/

	var divc=document.createElement("div");
	divc.style="align:center;position:relative;margin-top:10px";
	var comm=document.createElement("fb:comments");
	comm.setAttribute('data-href','https://apps.facebook.com/sheeladomain/'+'#'+postid);
	comm.setAttribute('data-numposts','5');
	comm.setAttribute('data-colorscheme','light');
	divc.appendChild(comm);
	divele.appendChild(br);
	divele.appendChild(br);
	divele.appendChild(divc);
	divele.border="0";
	
	document.body.appendChild(divele);
	
	//document.getElementById("loginname").focus();
	
	document.body.appendChild(document.createElement("br"));
	
	
	<% propertyFilter =new FilterPredicate("pid",FilterOperator.EQUAL,pid);
	
	
	Query q1 = new Query("replies").setFilter(propertyFilter);
	//.setFilter(heightRangeFilter);
	 List<Entity> replies = ds.prepare(q1).asList(FetchOptions.Builder.withDefaults());
	//PreparedQuery pq = ds.prepare(q);
	
    for (Entity res : replies) {%> 
    
         var replyid='<%= res.getProperty("replyid").toString()%>';
          
		 var uname='<%=(String)res.getProperty("uname")%>';
		 
		 //  String pdate = (String) result.getProperty("datepick");
		 var message='<%=(String)res.getProperty("replycontent")%>';
	
		  
		 var posteddate='<%=res.getProperty("posteddate")%>';
	     var replycount='<%=res.getProperty("rcount").toString()%>';
		  
		  
		  
	     var divrep=document.createElement("div");
	     divrep.id=replyid;
	     divrep.innerHTML=uname+" "+"says"+"<br>"+message;
	     divele.appendChild(divrep);
	     divele.appendChild(document.createElement("hr"));
	/**i changed thisbelow line**/
	     document.body.appendChild(divele);
	     document.body.appendChild(document.createElement("br"));
	//*******************************************************
	<%}%>
	

	FB.XFBML.parse();
		
	<%}%>
	
	
	
	}
	
	function replytopost(x,user,fid)
	{
	var pid=x.id;
//	document.getElementById("editor_id").focus();
	//document.getElementById("submitpost").disabled=true;
//	document.getElementById("rybut").disabled=false;
//	document.getElementById("rybut").onclick=function(){addreply(pid,user,fid);}
	/*var pid=x.id;
	
	var divrep=document.createElement("div");
	divrep.id="divrep";
	
	divrep.style="background-color:#f2f2f2;border:1px solid gray;padding:7px;width:750px;height:110px;align:center";
	var ta=document.createElement("textarea");
	ta.id="replyid";
	ta.cols="90";
	ta.rows="4";
	ta.value="please type in here to posta reply";
	ta.style="border-color:transparent";
	ta.style="background-color:#f2f2f2";
	var but1=document.createElement("button");
	but1.innerHTML="post to reply";
	but1.width="10";
	but1.height="2";
	but1.onclick=function(){addreply(pid,ta,user,fid);}
	
	divrep.appendChild(ta);
	divrep.appendChild(document.createElement("br"));
	divrep.appendChild(but1);
	divrep.style="align:center";
	document.body.appendChild(divrep);
	document.getElementById("replyid").focus();*/
	
	
	}
	
	
	function addreply(pid,user,fid)
	{
	
	var ta=document.getElementById("editor_id").value;
	var br=document.createElement("br");
	
     
     document.getElementById("postid").value=pid;
     document.getElementById("fid1").value=fid;
     document.getElementById("uname1").value=user;
     document.getElementById("uname2").value=user;
     document.getElementById("replycont").value=ta;

     document.getElementById("replyform").click();
    
	
	//-------------------------------------------------------------------------------
	}
</script>
</head>
<body background="images/blue-floral.jpg" onload="getposts()">
<meta property="fb:moderator" content="1072169092834252"/>
<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&appId=1072169092834252&version=v2.5";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>


<div align="center"><img src="images/forum-banner.jpg" align="middle"></img></div>


<br><br>
<form method="get" action="/replyservlet">
<input type="hidden" id="fid1" name="fid" value=""></input>
<input type="hidden" value="" id="replycont" name="replycont"></input>
<input type="hidden" value="" id="uname2" name="uname"></input>
<input type="hidden" value="" id="postid" name="postid"></input>
<button type="submit" style="display:none" id="replyform" value="submit"></button>
</form>

<input type="hidden" value="" id="imgtx"></input>


<form method="get" action="/openforumservlet" target="_self">

<input type="hidden" id="fid" name="fid" value=""></input>
<input type="hidden" id="uname1" name="uname" value=""></input>

<div id="maincontainer">

<h2>Add your message here</h2>

<textarea id="editor_id" name="tcont" cols="135" rows="15"></textarea><br>
<input type="submit" value="post" id="submitpost"></input>
<!--  <input type="button" style="display:none" value="reply" id="rybut"></input>-->
 


</div>

</form>

<hr/>
<br>
</body>
</html>