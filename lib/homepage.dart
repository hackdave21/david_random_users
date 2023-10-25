import 'package:flutter/material.dart';

import 'database/database.dart';
import 'model/userModel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    _loadUsersFromDatabase();
  }

  Future<void> _loadUsersFromDatabase() async {
    List<Map<String, dynamic>> maps = await DatabaseHelper().query('users');

    setState(() {
      users = List.generate(maps.length, (i) {
        return User.fromMap(maps[i]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users List'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          User user = users[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user.picture),
              ),
              title: Text(user.name),
              subtitle: Text(user.email),
              trailing: user.favorite
                  ? Icon(Icons.star, color: Colors.yellow)
                  : Icon(Icons.star_border),
            ),
          );
        },
      ),
    );
  }
}
