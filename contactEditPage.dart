import 'package:contact_app/data/contact.dart';
import 'package:flutter/material.dart';

import 'contactForm.dart';

class contactEditPage extends StatelessWidget {
  final Contactss? editedContact;

  contactEditPage({
    key,
    required this.editedContact,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
      ),
      body: contactForm(
        editedContact: editedContact,
      ),
    );
  }
}
