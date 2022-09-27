import 'package:flutter/material.dart';

import '../LoginContainer.dart';

class RegisterPage extends StatelessWidget {
  final LoginContainerState activeState;

  RegisterPage(this.activeState);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(3, 192, 74, 1)),
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
                    child: Image.asset("assets/logo_with_name.png"),
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
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: "Name",
                        hintStyle:
                        Theme.of(context).textTheme.headline6?.copyWith(
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
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle:
                        Theme.of(context).textTheme.headline6?.copyWith(
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
                        hintStyle:
                        Theme.of(context).textTheme.headline6?.copyWith(
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
                  onPressed: () async => activeState.registerUser(
                    nameController.value.text,
                    emailController.value.text,
                    passwordController.value.text,
                  ),
                  child: Text("Submit"),
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
                ),
                TextButton(
                  onPressed: () {
                    activeState.updateState(LoginPages.LoginPage);
                  },
                  child: Text("Back"),
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
                ),
                Spacer(flex: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
