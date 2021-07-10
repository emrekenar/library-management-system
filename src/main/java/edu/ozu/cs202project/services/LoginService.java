package edu.ozu.cs202project.services;

import edu.ozu.cs202project.Salter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.sql.Statement;
import java.util.List;
import java.util.Map;

@Service
public class LoginService
{
    @Autowired
    JdbcTemplate conn;

    public boolean validate(String username, String password)
    {
        List<Map<String, Object>> response = conn.queryForList(
                "SELECT * FROM user WHERE username = ? AND password = ?",
                new Object[]{ username, Salter.salt(password, "Group13x") } );

        if (response.size() == 1)
        {
            conn.execute("update user set status = 'i' where username = '"+username+"'");
        }

        return response.size() == 1;
    }
}
