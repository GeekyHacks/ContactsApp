import 'package:contact_app/data/app_database.dart';
import 'package:contact_app/data/contact.dart';

import 'package:sembast/sembast.dart';

class ContactDao {
  static const String CONTACT_STORE_NAME = 'contacts';

//a store with int keys and Map<string, dynamic> values
//we need it to convert contact objects into map
  final _contactStore = intMapStoreFactory.store(CONTACT_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Contactss contact) async {
    await _contactStore.add(await _db, contact.toMap());
  }

  Future updatee(Contactss contact) async {
    final finderr = Finder(filter: Filter.byKey(contact.id));
    await _contactStore.update(
      await _db,
      contact.toMap(),
      finder: finderr,
    );
  }

  Future deletee(Contactss contact) async {
    final finderr = Finder(filter: Filter.byKey(contact.id));
    await _contactStore.delete(
      await _db,
      finder: finderr,
    );
  }

  Future<List<Contactss>> getAllInSortedOrder() async {
    final finderss = Finder(sortOrders: [
      SortOrder('isFavorite', false),
      SortOrder('name'),
    ]);

    final recordSnapshots =
        await _contactStore.find(await _db, finder: finderss);

    return recordSnapshots.map((snapshot) {
      final contact = Contactss.fromMap(snapshot.value);
      contact.id = snapshot.key;
      return contact;
    }).toList();
  }
}
