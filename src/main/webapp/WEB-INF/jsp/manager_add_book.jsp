<%--
  Created by IntelliJ IDEA.
  User: emrekenar
  Date: 14.01.2021
  Time: 14:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Book</title>
    <Style>
        table, th, td { border: 1px solid black; }
    </Style>
</head>
<body>
    <p style="color: red" >${errorMessage}</p>
    <table>
        <tr>
            <th>Publisher ID</th>
            <th>Publisher Name</th>
        </tr>
        <%
            String[][] publisherList = (String[][])session.getAttribute("publisher_list");
            for (String[] record : publisherList)
            {
        %>
        <tr>
            <%
                for (String data : record)
                {
                    if (data == null) {
                        %>
                            <td></td>
                        <%
                    } else {
                        %>
                            <td><%=data%></td>
                        <%
                    }
                }
            %>
        </tr>
        <%
            }
        %>
    </table>
    <form method="post">
        <p>Add a book using a publisher in the above list</p>
        <p>Enter an ISBN : <input type="text" name="isbn" /></p>
        <p>Title : <input type="text" name="title" /></p>
        <p>Author : <input type="text" name="author"/></p>
        <p>Topic : <input type="text" name="topic" /></p>
        <p>Genre : <input type="text" name="genre" /></p>
        <p>Publisher Id : <input type="text" name="publisher_id_"/></p>
        <p>Publication Year : <input type="text" name="p_year_"/></p>
        <p>Book language : <input type="text" name="language"/></p>
        <input type="submit" value="Register Book" /><br>
    </form>
    <a href="/manager_ui">Back</a>
</body>
</html>