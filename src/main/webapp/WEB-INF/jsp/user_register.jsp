<%--
  Created by IntelliJ IDEA.
  User: emrekenar
  Date: 11.01.2021
  Time: 20:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Register</title>
</head>
<body>
<%
    String username = (String) session.getAttribute("reg_username");

    if (username == null)
    {
%>
<p style="color: red" >${errorMessage}</p>
<form method="post">
    Create a Username : <input type="text" name="username" /><br>
    Create a Password : <input type="password" name="password" /><br>
    Enter a Name : <input type="text" name="name"/><br>
    <input type="submit" value="Sign Up" /><br>
</form>
<a href="/home">Back</a>
<%
} else {
%>
<p>You are logged in as : <%= username %> </p>
<a href="/logout">Logout</a>
<%
    }
%>
</body>
</html>
