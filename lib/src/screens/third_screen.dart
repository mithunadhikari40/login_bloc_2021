import 'package:flutter/material.dart';
import 'package:login_bloc/src/blocs/auth_bloc_provider.dart';

class ThirdScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final authBloc= AuthBlocProvider.of(context);
    return StreamBuilder(
      stream: authBloc.passwordStream,
      builder: (context, snapshot) {
        return CheckboxListTile(
          title: Text("I agree to the terms and conditions"),
            value: snapshot.hasData, onChanged: (bool? val){

        });
      }
    );
  }
}
