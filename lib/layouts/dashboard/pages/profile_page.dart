import 'package:budget_maker_app/widgets/page_header_widget.dart';
import 'package:budget_maker_app/widgets/profile/brightness_selector.dart';
import 'package:budget_maker_app/widgets/profile/profile_name_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// Page de profil de l'utilisateur
class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Entête de la page
          PageHeader(
              title: AppLocalizations.of(context)!
                  .dashboard_account_settings_title),
          // Formulaire de changement de nom
          const ProfileNameForm(),
          // Sélecteur de thème
          const BrightnessSelector(),
        ],
      ),
    );
  }
}
