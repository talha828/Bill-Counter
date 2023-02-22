class Product {
  final String name;
  final int? quantity;
  final double? value;

  Product(
      this.name,
      this.quantity,
      this.value,
      );

  @override
  String toString() {
    return "Product{Name: $name, Quantity: $quantity, Value: $value}";
  }
}