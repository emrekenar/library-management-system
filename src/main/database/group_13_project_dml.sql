-- library managers
insert into user (username, password, name, user_type) values ('dnzyeniceri', 'nyjImNXnyZKZ+X3ZwW7DCA==', 'Deniz', 'm'); -- d12345
insert into user (username, password, name, user_type) values ('emre', 'NUxMj5fbwQpwVe150yciFA==', 'Emre', 'm'); -- 98765
insert into user (username, password, name, user_type) values ('pitir2020', 'X7YE0yBPATYVdIKAaCraiA==', 'Pitir', 'm'); -- 111222

-- users
insert into user (username, password, name, user_type) values ('krmyeniceri', 'sgNuZLDELNW0PH1j9bJCug==', 'Kerem', 'u'); -- 123459
insert into user (username, password, name, user_type) values ('ece007', '38XbPZ3ieUxsddkrlRXEfw==', 'Ece', 'u'); -- 234567

-- publishers
insert into user (username, password, name, user_type) values ('can2020', 'k+1hrC9AYVKjgEwaxkomtw==', 'Can Yayinlari', 'p'); -- can1987
insert into user (username, password, name, user_type) values ('isbank', 'pEIwVk1F2lUaxLhsgJ4HbA==', 'Is Bankasi Kultur Yayinlari', 'p'); -- isbank1937
insert into user (username, password, name, user_type) values ('yky', '6WVyBim0V1cATEwxLF0b5g==', 'Yapi Kredi Yayinlari', 'p'); -- 12345yapi
insert into user (username, password, name, user_type) values ('iletisim', 'MvvJZbitMQ9II8xuADOLVQ==', 'Iletisim Yayinlari', 'p'); -- ilet123

-- books
insert into book (isbn, title, author, topic, genre, publisher_id, p_year, language) values ('1234567891011', 'Hayvan Ciftligi', 'George Orwell', 'Political', 'Novel', 6, 2010, 'Turkish');
insert into book (isbn, title, author, topic, genre, publisher_id, p_year, language) values ('6789567891011', 'Suc ve Ceza', 'Fyodor Dostoyevski', 'Psychological', 'Novel', 7, 2008, 'Turkish');
insert into book (isbn, title, author, topic, genre, publisher_id, p_year, language) values ('9876543210987', 'Sefiller', 'Victor Hugo', 'Tragedy', 'Novel', 7, 1862, 'Turkish');
insert into book (isbn, title, author, topic, genre, publisher_id, p_year, language) values ('1234567890987', '1984', 'George Orwell', 'Distopia', 'Novel', 6, 1800, 'Turkish');
insert into book (isbn, title, author, topic, genre, publisher_id, p_year, language) values ('9876543210986', 'Korluk', 'Jose Saramago', 'Literature', 'Novel', 6, 1900, 'Turkish');
insert into book (isbn, title, author, topic, genre, publisher_id, p_year, language) values ('9876543210985', 'Gormek', 'Jose Saramago', 'Literature', 'Novel', 6, 1905, 'Turkish');
insert into book (isbn, title, author, topic, genre, publisher_id, p_year, language) values ('9876543210984', 'Ah\'lar Agaci', 'Didem Madak', 'Drama', 'Poem', 7, 1862, 'Turkish');
insert into book (isbn, title, author, topic, genre, publisher_id, p_year, language) values ('9876543210983', 'Memleketimden Insan Manzaralari', 'Nazim Hikmet', 'Drama', 'Poem', 7, 1938, 'Turkish');
insert into book (isbn, title, author, topic, genre, publisher_id, p_year, language) values ('9876543210982', 'Atesten Gomlek', 'Halide Edib Adivar', 'History', 'Novel', 7, 1918, 'Turkish');
insert into book (isbn, title, author, topic, genre, publisher_id, p_year, language) values ('9876543210981', 'Percy Jackson: Simsek Hirsizi', 'Rick Riordan', 'Mythology', 'Novel', 6, 2005, 'Turkish');
insert into book (isbn, title, author, topic, genre, publisher_id, p_year, language) values ('9876543210980', 'Percy Jackson: Canavarlar Denizi', 'Rick Riordan', 'Mythology', 'Novel', 6, 2006, 'Turkish');
insert into book (isbn, title, author, topic, genre, publisher_id, p_year, language) values ('9876543210979', 'Harry Potter: Felsefe Tasi', 'JK Rowling', 'Fantasy', 'Novel', 9, 1997, 'Turkish');
insert into book (isbn, title, author, topic, genre, publisher_id, p_year, language) values ('9876543210978', 'Korkuyu Beklerken', 'Oguz Atay', 'Drama', 'Story', 9, 1975, 'Turkish');
insert into book (isbn, title, author, topic, genre, publisher_id, p_year, language) values ('9876543210977', 'Budala', 'Fyodor Dostoyevski', 'Romance', 'Novel', 7, 1869, 'Turkish');
insert into book (isbn, title, author, topic, genre, publisher_id, p_year, language) values ('9876543210976', 'Veronika Olmek Istiyor', 'Paulo Coelho', 'History', 'Novel', 8, 1998, 'Turkish');
insert into book (isbn, title, author, topic, genre, publisher_id, p_year, language) values ('9876543210975', 'Avatar', 'Gene Luen Yang', 'Fantasy', 'Comic', 8, 1862, 'Turkish');
insert into book (isbn, title, author, topic, genre, publisher_id, p_year, language) values ('9876543210974', 'Deep Learning', 'Ian Goodfellow', 'Artificial Intelligence', 'Academic Literature', 9, 2013, 'English');
insert into book (isbn, title, author, topic, genre, publisher_id, p_year, language) values ('9876543210973', 'The Singularity is Real', 'Ray Kurzweil', 'Artificial Intelligence', 'Academic Literature', 8, 2019, 'English');
insert into book (isbn, title, author, topic, genre, publisher_id, p_year, language) values ('9876543210972', 'Bir Idam Mahkumunun Son Gunu', 'Victor Hugo', 'Romance', 'Novel', 7, 1829, 'Turkish');

insert into borrow (user_id, book_id, borrow_date) values (4, 5, '2020-09-01 00:00:00');
update book set status = 'Borrowed' where id = 5;
delete from booking where status='Reserved' and user_id=4 and book_id=5;
insert into borrow (user_id, book_id, borrow_date) values (4, 6, '2020-09-01 00:00:00');
update book set status = 'Borrowed' where id = 6;
delete from booking where status='Reserved' and user_id=4 and book_id=6;
insert into borrow (user_id, book_id, borrow_date) values (5, 7, '2020-08-01 00:00:00');
update book set status = 'Borrowed' where id = 7;
delete from booking where status='Reserved' and user_id=5 and book_id=7;
insert into borrow (user_id, book_id, borrow_date) values (5, 8, '2020-10-01 00:00:00');
update book set status = 'Borrowed' where id = 8;
delete from booking where status='Reserved' and user_id=5 and book_id=8;
