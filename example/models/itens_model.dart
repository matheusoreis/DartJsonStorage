class ItemModel {
  final String name;
  final double price;
  final IconModel icon;

  ItemModel({
    required this.name,
    required this.price,
    required this.icon,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'icon': icon.toJson(),
    };
  }

  static ItemModel fromJson(Map<String, dynamic> json) {
    return ItemModel(
      name: json['name'],
      price: json['price'],
      icon: IconModel.fromJson(
        json['icon'],
      ),
    );
  }
}

class IconModel {
  final int id;
  final String fileName;

  IconModel({
    required this.id,
    required this.fileName,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fileName': fileName,
    };
  }

  static IconModel fromJson(Map<String, dynamic> json) {
    return IconModel(
      id: json['id'],
      fileName: json['fileName'],
    );
  }
}
