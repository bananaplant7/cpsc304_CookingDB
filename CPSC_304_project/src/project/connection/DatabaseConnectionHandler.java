package project.connection;

import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

// CREDIT: constructor, login, close and rollback functions based off of sample project
public class DatabaseConnectionHandler {
    // other option: ORACLE_URL = "jdbc:oracle:thin:@dbhost.students.cs.ubc.ca:1522:stu"
    private static final String ORACLE_URL = "jdbc:oracle:thin:@localhost:1522:stu";

    private Connection connection = null;

    public DatabaseConnectionHandler() {
        try {
            // Load the Oracle JDBC driver
            // Note that the path could change for new drivers
            DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public void close() {
        try {
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public boolean login(String username, String password) {
        try {
            if (connection != null) {
                connection.close();
            }

            connection = DriverManager.getConnection(ORACLE_URL, username, password);
            connection.setAutoCommit(false);

            System.out.println("\nConnected to Oracle!");
            return true;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return false;
        }
    }

    private void rollbackConnection() {
        try  {
            connection.rollback();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    // parsing input from setup.sql - to check whether this is working correctly
    public void databaseSetup() {
        String sqlFilePath = "CPSC_304_project/src/project/scripts/setup.sql";

        try (Statement stmt = connection.createStatement()) {
            // Read SQL file
            BufferedReader reader = new BufferedReader(new FileReader(sqlFilePath));
            StringBuilder stringBuilder = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.trim().startsWith("--") && !line.trim().isEmpty()) {
                    stringBuilder.append(line);
//                    stringBuilder.append("\n");
                }
            }
            reader.close();

            // Split SQL statements by semicolon
            String[] sqlStatements = stringBuilder.toString().split(";");

            // Execute each SQL statement
            for (String sql : sqlStatements) {
                try {
                    stmt.execute(sql);
                } catch (SQLException e) {
                    if (e.getMessage().contains("table or view does not exist")) {
                        // ignore the issue, just means not populated to begin
                        System.out.println("drop table issue: " + e.getMessage());
                    } else {
                        System.out.println("other SQL issue: " + e.getMessage());
                    }
                }
            }
            System.out.println("SQL file executed successfully.");
        } catch (SQLException e) {
            System.out.println("SQL exception: " + e.getMessage());
        } catch (Exception e) {
            System.out.println("other exception: " + e.getMessage());
        }
    }
}
