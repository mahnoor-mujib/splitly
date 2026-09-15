class WishlistItem {
  final String id;
  final String name;
  final String category;
  final double price;
  final DateTime? deadline;
  final bool isReserved;

  const WishlistItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    this.deadline,
    this.isReserved = false,
  });

  WishlistItem copyWith({
    String? id,
    String? name,
    String? category,
    double? price,
    DateTime? deadline,
    bool? isReserved,
  }) {
    return WishlistItem(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      deadline: deadline ?? this.deadline,
      isReserved: isReserved ?? this.isReserved,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'deadline': deadline?.millisecondsSinceEpoch,
      'isReserved': isReserved ? 1 : 0,
    };
  }

  factory WishlistItem.fromMap(Map<String, dynamic> map) {
    return WishlistItem(
      id: map['id'] as String,
      name: map['name'] as String,
      category: map['category'] as String,
      price: (map['price'] as num).toDouble(),
      deadline: map['deadline'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['deadline'] as int),
      isReserved: (map['isReserved'] as int) == 1,
    );
  }
}