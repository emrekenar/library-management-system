package edu.ozu.cs202project.services;

import edu.ozu.cs202project.Salter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.sql.Statement;
import java.util.List;
import java.util.Map;

@Service
public class RequestBook
{
    @Autowired
    JdbcTemplate conn;

    public boolean validate(String isbn, String title, String author, String topic,
                            String genre, int p_year, String language, String publisher)
    {
        List<Map<String, Object>> response = conn.queryForList(
                "SELECT isbn FROM book WHERE isbn = ?", new Object[]{ isbn }
        );

        List<Integer> pub = conn.query("select id from user where username='"+publisher+"'",
                (row, index) -> {
                    return row.getInt("id");
                });

        if (response.size() == 0)
            conn.execute("insert into book (isbn, title, " +
                    "author, topic, genre, publisher_id, p_year, language, status) " +
                    "values ('"+isbn+"','"+title+"','"+author+"','"+topic+"','"+
                    genre+"',"+pub.get(0)+","+p_year+",'"+language+"','Requested')");

        return response.size() == 0;
    }
}
