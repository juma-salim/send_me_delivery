import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final int phone;
  final String address;
  final String county;

  const MyUserEntity(
      {required this.address,
      required this.county,
      required this.email,
      required this.phone,
      required this.id,
      required this.name});

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'county': county,
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      id: doc['id'],
      name: doc['name'],
      email: doc['email'],
      phone: doc['phone'],
      address: doc['address'],
      county: doc['county'],
    );
  }

  @override
  List<Object?> get props => [id, name, email, phone, address, county];

  String toString() {
    return '''MyUserEntity { id: $id, name: $name, email: $email, phone: $phone, address: $address, county: $county }''';
  }
}
