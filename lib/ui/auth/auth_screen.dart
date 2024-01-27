import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobileapp/ui/auth/auth_login_screen.dart';
import 'package:mobileapp/ui/auth/auth_manager.dart';
import 'package:mobileapp/ui/share/draw.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = "/auth-screen";

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Personal",
          style: GoogleFonts.pacifico(
            fontSize: 26,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(215, 19, 19, 19),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                ..pop()
                ..pushNamed(AuthLoginScreen.routeName);
              (context).read<AuthManager>().logout();
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.orange,
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 25,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://www.hopectr.org/wp-content/uploads/2022/11/blank-avatar-icon-35.png'),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Text(
                  'Dương Hãi Băng',
                  style: GoogleFonts.pacifico(
                    fontSize: 18,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
