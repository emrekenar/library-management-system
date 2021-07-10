package edu.ozu.cs202project.controllers;

import edu.ozu.cs202project.Salter;
import edu.ozu.cs202project.services.LoginService;
import edu.ozu.cs202project.services.RegisterBook;
import edu.ozu.cs202project.services.RegisterService;
import edu.ozu.cs202project.services.RequestBook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.request.WebRequest;

import java.sql.Array;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

@Controller
@SessionAttributes({ "publisher_list", "reg_username", "username", "bookData", "borrowData",
        "userBorrowData", "publisherCountData", "userBookingData", "reservations", "requests",
        "removals", "authors", "topics", "genres", "publishers", "years", "status" })
public class AppController
{
    @Autowired
    LoginService service;

    @Autowired
    RegisterService rservice;

    @Autowired
    RegisterBook rbook;

    @Autowired
    JdbcTemplate conn;

    @Autowired
    RequestBook req_book;

    @GetMapping("/")
    public String index(ModelMap model) { return "home"; }

    @GetMapping("/home")
    public String home(ModelMap model) { return "home"; }

    @GetMapping("/login")
    public String loginPage(ModelMap model)
    {
        return "login";
    }

    @PostMapping("/login")
    public String login(ModelMap model, @RequestParam String username, @RequestParam String password)
    {
        if (!service.validate(username, password))
        {
            model.put("errorMessage", "Invalid Credentials");

            return "login";
        }

        model.put("username", username);

        char login_type = getUserType();

        if (login_type == 'm')
            return "manager_ui";
        else if (login_type == 'p')
            return "publisher_ui";
        return "user_ui";
    }

    @GetMapping("/logout")
    public String logout(ModelMap model, WebRequest request, SessionStatus session)
    {
        session.setComplete();
        conn.execute("update user set status = 'o' where username = "+"username");
        request.removeAttribute("username", WebRequest.SCOPE_SESSION);

        return "home";
    }

    @GetMapping("/user_register")
    public String user_register_page(ModelMap model)
    { return "user_register"; }

    @PostMapping("/user_register")
    public String user_register(ModelMap model, @RequestParam String username, @RequestParam String password,
                                @RequestParam String name)
    {
        if (!rservice.validate(username, password, name, 'u'))
        {
            model.put("errorMessage", "This username is in use.");

            return "user_register";
        }

        model.put("reg_username", username);

        return "home";
    }

    @GetMapping("/publisher_register")
    public String publisher_register_page(ModelMap model)
    { return "publisher_register"; }

    @PostMapping("/publisher_register")
    public String publisher_register(ModelMap model, @RequestParam String username, @RequestParam String password,
                                     @RequestParam String name)
    {
        if (!rservice.validate(username, password, name, 'p'))
        {
            model.put("errorMessage", "This username is in use.");

            return "publisher_register";
        }

        model.put("reg_username", username);

        return "manager_ui";
    }

    @GetMapping("/manager_ui")
    public String manager_ui(ModelMap model)
    {
        return "manager_ui";
    }

    @GetMapping("/publisher_ui")
    public String publisher_ui(ModelMap model)
    {
        return "publisher_ui";
    }

    @GetMapping("/user_ui")
    public String user_ui(ModelMap model)
    {
        return "user_ui";
    }

    @GetMapping("/manager_add_book")
    public String manager_add_book(ModelMap model)
    {
        // list publisher id's for easy usage
        List<String[]> publisher_list = conn.query("select id, name " +
                        "from user " +
                        "where user_type='p'",
                (row, index) -> {
                    return new String[]{ Integer.toString(row.getInt("id")),
                            row.getString("name")
                    };
                });

        model.addAttribute("publisher_list", publisher_list.toArray(new String[0][2]));

        return "manager_add_book";
    }

