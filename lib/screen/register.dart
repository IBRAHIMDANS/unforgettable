import 'dart:convert';

import 'package:birthday/screen/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

bool isEmail(String string) {
  const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  final regExp = RegExp(pattern);

  return regExp.hasMatch(string);
}

class RegisterScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Flex(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          direction: Axis.horizontal,
          children: [
            Expanded(
                child: Container(
                    padding: EdgeInsets.all(50),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(238, 238, 238, 238)
                    ),
                    child: Center(
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: 600
                        ),
                        child: SvgPicture.asset(
                          "asset/image/cake.svg",
                        ),
                      ),
                    )
                )
            ),
            RegisterForm(),
          ],
        )
    );
  }
}

class DataForm{
  String? email = null;
  String? email_confirmation = null;

  String? password = null;
  String? password_confirmation = null;

  String? lastname = null;
  String? firstname = null;
}

class RegisterFormState extends State<RegisterForm>
  with TickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width > 1000 ? 420 : MediaQuery.of(context).size.width,
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                  minHeight: MediaQuery.of(context).size.height
              ),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 255, 255, 255),
                      spreadRadius: 2,
                      blurRadius: 4,
                    )
                  ]
              ),
              child: IntrinsicHeight(
                child: Flex(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  direction: Axis.vertical,
                  children: [
                    Flexible(
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: 350
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 7
                        ),
                        child: Flex(
                          direction: Axis.vertical,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 70,
                            ),
                            Center(
                              child: Text(
                                'Register Page',
                                textAlign: TextAlign.center,
                                textScaleFactor: 2.2,
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Focus(
                              child: TextFormField(
                                autocorrect: false,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                maxLines: 1,
                                onEditingComplete: () => node.nextFocus(),
                                decoration: InputDecoration(
                                  labelText: 'Lastname',
                                  errorText: error.lastname,
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (String? value) {
                                  if (value == null){
                                    return;
                                  }

                                  data.lastname = value;
                                  error.lastname = null;

                                  setState(() {});
                                },
                              ),
                              onFocusChange: (value){
                                if (value){
                                  return;
                                }

                                this.checkLastname();

                                setState(() {});
                              },
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            Focus(
                              child: TextFormField(
                                autocorrect: false,
                                maxLines: 1,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => node.nextFocus(),
                                decoration: InputDecoration(
                                  labelText: 'Firstname',
                                  errorText: error.firstname,
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (String? value) {
                                  if (value == null){
                                    return;
                                  }

                                  data.firstname = value;
                                  error.firstname = null;

                                  setState(() {});
                                },
                              ),
                              onFocusChange: (value){
                                if (value){
                                  return;
                                }

                                this.checkFirstname();

                                setState(() {});
                              },
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            Focus(
                              child: TextFormField(
                                autocorrect: false,
                                maxLines: 1,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                onEditingComplete: () => node.nextFocus(),
                                decoration: InputDecoration(
                                  labelText: 'E-mail address',
                                  errorText: error.email,
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (String? value) {
                                  if (value == null){
                                    return;
                                  }

                                  data.email = value;
                                  error.email = null;

                                  setState(() {});
                                },
                              ),
                              onFocusChange: (value){
                                if (value){
                                  return;
                                }

                                this.checkEmail();

                                setState(() {});
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Focus(
                              child: TextFormField(
                                autocorrect: false,
                                maxLines: 1,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => node.nextFocus(),
                                decoration: InputDecoration(
                                  labelText: 'Confirm',
                                  errorText: error.email_confirmation,
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (String? value) {
                                  if (value == null){
                                    return;
                                  }

                                  data.email_confirmation = value;
                                  error.email_confirmation = null;

                                  setState(() {});
                                },
                              ),
                              onFocusChange: (value){
                                if (value){
                                  return;
                                }

                                this.checkEmail();

                                setState(() {});
                              },
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            Focus(
                              child: TextFormField(
                                autocorrect: false,
                                obscureText: true,
                                maxLines: 1,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => node.nextFocus(),
                                decoration: InputDecoration(
                                  errorText: error.password,
                                  labelText: 'Password',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (String? value) {
                                  if (value == null){
                                    return;
                                  }

                                  data.password = value;
                                  error.password = null;

                                  setState(() {});
                                },
                              ),
                              onFocusChange: (value){
                                if (value){
                                  return;
                                }

                                this.checkPassword();

                                setState(() {});
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Focus(
                              child: TextFormField(
                                maxLines: 1,
                                obscureText: true,
                                onEditingComplete: () => node.unfocus(),
                                onChanged: (String? value) {
                                  if (value == null){
                                    return;
                                  }

                                  data.password_confirmation = value;
                                  error.password_confirmation = null;

                                  setState(() {});
                                },
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  errorText: error.password_confirmation,
                                  labelText: 'Confirm',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              onFocusChange: (value){
                                if (value){
                                  return;
                                }

                                this.checkPassword();

                                setState(() {});
                              },
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            ElevatedButton(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 15
                                ),
                                child: Text(
                                  'Register',
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1.1,
                                ),
                              ),
                              onPressed: () {
                                if (this.data.lastname == null){
                                  this.data.lastname = "";
                                }
                                if (this.data.firstname == null){
                                  this.data.firstname = "";
                                }

                                if (this.data.password == null){
                                  this.data.password = "";
                                }
                                if (this.data.password_confirmation == null){
                                  this.data.password_confirmation = "";
                                }
                                if (this.data.email == null){
                                  this.data.email = "";
                                }
                                if (this.data.email_confirmation == null){
                                  this.data.email_confirmation = "";
                                }

                                this.checkLastname();
                                this.checkFirstname();
                                this.checkEmail();
                                this.checkPassword();

                                this.setState(() {});

                                print(jsonEncode(<String, String>{
                                  "email": this.data.email!,
                                  "password": this.data.password!,
                                  "lastname": this.data.lastname!,
                                  "firstname": this.data.firstname!,
                                }));
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 5
                            ),
                            child: SvgPicture.asset(
                                "asset/image/icons/facebook.svg",
                                width: 40,
                                height: 40
                            ),
                          ),
                          onTap: () {
                            // Respond to button press
                          },
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 5
                            ),
                            child: SvgPicture.asset(
                                "asset/image/icons/google-plus.svg",
                                width: 40,
                                height: 40
                            ),
                          ),
                          onTap: () {
                            // Respond to button press
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: 320
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 17
                      ),
                      child: ElevatedButton(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15
                          ),
                          constraints: BoxConstraints(
                              maxWidth: 320
                          ),
                          width: 320,
                          child: Text(
                            'Login',
                            textAlign: TextAlign.center,
                            textScaleFactor: 1.1,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                  ]
                ),
              )
          ),
        );
      },
    );
  }
  isValid(){
    return
      this.error.email == null
      && this.error.email_confirmation == null
      && this.error.password == null
      && this.error.password_confirmation == null
      && this.error.firstname == null
      && this.error.lastname == null

      && this.data.email != null
      && this.data.email_confirmation != null
      && this.data.password != null
      && this.data.password_confirmation != null
      && this.data.firstname != null
      && this.data.lastname != null
    ;
  }
  checkPassword(){
    if (data.password_confirmation != null){
      if (data.password_confirmation!.length <= 0){
        error.password_confirmation = "Merci de bien vouloir remplir votre mot de passe.";
      }else if (data.password_confirmation!.length > 40){
        error.password_confirmation = "Votre mot de passe ne peut pas contenir plus de 40 caractères or il en contient "+data.password_confirmation!.length.toString()+".";
      }else if (data.password_confirmation!.length < 5){
        error.password_confirmation = "Votre mot de passe doit contenir au moins 5 caractères or il en contient "+data.password_confirmation!.length.toString()+".";
      }else{
        error.password_confirmation = null;
      }
    }
    if (data.password != null){
      if (data.password!.length <= 0){
        error.password = "Merci de bien vouloir remplir votre mot de passe.";
      }else if (data.password!.length > 40){
        error.password = "Votre mot de passe ne peut pas contenir plus de 40 caractères or il en contient "+data.password!.length.toString()+".";
      }else if (data.password!.length < 5){
        error.password = "Votre mot de passe doit contenir au moins 5 caractères or il en contient "+data.password!.length.toString()+".";
      }else{
        error.password = null;
      }
    }

    if (
        data.password_confirmation != null
        && data.password != null
        && error.password_confirmation == null
        && error.password == null
        && data.password_confirmation != data.password
    ){
      error.password = "Vos mots de passe ne concordent pas";
      error.password_confirmation = "Vos mots de passe ne concordent pas";
    }
  }
  checkEmail(){
    if (data.email != null){
      if (data.email!.trim().length <= 0){
        error.email = "Merci de bien vouloir remplir votre adresse E-mail.";
      }else if (!isEmail(data.email!)){
        error.email = "Votre adresse E-mail semble avoir une syntaxe incorrecte.";
      }else{
        error.email = null;
      }
    }
    if (data.email_confirmation != null){
      if (data.email_confirmation!.trim().length <= 0){
        error.email_confirmation = "Merci de bien vouloir remplir votre adresse E-mail.";
      }else if (!isEmail(data.email_confirmation!)){
        error.email_confirmation = "Votre adresse E-mail semble avoir une syntaxe incorrecte.";
      }else{
        error.email_confirmation = null;
      }
    }

    if (
        data.email_confirmation != null
        && data.email != null
        && error.email_confirmation == null
        && error.email == null
        && data.email_confirmation != data.email
    ){
      error.email = "Vos adresse E-mail ne concordent pas";
      error.email_confirmation = "Vos adresse E-mail ne concordent pas";
    }
  }

  checkLastname(){
    if (data.lastname != null){
      if (data.lastname!.trim().length <= 0){
        error.lastname = "Merci de bien vouloir remplir votre nom de famille.";
      }else{
        error.lastname = null;
      }
    }
  }

  checkFirstname(){
    if (data.firstname != null){
      if (data.firstname!.trim().length <= 0){
        error.firstname = "Merci de bien vouloir remplir votre prénom.";
      }else{
        error.firstname = null;
      }
    }
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  late AnimationController controller;
  DataForm data = DataForm();
  DataForm error = DataForm();
}

class RegisterForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterFormState();
  }
}