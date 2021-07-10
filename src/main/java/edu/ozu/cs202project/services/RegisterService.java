package edu.ozu.cs202project.services;

import edu.ozu.cs202project.Salter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.sql.Statement;
import java.util.List;
import java.util.Map;

@Service
public class RegisterService
{
    @Autowired
    JdbcTemplate conn;

    public boolean validate(String username, String password, String name, char type)
    {
        List<Map<String, Object>> response = conn.queryForList(
                "SELECT * FROM user WHERE username = ?", new Object[]{ username }
        );

        if (response.size() == 0)
            conn.execute("insert into user (username, password, name, user_type) " +
                    "values ('"+username+"','"+Salter.salt(password, "Group13x")+
                    "','"+name+"','"+type+"')");

        return response.size() == 0;
    }
}
