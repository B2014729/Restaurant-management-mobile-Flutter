import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobileapp/ui/auth/auth_card.dart';

class AuthLoginScreen extends StatelessWidget {
  static const routeName = '/auth-login-screen';

  const AuthLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/backgroundImage.png"),
                fit: BoxFit.cover,
                opacity: 0.8,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 220,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Beach",
                      style: GoogleFonts.pacifico(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.withOpacity(0.75),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 90,
                ),
                const AuthCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
