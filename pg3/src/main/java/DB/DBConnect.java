package DB;
import java.sql.*;
public class DBConnect{
 public static Connection getConnection() throws Exception {
	 Connection conn = null;
	 
	 String url = "jdbc:oracle:thin:@//localhost:1521/xe";
	 String user = "system";
	 String pw = "1234";
	
	 Class.forName("oracle.jdbc.OracleDriver");
 		conn = DriverManager.getConnection(url,user,pw);
 		return conn;
 }
}
