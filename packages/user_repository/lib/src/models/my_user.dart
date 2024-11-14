import 'package:equatable/equatable.dart';
import 'package:user_repository/src/entities/my_user_entity.dart';

class MyUser extends Equatable {
  final String id;
  final String name;
  final String email;
  final int phone;
  final String address;
  final String county;

  const MyUser(
      {required this.address,
      required this.county,
      required this.email,
      required this.phone,
      required this.id,
      required this.name});
  static const empty =
      MyUser(address: '', county: '', email: '', phone: 0, id: '', name: '');
  MyUser copyWith({
    String? id,
    String? name,
    String? email,
    int? phone,
    String? address,
    String? county,
  }) {
    return MyUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      county: county ?? this.county,
    );
  }

  bool get isEmpty => this == MyUser.empty;
  bool get isNotEmpty => this != MyUser.empty;

  MyUserEntity toEntity() {
    return MyUserEntity(
      id: id,
      name: name,
      email: email,
      phone: phone,
      address: address,
      county: county,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      phone: entity.phone,
      address: entity.address,
      county: entity.county,
    );
  }

  @override
  List<Object?> get props => [];
}
