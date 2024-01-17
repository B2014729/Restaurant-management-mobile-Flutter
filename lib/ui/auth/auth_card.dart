import 'package:flutter/material.dart';
// import 'package:mobileapp/models/http_exception.dart';
// import 'package:provider/provider.dart';

// import '../share/dialog_utils.dart';

// import 'auth_manager.dart';

class AuthCard extends StatefulWidget {
  const AuthCard({
    super.key,
  });

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final Map<String, String> _authData = {
    'username': '',
    'password': '',
  };
  final _isSubmitting = ValueNotifier<bool>(false);
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    _isSubmitting.value = true;

    // try {
    //   await context.read<AuthManager>().login(
    //         _authData['email']!,
    //         _authData['password']!,
    //       );
    // } catch (error) {
    //   if (mounted) {
    //     showErrorDialog(
    //         context,
    //         (error is HttpException)
    //             ? error.toString()
    //             : 'Authentication failed');
    //   }
    // }

    _isSubmitting.value = false;
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      color: const Color.fromARGB(0, 250, 250, 250),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 9.0,
      child: Container(
        constraints: const BoxConstraints(minHeight: 250),
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildEmailField(),
                _buildPasswordField(),
                const SizedBox(
                  height: 20,
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: _isSubmitting,
                  builder: (context, isSubmitting, child) {
                    if (isSubmitting) {
                      return const CircularProgressIndicator();
                    }
                    return _buildSubmitButton();
                  },
                ),
                //_buildAuthModeSwitchButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildAuthModeSwitchButton() {
  //   return TextButton(
  //     onPressed: _switchAuthMode,
  //     style: TextButton.styleFrom(
  //       padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
  //       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //     ),
  //     child: Text(
  //       'LOGIN INSTEAD',
  //       style: TextStyle(
  //         color: Colors.orange.withOpacity(0.6),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submit,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: Colors.orange,
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
        textStyle: TextStyle(
          color: Theme.of(context).primaryTextTheme.titleLarge?.color,
        ),
      ),
      child: const Text('LOGIN'),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: const TextStyle(
          color: Colors.orange,
          letterSpacing: 2,
          fontWeight: FontWeight.bold,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange.withOpacity(0.4),
          ),
        ),
      ),
      style: const TextStyle(color: Colors.white),
      obscureText: true,
      controller: _passwordController,
      validator: (value) {
        if (value == null || value.length < 5) {
          return 'Password không đủ 5 kí tự!';
        }
        return null;
      },
      onSaved: (value) {
        _authData['password'] = value!;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Username',
        labelStyle: const TextStyle(
          color: Colors.orange,
          letterSpacing: 2,
          fontWeight: FontWeight.bold,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange.withOpacity(0.4),
          ),
        ),
      ),
      style: const TextStyle(color: Colors.white),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Username không được để trống!';
        }
        return null;
      },
      onSaved: (value) {
        _authData['username'] = value!;
      },
    );
  }
}
