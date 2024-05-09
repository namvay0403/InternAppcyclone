import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../models/users.dart';

class UserBloc {
  final _userController = BehaviorSubject<List<User>>();

  Stream<List<User>> get users => _userController.stream;

  void changeUsers(List<User> users) {
    _userController.sink.add(users);
  }

  void dispose() {
    _userController.close();
  }

  Future<void> fetchUsers() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as List;
      List<User> users = [];
      for (var user in jsonResponse) {
        users.add(User.fromJson(user));
      }

      changeUsers(users);
      print(users.toString());
    } else {
      throw Exception('Failed to load users');
    }
  }
}
