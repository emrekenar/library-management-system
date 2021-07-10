<%--
  Created by IntelliJ IDEA.
  User: emrekenar
  Date: 14.01.2021
  Time: 17:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Request Book</title>
    <Style>
        table, th, td { border: 1px solid black; }
    </Style>
</head>
<body>
    <p style="color: red" >${errorMessage}</p>
    <form method="post">
        Enter an ISBN : <input type="text" name="isbn" /><br>
        Title : <input type="text" name="title" /><br>
        Author : <input type="text" name="author"/><br>
        Topic : <input type="text" name="topic" /><br>
        Genre : <input type="text" name="genre" /><br>
        Publication Year : <input type="text" name="p_year_"/><br>
        Book language : <input type="text" name="language"/><br>
        <input type="submit" value="Request Book" />
    </form>
    <a href="/publisher_ui">Back</a>
</body>
</html>