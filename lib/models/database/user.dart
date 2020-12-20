import 'package:meta/meta.dart';

class User {
  // Id will be gotten from the database.
  // It's automatically generated & unique for every stored Fruit.
  int id;

  final String userId;
  final String profileId;
  final String profileName;
  final int active;

  User({
    @required this.userId,
    @required this.profileId,
    @required this.profileName,
    @required this.active,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'profileId': profileId,
      'profileName': profileName,
      'active': active,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['name'],
      profileId: map['profileId'],
      profileName: map['profileName'],
      active: map['active'],
    );
  }
}
