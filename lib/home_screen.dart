import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_firebase_auth_project/auth_service.dart';
import 'package:flutter_application_firebase_auth_project/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  final String? userId;
  const HomeScreen({super.key, required this.userId});

  void signOut(BuildContext context) async {
    AuthService authService = AuthService();

    final SharedPreferences preferences = await SharedPreferences.getInstance();

    await authService.signOut();

    await preferences.remove("user");

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SignInScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _todoController = TextEditingController();
    final user = FirebaseAuth.instance.currentUser;

    void _addTodo() {
      if (_todoController.text.isNotEmpty) {
        FirebaseFirestore.instance.collection('todos').add({
          'userId': user?.uid,
          'title': _todoController.text,
          'completed': false,
          'createdAt': Timestamp.now(),
        });
        _todoController.clear();
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Todo with firebase",
          style: TextStyle(color: Colors.green[400]),
        ),
        actions: [
          IconButton(
              onPressed: () {
                signOut(context);
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("todos")
                .where('userId', isEqualTo: userId!)
                .orderBy("createdAt", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              var todos = snapshot.data!.docs;
              return ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  var todo = todos[index];
                  return ListTile(
                    title: Text(todo["title"]),
                    trailing: Checkbox(
                      value: todo["completed"],
                      onChanged: (value) {
                        FirebaseFirestore.instance
                            .collection("todos")
                            .doc(todo.id)
                            .update({"completed": value});
                      },
                    ),
                  );
                },
              );
            },
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Add to-do"),
                content: TextField(
                  controller: _todoController,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      _addTodo();
                      Navigator.pop(context);
                    },
                    child: Text("Add"),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
