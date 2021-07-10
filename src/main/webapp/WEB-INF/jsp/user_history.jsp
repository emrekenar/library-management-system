<%--
  Created by IntelliJ IDEA.
  User: emrekenar
  Date: 10.01.2021
  Time: 14:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>My Borrow History</title>
    <Style>
        table, th, td { border: 1px solid black; }
    </Style>
</head>
<body>
<p>Borrow history:</p>
    <table>
        <tr>
            <th>ISBN</th>
            <th>Title</th>
            <th>Author</th>
            <th>Borrow Date</th>
            <th>Return Date</th>
            <th>Penalty</th>
            <th>Is Paid</th>
        </tr>
        <%
            String[][] borrowHistory = (String[][])session.getAttribute("userBorrowData");
            for (String[] record : borrowHistory)
            {
        %>
        <tr>
            <%
                for (String data : record)
                {
                    if (data==record[0]) continue;
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
        <tr>
            <td></td><td></td><td></td><td></td>
            <td>Total Unpaid</td>
            <%
                int total_penalty = 0;
                for (String[] record : borrowHistory)
                    if (record[7].charAt(0)=='N')
                        total_penalty += Integer.parseInt(record[6]);
            %>
            <td><%=total_penalty%></td>
        </tr>
    </table>
    <p><a href="/user_ui">Back</a></p>
</body>
</html>
