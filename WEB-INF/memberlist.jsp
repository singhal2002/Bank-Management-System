<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>

<%
Calendar cal=new GregorianCalendar();
int day=cal.get(Calendar.DATE);
int month=cal.get(Calendar.MONTH)+1;
int year=cal.get(Calendar.YEAR);
String date=day+"-"+month+"-"+year;
String loginid=request.getParameter("loginid");
%>

<html>
<body>
<table width="100%">
    <tr><td align="left">Welcome <%=date%></td></tr>

</table>
<br><br>
<table border="1" align="center" cellpadding="4" cellspacing="4">
    <tr align="center" valign="top">
        <td>Account No.</td>
        <td>Name</td>
        <td>Gender</td>
        <td>D.O.B</td>
        <td>Phone No.</td>
        <td>Address</td>
        <td>Qualification</td>
        <td>Balance</td>
        <td>Status</td>
        <td>Profile Photo</td>
    </tr>
    <%
    try
    {
        Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/bank","root","root");
Statement st=con.createStatement();

ResultSet rt=st.executeQuery("select accountno,name,gender,dob,phoneno,address,qualifications,balance,active,image_ref from account order by accountno");

while(rt.next())
{ String temp_active="active";
    if(rt.getInt("active")==0)
     temp_active="Deleted";

  
    %>
    
    <tr>
        <td><%=rt.getString("accountno")%> </td>
        <td><%=rt.getString("name")%> </td>
        <td><%=rt.getString("gender")%> </td>
        <td><%=rt.getString("dob")%> </td>
        <td><%=rt.getString("phoneno")%> </td>
        <td><%=rt.getString("address")%> </td>
        <td><%=rt.getString("qualifications")%> </td>
        <td><%=rt.getString("balance")%> </td>
        
        <td><%=temp_active%> </td>

        <td><img src=<%=rt.getString("image_ref")%> style="width:100px;height:100px;"> </td>         
    </tr>
    <%
} //while
rt.close();
st.close();
con.close();
        
    }
    catch(Exception e)
    {
        out.print(e);
    }
    %>
</table>

</body>
</html>
