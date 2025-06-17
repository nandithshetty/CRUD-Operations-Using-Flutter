import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart'; // Make sure this path is correct

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = TextEditingController();
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  String documentId = "demo-user";
  String names = "";

  void createData() {
    users.doc(documentId).set({"name": controller.text.toString()});
    controller.clear();
  }

  void readData() async {
    DocumentSnapshot doc = await users.doc(documentId).get();
    if (doc.exists) {
      setState(() {
        names = doc['name'];
      });
    } else {
      setState(() {
        names = "No data found";
      });
    }
  }

  void updateData() {
    users.doc(documentId).update({"name": controller.text});
  }

  void deleteData() {
    users.doc(documentId).delete();
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: logout,
          )
        ],
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                names,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: "Enter Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: [
                  ElevatedButton(onPressed: createData, child: const Text("Create")),
                  ElevatedButton(onPressed: updateData, child: const Text("Update")),
                  ElevatedButton(onPressed: readData, child: const Text("Read")),
                  ElevatedButton(onPressed: deleteData, child: const Text("Delete")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
