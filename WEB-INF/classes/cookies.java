import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import javax.sql.DataSource;
import javax.naming.*;

public class cookies extends HttpServlet
{
public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
{
     PrintWriter out=response.getWriter();
     boolean newuser=true;
     String cookievalue=null;
     String msg=null;
     Cookie cookies[]=request.getCookies();
     if(cookies!=null)
     {
         for(int loop=0;loop<cookies.length;loop++)
         {  String cookiename=cookies[loop].getName();
             cookievalue=cookies[loop].getValue();

             if(cookiename.equals("cookiename"))
             newuser=false;
         }
     }
     if(newuser==true)
     {
         Cookie c=new Cookie("cookiename","12345");
         c.setMaxAge(60*60*24);
         response.addCookie(c);
         msg="Welcome To New User";
     }
     else{
         msg="Welcome To our Previous User. You Have Cookie data"+cookievalue;
     }
     out.println("<html><body><table><tr><td>");
     out.println(msg);
     out.println("</td></tr></table</body></html>");
}
}
























