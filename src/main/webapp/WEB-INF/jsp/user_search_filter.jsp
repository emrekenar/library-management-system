<%--
  Created by IntelliJ IDEA.
  User: emrekenar
  Date: 15.01.2021
  Time: 21:58
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
    <form method="post">
        <input type="text" placeholder="Search..." name="search"/>
        <input type="submit" name="action" value="Search"/>
        <p>
            Author <select name="authors" id="authors">
                    <option value="all">All</option>
                    <%
                        for (String author : (String[])session.getAttribute("authors"))
                        {
                    %>
                            <option value="<%=author%>"><%=author%></option>
                    <%
                        }
                    %>
                </select>
            Topic <select name="topics" id="topics">
                    <option value="all">All</option>
                    <%
                        for (String topic : (String[])session.getAttribute("topics"))
                        {
                    %>
                            <option value="<%=topic%>"><%=topic%></option>
                    <%
                        }
                    %>
                </select>
            Genre <select name="genres" id="genres">
                    <option value="all">All</option>
                    <%
                        for (String genre : (String[])session.getAttribute("genres"))
                        {
                    %>
                            <option value="<%=genre%>"><%=genre%></option>
                    <%
                        }
                    %>
                    </select>
            Publisher <select name="publishers" id="publishers">
                    <option value="all">All</option>
                    <%
                        for (String pub : (String[])session.getAttribute("publishers"))
                        {
                    %>
                            <option value="<%=pub%>"><%=pub%></option>
                    <%
                        }
                    %>
                    </select>
            Year <select name="years" id="years">
                    <option value="all">All</option>
                    <%
                        for (Integer year : (Integer[])session.getAttribute("years"))
                        {
                    %>
                            <option value="<%=year%>"><%=year%></option>
                    <%
                        }
                    %>
                    </select>
            Status <select name="status" id="status">
                    <option value="all">All</option>
                    <%
                        for (String status : (String[])session.getAttribute("status"))
                        {
                    %>
                            <option value="<%=status%>"><%=status%></option>
                    <%
                        }
                    %>
                    </select>
        </p>
    </form>
    <br>
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
                    if (data.equals(book[0]))
                        continue;
            %>
            <td><%=data%></td>
            <%
                }
            }
            %>
        </tr>
    </table>
    <p><a href="/user_ui">Back</a></p>
</body>
</html>
