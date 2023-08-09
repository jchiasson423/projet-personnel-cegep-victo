import 'package:budget_maker_app/widgets/login/google_login_button_widget.dart';
import 'package:budget_maker_app/widgets/login/register_form_widget.dart';
import 'package:budget_maker_app/widgets/login/sign_in_form_widget.dart';
import 'package:budget_maker_app/widgets/logo/logo_widget.dart';
import 'package:flutter/material.dart';

/// Page de connexion
class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          // Logo de l'app
          Logo(
            width: 500,
            height: 500,
          ),
          Column(
            children: [
              // Bouton de connexion Google
              GoogleLoginButton(),
              // Formulaire de connexion
              SignInForm(),
              // Formulaire d'inscription
              RegisterForm(),
            ],
          ),
        ],
      ),
    );
  }
}
