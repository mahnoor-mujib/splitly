class AppUser {
  final String id;
  final String email;
  final String? name;
  final String? phone;
  final String currency;

  const AppUser({
    required this.id,
    required this.email,
    this.name,
    this.phone,
    this.currency = 'Rs.',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'currency': currency,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'] as String,
      email: map['email'] as String,
      name: map['name'] as String?,
      phone: map['phone'] as String?,
      currency: map['currency'] as String? ?? 'Rs.',
    );
  }
}