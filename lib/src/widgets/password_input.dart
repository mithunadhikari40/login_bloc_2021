import 'package:flutter/material.dart';
import 'package:login_bloc/src/blocs/auth_bloc_provider.dart';

class PasswordInput extends StatefulWidget {
  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  @override
  Widget build(BuildContext context) {
    final authBloc = AuthBlocProvider.of(context);
    return StreamBuilder(
        stream: authBloc.passwordStream,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return TextField(
            onChanged: authBloc.changePassword,
            obscureText: true,
            decoration: InputDecoration(
                labelText: "Your password",
                hintText: "password",
                border: OutlineInputBorder(),
                errorText:
                !snapshot.hasError ? null : snapshot.error.toString()),
          );
        });
  }
}
