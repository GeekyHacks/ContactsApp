import 'package:contact_app/UI/Contact_List/Contact_List_Page.dart';

import 'package:contact_app/UI/Contact_List/contactModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:contact_app/data/app_database.dart';

void main() {
  runApp(const MyApp());

  ;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /*scoped model widget will make sure that can access the contactmodel
    anywhere down the widget tree, this is possible because flutter 
    inheritedwidget*/
    return ScopedModel(
      /*load all contacts from database as soon as the app starts*/
      model: contactModel()..loadContactss(),
      child: MaterialApp(
        title: 'Contacts',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ContactsListPage(),
      ),
    );
  }
}
