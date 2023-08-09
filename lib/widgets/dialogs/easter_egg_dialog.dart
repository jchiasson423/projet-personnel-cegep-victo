// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Dialogue du easter egg
class EasterEggDialog extends StatefulWidget {
  /// Constructeur
  const EasterEggDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<EasterEggDialog> createState() => _EasterEggDialogState();
}

class _EasterEggDialogState extends State<EasterEggDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // Titre du dialogue (message)
      title: Text(AppLocalizations.of(context)!.easter_egg_text,
          style: Theme.of(context).textTheme.titleLarge),
      content: SizedBox(
        height: MediaQuery.of(context).size.height - 50,
        width: MediaQuery.of(context).size.width - 50,

        // Affiche une image aléatoire de chatpn à partir de cataas.com
        // Je met un paramètre de temps pour que l'image change à chaque fois,
        // sinon, elle est mise en cache par le navigateur et ne change pas
        child: Image.network(
          'https://images.pexels.com/photos/1870376/pexels-photo-1870376.jpeg?cs=srgb&dl=pexels-larissa-barbosa-1870376.jpg&fm=jpg',
          fit: BoxFit.contain,
        ),
      ),
      actions: [
        // Bouton retour
        TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text(AppLocalizations.of(context)!.general_back)),
      ],
    );
  }
}
