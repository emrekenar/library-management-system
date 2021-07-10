<%--
  Created by IntelliJ IDEA.
  User: emrekenar
  Date: 11.01.2021
  Time: 21:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Register</title>
</head>
<body>
<p style="color: red" >${errorMessage}</p>
<p>Register a publisher</p>
<form method="post">
    <p>Create a Username : <input type="text" name="username" /></p>
    <p>Create a Password : <input type="password" name="password" /></p>
    <p>Enter a Name : <input type="text" name="name"/></p>
    <input type="submit" value="Sign Up" /><br>
</form>
<p><a href="/manager_ui">Back</a></p>
</body>
</html>
