import 'package:birthday/lib/loading.dart';
import 'package:birthday/lib/right-panel.dart';
import 'package:birthday/lib/state/field.dart';
import 'package:birthday/screen/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

bool isEmail(String string) {
  const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  final regExp = RegExp(pattern);

  return regExp.hasMatch(string);
}

class LoginScreen extends StatelessWidget{
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
        right: LoginForm()
      )
    );
  }
}
class LoginFormState extends State<LoginForm>{
  final email = StateField();
  final password = StateField();
  late Widget form;
  late Widget loading;
  late Widget error;
  late Widget page;

  @override
  void initState() {
    this.form = Column(
      children: [
        Expanded(
          // A flexible child that will grow to fit the viewport but
          // still be at least as big as necessary to fit its contents.
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
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
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

                      this.checkPassword();
                    },
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
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
          mainAxisSize: MainAxisSize.min,
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
                          'user_friends',
                          'user_birthday',
                          'email',
                        ]
                    );

                    if (result.status == LoginStatus.success) {
                      // you are logged
                      final AccessToken accessToken = result.accessToken!;
                      print(accessToken);

                      final url = Uri.parse('https://birthday-apiim.herokuapp.com/auth/register/');
                      final response = await http.post(url, body: {

                      });
                      print('Response status: ${response.statusCode}');
                      print('Response body: ${response.body}');

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
            )
          ],
        ),
      ],
    );

    this.loading =  Loading();

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
      this.email.isValid()
      && this.password.isValid();
  }
  checkPassword(){
    if (this.password.value != null){
      if (this.password.value!.length <= 0){
        this.password.error = "Merci de bien vouloir remplir votre mot de passe.";
      }else if (this.password.value!.length > 40){
        this.password.error = "Votre mot de passe ne peut pas contenir plus de 40 caractères or il en contient "+this.password.value!.length.toString()+".";
      }else if (this.password.value!.length < 5){
        this.password.error = "Votre mot de passe doit contenir au moins 5 caractères or il en contient "+this.password.value!.length.toString()+".";
      }else{
        this.password.error = null;
      }
    }

    this.setState(() {});

    return this.password.error;
  }
  checkEmail(){
    if (this.email.value != null){
      if (this.email.value!.trim().length <= 0){
        this.email.error = "Merci de bien vouloir remplir votre adresse E-mail.";
      }else if (!isEmail(this.email.value!)){
        this.email.error = "Votre adresse E-mail semble avoir une syntaxe incorrecte.";
      }else{
        this.email.error = null;
      }
    }

    this.setState(() {});

    return this.email.error;
  }
}

class LoginForm extends StatefulWidget{
  @override
  LoginFormState createState() {
    return LoginFormState();
  }

}