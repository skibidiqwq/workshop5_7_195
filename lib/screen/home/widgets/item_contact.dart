import 'package:flutter/material.dart';
import '../../../models/contact.dart';
import '../../add-contact/add_contact_screen.dart';

class ItemContact extends StatelessWidget {
  final Contact contact;
  const ItemContact({super.key, required this.contact});

  Color get groupColor {
    switch (contact.contactGroup) {
      case 'ครอบครัว': return Colors.red;
      case 'เพื่อน': return Colors.blue;
      case 'เพื่อนร่วมงาน': return Colors.green;
      case 'อื่นๆ': return Colors.orange;
      default: return Colors.grey;
    }
  }

  IconData get groupIcon {
    switch (contact.contactGroup) {
      case 'ครอบครัว': return Icons.home;
      case 'เพื่อน': return Icons.sentiment_satisfied;
      case 'เพื่อนร่วมงาน': return Icons.work;
      case 'อื่นๆ': return Icons.person;
      default: return Icons.person;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => AddContactScreen(contact: contact)),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: groupColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade200, blurRadius: 4, offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: groupColor,
              foregroundColor: Colors.white,
              radius: 26,
              child: Text(
                contact.name.isNotEmpty ? contact.name[0].toUpperCase() : '?',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          contact.name,
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: groupColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(groupIcon, size: 13, color: groupColor),
                            const SizedBox(width: 4),
                            Text(contact.contactGroup, style: TextStyle(color: groupColor, fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.phone, size: 16, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text(contact.phone, style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}