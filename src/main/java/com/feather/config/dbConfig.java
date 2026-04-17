package com.feather.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class dbConfig {

    private String dbName = "feather";
    private String url = "jdbc:mysql://127.0.0.1:3306/" + dbName;
    private String username = "root";
    private String password = "";

    public Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return DriverManager.getConnection(url, username, password);
    }
}