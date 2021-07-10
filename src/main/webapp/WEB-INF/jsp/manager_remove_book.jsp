<%--
  Created by IntelliJ IDEA.
  User: emrekenar
  Date: 14.01.2021
  Time: 16:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Remove a Book</title>
    <Style>
        table, th, td { border: 1px solid black; }
    </Style>
</head>
<body>
<p>Select the book you want to remove</p>
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
            <th>Operation</th>
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

            %>
            <td><a href="<%="/removal_approved?b="+book[0]%>">Remove</a>
            <%
                }
            %>
        </tr>
    </table>
<p><a href="/manager_ui">Back</a></p>
</body>
</html>
