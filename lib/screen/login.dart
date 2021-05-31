import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget loginScreen(){
  return Scaffold(
    body: Flex(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(238, 238, 238, 238)
            ),
            child: Center(
                child: Image.asset(
                  "asset/image/party.png",
                  width: 300,
                )
            ),
          )
        ),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
                width: MediaQuery.of(context).size.width > (420 + 400) ? 420 : MediaQuery.of(context).size.width,
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width
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
                child: Flex(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  direction: Axis.vertical,
                  children: [
                    Expanded(
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
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'E-mail address',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Password',
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
                                  child: Text('Login')),
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
                    Column(
                      children: [
                        ElevatedButton(
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 15
                              ),
                              constraints: BoxConstraints(
                                  maxWidth: 320
                              ),
                              width: 320,
                              child: Text('Register'),
                          ),
                          onPressed: () {
                            // Respond to button press
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 35,
                    ),
                  ]
                )
            );
          },
        ),
      ],
    )
  );
}