    @PostMapping("/manager_add_book")
    public String add_book(ModelMap model, @RequestParam String isbn,
                           @RequestParam String title, @RequestParam String author,
                           @RequestParam String topic, @RequestParam String genre,
                           @RequestParam String publisher_id_, @RequestParam String p_year_,
                           @RequestParam String language) throws SQLException
    {
        if (isbn.length()!=13)
        {
            model.put("errorMessage", "ISBN must be 13 digits.");
            return "manager_add_book";
        }

        // check if publisher id and publication year are integers
        int publisher_id, p_year;
        try {
            publisher_id = Integer.parseInt(publisher_id_);
            p_year = Integer.parseInt(p_year_);
        } catch (Exception e) {
            model.put("errorMessage", "Enter valid publisher ID and publication year.");
            return "manager_add_book";
        }

        if (!rbook.validate(isbn, title, author, topic, genre, publisher_id, p_year, language))
        {
            if (isbn.length()!=13)
                model.put("errorMessage", "This book already exists.");
            else
                model.put("errorMessage", "Publisher does not exist.");

            return "manager_add_book";
        }

        model.put("reg_isbn", isbn);

        return "manager_ui";
    }

    @GetMapping("/manager_remove_book")
    public String manager_remove_book(ModelMap model)
    {
        model.addAttribute("bookData", generateBookData(model).toArray(new String[0][10]));

        return "manager_remove_book";
    }

    @GetMapping("/removal_approved")
    public String remove_book(ModelMap model, WebRequest request, SessionStatus session)
    {
        conn.execute("delete from book where id="+request.getParameter("b"));

        return "redirect:/manager_remove_book";
    }

    @GetMapping("/manager_addition_requests")
    public String manager_addition_requests(ModelMap model)
    {
        List<String[]> requests = conn.query("select book.id, book.isbn, book.title, " +
                        "book.author, book.topic, book.genre, user.name, " +
                        "book.p_year, book.language " +
                        "from book, user " +
                        "where user.id=book.publisher_id and book.status='Requested'",
                (row, index)->{
                    return new String[]{ Integer.toString(row.getInt("id")),
                            row.getString("isbn"),
                            row.getString("title"),
                            row.getString("author"),
                            row.getString("topic"),
                            row.getString("genre"),
                            row.getString("name"),
                            Integer.toString(row.getInt("p_year")),
                            row.getString("language")
                    };
                });

        model.addAttribute("requests", requests.toArray(new String[0][9]));

        return "manager_addition_requests";
    }

    @GetMapping("/approve_request")
    public String approve_request(ModelMap model, WebRequest request, SessionStatus session)
    {
        conn.execute("update book set status='Available' "+
                "where id="+request.getParameter("b"));

        return "redirect:/manager_addition_requests";
    }

    @GetMapping("/manager_removal_requests")
    public String manager_removal_requests(ModelMap model)
    {
        List<String[]> removals = conn.query("select book.id, book.isbn, book.title, book.author, book.topic, " +
                        "book.genre, book.language, book.p_year, user.name, book.status " +
                        "FROM user, book, booking " +
                        "where book.publisher_id = user.id and book.status<>'Requested' and "+
                        "booking.book_id=book.id and booking.status='Removal'",
                (row, index) -> {
                    return new String[]{ Integer.toString(row.getInt("id")),
                            row.getString("isbn"),
                            row.getString("title"),
                            row.getString("author"),
                            row.getString("topic"),
                            row.getString("genre"),
                            row.getString("language"),
                            Integer.toString(row.getInt("p_year")),
                            row.getString("name"),
                            row.getString("status") };
                });

        model.addAttribute("removals", removals.toArray(new String[0][10]));

        return "manager_removal_requests";
    }

    @GetMapping("/approve_removal")
    public String approve_removal(ModelMap model, WebRequest request, SessionStatus session)
    {
        conn.execute("delete from book where id="+request.getParameter("b"));
        conn.execute("delete from booking where book_id="+request.getParameter("b"));

        return "redirect:/manager_removal_requests";
    }

