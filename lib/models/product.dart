class Product {
  final String id;
  final String name;
  final double price;
  final String image;
  final String category;
  final double rating;
  final int reviews;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.category,
    this.rating = 4.8,
    this.reviews = 50,
  });
}
