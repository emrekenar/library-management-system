drop table if exists booking;
drop table if exists borrow;
drop table if exists book;
drop table if exists user;

create table user
(
	id        int not null auto_increment,
	username  varchar(11) not null,
    password  varchar(50) not null,
    name      varchar(30) not null,
    user_type char(1) not null, -- p: publisher, m: manager, u: user
    status    char(1) default 'o', -- i: loggedusername in, o: logged out
    primary key (id)
);

create table book
(
	id              int not null auto_increment,
    isbn            char(13) not null,
    title           varchar(100) not null,
    author          varchar(50) not null,
    topic           varchar(50) not null,
    genre           varchar(50) not null,
    publisher_id    int not null,
	p_year          int not null,
    language        varchar(30),
    status          varchar(9) default 'Available', -- Available, Borrowed, Reserved, Requested
    primary key (id),
    foreign key (publisher_id) references user (id)
    on delete cascade
);

create table borrow
(
	id               int not null auto_increment,
    user_id          int not null,
    book_id          int not null,
    borrow_date      datetime default CURRENT_TIMESTAMP,
    return_date      datetime,
    overdue          int default 0,
    paid             varchar(8) default 'Not Paid', -- Not Paid, Paid
    primary key (id),
    foreign key (user_id) references user (id) on delete cascade,
    foreign key (book_id) references book (id) on delete cascade
);

create table booking
(
	id       int not null auto_increment,
    user_id  int not null,
	book_id  int not null,
    status   varchar(12) not null, -- Held Request, Reserved, Removal
    primary key (id),
    foreign key (user_id) references user (id) on delete cascade,
    foreign key (book_id) references book (id) on delete cascade
);
