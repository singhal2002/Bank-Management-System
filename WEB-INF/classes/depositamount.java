import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.*;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.*;
import javax.activation.*;
import javax.mail.*;
import javax.mail.internet.*;
import java.net.URL;
import java.net.URLEncoder;
import java.net.HttpURLConnection;
public class depositamount extends HttpServlet
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
st.close();
con.close();
datatosend.append("</data>");

response.setContentType("text/xml");
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);

response.getWriter().write(datatosend.toString());
//response.getWriter().flush();

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
public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
{
try{
String html_accno=request.getParameter("accno");
String html_remark=request.getParameter("remark");
String html_deposit_amount=request.getParameter("new_deposit_amount");
String balance="";
String emailid="";
Connection con=null;
Statement st=null;
ResultSet rt=null;

Class.forName("com.mysql.jdbc.Driver");
con=DriverManager.getConnection("jdbc:mysql://localhost:3306/bank","root","root");
st=con.createStatement();

StringBuffer query=new StringBuffer();
query.append("update account set balance=balance+").append(html_deposit_amount);
query.append(" where accountno=").append(html_accno);

st.executeUpdate(query.toString());

query.delete(0,query.length()); //to free up the previous memory
query.append("insert into transaction (accountno, date, time, deposit, withdraw, remark)");
query.append("values(").append(html_accno).append(",curdate(),curtime(),");
query.append(html_deposit_amount).append(",0,'").append(html_remark).append("')");

st.executeUpdate(query.toString());
response.setContentType("text/html");
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);

/////////////////////////////send email/////////////////////////
rt=st.executeQuery("select balance,emailid from account where accountno="+html_accno);
while(rt.next())
{
balance=rt.getString("balance");
emailid=rt.getString("emailid");
}
final String sourceEmail="uditsinghal455@gmail.com";      //requires valid source gmail id
final String password="ch123@123";   //your email id password

String msg="you have deposited "+html_deposit_amount+"amount into account number "+html_accno+"\n Now your current balance is:"+balance;
String subject="amount deposited";
// dont change below setup if your smtp server is gmail
Properties props=new Properties();
props.put("mail.smtp.host", "smtp.gmail.com");  //your smtp server
props.put("mail.smtp.port", "587");  //port no.
props.put("mail.smtp.auth", "true"); //authentication must be true
props.put("mail.smtp.starttls.enable", "true");

Authenticator authentication=new Authenticator()
{
    protected PasswordAuthentication getPasswordAuthentication()
    {
        return new PasswordAuthentication(sourceEmail,password);
    }
};
Session session=Session.getInstance(props,authentication);

Message message=new MimeMessage(session);
message.setFrom(new InternetAddress(sourceEmail));
message.setRecipients(Message.RecipientType.TO,InternetAddress.parse(emailid));
message.setSubject(subject);
message.setContent(msg,"text/html;charset=utf-8");
Transport.send(message);

response.getWriter().write("successfully executed");
//response.getWriter().flush();
}
catch(Exception e)
{
System.out.println(e);
}
}
}
























