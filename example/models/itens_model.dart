class ItemModel {
  ItemModel({
    required this.name,
    required this.price,
    required this.icon,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      name: json['name'] as String,
      price: json['price'] as double,
      icon: IconModel.fromJson(
        json['icon'] as Map<String, dynamic>,
      ),
    );
  }

  final String name;
  final double price;
  final IconModel icon;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'icon': icon.toJson(),
    };
  }
}

class IconModel {
  IconModel({
    required this.id,
    required this.fileName,
  });

  factory IconModel.fromJson(Map<String, dynamic> json) {
    return IconModel(
      id: json['id'] as int,
      fileName: json['fileName'] as String,
    );
  }

  final int id;
  final String fileName;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fileName': fileName,
    };
  }
}
