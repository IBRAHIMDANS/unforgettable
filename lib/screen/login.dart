import 'package:birthday/lib/form.dart';
import 'package:birthday/lib/input.dart';
import 'package:birthday/lib/right-panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
        right: Flex(
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
                      LibForm(
                        children: [
                          Input(
                            label: "Adresse E-mail",
                            form_key: "email",
                            validator: (value) {
                              print(value);
                              return value;
                            }
                          )
                        ],
                      ),
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

                  },
                ),
              ),
              SizedBox(
                height: 35,
              ),
            ]
        ),
      )
    );
  }
}