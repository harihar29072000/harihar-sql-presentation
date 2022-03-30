
CREATE PROC dbo.LibraryManagementSystemProcedure
AS
CREATE DATABASE db_LibraryManagement

GO
	/* =======================CREATE TABLES ========================*/

	/* ====TABLE 1 =====*/
	CREATE TABLE publisher (
		publisher_Name VARCHAR(100) PRIMARY KEY NOT NULL,
		publisher_Address VARCHAR(200) NOT NULL,
		publisher_Phone VARCHAR(50) NOT NULL);

	/* ====TABLE 2 =====*/
	CREATE TABLE book (
		book_ID INT PRIMARY KEY NOT NULL IDENTITY (1,1),
		book_Title VARCHAR(100) NOT NULL,
		book_PublisherName VARCHAR(100) NOT NULL CONSTRAINT fk_publisher_name1 FOREIGN KEY REFERENCES publisher(publisher_Name) ON UPDATE CASCADE ON DELETE CASCADE,
	);

	/* ====TABLE 3 =====*/
	CREATE TABLE library_branch (
		library_BranchID INT PRIMARY KEY NOT NULL IDENTITY (1,1),
		library_BranchName VARCHAR(100) NOT NULL,
		library_BranchAddress VARCHAR(200) NOT NULL,
	);

	SELECT * FROM library_branch

	/* ====TABLE 4 =====*/
	CREATE TABLE borrower (
		borrower_CardNo INT PRIMARY KEY NOT NULL IDENTITY (100,1),
		borrower_Name VARCHAR(100) NOT NULL,
		borrower_Address VARCHAR(200) NOT NULL,
		borrower_Phone VARCHAR(50) NOT NULL,
	);

	SELECT * FROM borrower

	/* ====TABLE 5 =====*/
	CREATE TABLE book_loans (
		book_LoansID INT PRIMARY KEY NOT NULL IDENTITY (1,1),
		book_ID INT NOT NULL CONSTRAINT fk_book_id1 FOREIGN KEY REFERENCES book(book_ID) ON UPDATE CASCADE ON DELETE CASCADE,
		branch_ID INT NOT NULL CONSTRAINT fk_branch_id1 FOREIGN KEY REFERENCES library_branch(library_branchID) ON UPDATE CASCADE ON DELETE CASCADE,
		book_CardNo INT NOT NULL CONSTRAINT fk_cardno FOREIGN KEY REFERENCES borrower(borrower_CardNo) ON UPDATE CASCADE ON DELETE CASCADE,
		book_DateOut VARCHAR(50) NOT NULL,
		book_DueDate VARCHAR(50) NOT NULL,
	);

	SELECT * FROM book_loans
		/* Use GETDATE() to retrieve the date values for Date out. Use DATEADD for the DueDate*/
	 
	/* ====TABLE 6 =====*/
	CREATE TABLE book_copies (
		copies_ID INT PRIMARY KEY NOT NULL IDENTITY (1,1),
		copies_BookID INT NOT NULL CONSTRAINT fk_book_id2 FOREIGN KEY REFERENCES book(book_ID) ON UPDATE CASCADE ON DELETE CASCADE,
		copies_BranchID INT NOT NULL CONSTRAINT fk_branch_id2 FOREIGN KEY REFERENCES library_branch(library_branchID) ON UPDATE CASCADE ON DELETE CASCADE,
		no_Of_Copies INT NOT NULL,
	);

	SELECT * FROM book_copies

	/* ====TABLE 7 =====*/
	CREATE TABLE book_authors (
		authorID INT PRIMARY KEY NOT NULL IDENTITY (1,1),
		authors_BookID INT NOT NULL CONSTRAINT fk_book_id3 FOREIGN KEY REFERENCES book(book_ID) ON UPDATE CASCADE ON DELETE CASCADE,
		authors_Name VARCHAR(50) NOT NULL,
	);

	SELECT * FROM book_authors

/*======================== END TABLES ======================*/


