import 'dart:io';

class Contactss {
  int? id;
  String name;
  String email;
  String phoneNumber;
  bool isFavorite;
  File? imageFile;

  Contactss({
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.isFavorite = false,
    this.imageFile,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'isFavorite': isFavorite ? 1 : 0,
      // cant store file objects with sembest,
      //thats why we store the path only.
      'imageFilePath': imageFile?.path,
    };
  }

// we need static function to
  static Contactss fromMap(Map<String, dynamic> map) {
    return Contactss(
      name: map['name'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      isFavorite: map['isFavorite'] == 1 ? true : false,
      //if theres an imagefilepath, convert it to file
      // otherwise set imagefile to be null.
      imageFile:
          map['imageFilePath'] != null ? File(map['imageFilePath']) : null,
    );
  }
}