    @GetMapping("/manager_current_reservations")
    public String manager_current_reservations(ModelMap model)
    {
        List<String[]> reservations = conn.query("select user.id as id1, user.username, book.id as id2, book.isbn, book.title, book.author "+
                        "from user, booking, book " +
                        "where booking.user_id=user.id and booking.book_id=book.id and booking.status='Reserved'",
                (row, index) -> {
                    return new String[]{ Integer.toString(row.getInt("id1")),
                            row.getString("username"),
                            Integer.toString(row.getInt("id2")),
                            row.getString("isbn"),
                            row.getString("title"),
                            row.getString("author")
                    };
                });

        model.addAttribute("reservations", reservations.toArray(new String[0][6]));

        return "manager_current_reservations";
    }

    @GetMapping("/lend")
    public String lend_book(ModelMap model, WebRequest request, SessionStatus session)
    {
        int u = Integer.parseInt(request.getParameter("u"));
        int b = Integer.parseInt(request.getParameter("b"));
        conn.execute("insert into borrow (user_id, book_id, borrow_date) values ("+
                u+","+b+",now())");
        conn.execute("delete from booking where status='Reserved' and "+
                "user_id="+u+" and book_id="+b);
        conn.execute("update book set status='Borrowed' where id="+b);

        return "redirect:/manager_current_reservations";
    }

    @GetMapping("/manager_borrow_history")
    public String borrow_history(ModelMap model)
    {
        update_overdue(model);

        // list all borrow data
        List<String[]> borrowData = conn.query("select borrow.id, user.id as id1, user.username, book.id as id2, book.title," +
                        "book.author, borrow.borrow_date, borrow.return_date, borrow.overdue " +
                        "from user, book, borrow " +
                        "where borrow.user_id=user.id and borrow.book_id=book.id;",
                (row, index) -> {
                    return new String[]{ Integer.toString(row.getInt("id")),
                            Integer.toString(row.getInt("id1")),
                            row.getString("username"),
                            Integer.toString(row.getInt("id2")),
                            row.getString("title"),
                            row.getString("author"),
                            row.getString("borrow_date"),
                            row.getString("return_date"),
                            Integer.toString(row.getInt("overdue"))
                    };
                });

        model.addAttribute("borrowData", borrowData.toArray(new String[0][9]));

        return "manager_borrow_history";
    }

    @GetMapping("/return")
    public String return_book(ModelMap model, WebRequest request, SessionStatus session)
    {
        int borrow = Integer.parseInt(request.getParameter("w"));
        int book = Integer.parseInt(request.getParameter("b"));

        conn.execute("update borrow set return_date=now() where id="+borrow);

        List<Integer[]> requests = conn.query("select booking.id as id1, book.id as id2 " +
                        "from booking, book, user " +
                        "where user.id=booking.user_id and book.id=booking.book_id and booking.status='Held Request' " +
                        "limit 1",
                (row, index)->{
                    return new Integer[]{ row.getInt("id1"), row.getInt("id2") };
                });

        if (requests.size()!=0)
        { // if there are people who held request the book, make it reserved for the first person
            conn.execute("update booking set status='Reserved' where id="+requests.get(0)[0]);
            conn.execute("update book set status='Reserved' where id="+requests.get(0)[1]);
        }
        else
            conn.execute("update book set status='Available' where id="+book);

        return "redirect:/manager_borrow_history";
    }

    @GetMapping("/manager_booking_history")
    public String manager_booking_history (ModelMap model)
    {
        // get all booking records
        List<String[]> booking_records = conn.query("select user.id as id1, user.username, book.id as id2, " +
                        "book.isbn, book.title, book.author, booking.status "+
                        "from user, booking, book " +
                        "where booking.user_id=user.id and booking.book_id=book.id",
                (row, index) -> {
                    return new String[]{ Integer.toString(row.getInt("id1")),
                            row.getString("username"),
                            Integer.toString(row.getInt("id2")),
                            row.getString("isbn"),
                            row.getString("title"),
                            row.getString("author"),
                            row.getString("status")
                    };
                });

        model.addAttribute("reservations", booking_records.toArray(new String[0][7]));

        return "manager_booking_history";
    }

