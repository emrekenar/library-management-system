<%--
  Created by IntelliJ IDEA.
  User: emrekenar
  Date: 11.01.2021
  Time: 21:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Book Information</title>
    <Style>
        table, th, td { border: 1px solid black; }
    </Style>
</head>
<body>
<p>Book list:</p>
    <table>
        <tr>
            <th>Book ID</th>
            <th>ISBN</th>
            <th>Title</th>
            <th>Author</th>
            <th>Topic</th>
            <th>Genre</th>
            <th>Language</th>
            <th>Publication Year</th>
            <th>Publisher Name</th>
            <th>Status</th>
        </tr>
        <%
            String[][] books = (String[][])session.getAttribute("bookData");
            for (String[] book : books)
            {
        %>
        <tr>
            <%
                for (String data : book)
                {
            %>
            <td><%=data%></td>
            <%
                }
            }
            %>
        </tr>
    </table>
    <br>
    <p><a href="/publisher_ui">Back</a></p>
</body>
</html>
