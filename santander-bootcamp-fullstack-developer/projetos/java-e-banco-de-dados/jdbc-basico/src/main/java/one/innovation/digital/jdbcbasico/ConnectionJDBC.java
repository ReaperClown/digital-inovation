package one.innovation.digital.jdbcbasico;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionJDBC {
    public static void main(String[] args) throws SQLException {

        String urlConnection = "jdbc:mysql://localhost/digital_innovation_one";

        try (Connection conn = DriverManager.getConnection(urlConnection, "root", "rootsql")) {
            System.out.println("SUCESSO!");
        } catch (Exception e) {
            System.out.println("FALHA!");
            e.printStackTrace();
        }
    }
}