    @GetMapping("/manager_overdue_books")
    public String manager_overdue_books(ModelMap model)
    {
        update_overdue(model);

        List<String[]> bookData = conn.query("SELECT user.id as id1, user.username, book.id as id2, book.isbn, " +
                        "book.title, book.author, book.status, borrow.return_date, borrow.overdue, borrow.paid " +
                        "FROM user, book, borrow " +
                        "where book.status<>'Requested' and " +
                        "borrow.user_id=user.id and borrow.book_id=book.id and borrow.overdue>0",
                (row, index) -> {
                    return new String[]{ Integer.toString(row.getInt("id1")),
                            row.getString("username"),
                            Integer.toString(row.getInt("id2")),
                            row.getString("isbn"),
                            row.getString("title"),
                            row.getString("author"),
                            row.getString("status"),
                            row.getString("return_date"),
                            Integer.toString(row.getInt("overdue")),
                            row.getString("paid")
                    };
                });

        model.addAttribute("bookData", bookData.toArray(new String[0][10]));

        return "manager_overdue_books";
    }

    @GetMapping("/payment_accepted")
    public String accept_payment(ModelMap model, WebRequest request, SessionStatus session)
    {
        conn.execute("update borrow set paid='Paid' "+
                "where user_id="+request.getParameter("u")+" and book_id="+request.getParameter("b"));

        return "redirect:/manager_overdue_books";
    }

    @GetMapping("/publisher_request_addition")
    public String publisher_request_addition(ModelMap model)
    {
        return "publisher_request_addition";
    }

    @PostMapping("/publisher_request_addition")
    public String request_book(ModelMap model, @RequestParam String isbn,
                               @RequestParam String title, @RequestParam String author,
                               @RequestParam String topic, @RequestParam String genre,
                               @RequestParam String p_year_,
                               @RequestParam String language) throws SQLException
    {
        if (isbn.length()!=13)
        {
            model.put("errorMessage", "ISBN must be 13 digits.");
            return "publisher_request_addition";
        }

        int p_year;
        try {
            p_year = Integer.parseInt(p_year_);
        } catch (Exception e) {
            model.put("errorMessage", "Enter valid publisher ID and publication year.");
            return "publisher_request_addition";
        }

        if (!req_book.validate(isbn, title, author, topic, genre, p_year, language, (String)model.getAttribute("username")))
        {
            model.put("errorMessage", "This book already exists.");

            return "publisher_request_addition";
        }

        model.put("reg_isbn", isbn);

        return "publisher_ui";
    }

    @GetMapping("/publisher_request_removal")
    public String publisher_request_removal(ModelMap model)
    {
        List<String[]> bookData = conn.query("select book.id, book.isbn, book.title, book.author, " +
                        "book.topic, book.genre, book.language, book.p_year, user.name, book.status " +
                        "FROM user, book " +
                        "where book.publisher_id = user.id and book.status<>'Requested' and user.username='"+
                        model.getAttribute("username")+"'",
                (row, index) -> {
                    return new String[]{ Integer.toString(row.getInt("id")),
                            row.getString("isbn"),
                            row.getString("title"),
                            row.getString("author"),
                            row.getString("topic"),
                            row.getString("genre"),
                            row.getString("language"),
                            Integer.toString(row.getInt("p_year")),
                            row.getString("name"),
                            row.getString("status") };
                });

        model.addAttribute("bookData", bookData.toArray(new String[0][10]));

        return "publisher_request_removal";
    }

    @GetMapping("/removal_requested")
    public String request_removal(ModelMap model, WebRequest request, SessionStatus session)
    {
        conn.execute("insert into booking (user_id, book_id, status) " +
                "values ((select id from user where username='"+model.getAttribute("username")+"')"+
                ","+request.getParameter("b")+",'Removal')");

        return "redirect:/publisher_request_removal";
    }

