import com.mysql.jdbc.jdbc2.optional.MysqlDataSource;

import javax.sql.DataSource;
import java.sql.*;
import java.util.Scanner;

public class Main {

    private static int globalUserId = -1;
    private static String globalUsername = null;

    // 库名称修改了，其他位置保持不变
    private static final String url = "jdbc:mysql://127.0.0.1:3306/2020_0211?useSSL=false&characterEncoding=utf8";
    private static final String mysqlUsername = "root";
    private static final String mysqlPassword = "";

    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.jdbc.Driver");
        Scanner scanner = new Scanner(System.in);
        while (true) {
            menu();

            int select = scanner.nextInt();
            scanner.nextLine(); // 把换行读走

            switch (select) {
                case 1:
                    register();
                    break;
                case 2:
                    login();
                    break;
                case 3:
                    publish();
                    break;
            }
        }
    }

    private static void publish() throws SQLException {
        if (globalUserId == -1) {
            System.out.println("请先登录");
            return;
        }
        // 需要用户名输入标题 + 正文
        Scanner scanner = new Scanner(System.in);
        String title = scanner.nextLine();
        String content = scanner.nextLine();


        MysqlDataSource mysqlDataSource = new MysqlDataSource();
        mysqlDataSource.setServerName("127.0.0.1");
        mysqlDataSource.setPort(3306);
        mysqlDataSource.setUser("root");
        mysqlDataSource.setPassword("");
        mysqlDataSource.setDatabaseName("2020_0211");
        mysqlDataSource.setUseSSL(false);
        mysqlDataSource.setCharacterEncoding("utf8");
        DataSource dataSource = mysqlDataSource;
        try(Connection con = dataSource.getConnection()){
            String sql = "Insert Into articles (author_id,title,content) Values(?,?,?)";
            try(PreparedStatement statement = con.prepareStatement(sql)){
                statement.setInt(1,globalUserId);
                statement.setString(2,title);
                statement.setString(3,content);
                statement.executeUpdate();//因为插入了信息，所以需要更新
                System.out.println("published success");
            }
        }
    }

    private static void login() throws SQLException {
        // 需要用户名输入用户名 + 密码
        Scanner scanner = new Scanner(System.in);
        String username = scanner.nextLine();
        String password = scanner.nextLine();

        //获取连接的方式2（DataSource）
        MysqlDataSource mysqlDataSource = new MysqlDataSource();
        mysqlDataSource.setServerName("127.0.0.1");
        mysqlDataSource.setPort(3306);
        mysqlDataSource.setUser("root");
        mysqlDataSource.setPassword("");
        mysqlDataSource.setDatabaseName("2020_0211");
        mysqlDataSource.setUseSSL(false);
        mysqlDataSource.setCharacterEncoding("utf8");
        DataSource dataSource = mysqlDataSource;
        try(Connection con = dataSource.getConnection()){
            String sql = "SELECT id, username FROM users WHERE username = ? AND password = ?";
            try(PreparedStatement statement = con.prepareStatement(sql)){
                // 类似 ResultSet
                // 1. 各种各样的类型
                // 2. 下标从 1 开始
                statement.setString(1, username);
                statement.setString(2, password);
                // MySQL Driver 时打印 SQL 的小技巧
                // JDBC 规定中，PrepareStatement 是无法打印填充完占位符后的 SQL
                // PrepareStatement 的实现类 com.mysql.jdbc.PreparedStatement
                // 有个方法 asSql 干这个事情的
                // 利用向下转型完成
                com.mysql.jdbc.PreparedStatement mysqlStatement = (com.mysql.jdbc.PreparedStatement) statement;
                System.out.println(mysqlStatement.asSql());

                try (ResultSet resultSet = statement.executeQuery()) {
                    if (!resultSet.next()) {
                        System.out.println("登录失败");
                    } else {
                        int id = resultSet.getInt("id");
                        String usernameInTable = resultSet.getString("username");
                        globalUserId = id;
                        globalUsername = usernameInTable;
                        System.out.println("登录成功: " + id + ", " + usernameInTable);
                    }
                }
            }
        }

    }

    private static void register() throws SQLException {
        // 需要用户名输入用户名 + 密码
        Scanner scanner = new Scanner(System.in);
        String username = scanner.nextLine();
        String password = scanner.nextLine();
        //获取连接的方式1（DriverManager.getConnection();）
        /*
        Connection con = DriverManager.getConnection(url,mysqlUsername,mysqlPassword);
        Statement statement = con.createStatement();
        String sql = String.format(
                "INSERT INTO users (username, password) VALUES ('%s', '%s')",
                username, password
        );
        statement.executeUpdate(sql);
        statement.close();
        con.close();
        */

        //获取连接的方式1（优化版）引入了 try-with-resource 的用法
        try(Connection con = DriverManager.getConnection(url, mysqlUsername, mysqlPassword)){
            try(Statement statement = con.createStatement()){
                String sql = String.format(
                        "INSERT INTO users (username, password) VALUES ('%s', '%s')",
                        username, password
                );
                statement.executeUpdate(sql);
            }
        }
        System.out.println("用户注册成功");
    }

    private static void menu() {
        System.out.println("=====================");
        System.out.println("1. 用户注册");
        System.out.println("2. 用户登录");
        System.out.println("3. 发表文章");
        System.out.println("4. 文章列表页");
        System.out.println("5. 文章详情页");
        System.out.println("=====================");
    }
}
