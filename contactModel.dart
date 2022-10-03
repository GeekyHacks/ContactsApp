import 'package:contact_app/data/contact.dart';
import 'package:contact_app/data/contactDao.dart';

import 'package:scoped_model/scoped_model.dart';

class contactModel extends Model {
  final ContactDao _contactDao = ContactDao();

  List<Contactss>? _contacts;
  // shows the loading indicator
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  // we dont need these listing finctions cause contactdao does that
  /*= List.generate(
    6,
    ((index) {
      return Contactss(
        name: faker.Person(faker.RandomGenerator()).firstName() +
            ' ' +
            faker.Person(faker.RandomGenerator()).lastName(),
        email: faker.Internet(faker.RandomGenerator()).freeEmail(),
        phoneNumber: faker.RandomGenerator().integer(1000000).toString(),
      );
    }),
  );*/
// this make sure to not overwrite contacts from different classes
  List<Contactss> get contacts => _contacts!;

  Future loadContactss() async {
    _isLoading = true;
    notifyListeners();
    _contacts = await _contactDao.getAllInSortedOrder();
    _isLoading = false;
    notifyListeners();
  }

  Future addContact(Contactss contact) async {
    await _contactDao.insert(contact);
    await loadContactss();
    notifyListeners();
  }

  Future updateContact(Contactss contact) async {
    await _contactDao.updatee(contact);
    await loadContactss();
    notifyListeners();
  }

  Future deleteContact(Contactss contact) async {
    await _contactDao.deletee(contact);
    await loadContactss();
    notifyListeners();
  }

  Future changeFavoriteStatus(Contactss contact) async {
    contact.isFavorite = !contact.isFavorite;
    await _contactDao.updatee(contact);
    _contacts = await _contactDao.getAllInSortedOrder();
    notifyListeners();
  }

// we dont need these sorting finctions cause contactdao does that

  /*void _sortContacts() {
    _contacts.sort((a, b) {
      int comperisonResult;
      comperisonResult = _compareBasedOnFavoriteStatus(a, b);

      if (comperisonResult == 0) {
        comperisonResult = _compareAlphabetically(a, b);
      }

      return comperisonResult;
    });
  }

  int _compareAlphabetically(Contactss a, Contactss b) {
    return a.name.compareTo(b.name);
  }

  int _compareBasedOnFavoriteStatus(Contactss a, Contactss b) {
    if (a.isFavorite) {
      return -1; // contactone will
      //be before contacttwo
    } else if (b.isFavorite) {
      return 1; //contactone will be after contacttwo
    } else {
      return 0; //the postions doesnt change
    }
  }*/
}
