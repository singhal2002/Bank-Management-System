import java.io.*;
import javax.servlet.http.*;
import javax.servlet.*;
import java.sql.*;
import java.util.*;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.*;

public class uploadphoto extends HttpServlet
{
    public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException
    { 
    
        String accountno="";    String db_image_path="";
        String image_ref="";
        FileItemFactory factory=new DiskFileItemFactory();
        ServletFileUpload upload=new ServletFileUpload(factory);
        List items=null;

        Iterator itr=null;
        try {   Class.forName("com.mysql.jdbc.Driver");  
        Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/bank","root","root"); 
        Statement st=con.createStatement(); 
        PreparedStatement ps;
        ResultSet rt=null;
            items=upload.parseRequest(request);
            itr=items.iterator();

            while(itr.hasNext())
            {
                FileItem item=(FileItem) itr.next();
                if(item.isFormField())//html form elements
                {
                    String name=item.getFieldName();
                    String value=item.getString();
                    if(name.equals("accountno"))
                    {
                        accountno=value;
                    }
                    



                } 
                else{
                    rt=st.executeQuery("select accountno from account ");
                    String i="";
                    while(rt.next())
                      {  i=Integer.toString(rt.getInt("accountno"));
                          if(accountno.equals(i))
                           {
                             String itemName=item.getName();
                             String absolutePathToIndexJSP = request.getServletContext().getRealPath("/");
				//System.out.println( absolutePathToIndexJSP ); f:/adob/webapps/schoolx/
				//String imgpath = absolutePathToIndexJSP+"img\\"+code+"\\online_exam\\"+folder;
image_ref=absolutePathToIndexJSP+"\\img\\"+accountno+".jpg";
 db_image_path="img\\"+accountno+".jpg";
                   

                    File savedFile=new File(image_ref);
                    item.write(savedFile);
                         }
else{

}
       
}
                    

                }
            }
            ps=con.prepareStatement("update account set image_ref=? where accountno="+accountno);
            ps.setString(1,db_image_path);
            ps.executeUpdate();
            ps.close();
            rt.close();



st.close();
con.close();
            response.getWriter().print("Successfully Saved");
        } catch (Exception e) {
            //TODO: handle exception
            System.out.println(e);
        }
    }
}
