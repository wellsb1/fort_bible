
drop table if exists BibleChapter;
drop table if exists BibleBook;
drop table if exists Bible;

CREATE TABLE `Bible` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `translation` varchar(512) DEFAULT NULL,
  `abbreviation` varchar(512) DEFAULT NULL,
  `lastModified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;


CREATE TABLE `BibleBook` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `bibleId` bigint unsigned, 
  `book` varchar(512) DEFAULT NULL,
  `chapters` int,
  `lastModified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `fk_BibleBook_Bible_id` FOREIGN KEY (`bibleId`) REFERENCES `Bible` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

CREATE TABLE `BibleChapter` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `bibleId` bigint unsigned, 
  `bibleBookId` bigint unsigned, 
  `book` varchar(512) DEFAULT NULL,
  `chapter` int,
  `text` LONGTEXT,
  `lastModified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `fk_BibleChapter_Bible_id` FOREIGN KEY (`bibleId`) REFERENCES `Bible` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_BibleChapter_BibleBooks_id` FOREIGN KEY (`bibleBookId`) REFERENCES `BibleBook` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;



insert into Bible(book, chapters) values ('Genesis',50);
insert into Bible(book, chapters) values ('Exodus', 40);
insert into Bible(book, chapters) values ('Leviticus', 27);
insert into Bible(book, chapters) values ('Numbers', 36);
insert into Bible(book, chapters) values ('Deuteronomy', 34);
insert into Bible(book, chapters) values ('Joshua',24);
insert into Bible(book, chapters) values ('Judges',21);
insert into Bible(book, chapters) values ('Ruth',4);
insert into Bible(book, chapters) values ('1 Samuel',31);
insert into Bible(book, chapters) values ('2 Samuel',24);
insert into Bible(book, chapters) values ('1 Kings',22);
insert into Bible(book, chapters) values ('2 Kings',25);
insert into Bible(book, chapters) values ('1 Chronicles',29);
insert into Bible(book, chapters) values ('2 Chronicles',36);
insert into Bible(book, chapters) values ('Ezra',10);
insert into Bible(book, chapters) values ('Nehemiah',13);
insert into Bible(book, chapters) values ('Ester',10);
insert into Bible(book, chapters) values ('Job',42);
insert into Bible(book, chapters) values ('Psalms',150);
insert into Bible(book, chapters) values ('Proverbs',31);
insert into Bible(book, chapters) values ('Ecclesiastes',12);
insert into Bible(book, chapters) values ('Song of Songs',8);
insert into Bible(book, chapters) values ('Isaiah',66);
insert into Bible(book, chapters) values ('Jeremiah',52);
insert into Bible(book, chapters) values ('Lamentations',5);
insert into Bible(book, chapters) values ('Ezekiel',48);
insert into Bible(book, chapters) values ('Daniel',12);
insert into Bible(book, chapters) values ('Hosea',14);
insert into Bible(book, chapters) values ('Joel',3);
insert into Bible(book, chapters) values ('Amos',9);
insert into Bible(book, chapters) values ('Obadiah',1);
insert into Bible(book, chapters) values ('Jonah',4);
insert into Bible(book, chapters) values ('Micah',7);
insert into Bible(book, chapters) values ('Nahum',3);
insert into Bible(book, chapters) values ('Habakkuk',3);
insert into Bible(book, chapters) values ('Zephaniah',3);
insert into Bible(book, chapters) values ('Haggai',2);
insert into Bible(book, chapters) values ('Zachariah',14);
insert into Bible(book, chapters) values ('Malachi',4);
insert into Bible(book, chapters) values ('Matthew',28);
insert into Bible(book, chapters) values ('Mark',16);
insert into Bible(book, chapters) values ('Luke',24);
insert into Bible(book, chapters) values ('John',21);
insert into Bible(book, chapters) values ('Acts',28);
insert into Bible(book, chapters) values ('Romans',16);
insert into Bible(book, chapters) values ('1 Corinthians',16);
insert into Bible(book, chapters) values ('2 Corinthians',13);
insert into Bible(book, chapters) values ('Galatians',6);
insert into Bible(book, chapters) values ('Ephesians',6);
insert into Bible(book, chapters) values ('Philippians',4);
insert into Bible(book, chapters) values ('Colossians',4);
insert into Bible(book, chapters) values ('1 Thessalonians',5);
insert into Bible(book, chapters) values ('2 Thessalonians',3);
insert into Bible(book, chapters) values ('1 Timothy',6);
insert into Bible(book, chapters) values ('2 Timothy',4);
insert into Bible(book, chapters) values ('Titus',3);
insert into Bible(book, chapters) values ('Philemon',1);
insert into Bible(book, chapters) values ('Hebrews',13);
insert into Bible(book, chapters) values ('James',5);
insert into Bible(book, chapters) values ('1 Peter', 5);
insert into Bible(book, chapters) values ('2 Peter',3);
insert into Bible(book, chapters) values ('1 John',5);
insert into Bible(book, chapters) values ('2 John',1);
insert into Bible(book, chapters) values ('3 John',1);
insert into Bible(book, chapters) values ('Jude',1);
insert into Bible(book, chapters) values ('Revelations',22);
