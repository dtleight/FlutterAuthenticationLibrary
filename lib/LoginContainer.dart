import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Pages/HomePage.dart';
import '../Pages/LoginPage.dart';
import '../Pages/RegisterPage.dart';

///LoginContainer is responsible for handling navigation and authentication events
/// from the login flow model. Currently the login flow supports the following:
/// Login Page, RegisterPage. Navigation is handled by updating the active widget
/// object to a given page. This allows for the container to maintain its state
/// throughout the entire login flow.
class LoginContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginContainerState();
  }
}

class LoginContainerState extends State<LoginContainer> {
  LoginPages activePage = LoginPages.LoginPage;

  ///Builds the currently visible page in the container.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: activePage.build(this),
    );
  }

  ///Avoids the need for a navigation stack to handle login page manipulation
  void updateState(LoginPages page) => setState(() => activePage = page);

  ///Creates a navigation route to the home page and clears the navigation stack.
  void moveToHomePage() async {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
      builder: (ctxt) {
        return HomePage();
      },
    ), (Route<dynamic> route) => false);
  }

  ///This function calls the Firebase API to create a user with
  ///username and password. If this is successful it calls the createUser
  ///function to setup the user model.
  void registerUser(String name, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      createUser();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          {
            print("Bad");
          }
          break;
        case "invalid-email":
          {
            print("Bad");
          }
          break;
      }
    }
  }

  ///This function instantiates the user into a users collection in Firebase Firestore.
  ///The users are mapped to the UID provided by Firebase Authentication. Upon successful
  ///instantiation.
  void createUser() {
    String? uid = FirebaseAuth.instance.currentUser!.uid;
    String? name = FirebaseAuth.instance.currentUser!.displayName;
    FirebaseFirestore.instance.collection("users").doc(uid).set(
      {
        'name': name,
      },
    );
    moveToHomePage();
  }

  ///This function calls the Firebase API to sign a user in using their google
  ///account. If the user does not exist within the users database it creates a
  ///new entry by calling the create user function. If the user exists it routes
  ///to the home page.
  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
    await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection("users").doc(uid).get();
    if(uid != null)
      {
       if(!ds.exists)
         {
           createUser();
         }
       else
         {
           moveToHomePage();
         }
    }
  }

  ///Attempts to sign in with username and password
  void login(String email, String password) async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      moveToHomePage();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.'); //BRB
      }
    }
  }
}

/// Enum is used to centralize page navigation inside the container
enum LoginPages {
  LoginPage,
  RegisterPage,
}

extension LoginContainerExtension on LoginPages {
  Function get build {
    switch (this) {
      case LoginPages.LoginPage:
        return (LoginContainerState state) => LoginPage(state);
      case LoginPages.RegisterPage:
        return (LoginContainerState state) => RegisterPage(state);
    }
  }
}