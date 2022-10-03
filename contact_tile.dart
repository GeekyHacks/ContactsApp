import 'package:contact_app/UI/Contact_List/contactEditPage.dart';
import 'package:contact_app/UI/Contact_List/contactModel.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class contactTile extends StatelessWidget {
  const contactTile({
    Key? key,
    this.contactIndex,
  }) : super(key: key);

  final int? contactIndex;

  @override
  Widget build(BuildContext context) {
    //

    final model = ScopedModel.of<contactModel>(context);
    final displayedContact = model.contacts[contactIndex!];

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      actions: <Widget>[
        IconSlideAction(
          caption: 'Email',
          color: Colors.blue,
          icon: Icons.email,
          onTap: () {},
        ),
        IconSlideAction(
          caption: 'Share',
          color: Colors.indigo,
          icon: Icons.share,
          onTap: () {},
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Call',
          color: Colors.green,
          icon: Icons.phone,
          onTap: () => _callPhoneNumber(
            context,
            displayedContact.phoneNumber,
          ),
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            model.deleteContact(displayedContact);
          },
        ),
      ],
      child: Container(
        color: Theme.of(context).canvasColor,
        child: ListTile(
            title: Text(displayedContact.name),
            subtitle: Text(displayedContact.email),
            //displaying first letter of names.
            leading: _BuildCircleAvatar(displayedContact),
            trailing: IconButton(
              icon: Icon(
                displayedContact.isFavorite ? Icons.star : Icons.star_border,
                color: displayedContact.isFavorite ? Colors.amber : Colors.grey,
              ),
              onPressed: () {
                model.changeFavoriteStatus(displayedContact);
              },
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
                builder: (_) => contactEditPage(
                  editedContact: displayedContact,
                ),
              ));
            }),
      ),
    );
  }

// hero widget a good animation between two routes.you must put in the
// wanted routes( or pages)
  Hero _BuildCircleAvatar(displayedContact) {
    return Hero(
      tag: displayedContact.hashCode,
      child: CircleAvatar(
        child: _BuildCircleAvatarContent(displayedContact),
      ),
    );
  }

  Widget _BuildCircleAvatarContent(displayedContact) {
    if (displayedContact.imageFile == null) {
      return Text(displayedContact.name[0]);
    } else {
      return ClipOval(
        child: AspectRatio(
          aspectRatio: 1,
          child: Image.file(
            displayedContact.imageFile,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }

  Future _callPhoneNumber(
    BuildContext context,
    String number,
  ) async {
    final Url = 'tel:$number';
    if (await url_launcher.canLaunch(Url)) {
      await url_launcher.launch(Url);
    } else {
      final snackBar = SnackBar(
        content: Text('Can not make a call'),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }
}
