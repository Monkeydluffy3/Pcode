import java.net.*;
import java.util.*;
class Addr
{
   public static void main(String args[])
   {
      String ip;
      System.out.println("Enter url or ip address : ");
      Scanner sc = new Scanner(System.in);
      ip = sc.next(); 
         
      try
      {
         InetAddress in=InetAddress.getByName(ip);
         if(ip.charAt(0) >='0' && ip.charAt(0) <='9')
            System.out.println("The url of given ip Address is:"+in.getHostName());
         else
            System.out.println("The ip Address of site is:"+in.getHostAddress());
      
      }
      catch(Exception e)
      {
         System.out.println("Some Exception has occurred with details"+e.getMessage());
      }
   }
}
