class Coffee {
  final String name;
  final String price;
  final String imageUrl;
  late final int quantity;
  Coffee(
      {required this.name,
      required this.price,
      required this.imageUrl,
      this.quantity = 1});
}
