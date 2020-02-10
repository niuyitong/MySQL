import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class Test {
    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://127.0.0.1:3306/2020_0210?useSSL=false&characterEncoding=utf8";
        String user = "root"; // 连接 mysql 的用户名
        String password = ""; // 连接 mysql 的密码
        Connection connection = DriverManager.getConnection(
                url, user, password
        );
        {
            Statement statement = connection.createStatement();
            String sql = "insert into emp(name, role, salary) values ('马云','服务员', 1000.20), ('马化腾','游戏陪玩', 2000.99), ('孙悟空','游戏角色', 999.11), ('猪无能','游戏角色', 333.5), ('沙和尚','游戏角色', 700.33), ('隔壁老王','董事长', 12000.66)";
            statement.executeUpdate(sql); // 通过 statement 对象来执行 SQL 语句
            statement.close();
        }
    }
}