    @GetMapping("/publisher_search")
    public String publisher_search(ModelMap model)
    {
        model.addAttribute("bookData", generateBookData(model).toArray(new String[0][10]));

        return "publisher_search";
    }

    @GetMapping("/publisher_borrowed_books")
    public String publisher_borrowed_books(ModelMap model)
    {
        List<String[]> borrowData = conn.query("select book.id as id1, book.isbn, book.title, book.author, " +
                        "(select count(id) from borrow where book_id=id1) as count_borrowed from user, book "+
                        "where book.publisher_id=user.id " +
                        "and user.username='"+model.getAttribute("username")+ "'",
                (row, index) -> {
                    return new String[]{ Integer.toString(row.getInt("id1")),
                            row.getString("isbn"),
                            row.getString("title"),
                            row.getString("author"),
                            Integer.toString(row.getInt("count_borrowed"))
                    };
                });

        model.addAttribute("publisherCountData", borrowData.toArray(new String[0][5]));

        return "publisher_borrowed_books";
    }

    @GetMapping("/user_search")
    public String user_search(ModelMap model)
    {
        List<String[]> bookingData = conn.query("select user.username, booking.book_id " +
                        "from booking, user where user.id=booking.user_id",
                (row, index) -> {
                    return new String[]{ row.getString("username"),
                            Integer.toString(row.getInt("book_id"))
                    };
                });

        List<String[]> userBorrowData = conn.query("select user.username, borrow.book_id "+
                        "from user, borrow where borrow.user_id=user.id and borrow.return_date is null",
                (row, index) -> {
                    return new String[]{ row.getString("username"),
                            Integer.toString(row.getInt("book_id"))
                    };
                });

        model.addAttribute("borrowData", bookingData.toArray(new String[0][2]));
        model.addAttribute("userBorrowData", userBorrowData.toArray(new String[0][2]));
        model.addAttribute("bookData", generateBookData(model).toArray(new String[0][10]));

        return "user_search";
    }

    @GetMapping("/reserve")
    public String reserve(ModelMap model, WebRequest request, SessionStatus session)
    {
        int b = Integer.parseInt(request.getParameter("b"));
        conn.execute("insert into booking (user_id, book_id, status) " +
                "values ((select id from user where username='"+model.getAttribute("username")+
                "'),"+b+",'Reserved')");
        conn.execute("update book set status='Reserved' where id="+b);

        return "redirect:/user_search";
    }

    @GetMapping("/hold_request")
    public String hold_request(ModelMap model, WebRequest request, SessionStatus session) {
        conn.execute("insert into booking (user_id, book_id, status) values (" +
                "(select id from user where username='" + model.getAttribute("username") +
                "'), " + request.getParameter("b") + ", 'Held Request')");

        return "redirect:/user_search";
    }

    @GetMapping("/user_search_filter")
    public String user_search_filter(ModelMap model)
    {
        addFilters(model);

        model.addAttribute("bookData", generateBookData(model).toArray(new String[0][10]));

        return "user_search_filter";
    }

