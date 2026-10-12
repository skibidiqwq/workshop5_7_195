class Contact {
  int? id;
  String name;
  String phone;
  String contactGroup;
  DateTime createdAt;

  Contact({
    this.id,
    required this.name,
    required this.phone,
    required this.contactGroup,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'contactGroup': contactGroup,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  static Contact fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      contactGroup: map['contactGroup'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}