import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Loading extends Center{
  Loading() : super(
    child: Container(
      width: 50,
      height: 50,
      child: LoadingIndicator(indicatorType: Indicator.circleStrokeSpin, color: Colors.red),
    )
  ){

  }
}