/*==================== INSERTING VALUES INTO TABLES ======================*/
	
	INSERT INTO publisher
		(publisher_Name, publisher_Address, publisher_Phone)
		VALUES
		('DAW Books','375 Hudson Street, New York, NY 10014','212-366-2000'),
		('Viking','375 Hudson Street, New York, NY 10014','212-366-2000'),
		('Signet Books','375 Hudson Street, New York, NY 10014','212-366-2000'),
		('Chilton Books','Not Available','Not Available'),
		('George Allen & Unwin','83 Alexander Ln, Crows Nest NSW 2065, Australia','+61-2-8425-0100'),
		('Alfred A. Knopf','The Knopf Doubleday Group Domestic Rights, 1745 Broadway, New York, NY 10019','212-940-7390'),		
		('Bloomsbury','Bloomsbury Publishing Inc., 1385 Broadway, 5th Floor, New York, NY 10018','212-419-5300'),
		('Shinchosa','Oga Bldg. 8, 2-5-4 Sarugaku-cho, Chiyoda-ku, Tokyo 101-0064 Japan','+81-3-5577-6507'),
		('Harper and Row','HarperCollins Publishers, 195 Broadway, New York, NY 10007','212-207-7000'),
		('Pan Books','175 Fifth Avenue, New York, NY 10010','646-307-5745'),
		('Chalto & Windus','375 Hudson Street, New York, NY 10014','212-366-2000'),
		('Harcourt Brace Jovanovich','3 Park Ave, New York, NY 10016','212-420-5800'),
		('W.W. Norton',' W. W. Norton & Company, Inc., 500 Fifth Avenue, New York, New York 10110','212-354-5500'),
		('Scholastic','557 Broadway, New York, NY 10012','800-724-6527'),
		('Bantam','375 Hudson Street, New York, NY 10014','212-366-2000'),
		('Picador USA','175 Fifth Avenue, New York, NY 10010','646-307-5745')		
	;

	SELECT * FROM publisher

	INSERT INTO book
		(book_Title, book_PublisherName)
		VALUES 
		('The Name of the Wind', 'DAW Books'),
		('It', 'Viking'),
		('The Green Mile', 'Signet Books'),
		('Dune', 'Chilton Books'),
		('The Hobbit', 'George Allen & Unwin'),
		('Eragon', 'Alfred A. Knopf'),
		('A Wise Mans Fear', 'DAW Books'),
		('Harry Potter and the Philosophers Stone', 'Bloomsbury'),
		('Hard Boiled Wonderland and The End of the World', 'Shinchosa'),
		('The Giving Tree', 'Harper and Row'),
		('The Hitchhikers Guide to the Galaxy', 'Pan Books'),
		('Brave New World', 'Chalto & Windus'),
		('The Princess Bride', 'Harcourt Brace Jovanovich'),
		('Fight Club', 'W.W. Norton'),
		('Holes', 'Scholastic'),
		('Harry Potter and the Chamber of Secrets', 'Bloomsbury'),
		('Harry Potter and the Prisoner of Azkaban', 'Bloomsbury'),
		('The Fellowship of the Ring', 'George Allen & Unwin'),
		('A Game of Thrones', 'Bantam'),
		('The Lost Tribe', 'Picador USA');

	SELECT * FROM book WHERE book_PublisherName = 'George Allen & Unwin'

	INSERT INTO library_branch
		(library_BranchName, library_BranchAddress)
		VALUES
		('Sharpstown','32 Corner Road, New York, NY 10012'),
		('Central','491 3rd Street, New York, NY 10014'),
		('Saline','40 State Street, Saline, MI 48176'),
		('Ann Arbor','101 South University, Ann Arbor, MI 48104');

	/*UPDATE library_branch
	SET library_BranchName = 'Central'
	WHERE library_BranchID = 2;*/
	
	SELECT * FROM library_branch

	INSERT INTO borrower
		(borrower_Name, borrower_Address, borrower_Phone)
		VALUES
		('Joe Smith','1321 4th Street, New York, NY 10014','212-312-1234'),
		('Jane Smith','1321 4th Street, New York, NY 10014','212-931-4124'),
		('Tom Li','981 Main Street, Ann Arbor, MI 48104','734-902-7455'),
		('Angela Thompson','2212 Green Avenue, Ann Arbor, MI 48104','313-591-2122'),
		('Harry Emnace','121 Park Drive, Ann Arbor, MI 48104','412-512-5522'),
		('Tom Haverford','23 75th Street, New York, NY 10014','212-631-3418'),
		('Haley Jackson','231 52nd Avenue New York, NY 10014','212-419-9935'),
		('Michael Horford','653 Glen Avenue, Ann Arbor, MI 48104','734-998-1513');
	
	SELECT * FROM borrower

	INSERT INTO book_loans
		(book_ID, branch_ID, book_CardNo, book_DateOut, book_DueDate)
		VALUES
		('1','1','100','1/1/18','2/2/18'),
		('2','1','100','1/1/18','2/2/18'),
		('3','1','100','1/1/18','2/2/18'),
		('4','1','100','1/1/18','2/2/18'),
		('5','1','102','1/3/18','2/3/18'),
		('6','1','102','1/3/18','2/3/18'),
		('7','1','102','1/3/18','2/3/18'),
		('8','1','102','1/3/18','2/3/18'),
		('9','1','102','1/3/18','2/3/18'),
		('11','1','102','1/3/18','2/3/18'),
		('12','2','105','12/12/17','1/12/18'),
		('10','2','105','12/12/17','1/12/17'),
		('20','2','105','2/3/18','3/3/18'),
		('18','2','105','1/5/18','2/5/18'),
		('19','2','105','1/5/18','2/5/18'),
		('19','2','100','1/3/18','2/3/18'),
		('11','2','106','1/7/18','2/7/18'),
		('1','2','106','1/7/18','2/7/18'),
		('2','2','100','1/7/18','2/7/18'),
		('3','2','100','1/7/18','2/7/18'),
		('5','2','105','12/12/17','1/12/18'),
		('4','3','103','1/9/18','2/9/18'),
		('7','3','102','1/3/18','2/3/18'),
		('17','3','102','1/3/18','2/3/18'),
		('16','3','104','1/3/18','2/3/18'),
		('15','3','104','1/3/18','2/3/18'),
		('15','3','107','1/3/18','2/3/18'),
		('14','3','104','1/3/18','2/3/18'),
		('13','3','107','1/3/18','2/3/18'),
		('13','3','102','1/3/18','2/3/18'),
		('19','3','102','12/12/17','1/12/18'),
		('20','4','103','1/3/18','2/3/18'),
		('1','4','102','1/12/18','2/12/18'),
		('3','4','107','1/3/18','2/3/18'),
		('18','4','107','1/3/18','2/3/18'),
		('12','4','102','1/4/18','2/4/18'),
		('11','4','103','1/15/18','2/15/18'),
		('9','4','103','1/15/18','2/15/18'),
		('7','4','107','1/1/18','2/2/18'),
		('4','4','103','1/1/18','2/2/18'),
		('1','4','103','2/2/17','3/2/18'),
		('20','4','103','1/3/18','2/3/18'),
		('1','4','102','1/12/18','2/12/18'),
		('3','4','107','1/13/18','2/13/18'),
		('18','4','107','1/13/18','2/13/18'),
		('12','4','102','1/14/18','2/14/18'),
		('11','4','103','1/15/18','2/15/18'),
		('9','4','103','1/15/18','2/15/18'),
		('7','4','107','1/19/18','2/19/18'),
		('4','4','103','1/19/18','2/19/18'),
		('1','4','103','1/22/18','2/22/18');
		
	SELECT * FROM book_loans

	INSERT INTO book_copies
		(copies_ID, copies_BranchID, no_Of_Copies)
		VALUES
		('1','1','5'),
		('2','1','5'),
		('3','1','5'),
		('4','1','5'),
		('5','1','5'),
		('6','1','5'),
		('7','1','5'),
		('8','1','5'),
		('9','1','5'),
		('10','1','5'),
		('11','1','5'),
		('12','1','5'),
		('13','1','5'),
		('14','1','5'),
		('15','1','5'),
		('16','1','5'),
		('17','1','5'),
		('18','1','5'),
		('19','1','5'),
		('20','1','5'),
		('1','2','5'),
		('2','2','5'),
		('3','2','5'),
		('4','2','5'),
		('5','2','5'),
		('6','2','5'),
		('7','2','5'),
		('8','2','5'),
		('9','2','5'),
		('10','2','5'),
		('11','2','5'),
		('12','2','5'),
		('13','2','5'),
		('14','2','5'),
		('15','2','5'),
		('16','2','5'),
		('17','2','5'),
		('18','2','5'),
		('19','2','5'),
		('20','2','5'),
		('1','3','5'),
		('2','3','5'),
		('3','3','5'),
		('4','3','5'),
		('5','3','5'),
		('6','3','5'),
		('7','3','5'),
		('8','3','5'),
		('9','3','5'),
		('10','3','5'),
		('11','3','5'),
		('12','3','5'),
		('13','3','5'),
		('14','3','5'),
		('15','3','5'),
		('16','3','5'),
		('17','3','5'),
		('18','3','5'),
		('19','3','5'),
		('20','3','5'),
		('1','4','5'),
		('2','4','5'),
		('3','4','5'),
		('4','4','5'),
		('5','4','5'),
		('6','4','5'),
		('7','4','5'),
		('8','4','5'),
		('9','4','5'),
		('10','4','5'),
		('11','4','5'),
		('12','4','5'),
		('13','4','5'),
		('14','4','5'),
		('15','4','5'),
		('16','4','5'),
		('17','4','5'),
		('18','4','5'),
		('19','4','5'),
		('20','4','5');

	SELECT * FROM book_copies
 

	INSERT INTO book_authors
		(authors_BookID,authors_Name)
		VALUES
		('1','Patrick Rothfuss'),
		('2','Stephen King'),
		('3','Stephen King'),
		('4','Frank Herbert'),
		('5','J.R.R. Tolkien'),
		('6','Christopher Paolini'),
		('6','Patrick Rothfuss'),
		('8','J.K. Rowling'),
		('9','Haruki Murakami'),
		('10','Shel Silverstein'),
		('11','Douglas Adams'),
		('12','Aldous Huxley'),
		('13','William Goldman'),
		('14','Chuck Palahniuk'),
		('15','Louis Sachar'),
		('16','J.K. Rowling'),
		('17','J.K. Rowling'),
		('18','J.R.R. Tolkien'),
		('19','George R.R. Martin'),
		('20','Mark Lee');

	SELECT * FROM book_authors
