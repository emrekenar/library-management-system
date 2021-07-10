<%--
  Created by IntelliJ IDEA.
  User: emrekenar
  Date: 12.01.2021
  Time: 01:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Reservations</title>
    <Style>
        table, td, th { border: 1px solid black }
    </Style>
</head>
<body>
    <p>List of active reservations</p>
    <table>
        <tr>
            <th>User Id</th>
            <th>Username</th>
            <th>Book Id</th>
            <th>ISBN</th>
            <th>Title</th>
            <th>Author</th>
            <th>Operation</th>
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
                <td><a href=<%="lend?u="+record[0]+"&b="+record[2]%>>Lend Book</a></td>
        </tr>
        <%
            }
        %>
    </table>
    <p><a href="/manager_ui">Back</a></p>
</body>
</html>
