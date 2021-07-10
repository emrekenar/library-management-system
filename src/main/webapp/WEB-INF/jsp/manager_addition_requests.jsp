<%--
  Created by IntelliJ IDEA.
  User: emrekenar
  Date: 14.01.2021
  Time: 18:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Addition Requests</title>
    <Style>
        table, td, th { border: 1px solid black }
    </Style>
</head>
<body>
    <p>List of active requests</p><br>
    <table>
        <tr>
            <th>ISBN</th>
            <th>Title</th>
            <th>Author</th>
            <th>Topic</th>
            <th>Genre</th>
            <th>Publisher</th>
            <th>Publication Year</th>
            <th>Language</th>
            <th>Operation</th>
        </tr>
        <%
            String[][] requests = (String[][])session.getAttribute("requests");
            for (String[] record : requests)
            {
        %>
                <tr>
                    <%
                        for (String data : record)
                        {
                            if (data == record[0])
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
                    <td><a href=<%="/approve_request?b="+record[0]%>>Approve</a></td>
                </tr>
        <%
            }
        %>
    </table>
    <p><a href="/manager_ui">Back</a></p>
</body>
</html>