END
	/*============================== END POPULATING TABLES ==============================*/


/* =================== QUERY QUESTIONS =================================== */

/* #1- How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"? */

CREATE PROCEDURE dbo.bookCopiesAtAllSharpstown 
(@bookTitle varchar(70) = 'The Lost Tribe', @branchName varchar(70) = 'Sharpstown')
AS
SELECT copies.copies_BranchID AS [Branch ID], branch.library_BranchName AS [Branch Name],
	   copies.no_Of_Copies AS [Number of Copies],
	   book.book_Title AS [Book Title]
	   FROM book_copies AS copies
			INNER JOIN book AS book ON copies.copies_BookID = book.book_ID
			INNER JOIN library_branch AS branch ON copies_BranchID = branch.library_BranchID
	   WHERE book.book_Title = @bookTitle AND branch.library_BranchName = @branchName
GO
EXEC dbo.bookCopiesAtAllSharpstown 


/* #2- How many copies of the book titled "The Lost Tribe" are owned by each library branch? */

CREATE PROCEDURE dbo.bookCopiesAtAllBranches 
(@bookTitle varchar(70) = 'The Lost Tribe')
AS
SELECT copies.copies_BranchID AS [Branch ID], branch.library_BranchName AS [Branch Name],
	   copies.no_Of_Copies AS [Number of Copies],
	   book.book_Title AS [Book Title]
	   FROM book_copies AS copies
			INNER JOIN book AS book ON copies.copies_BookID = book.book_ID
			INNER JOIN library_branch AS branch ON copies_BranchID = branch.library_BranchID
	   WHERE book.book_Title = @bookTitle 
