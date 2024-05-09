import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  String? id;
  String? email;
  String? displayName;
  String? photoURL;
  String? phoneNumber;
  String? country;

  UserModel(
      {this.phoneNumber = '1234567890',
      this.id = 'ID',
      this.email = 'Email',
      this.displayName = 'Name',
      this.photoURL = 'Photo',
      this.country = 'Country'});

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 'ID',
        email = json['email'] ?? 'Email',
        displayName = json['displayName'] ?? 'Name',
        photoURL = json['photoURL'] ?? 'Photo',
        phoneNumber = json['phoneNumber'] ?? 'Phone',
        country = json['country'] ?? 'Country';

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'displayName': displayName,
        'photoURL': photoURL,
        'phoneNumber': phoneNumber,
        'country': country,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [id, email, displayName, photoURL, phoneNumber];


}
