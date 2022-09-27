import 'package:authentication_library/LoginContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import '../LoginContainer.dart';

class LoginPage extends StatelessWidget {
  TextEditingController loginController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  LoginContainerState activeState;

  LoginPage(this.activeState);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.blue),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Spacer(flex: 1),
              Expanded(
                flex: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Center(child: Text("Add an image/logo here")),
                ),
              ),
              Spacer(flex: 1),
              Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    controller: loginController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: Theme.of(context).textTheme.headline6?.copyWith(
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Spacer(flex: 1),
              Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: passwordController,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: Theme.of(context).textTheme.headline6?.copyWith(
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                      ),
                      border: InputBorder.none,
                    ),
                    obscureText: true,
                    obscuringCharacter: '*',
                  ),
                ),
              ),
              Spacer(flex: 3),
              TextButton(
                onPressed: () async {
                  activeState.login(
                      loginController.text, passwordController.text);
                },
                child: Text("Submit"),
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white),
                    textStyle: MaterialStateProperty.all(
                      Theme.of(context).textTheme.headline6?.copyWith(
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                      ),
                    )),
              ),
              TextButton(
                child: Text("Create an account"),
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
                  textStyle: MaterialStateProperty.all(
                    Theme.of(context).textTheme.headline6?.copyWith(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                onPressed: () {
                  activeState.updateState(LoginPages.RegisterPage);
                },
              ),
              Container(
                child: SignInButton(
                  Buttons.Google,
                  text: "Sign in with Google",
                  onPressed: () async {
                    await activeState.signInWithGoogle();
                  },
                ),
              ),
              Spacer(flex: 4)
            ],
          ),
        ),
      ),
    );
  }
}