GO
EXEC dbo.bookCopiesAtAllBranches


/* #3- Retrieve the names of all borrowers who do not have any books checked out. */
		
CREATE PROCEDURE dbo.NoLoans
AS
SELECT borrower_Name FROM borrower
	WHERE NOT EXISTS
		(SELECT * FROM book_loans
		WHERE book_CardNo = borrower_CardNo)
GO
EXEC dbo.NoLoans

/* #4- For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today, retrieve the book title, the borrower's name, and the borrower's address.  */

CREATE PROCEDURE dbo.LoanersInfo 
(@DueDate date = NULL, @LibraryBranchName varchar(50) = 'Sharpstown')
AS
SET @DueDate = GETDATE()
SELECT Branch.library_BranchName AS [Branch Name],  Book.book_Title [Book Name],
	   Borrower.borrower_Name AS [Borrower Name], Borrower.borrower_Address AS [Borrower Address],
	   Loans.book_DateOut AS [Date Out], Loans.book_DueDate [Due Date]
	   FROM book_loans AS Loans
			INNER JOIN book AS Book ON Loans.book_ID = Book.book_ID
			INNER JOIN borrower AS Borrower ON Loans.book_CardNo = Borrower.borrower_CardNo
			INNER JOIN library_branch AS Branch ON Loans.branch_ID = Branch.library_BranchID
		WHERE Loans.book_DueDate = @DueDate AND Branch.library_BranchName = @LibraryBranchName
