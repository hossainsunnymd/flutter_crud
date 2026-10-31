import '../models/user.dart';

class UserService {
  final List<User> _users = [
    const User(
      id: 1,
      name: 'Rahim',
      email: 'rahim@gmail.com',
      Phone: '01700000000',
),
    const User(
      id: 2,
      name: 'Karim',
      email: 'karim@gmail.com',
      Phone: '01800000000',
    ),
  ];

  int _nextId = 3;

  // Read
  List<User> getUsers() {
    return List.unmodifiable(_users);
  }

  // Create
  void addUser(User user) {
    final newUser = User(
      id: _nextId++,
      name: user.name,
      email: user.email,
      Phone: user.Phone,
    );

    _users.add(newUser);
  }

  // Update
  void updateUser(User updatedUser) {
    final index = _users.indexWhere(
      (user) => user.id == updatedUser.id,
    );

    if (index == -1) return;

    _users[index] = updatedUser;
  }

  // Delete
  void deleteUser(int id) {
    _users.removeWhere((user) => user.id == id);
  }
}