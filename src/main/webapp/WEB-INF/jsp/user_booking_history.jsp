<%--
  Created by IntelliJ IDEA.
  User: emrekenar
  Date: 12.01.2021
  Time: 00:05
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
<p>List of my bookings:</p>
<table>
    <tr>
        <th>ISBN</th>
        <th>Title</th>
        <th>Author</th>
        <th>Status</th>
        <th>Operation</th>
    </tr>
    <%
        String[][] borrowHistory = (String[][])session.getAttribute("userBookingData");
        for (String[] record : borrowHistory)
        {
    %>
    <tr>
        <%
            for (String data : record)
            {
                if (data.equals(record[0]))
                    continue;
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
        <td><a href=<%="/booking_canceled?b="+record[0]%>>Cancel</a></td>
    </tr>
    <%
        }
    %>
</table>
<p><a href="/user_ui">Back</a></p>
</body>
</html>
