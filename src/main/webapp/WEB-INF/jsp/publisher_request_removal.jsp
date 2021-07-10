<%--
  Created by IntelliJ IDEA.
  User: emrekenar
  Date: 14.01.2021
  Time: 17:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Request Removal</title>
    <Style>
        table, th, td { border: 1px solid black; }
    </Style>
</head>
<body>
<p>Select the book you want to have removed</p>
<form method="post">
    <table>
        <tr>
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
                    if (data == book[0]) continue;
            %>
            <td><%=data%></td>
            <%
                }

            %>
            <td><a href="<%="/removal_requested?b="+book[0]%>">Request Removal</a>
        <%
            }
        %>
        </tr>
    </table>
    <p><a href="/publisher_ui">Back</a></p>
</form>
</body>
</html>
