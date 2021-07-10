<%--
  Created by IntelliJ IDEA.
  User: emrekenar
  Date: 10.01.2021
  Time: 12:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Book Information</title>
    <Style>
        table, th, td { border: 1px solid black; }
    </Style>
</head>
<body>
<p>List of the books:</p>
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
            String[][] bookings = (String[][])session.getAttribute("borrowData");
            String[][] borrowings = (String[][])session.getAttribute("userBorrowData");

            for (String[] book : books)
            {
        %>
        <tr>
        <%
                for (String data : book)
                {
                    if (data.equals(book[0]))
                        continue;
        %>
                    <td><%=data%></td>
        <%
                }
                boolean used = false;
                for (String[] record : bookings)
                    if (record[0].equals((String)session.getAttribute("username")) && record[1].equals(book[0]))
                        used = true;
                for (String[] record : borrowings)
                    if (record[0].equals((String)session.getAttribute("username")) && record[1].equals(book[0]))
                        used = true;
                if (used) { // if the user borrowed, reserved or put a hold request on the book
        %>
                    <td></td>
        <%
                } else if (book[9].charAt(0)=='A') {
        %>
                    <td><a href=<%="/reserve?b="+book[0]%>>Reserve</a>
        <%
                } else {
        %>
                    <td><a href=<%="/hold_request?b="+book[0]%>>Hold Request</a>
        <%
                }
            }
        %>
                </tr>
    </table>
    <p><a href="/user_ui">Back</a></p>
</body>
</html>
