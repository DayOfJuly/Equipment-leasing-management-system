<jsp:directive.tag language="java" pageEncoding="UTF-8"/>  
 <%@ attribute name="path"%>  
 <%@ attribute name="name" required="true"  %>  
 <%
     String[] names	=	name.split(",");
 
    for(int i=0;i<names.length;i++){
    	String name=names[i];
     	String fullName=null;
     	if(path!=null)
     		fullName	=	path+"/"+name+".js";
     	else
     		fullName=name+".js";
     	
    	out.print("<script type=\"text/javascript\" src=\"");
    	out.print(fullName);
      	out.println("\"></script>");
      }
   %>
  