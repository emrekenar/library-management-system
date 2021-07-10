<%--
  Created by IntelliJ IDEA.
  User: emrekenar
  Date: 16.01.2021
  Time: 23:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Booking History</title>
    <Style>
        table, td, th { border: 1px solid black }
    </Style>
</head>
<body>
    <p>List of booking records:</p>
    <table>
        <tr>
            <th>User Id</th>
            <th>Username</th>
            <th>Book Id</th>
            <th>ISBN</th>
            <th>Title</th>
            <th>Author</th>
            <th>Status</th>
        </tr>
        <%
            String[][] reservations = (String[][])session.getAttribute("reservations");
            for (String[] record : reservations)
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
    <p><a href="/manager_ui">Back</a></p>
</body>
</html>
