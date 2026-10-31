import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services/user_service.dart';
import '../widgets/user_card.dart';
import '../widgets/user_form_dialog.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final UserService _userService = UserService();

  late List<User> _users;

  @override
  void initState() {
    super.initState();

    _users = _userService.getUsers();
  }

  // Create & Update
  Future<void> openUserForm({User? user}) async {
    final result = await showDialog<User>(
      context: context,
      builder: (context) {
        return UserFormDialog(user: user);
      },
    );

    if (!mounted || result == null) return;

    setState(() {
      if (user == null) {
        _userService.addUser(result);
      } else {
        _userService.updateUser(result);
      }

      _users = _userService.getUsers();
    });
  }

  // Delete
  Future<void> deleteUser(User user) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete User'),
          content: Text('Delete ${user.name}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (!mounted || confirm != true) return;

    setState(() {
      _userService.deleteUser(user.id);
      _users = _userService.getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
        centerTitle: true,
      ),

      body: _users.isEmpty
          ? const Center(
              child: Text('No users found'),
            )
          : ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];

                return UserCard(
                  user: user,
                  onEdit: () => openUserForm(user: user),
                  onDelete: () => deleteUser(user),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => openUserForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}