    @PostMapping("/user_search_filter")
    public String user_search_filter_post(ModelMap model, @RequestParam String search,
                                          @RequestParam String authors, @RequestParam String topics,
                                          @RequestParam String genres, @RequestParam String publishers,
                                          @RequestParam String years, @RequestParam String status)
    {
        String q_a = "";
        String q_t = "";
        String q_g = "";
        String q_p = "";
        String q_y = "";
        String q_s = "";

        if (!authors.equals("all"))
            q_a += " and book.author='"+authors+"'";
        if (!topics.equals("all"))
            q_t += " and book.topic='"+topics+"'";
        if (!genres.equals("all"))
            q_g += " and book.genre='"+genres+"'";
        if (!publishers.equals("all"))
            q_p += " and user.name='"+publishers+"'";
        if (!years.equals("all"))
            q_y += " and book.p_year="+years+"";
        if (status.equals("Available"))
            q_s += " and book.status='Available'";
        if (!status.equals("all"))
            q_s += " and book.status='Not Available'";

        String filter_query = q_a+q_t+q_g+q_p+q_y+q_s;

        System.out.println(search);
        List<String[]> filtered = conn.query("SELECT book.id, book.isbn, book.title, book.author, book.topic, " +
                        "book.genre, book.language, book.p_year, user.name, book.status " +
                        "FROM user, book " +
                        "where book.publisher_id = user.id and book.status<>'Requested' " +
                        "and (book.title like '%"+search+"%' or book.author like '%"+search+"%' or " +
                        "book.topic like '%"+search+"%' or book.genre like '%"+search+"%' or " +
                        "book.language like '%"+search+"%' or user.name like '%"+search+"%' or " +
                        "book.p_year like '%"+search+"%' or book.status like '%"+search+"%')"+filter_query,
                (row, index) -> {
                    return new String[]{ Integer.toString(row.getInt("id")),
                            row.getString("isbn"),
                            row.getString("title"),
                            row.getString("author"),
                            row.getString("topic"),
                            row.getString("genre"),
                            row.getString("language"),
                            Integer.toString(row.getInt("p_year")),
                            row.getString("name"),
                            row.getString("status") };
                });

        List<String[]> bookingData = conn.query("select user.username, booking.book_id " +
                        "from booking, user where user.id=booking.user_id",
                (row, index) -> {
                    return new String[]{ row.getString("username"),
                            Integer.toString(row.getInt("book_id"))
                    };
                });

        List<String[]> userBorrowData = conn.query("select user.username, borrow.book_id "+
                        "from user, borrow where borrow.user_id=user.id and borrow.return_date is null",
                (row, index) -> {
                    return new String[]{ row.getString("username"),
                            Integer.toString(row.getInt("book_id"))
                    };
                });

        model.addAttribute("borrowData", bookingData.toArray(new String[0][2]));
        model.addAttribute("userBorrowData", userBorrowData.toArray(new String[0][2]));
        model.addAttribute("bookData", filtered.toArray(new String[0][10]));

        return "user_search";
    }

    @GetMapping("/user_history")
    public String user_borrow_history(ModelMap model)
    {
        update_overdue(model);

        List<String[]> userBorrowData = conn.query("select book.id, book.isbn, book.title, book.author, " +
                        "borrow.borrow_date, borrow.return_date, borrow.overdue, borrow.paid "+
                        "from user, book, borrow " +
                        "where borrow.user_id=user.id and borrow.book_id=book.id and user.username='"+model.getAttribute("username")+"'",
                (row, index) -> {
                    return new String[]{ Integer.toString(row.getInt("id")),
                            row.getString("isbn"),
                            row.getString("title"),
                            row.getString("author"),
                            row.getString("borrow_date"),
                            row.getString("return_date"),
                            Integer.toString(row.getInt("overdue")),
                            row.getString("paid")
                    };
                });

        model.addAttribute("userBorrowData", userBorrowData.toArray(new String[0][8]));

        return "user_history";
    }

    @GetMapping("/user_booking_history")
    public String user_booking_history(ModelMap model)
    {
        List<String[]> userBorrowData = conn.query("select booking.id, book.isbn, book.title, book.author, booking.status "+
                        "from user, booking, book " +
                        "where booking.user_id=user.id and booking.book_id=book.id and user.username='"+model.getAttribute("username")+"'",
                (row, index) -> {
                    return new String[]{ Integer.toString(row.getInt("id")),
                            row.getString("isbn"),
                            row.getString("title"),
                            row.getString("author"),
                            row.getString("status")
                    };
                });

        model.addAttribute("userBookingData", userBorrowData.toArray(new String[0][5]));

        return "user_booking_history";
    }

