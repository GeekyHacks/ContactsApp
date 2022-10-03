// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:contact_app/UI/Contact_List/contactCreatePage.dart';
import 'package:contact_app/UI/Contact_List/contactModel.dart';
import 'package:flutter/material.dart';

import 'package:contact_app/UI/Contact_List/contact_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactsListPage extends StatefulWidget {
  const ContactsListPage({Key? key}) : super(key: key);

  @override
  State<ContactsListPage> createState() => _ContactsListPageState();
}

class _ContactsListPageState extends State<ContactsListPage> {
  // ignore: prefer_final_fields

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Contacts')),
        body: ScopedModelDescendant<contactModel>(
            builder: (context, child, model) {
          if (model.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: model.contacts.length,
              itemBuilder: (context, index) {
                return contactTile(
                  contactIndex: index,
                );
              },
            );
          }
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: (() {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => contactCreatePage()));
          }),
          child: Icon(Icons.person_add),
        )); //build function changes everytime you reset state
    //function unlike initstate which only changes once
  }
}
