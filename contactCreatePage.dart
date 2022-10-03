import 'package:flutter/material.dart';

import 'contactForm.dart';

class contactCreatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: dead_code
    return Scaffold(
        appBar: AppBar(
          title: Text('Create'),
        ),
        body: contactForm());
  }
}
