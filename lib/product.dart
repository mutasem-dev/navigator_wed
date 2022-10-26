class Product{
  String name;
  double price;
  int quantity;

  Product({required this.name,required this.price,required this.quantity});

  @override
  String toString() {
    return 'Product{name: $name, price: $price, quantity: $quantity}';
  }
}