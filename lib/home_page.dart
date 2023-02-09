import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:order_app_objectbox/main.dart';

import 'model/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //load users from objectbox
  late Stream<List<User>> streamUsers;

  @override
  void initState() {
    super.initState();

    streamUsers = objectBox.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ObjectBox"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: StreamBuilder<List<User>>(
        stream: streamUsers,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final users = snapshot.data!;

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];

                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          //create a new user with a faker
          final user = User(
            name: Faker().person.firstName(),
            email: Faker().internet.email(),
          );
          //insert user to objectbox
          objectBox.insertUser(user);
        },
      ),
    );
  }
}
