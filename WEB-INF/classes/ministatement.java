import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

public class ministatement extends HttpServlet
{
public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
{
try
{
StringBuffer datatosend=new StringBuffer(1024);
datatosend.append("<?xml version=\"1.0\"?>");
datatosend.append("<data>");

String accountno_to_search=request.getParameter("accountno_to_search");
System.out.println(accountno_to_search);

Connection con=null;
Statement st=null;
ResultSet rt=null;

Class.forName("com.mysql.jdbc.Driver");
con=DriverManager.getConnection("jdbc:mysql://localhost:3306/bank","root","root");
st=con.createStatement();

rt=st.executeQuery("select name,balance from account where accountno="+accountno_to_search);
while(rt.next())
{
datatosend.append("<member>");
datatosend.append("<name>").append(rt.getString("name")).append("</name>");
datatosend.append("<balance>").append(rt.getInt("balance")).append("</balance>");
datatosend.append("<accno>").append(accountno_to_search).append("</accno>");
datatosend.append("</member>");
}
rt.close();

String query="select date,time,deposit,withdraw,remark from transaction where accountno="+accountno_to_search+" order by date,time";
rt=st.executeQuery(query);
while(rt.next())
{
    datatosend.append("<transaction>");
datatosend.append("<date>").append(rt.getString("date")).append("</date>");
datatosend.append("<time>").append(rt.getString("time")).append("</time>");
datatosend.append("<deposit>").append(rt.getInt("deposit")).append("</deposit>");
datatosend.append("<withdraw>").append(rt.getInt("withdraw")).append("</withdraw>");
datatosend.append("<remark>").append(rt.getString("remark")).append("</remark>");

datatosend.append("</transaction>");
}
rt.close();
st.close();
con.close();
datatosend.append("</data>");

response.setContentType("text/xml");
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);

response.getWriter().write(datatosend.toString());
response.getWriter().flush();

/*
PrintWriter out=response.getWriter();
out.write(datatosend.toString());
*/

datatosend=null;
}
catch(Exception e)
{
System.out.println(e);
}
}
}























