package com.feather.dao;

import com.feather.config.dbConfig;
import com.feather.model.Menu;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MenuDAO {

    public List<Menu> getAllMenuItems() {

        List<Menu> list = new ArrayList<>();

        try {

            Connection conn =
                    new dbConfig().getConnection();

            String sql = "SELECT * FROM menu";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {

                Menu m = new Menu();

                m.setId(rs.getInt("id"));
                m.setName(rs.getString("name"));
                m.setDescription(rs.getString("description"));
                m.setPrice(rs.getDouble("price"));
                m.setImage(rs.getString("image"));
                m.setCategory(rs.getString("category"));

                list.add(m);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}