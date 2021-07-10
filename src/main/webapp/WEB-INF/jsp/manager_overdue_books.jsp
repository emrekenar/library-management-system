<%--
  Created by IntelliJ IDEA.
  User: emrekenar
  Date: 16.01.2021
  Time: 00:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Overdue Books</title>
    <Style>
        table, th, td { border: 1px solid black; }
    </Style>
</head>
<body>
    <p>List of overdue books:</p>
    <table>
        <tr>
            <th>User ID</th>
            <th>Username</th>
            <th>Book ID</th>
            <th>ISBN</th>
            <th>Title</th>
            <th>Author</th>
            <th>Status</th>
            <th>Return Date</th>
            <th>Overdue</th>
            <th>Is Paid</th>
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
                if (book[9].charAt(0)=='P' || book[7]==null) {
            %>
                <td></td>
            <%
                } else {
            %>
                <td><a href=<%="payment_accepted?u="+book[0]+"&b="+book[2]%>>Accept Payment</a></td>
            <%
                }
            }
            %>
        </tr>
        <tr>
            <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
            <td>Total Unpaid</td>
            <%
                int total_penalty = 0;
                for (String[] book : books)
                    if (book[9].charAt(0)=='N')
                        total_penalty += Integer.parseInt(book[8]);
            %>
            <td><%=total_penalty%></td>
        </tr>
    </table>
    <p><a href="/manager_ui">Back</a></p>
</body>
</html>
