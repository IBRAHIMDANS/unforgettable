import 'package:birthday/_screen/login.dart';
import 'package:birthday/lib/right-panel.dart';
import 'package:birthday/lib/state/field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_indicator/loading_indicator.dart';

bool isEmail(String string) {
  const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  final regExp = RegExp(pattern);

  return regExp.hasMatch(string);
}

class RegisterScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RightPanel(
        left: Container(
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
        ),
        right: RegisterForm()
      )
    );
  }
}
class RegisterFormState extends State<RegisterForm>{
  final firstname = StateField();
  final lastname = StateField();
  final email = StateField();
  final email_confirmation = StateField();
  final password = StateField();
  final password_confirmation = StateField();
  late Widget form;
  late Widget loading;
  late Widget error;
  late Widget page;

  @override
  void initState() {
    this.form = IntrinsicHeight(
      child: Flex(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
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
                        canRequestFocus: false,
                        onFocusChange: (value){
                          if (value){
                            return;
                          }

                          this.checkFirstname();
                        },
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          autocorrect: false,

                          decoration: InputDecoration(
                            labelText: "Prénom",
                            errorText: this.firstname.error,
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String? value){
                            if (value == null){
                              return;
                            }

                            this.firstname.error = null;
                            this.firstname.value = value;
                            setState(() {});
                          },
                        )
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Focus(
                        canRequestFocus: false,
                        onFocusChange: (value){
                          if (value){
                            return;
                          }

                          this.checkLastname();
                        },
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          autocorrect: false,

                          decoration: InputDecoration(
                            labelText: "Nom de famille",
                            errorText: this.lastname.error,
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String? value){
                            if (value == null){
                              return;
                            }

                            this.lastname.error = null;
                            this.lastname.value = value;
                            setState(() {});
                          },
                        )
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Focus(
                      canRequestFocus: false,
                      onFocusChange: (value){
                        if (value){
                          return;
                        }

                        this.checkEmail();
                      },
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        autocorrect: false,

                        decoration: InputDecoration(
                          labelText: "Adresse E-mail",
                          errorText: this.email.error,
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String? value){
                          if (value == null){
                            return;
                          }

                          this.email.error = null;
                          this.email.value = value;
                          setState(() {});
                        },
                      )
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Focus(
                        canRequestFocus: false,
                        onFocusChange: (value){
                          if (value){
                            return;
                          }

                          this.checkEmail();
                        },
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autocorrect: false,

                          decoration: InputDecoration(
                            labelText: "Confirmation",
                            errorText: this.email_confirmation.error,
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String? value){
                            if (value == null){
                              return;
                            }

                            this.email_confirmation.error = null;
                            this.email_confirmation.value = value;
                            setState(() {});
                          },
                        )
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Focus(
                      canRequestFocus: false,
                      onFocusChange: (value){
                        if (value){
                          return;
                        }

                        this.checkPassword();
                      },
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: "Password",
                          errorText: this.password.error,
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String? value){
                          if (value == null){
                            return;
                          }

                          this.password.error = null;
                          this.password.value = value;
                          setState(() {});
                        },
                      )
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Focus(
                        canRequestFocus: false,
                        onFocusChange: (value){
                          if (value){
                            return;
                          }

                          this.checkPassword();
                        },
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          autocorrect: false,
                          decoration: InputDecoration(
                            labelText: "Confirmation",
                            errorText: this.password_confirmation.error,
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String? value){
                            if (value == null){
                              return;
                            }

                            this.password_confirmation.error = null;
                            this.password_confirmation.value = value;
                            setState(() {});
                          },
                        )
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                            setState(() {});
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
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
                )
              ],
            ),
          ]
      ),
    );
    this.loading =  Center(
      child: Container(
        width: 50,
        height: 50,
        child: LoadingIndicator(indicatorType: Indicator.circleStrokeSpin, color: Colors.red),
      ),
    );

    this.page = this.form;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: new Duration(milliseconds: 300),
      child: this.page,
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
    );
  }

  setAsLoading(){
    this.page = this.loading;
    this.setState(() {});
  }
  setAsLoaded(){
    this.page = this.form;
    this.setState(() {});
  }

  isValid(){
    return
      this.firstname.isValid()
      && this.lastname.isValid()
      && this.email_confirmation.isValid()
      && this.email.isValid()
      && this.password_confirmation.isValid()
      && this.password.isValid()
    ;
  }
  
  checkPassword(){
    if (password_confirmation.value != null){
      if (password_confirmation.value!.length <= 0){
        password_confirmation.error = "Merci de bien vouloir remplir votre mot de passe.";
      }else if (password_confirmation.value!.length > 40){
        password_confirmation.error = "Votre mot de passe ne peut pas contenir plus de 40 caractères or il en contient "+password_confirmation.value!.length.toString()+".";
      }else if (password_confirmation.value!.length < 5){
        password_confirmation.error = "Votre mot de passe doit contenir au moins 5 caractères or il en contient "+password_confirmation.value!.length.toString()+".";
      }else{
        password_confirmation.error = null;
      }
    }
    if (password.value != null){
      if (password.value!.length <= 0){
        password.error = "Merci de bien vouloir remplir votre mot de passe.";
      }else if (password.value!.length > 40){
        password.error = "Votre mot de passe ne peut pas contenir plus de 40 caractères or il en contient "+password.value!.length.toString()+".";
      }else if (password.value!.length < 5){
        password.error = "Votre mot de passe doit contenir au moins 5 caractères or il en contient "+password.value!.length.toString()+".";
      }else{
        password.error = null;
      }
    }

    if (
      password.isValid()
      && password_confirmation.isValid()
      && password_confirmation.value != password.value
    ){
      password.error = "Vos mots de passe ne concordent pas";
      password_confirmation.error = "Vos mots de passe ne concordent pas";
    }
  }
  checkEmail(){
    if (this.email.value != null){
      if (this.email.value!.trim().length <= 0){
        email.error = "Merci de bien vouloir remplir votre adresse E-mail.";
      }else if (!isEmail(email.value!)){
        email.error = "Votre adresse E-mail semble avoir une syntaxe incorrecte.";
      }else{
        email.error = null;
      }
    }
    if (email_confirmation.value != null){
      if (email_confirmation.value!.trim().length <= 0){
        email_confirmation.error = "Merci de bien vouloir remplir votre adresse E-mail.";
      }else if (!isEmail(email_confirmation.value!)){
        email_confirmation.error = "Votre adresse E-mail semble avoir une syntaxe incorrecte.";
      }else{
        email_confirmation.error = null;
      }
    }

    if (
      email.isValid()
      && email_confirmation.isValid()
      && email_confirmation.value != email.value
    ){
      email.error = "Vos adresse E-mail ne concordent pas";
      email_confirmation.error = "Vos adresse E-mail ne concordent pas";
    }
  }
  checkLastname(){
    if (lastname.value != null){
      if (lastname.value!.trim().length <= 0){
        lastname.error = "Merci de bien vouloir remplir votre nom de famille.";
      }else{
        lastname.error = null;
      }
    }
  }
  checkFirstname(){
    if (firstname.value != null){
      if (firstname.value!.trim().length <= 0){
        firstname.error = "Merci de bien vouloir remplir votre prénom.";
      }else{
        firstname.error = null;
      }
    }
  }
}

class RegisterForm extends StatefulWidget{
  @override
  RegisterFormState createState() {
    return RegisterFormState();
  }

}