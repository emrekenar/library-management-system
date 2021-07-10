<%--
  Created by IntelliJ IDEA.
  User: emrekenar
  Date: 11.01.2021
  Time: 22:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Publisher Borrow Statistics</title>
    <Style>
        table, th, td { border: 1px solid black; }
    </Style>
</head>
<body>
<p>Statistics:</p>
    <table>
        <tr>
            <th>Book ID</th>
            <th>ISBN</th>
            <th>Title</th>
            <th>Author</th>
            <th>Count Borrowed</th>
        </tr>
        <%
            String[][] borrowHistory = (String[][])session.getAttribute("publisherCountData");
            for (String[] record : borrowHistory)
            {
        %>
                <tr>
                <%
                    for (String data : record)
                    {
                %>
                        <td><%=data%></td>
                <%
                    }
                %>
                </tr>
        <%
            }
        %>
        <tr>
            <td></td><td></td><td></td>
            <td>Total</td>
            <%
                int countTotal = 0;
                for (String[] record : borrowHistory)
                    countTotal += Integer.parseInt(record[4]);
            %>
            <td><%=countTotal%></td>
        </tr>
    </table>
    <p><a href="/publisher_ui">Back</a></p>
</body>
</html>