GO
EXEC dbo.LoanersInfo 

/* #5- For each library branch, retrieve the branch name and the total number of books loaned out from that branch.  */

CREATE PROCEDURE dbo.TotalLoansPerBranch
AS
SELECT  Branch.library_BranchName AS [Branch Name], COUNT (Loans.branch_ID) AS [Total Loans]
		FROM book_loans AS Loans
			INNER JOIN library_branch AS Branch ON Loans.branch_ID = Branch.library_BranchID
			GROUP BY library_BranchName
GO
EXEC dbo.TotalLoansPerBranch

/* #6- Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out. */

CREATE PROCEDURE dbo.BooksLoanedOut
(@BooksCheckedOut INT = 5)
AS
	SELECT Borrower.borrower_Name AS [Borrower Name], Borrower.borrower_Address AS [Borrower Address],
		   COUNT(Borrower.borrower_Name) AS [Books Checked Out]
		   FROM book_loans AS Loans
		   			INNER JOIN borrower AS Borrower ON Loans.book_CardNo = Borrower.borrower_CardNo
					GROUP BY Borrower.borrower_Name, Borrower.borrower_Address
		   HAVING COUNT(Borrower.borrower_Name) >= @BooksCheckedOut
GO
EXEC dbo.BooksLoanedOut



/* #7- For each book authored by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central".*/

CREATE PROCEDURE dbo.BookbyAuthorandBranch
	(@BranchName varchar(50) = 'Central', @AuthorName varchar(50) = 'Stephen King')
AS
	SELECT Branch.library_BranchName AS [Branch Name], Book.book_Title AS [Title], Copies.no_Of_Copies AS [Number of Copies]
		   FROM book_authors AS Authors
				INNER JOIN book AS Book ON Authors.authors_BookID = Book.book_ID
				INNER JOIN book_copies AS Copies ON Authors.authors_BookID = Copies.copies_BookID
				INNER JOIN library_branch AS Branch ON Copies.copies_BranchID = Branch.library_BranchID
			WHERE Branch.library_BranchName = @BranchName AND Authors.authors_Name = @AuthorName
GO	
EXEC dbo.BookbyAuthorandBranch

/* ==================================== QUERY QUESTIONS =================================== */
