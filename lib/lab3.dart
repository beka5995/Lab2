class Book {
  String title;
  String author;
  double price;
  bool isBorrowed;

  Book(this.title, this.author, this.price, {this.isBorrowed = false});

  @override
  String toString() => "'$title' by $author";
}

class Library {
  final List<Book> _books = [];

  void addBook(Book book) => _books.add(book);

  List<Book> getAvailableBooks() {
    return _books.where((book) => !book.isBorrowed).toList();
  }

  double getTotalValue() {
    return _books.fold(0.0, (sum, book) => sum + book.price);
  }
}

void main() {
  var library = Library();

  library.addBook(Book('Dart Basics', 'John Doe', 15.50));
  library.addBook(Book('Advanced Flutter', 'Jane Smith', 25.00, isBorrowed: true));
  library.addBook(Book('Clean Architecture', 'Uncle Bob', 30.00));

  print('Available books: ${library.getAvailableBooks()}');
  print('Total collection value: \$${library.getTotalValue()}');
}