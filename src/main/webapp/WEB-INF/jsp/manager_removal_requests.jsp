<%--
  Created by IntelliJ IDEA.
  User: emrekenar
  Date: 15.01.2021
  Time: 13:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Removal Requests</title>
    <Style>
        table, th, td { border: 1px solid black; }
    </Style>
</head>
<body>
<p>List of removal requests:</p>
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
            String[][] books = (String[][])session.getAttribute("removals");
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
            <td><a href="<%="/removal_approved?b="+book[0]%>">Approve</a>
        <%
            }
        %>
        </tr>
    </table>
    <p><a href="/manager_ui">Back</a></p>
</body>
</html>
