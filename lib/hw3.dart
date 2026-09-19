abstract class MediaItem {
  String id;
  String title;
  double price;

  MediaItem(this.id, this.title, this.price);

  String getDetails();
}

mixin Downloadable {
  void download(String title) {
    print('Downloading: $title...');
  }
}

class Audiobook extends MediaItem with Downloadable {
  double durationHours;
  String narrator;

  Audiobook(super.id, super.title, super.price, this.durationHours, this.narrator);

  @override
  String getDetails() => 'Audiobook: $title ($durationHours h), Narrator: $narrator - \$${price}';
}

class EBook extends MediaItem with Downloadable {
  double fileSizeMB;
  String author;

  EBook(super.id, super.title, super.price, this.fileSizeMB, this.author);

  @override
  String getDetails() => 'EBook: $title ($fileSizeMB MB), Author: $author - \$${price}';
}

class ShoppingCart {
  final List<MediaItem> _items = [];

  void addItem(MediaItem item) => _items.add(item);

  double calculateTotalWithTax({double taxRate = 0.12}) {
    double subtotal = _items.fold(0.0, (sum, item) => sum + item.price);
    return subtotal + (subtotal * taxRate);
  }

  List<MediaItem> filterByMaxPrice(double maxPrice) {
    return _items.where((item) => item.price <= maxPrice).toList();
  }

  void printReceipt() {
    print('Receipt');
    for (var item in _items) {
      print(item.getDetails());
      if (item is Downloadable) {
        (item as Downloadable).download(item.title);
      }
    }
    print('Total (with 12% tax): \$${calculateTotalWithTax()}');
  }
}

void main() {
  var cart = ShoppingCart();

  cart.addItem(EBook('1', 'Flutter UI', 15.0, 5.2, 'Alice'));
  cart.addItem(Audiobook('2', 'Dart Mastery', 20.0, 10.5, 'Bob'));

  cart.printReceipt();

  print('\n Items under \$18');
  for (var item in cart.filterByMaxPrice(18.0)) {
    print(item.title);
  }
}