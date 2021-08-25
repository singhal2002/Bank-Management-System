import java.io.*;

import java.net.*;

import javax.servlet.http.*;



import javax.servlet.*;
import java.sql.*;
import java.util.*;

public class sendsms extends HttpServlet
{
public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException
{  
   StringBuffer response_http=new StringBuffer();
   try{
       String destination_phoneno=request.getParameter("destination_phoneno");
       String msg="Dear parent, today your ward is absent.WEB ERP";
       StringBuffer url=new StringBuffer(256);
       /* #################Sending SMS #########*/
       url.append("http://bulksms.arsalsoftware.com/bulksms/bulksms?username=arsa-teaching&password=teaching&source=ERPWEB&tempid=1207161511599933506");
       url.append("&entityid=1601772161468146020");
       url.append("&destination=").append(destination_phoneno).append("&dlr=1&type=0&message=").append(URLEncoder.encode(msg.toString(),"UTF-8"));
       System.out.println(url.toString());
       URL obj=new URL(url.toString());
       HttpURLConnection  connect=(HttpURLConnection)obj.openConnection();
       connect.setRequestMethod("GET");
       //int responseCode=connect.getResponseCode();
       response_http.append("<br><br>SMS Gateway Code:");
       BufferedReader in=new BufferedReader(new InputStreamReader(connect.getInputStream()));
       String inputLine="";
       while((inputLine=in.readLine())!=null)
       {
           response_http.append(inputLine);
       }
       in.close();
       obj=null;
       connect=null;
       

   } 
   catch(Exception e)
   {
       response_http.append("<br><br>Error At code-1").append(e.toString());
   }

   try {
       /* ##############Check Balance  ######## */
       StringBuffer url=new StringBuffer(256);
       url.append("http://bulksms.arsalsoftware.com/CreditCheck/checkcredits?username=arsa-teaching&password=teaching");
       
       URL obj=new URL(url.toString());
       HttpURLConnection  connect=(HttpURLConnection)obj.openConnection();
       connect.setRequestMethod("GET");
       //int responseCode=connect.getResponseCode();
       response_http.append("<br><br>SMS Balance");
       BufferedReader in=new BufferedReader(new InputStreamReader(connect.getInputStream()));
       String inputLine="";
       while((inputLine=in.readLine())!=null)
       {
           response_http.append(inputLine);
       }
       in.close();
       obj=null;
       connect=null;
   } catch (Exception e) {
       //TODO: handle exception
       response_http.append("<br><br>Error At code-2").append(e.toString());

   }
   response.setContentType("text/html");
   response.setHeader("Cache-control","no-cache,no-store");
   response.setHeader("Pragma","no-cache");
   response.setDateHeader("Expires",0);
   response.getWriter().write(response_http.toString());
   response.getWriter().flush();
   

}
}