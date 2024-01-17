class DishModel {
  final int id;
  final String name;
  final String imageUrl;
  final int price;
  final int type;
  final int unit;

  DishModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.imageUrl,
      required this.unit,
      required this.type});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': name,
      'unit': unit,
      'price': price,
      'imageUrl': imageUrl,
      'type': type
    };
  }

  static DishModel fromJson(Map<String, dynamic> dishJson) {
    return DishModel(
      id: dishJson['id'],
      name: dishJson['name'],
      price: dishJson['price'],
      imageUrl: dishJson['imageUrl'],
      type: dishJson['type'],
      unit: dishJson['unit'],
    );
  }
}
