<%--
  Created by IntelliJ IDEA.
  User: emrekenar
  Date: 10.01.2021
  Time: 12:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Manager Interface</title>
</head>
<body>
<p>What would you like to do?</p>
    <p>
        <a href="/manager_current_reservations">See current reservations and lend books</a><br>
        <a href="/manager_borrow_history">See borrow history and get books back</a><br>
        <a href="/manager_overdue_books">See overdue books and collect penalties</a><br>
        <a href="/manager_add_book">Add a book</a><br>
        <a href="/manager_remove_book">List all books and remove a book</a><br>
        <a href="/manager_addition_requests">See book addition requests</a><br>
        <a href="/manager_removal_requests">See book removal requests</a><br>
        <a href="/publisher_register">Register a new publisher</a><br>
        <a href="/manager_booking_history">See booking history</a><br>
        <a href="/logout">Logout</a>
    </p>
</body>
</html>