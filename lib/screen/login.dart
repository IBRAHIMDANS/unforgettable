import 'dart:convert';

import 'package:birthday/screen/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:loading_indicator/loading_indicator.dart';

bool isEmail(String string) {
  const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  final regExp = RegExp(pattern);

  return regExp.hasMatch(string);
}

class LoginScreen extends StatelessWidget{
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
            LoginForm(),
          ],
        )
    );
  }
}

class DataForm{
  String? email = null;

  String? password = null;
}

class LoginFormState extends State<LoginForm>
    with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
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
                child: AnimatedSwitcher(
                  duration: new Duration(milliseconds: 300),
                  child: page,
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return SlideTransition(
                        position: animation.drive(
                            Tween(
                                begin: Offset(1.0, 0.0),
                                end: Offset.zero
                            )
                        ),
                        child: child,
                    );
                  },
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
          && this.error.password == null

          && this.data.email != null
          && this.data.password != null
    ;
  }
  checkPassword(){
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

    form = Flex(
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
                      'Login Page',
                      textAlign: TextAlign.center,
                      textScaleFactor: 2.2,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Focus(
                    child: TextFormField(
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
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
                      obscureText: true,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
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
                        'Login',
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.1,
                      ),
                    ),
                    onPressed: () {
                      this.setAsLoading();

                      if (this.data.password == null){
                        this.data.password = "";
                      }
                      if (this.data.email == null){
                        this.data.email = "";
                      }

                      this.checkEmail();
                      this.checkPassword();

                      this.setState(() {});

                      print(jsonEncode(<String, String>{
                        "email": this.data.email!,
                        "password": this.data.password!,
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
                onTap: () async {
                  this.setAsLoading();
                  final LoginResult result = await FacebookAuth.instance.login(
                      permissions: [
                        'user_age_range',
                        'user_gender',
                        'user_friends',
                        'user_birthday',
                        'email',
                      ]
                  );

                  if (result.status == LoginStatus.success) {
                    // you are logged
                    final AccessToken accessToken = result.accessToken!;
                  }

                  this.setAsLoaded();
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
                  'Register',
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.1,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
            ),
          ),
          SizedBox(
            height: 35,
          ),
        ]
    );
    loading =  Center(
        child: Container(
          width: 50,
          height: 50,
          child: LoadingIndicator(indicatorType: Indicator.circleStrokeSpin, color: Colors.red,),
        ),
    );
    page = form;

    super.initState();
  }

  setAsLoading(){
    this.page = this.loading;
    this.setState(() {});
  }
  setAsLoaded(){
    this.page = this.form;
    this.setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  late Widget form;
  late Widget page;
  late Widget loading;

  late AnimationController controller;
  DataForm data = DataForm();
  DataForm error = DataForm();
}

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginFormState();
  }
}