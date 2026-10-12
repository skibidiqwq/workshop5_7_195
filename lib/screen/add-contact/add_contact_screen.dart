import 'package:flutter/material.dart';
import '../../models/contact.dart';
import '../../repository/contact_repository.dart';

class AddContactScreen extends StatefulWidget {
  final Contact? contact;
  const AddContactScreen({super.key, this.contact});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  String _selectedGroup = 'เพื่อน';
  final List<String> _groups = ['ครอบครัว', 'เพื่อน', 'เพื่อนร่วมงาน', 'อื่นๆ'];

  @override
  void initState() {
    super.initState();
    if (widget.contact != null) {
      _nameCtrl.text = widget.contact!.name;
      _phoneCtrl.text = widget.contact!.phone;
      _selectedGroup = widget.contact!.contactGroup;
    }
  }

  Future<void> _saveContact() async {
    if (_nameCtrl.text.isEmpty || _phoneCtrl.text.isEmpty) return;

    if (widget.contact == null) {
      await ContactRepository.insert(Contact(
        name: _nameCtrl.text,
        phone: _phoneCtrl.text,
        contactGroup: _selectedGroup,
        createdAt: DateTime.now(),
      ));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ บันทึกรายชื่อสำเร็จ!")),
        );
        Navigator.pop(context);
      }
    } else {
      await ContactRepository.update(Contact(
        id: widget.contact!.id,
        name: _nameCtrl.text,
        phone: _phoneCtrl.text,
        contactGroup: _selectedGroup,
        createdAt: widget.contact!.createdAt,
      ));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ แก้ไขสำเร็จ!")),
        );
        Navigator.pop(context);
      }
    }
  }

  Future<void> _deleteContact() async {
    await ContactRepository.delete(widget.contact!);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contact == null ? "➕ เพิ่มรายชื่อใหม่" : "✏️ แก้ไขรายชื่อ"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          if (widget.contact != null)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.white),
              onPressed: () => showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("⚠️ ยืนยันการลบ"),
                  content: const Text("ต้องการลบรายชื่อนี้ใช่หรือไม่?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("ไม่"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _deleteContact();
                      },
                      child: const Text("ใช่", style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              ),
            ),
          IconButton(
            icon: const Icon(Icons.check_circle, size: 28),
            onPressed: _saveContact,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("👤 ชื่อ-นามสกุล", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(
                hintText: "กรอกชื่อ...",
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
              ),
            ),
            const SizedBox(height: 16),
            const Text("📱 เบอร์โทรศัพท์", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            TextField(
              controller: _phoneCtrl,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: "กรอกเบอร์โทร...",
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
              ),
            ),
            const SizedBox(height: 16),
            const Text("🏷️ กลุ่มความสัมพันธ์", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            DropdownButtonFormField(
              value: _selectedGroup,
              decoration: const InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)))),
              items: _groups.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
              onChanged: (v) => setState(() => _selectedGroup = v!),
            ),
          ],
        ),
      ),
    );
  }
}