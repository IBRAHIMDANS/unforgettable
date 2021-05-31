import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
            LayoutBuilder(
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Text(
                                          'Login Page',
                                          textAlign: TextAlign.center,
                                          textScaleFactor: 2.2,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 35,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Lastname',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 35,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Firstname',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 35,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'E-mail address',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Confirm',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 35,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Password',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Confirm',
                                          border: OutlineInputBorder(),
                                        ),
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
                                          // Respond to button press
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 35,
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
                                    // Respond to button press
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
            ),
          ],
        )
    );
  }
}

class RegisterFormState extends State<RegisterForm>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}

class RegisterForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterFormState();
  }
}