// ignore_for_file: deprecated_member_u, deprecated_member_use
/*@override
  void initState() {
    super.initState();

    _contactImageFile = widget.editedContact?.imageFile;
  }



   Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'isFavorite': isFavorite,
      'imageFile': imageFile,
      //'imageFilePath': imageFilePath,
    };
  }
   */
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:contact_app/data/contact.dart';

import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'contactModel.dart';

class contactForm extends StatefulWidget {
  final Contactss? editedContact;

  contactForm({
    Key? key,
    this.editedContact,
  }) : super(key: key);

  _contactFormEstate createState() => _contactFormEstate();
}

class _contactFormEstate extends State<contactForm> {
  final _formKey = GlobalKey<FormState>();

  File? _contactImageFile;
  late String? _name;
  late String? _email;
  late String? _phoneNumber;

  bool get isEditMode => widget.editedContact != null;
  bool get hasSelectedCustomImage => _contactImageFile != null;

  @override
  void initState() {
    super.initState();

    _contactImageFile = widget.editedContact?.imageFile;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          const SizedBox(height: 8),
          _buildContactPicture(),
          const SizedBox(height: 10),
          TextFormField(
            onSaved: (value) => _name = value,
            validator: (value) => _validateName(value!),
            initialValue: widget.editedContact?.name,
            decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                )),
          ),
          const SizedBox(height: 8),
          TextFormField(
            onSaved: (value) => _email = value,
            validator: (value) => _validateEmail(value.toString()),
            initialValue: widget.editedContact?.email,
            decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                )),
          ),
          const SizedBox(height: 8),
          TextFormField(
            onSaved: (value) => _phoneNumber = value,
            validator: (value) => _validatePhoneNumber(value.toString()),
            initialValue: widget.editedContact?.phoneNumber,
            decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                )),
          ),
          const SizedBox(height: 8),
          RaisedButton(
            elevation: 12,
            onPressed: _onSaveContactButtonPressed,
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 55),
                  Text('SAVE CONTACT'),
                  Icon(
                    Icons.person,
                    size: 28,
                  )
                ]),
          )
        ],
      ),
    );
  }

  Widget _buildContactPicture() {
    final halfScreenDiameter = MediaQuery.of(context).size.width / 3;
    return Hero(
      tag: widget.editedContact?.hashCode ?? 0,
      child: GestureDetector(
        onTap: _onContactPictureTapped,
        child: CircleAvatar(
          radius: halfScreenDiameter / 2,
          child: _buildCircleAvatarContent(halfScreenDiameter),
        ),
      ),
    );
  }

  void _onContactPictureTapped() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    final File imageFile = File(image!.path);

    setState(() {
      _contactImageFile = imageFile;
    });
  }

//show a person icon in create contact window instead of first contact letter
  Widget _buildCircleAvatarContent(double halfScreenDiameter) {
    if (isEditMode || hasSelectedCustomImage) {
      return _buildEditModeCircleAvatarContent(halfScreenDiameter);
    } else {
      return Icon(
        Icons.person,
        size: halfScreenDiameter / 2,
      );
    }
  }

  Widget _buildEditModeCircleAvatarContent(double halfScreenDiameter) {
    if (_contactImageFile == null) {
      return Text(
        widget.editedContact!.name[0],
        style: TextStyle(fontSize: halfScreenDiameter / 2),
      );
    } else {
      return ClipOval(
        child: AspectRatio(
            aspectRatio: 1,
            child: Image.file(
              _contactImageFile!,
              fit: BoxFit.cover,
            )),
      );
    }
  }

  String? _validateName(String value) {
    if (value.isEmpty) {
      return 'Enter a name';
    } else {
      return null;
    }
  }

  String? _validatePhoneNumber(String value) {
    final phoneRegex = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
    if (value.isEmpty) {
      return 'Enter a phone number';
    } else if (!phoneRegex.hasMatch(value)) {
      return 'Enter your phone number';
    }
    return null;
  }

  String? _validateEmail(String value) {
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value.isEmpty) {
      return 'Enter an email';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Enter a vaild email';
    }
    return null;
  }

  void _onSaveContactButtonPressed() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      final newOrEditedContact = Contactss(
        name: (_name.toString()),
        email: (_email.toString()),
        phoneNumber: (_phoneNumber.toString()),
        isFavorite: widget.editedContact?.isFavorite ?? false,
        imageFile: _contactImageFile,
      );

      if (isEditMode) {
        //Id doesnt change after updating other contact fields
        newOrEditedContact.id = widget.editedContact?.id;
        ScopedModel.of<contactModel>(context).updateContact(newOrEditedContact);
      } else {
        ScopedModel.of<contactModel>(context).addContact(newOrEditedContact);
      }

      Navigator.of(context).pop();
    }
  }
}
