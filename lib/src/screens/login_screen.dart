import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:login_bloc/src/blocs/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32),
      child: Center(
        child: Column(
          children: [
            buildEmailField(),
            SizedBox(height: 16),
            buildPasswordField(),
            SizedBox(height: 16),
            buildGenderField(),
            SizedBox(height: 16),
            buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget buildEmailField() {
    return StreamBuilder(
      stream: authBloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return TextField(
          keyboardType: TextInputType.emailAddress,
          onChanged: authBloc.changeEmail,
          decoration: InputDecoration(
              labelText: "Your email",
              hintText: "you@email.com",
              errorText: !snapshot.hasError ? null : snapshot.error.toString(),
              border: OutlineInputBorder()),
        );
      },
    );
  }

  Widget buildPasswordField() {
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

  Widget buildSubmitButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(16), primary: Colors.blueAccent),
        onPressed: () {},
        child: Text("Submit"),
      ),
    );
  }

  Widget buildGenderField() {
    return StreamBuilder(
        stream: authBloc.genderStream,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return DropdownButtonFormField<String>(
            items: [
              DropdownMenuItem(child: Text("Male"), value: "Male"),
              DropdownMenuItem(child: Text("Female"), value: "Female"),
              DropdownMenuItem(child: Text("Others"), value: "Others"),
              DropdownMenuItem(
                  child: Text("Rather Not Say"), value: "Rather Not Say"),
            ],
            onChanged: (String? val) {
              authBloc.changeGender(val!);
            },
            value: snapshot.data,
            decoration: InputDecoration(
                hintText: "Select your gender",
                border: OutlineInputBorder(),
                errorText:
                    !snapshot.hasError ? null : snapshot.error.toString()),
          );
        });
  }

/*
  Widget buildGenderField() {
    return StreamBuilder(
        stream: authBloc.genderStream,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: snapshot.hasError ? Colors.red : Colors.white),
                    borderRadius: BorderRadius.circular(4)),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButton(
                  items: [
                    DropdownMenuItem(child: Text("Male"), value: "Male"),
                    DropdownMenuItem(child: Text("Female"), value: "Female"),
                    DropdownMenuItem(child: Text("Others"), value: "Others"),
                    DropdownMenuItem(
                        child: Text("Rather Not Say"), value: "Rather Not Say"),
                  ],
                  onChanged: (String? val) {
                    authBloc.changeGender(val!);
                  },
                  value: snapshot.data,
                  underline: Container(),
                  isExpanded: true,
                  hint: Text("Select your gender"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,top: 8),
                child: Text(
                  !snapshot.hasError ? "" : snapshot.error.toString(),
                  style: TextStyle(color: Colors.red, fontSize: 10),
                ),
              ),
            ],
          );
        });
  }
*/

}