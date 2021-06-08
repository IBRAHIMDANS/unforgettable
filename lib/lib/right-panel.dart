import 'package:flutter/cupertino.dart';

/*
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
  )
 */

class RightPanel extends Flex{
  // ignore: non_constant_identifier_names
  RightPanel({required Widget left,required Widget right,break_at = 1000,width = 420}) : super(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.start,
    direction: Axis.horizontal,
    children: [
      Expanded(child: left),
      LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
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
                child: right
            ),
          );
        },
      )
    ],
  ){

  }
}