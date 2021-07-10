<%--
  Created by IntelliJ IDEA.
  User: emrekenar
  Date: 10.01.2021
  Time: 14:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Borrow History</title>
    <Style>
        table, th, td { border: 1px solid black; }
    </Style>
</head>
<body>
    <p>Borrow history:</p>
    <table>
        <tr>
            <th>Borrow ID</th>
            <th>User ID</th>
            <th>Username</th>
            <th>Book ID</th>
            <th>Title</th>
            <th>Author</th>
            <th>Borrow Date</th>
            <th>Return Date</th>
            <th>Penalty</th>
        </tr>
        <%
            String[][] borrowHistory = (String[][])session.getAttribute("borrowData");
            for (String[] record : borrowHistory)
            {
        %>
        <tr>
            <%
                for (String data : record)
                {
                    if (data == null) {
            %>
                        <td><a href=<%="/return?w="+record[0]+"&b="+record[3]%>>Return</a></td>
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
    <p><a href="/manager_ui">Back</a></p>
</body>
</html>
