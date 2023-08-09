import 'package:beamer/beamer.dart';
import 'package:budget_maker_app/utilities/services/auth_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Photo de profil
/// Peut être cliquée pour afficher un menu
class ProfilePicture extends StatefulWidget {
  /// URL de la photo
  final String? photoURL;

  /// Nom d'utilisateur
  final String? displayName;

  /// Affiche le menu
  final bool showMenu;

  /// Taille
  final double size;

  /// Constructeur
  const ProfilePicture({
    super.key,
    this.photoURL,
    this.displayName,
    this.showMenu = true,
    this.size = 50,
  });

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  /// Widget de la photo
  Widget get photoWidget {
    return widget.photoURL != null

        // Affiche la photo de profil si elle existe
        ? CachedNetworkImage(
            imageUrl: widget.photoURL!,
            imageBuilder: (context, imageProvider) => Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              child: Text(
                  widget.displayName != null ? widget.displayName![0] : 'A'),
            ),
          )

        // Affiche la première lettre du nom d'utilisateur sinon
        : Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            child:
                Text(widget.displayName != null ? widget.displayName![0] : 'A'),
          );
  }

  @override
  Widget build(BuildContext context) {
    // Affiche la photo de profil seulement si le menu n'est pas affiché
    if (!widget.showMenu) {
      return photoWidget;
    }

    // Affiche la photo de profil avec un menu sinon
    return PopupMenuButton(
      position: PopupMenuPosition.under,
      itemBuilder: (BuildContext context) {
        return [
          // Bouton pour afficher les paramètres du compte
          PopupMenuItem(
            child: Row(
              children: [
                const Icon(Icons.person),
                Text(AppLocalizations.of(context)!
                    .dashboard_account_settings_title),
              ],
            ),
            onTap: () {
              context.beamToNamed('/dashboard/profile');
            },
          ),

          // Bouton pour se déconnecter
          PopupMenuItem(
            child: Row(
              children: [
                const Icon(Icons.logout),
                Text(AppLocalizations.of(context)!.general_disconnect),
              ],
            ),
            onTap: () async {
              await AuthService.disconnectUser();
            },
          ),
        ];
      },
      child: photoWidget,
    );
  }
}
