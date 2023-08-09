import 'package:budget_maker_app/utilities/enums.dart';
import 'package:budget_maker_app/utilities/helpers/print_debug.dart';
import 'package:flutter/material.dart';

/// Gestionnaire de economy code
/// Détecte les gestes dans ses enfants et appelle une fonction lorsque le code est bon
class EconomyCodeAction extends StatefulWidget {
  /// Liste des gestes à effectuer
  final List<GestureType> gestures;

  /// Fonction à appeler lorsque le code est bon
  final Function() onAction;

  /// Enfant
  final Widget child;

  /// Constructeur
  const EconomyCodeAction({
    super.key,
    required this.gestures,
    required this.onAction,
    required this.child,
  });

  @override
  State<EconomyCodeAction> createState() => _EconomyCodeActionState();
}

class _EconomyCodeActionState extends State<EconomyCodeAction> {
  /// Index du geste à effectuer
  var index = 0;

  /// Vérifie le geste
  verifyGesture(GestureType gesture) {
    // Vérifie le geste
    if (widget.gestures[index] == gesture) {
      // Bon geste, on passe au suivant
      printDebug('Good move');
      index++;
    } else {
      // Mauvais geste, on recommence
      printDebug('Wrong move');
      index = 0;
    }

    // Vérifie si le code est bon
    if (index == widget.gestures.length) {
      // Appelle la fonction
      widget.onAction();
      index = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Taper sur l'écran
      onTap: () {
        verifyGesture(GestureType.tap);
      },

      // Taper deux fois sur l'écran
      onDoubleTap: () {
        verifyGesture(GestureType.doubleTap);
      },

      // Garder le doigt appuyé sur l'écran
      onLongPress: () {
        verifyGesture(GestureType.longPress);
      },

      // Faire glisser le doigt sur l'écran verticalement
      onVerticalDragEnd: (details) {
        verifyGesture(GestureType.verticalDrag);
      },

      // Faire glisser le doigt sur l'écran horizontalement
      onHorizontalDragEnd: (details) {
        verifyGesture(GestureType.horizontalDrag);
      },
      child: widget.child,
    );
  }
}