    @GetMapping("/booking_canceled")
    public String cancel_booking(ModelMap model, WebRequest request, SessionStatus session)
    {
        int b = Integer.parseInt(request.getParameter("b"));

        List<String[]> result = conn.query("select status, book_id from booking where id="+b,
                (row, index) -> {
                    return new String[] { row.getString("status"),
                                          Integer.toString(row.getInt("book_id"))
                    };
                });

        if (result.get(0)[0].charAt(0) == 'R') { // if reservation cancelled
            conn.execute("update book set status='Available' where id="+result.get(0)[1]);
        }

        conn.execute("delete from booking where id="+b);

        return "redirect:/user_booking_history";
    }

    public char getUserType ()
    {
        List<String> result = conn.query("select user_type from user where status='i' limit 1",
                (row, index) -> {
                    return row.getString("user_type");
                });
        return result.get(0).charAt(0);
    }

    public List<String[]> generateBookData(ModelMap model)
    {
        List<String[]> bookData = conn.query("SELECT book.id, book.isbn, book.title, book.author, book.topic, " +
                        "book.genre, book.language, book.p_year, user.name, book.status " +
                        "FROM user, book " +
                        "where book.publisher_id = user.id and book.status<>'Requested'",
                (row, index) -> {
                    return new String[]{ Integer.toString(row.getInt("id")),
                            row.getString("isbn"),
                            row.getString("title"),
                            row.getString("author"),
                            row.getString("topic"),
                            row.getString("genre"),
                            row.getString("language"),
                            Integer.toString(row.getInt("p_year")),
                            row.getString("name"),
                            row.getString("status") };
                });
        return bookData;
    }

    public void update_overdue (ModelMap model)
    {
        // update overdue of not returned books
        List<Integer[]> not_returned_overdue = conn.query("select id, datediff(now(), borrow_date)-14 as new_overdue " +
                        "from borrow where return_date is null and now()-interval 14 day > borrow_date and datediff(now(), borrow_date)-14<>overdue",
                (row, index)->{ return new Integer[] { row.getInt("id"),
                        row.getInt("new_overdue") };
                });
        for (Integer[] record : not_returned_overdue)
            conn.execute("update borrow set overdue="+record[1]+" where id="+record[0]);

        // update overdue of returned books
        List<Integer[]> returned_overdue = conn.query("select id, datediff(return_date, borrow_date)-14 as new_overdue " +
                        "from borrow where return_date is not null and return_date-interval 14 day > borrow_date and datediff(now(), borrow_date)-14<>overdue",
                (row, index)->{ return new Integer[] { row.getInt("id"),
                        row.getInt("new_overdue") };
                });
        for (Integer[] record : returned_overdue)
            conn.execute("update borrow set overdue="+record[1]+" where id="+record[0]);
    }

    public void addFilters(ModelMap model)
    {
        List<String> authors = conn.query("SELECT distinct author from book",
                (row, index) -> {
                    return row.getString("author");
                });
        List<String> topics = conn.query("SELECT distinct topic from book",
                (row, index) -> {
                    return row.getString("topic");
                });
        List<String> genres = conn.query("SELECT distinct genre from book",
                (row, index) -> {
                    return row.getString("genre");
                });
        List<String> publishers = conn.query("SELECT distinct name from user where user_type='p'",
                (row, index) -> {
                    return row.getString("name");
                });
        List<Integer> years = conn.query("SELECT distinct p_year from book",
                (row, index) -> {
                    return row.getInt("p_year");
                });
        String[] availability = {"Available", "Not Available"};

        model.addAttribute("authors", authors.toArray(new String[0]));
        model.addAttribute("topics", topics.toArray(new String[0]));
        model.addAttribute("genres", genres.toArray(new String[0]));
        model.addAttribute("publishers", publishers.toArray(new String[0]));
        model.addAttribute("years", years.toArray(new Integer[0]));
        model.addAttribute("status", availability);
    }
}
