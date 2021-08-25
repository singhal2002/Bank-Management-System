import java.io.*;


import javax.servlet.http.*;
import javax.servlet.*;
import java.sql.*;
import java.util.*;
import javax.activation.*;
import javax.mail.*;
import javax.mail.internet.*;

public class emailid extends HttpServlet
{
public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException
{
  try {
      final String sourceEmail="uditsinghal455@gmail.com";      //requires valid source gmail id
      final String password="ch123@123";   //your email id password
      String destination_emailid=request.getParameter("emailid");
      String msg=request.getParameter("message");
      String subject="try email demo";
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
      message.setRecipients(Message.RecipientType.TO,InternetAddress.parse(destination_emailid));
      message.setSubject(subject);
      message.setContent(msg,"text/html;charset=utf-8");
      Transport.send(message);
      response.getWriter().print("<br>Mail Successfully sent");
  } catch (Exception e) {
      //TODO: handle exception
      e.printStackTrace();
      System.out.println(e);
  }
}
}