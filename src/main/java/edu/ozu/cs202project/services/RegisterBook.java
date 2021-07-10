package edu.ozu.cs202project.services;

import edu.ozu.cs202project.Salter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.sql.Statement;
import java.util.List;
import java.util.Map;

@Service
public class RegisterBook
{
    @Autowired
    JdbcTemplate conn;

    public boolean validate(String isbn, String title, String author, String topic,
                            String genre, int publisher_id, int p_year, String language)
    {
        List<Map<String, Object>> response = conn.queryForList(
                "SELECT isbn FROM book WHERE isbn = ?", new Object[]{ isbn }
        );

        // if publisher does not exist, return false
        List<Map<String, Object>> response2 = conn.queryForList(
                "SELECT id FROM user WHERE user_type='p' and id = ?", new Object[]{ publisher_id }
        );
        if (response2.size() == 0)
            return false;

        if (response.size() == 0)
            conn.execute("insert into book (isbn, title, " +
                    "author, topic, genre, publisher_id, p_year, language) " +
                    "values ('"+isbn+"','"+title+"','"+author+"','"+topic+"','"+
                    genre+"',"+publisher_id+","+p_year+",'"+language+"')");

        return response.size() == 0;
    }
}
