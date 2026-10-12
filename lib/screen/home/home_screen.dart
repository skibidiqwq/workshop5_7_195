import 'package:flutter/material.dart';
import 'widgets/item_contact.dart';
import '../add-contact/add_contact_screen.dart';
import '../../repository/contact_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("📞 สมุดบันทึกรายชื่อ"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: () => setState(() {})),
        ],
      ),

      body: FutureBuilder(
        future: ContactRepository.getContacts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.contacts, size: 80, color: Colors.grey),
                  SizedBox(height: 10),
                  Text("📭 ยังไม่มีรายชื่อ", style: TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(14),
              itemCount: snapshot.data!.length,
              itemBuilder: (_, i) => ItemContact(contact: snapshot.data![i]),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddContactScreen()))
            .then((_) => setState(() {})),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.person_add),
        label: const Text("เพิ่มรายชื่อ"),
      ),
    );
  }
}