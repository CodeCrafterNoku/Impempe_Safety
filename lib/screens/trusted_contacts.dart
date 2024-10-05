/*
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class TrustedContactsScreen extends StatefulWidget {
  @override
  _TrustedContactsScreenState createState() => _TrustedContactsScreenState();
}

class _TrustedContactsScreenState extends State<TrustedContactsScreen> {
  List<Contact> _contacts = [];
  List<Map<String, String>> _trustedContacts = [];

  Future<void> _loadContacts() async {
    var contacts = await _contacts;
    setState(() {
      _contacts = contacts.toList();
    });
  }

  void _addTrustedContact(Contact contact, String email, String relationship) {
    setState(() {
      _trustedContacts.add({
        "name": contact.displayName ?? "",
        "email": email,
        "relationship": relationship,
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Trusted Contacts"),
      ),
      body: ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (context, index) {
          Contact contact = _contacts[index];
          return ListTile(
            title: Text(contact.displayName ?? "Unknown"),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  String email = '';
                  String relationship = '';
                  return AlertDialog(
                    title: Text("Add ${contact.displayName} as a Trusted Contact"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          decoration: InputDecoration(labelText: "Email"),
                          onChanged: (value) => email = value,
                        ),
                        TextField(
                          decoration: InputDecoration(labelText: "Relationship"),
                          onChanged: (value) => relationship = value,
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          _addTrustedContact(contact, email, relationship);
                          Navigator.pop(context);
                        },
                        child: Text("Add"),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
*/
