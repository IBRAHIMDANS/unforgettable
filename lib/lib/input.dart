import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputState extends State<Input>{
  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (value){
        if (value){
          return;
        }

        this.widget.check();

        setState(() {});
      },
      child: TextFormField(
        maxLines: 1,
        keyboardType: this.widget.keyboardType,
        decoration: InputDecoration(
          labelText: this.widget.label,
          errorText: this.widget.error,
          border: OutlineInputBorder(),
        ),
        onChanged: (String? value){
          if (value == null){
            return;
          }

          this.widget.value = value;

          this.setState(() {});
        },
      )
    );
  }
}

class Input extends StatefulWidget{
  final String? Function(String value) validator;
  final String? label;
  final String form_key;
  final TextInputType keyboardType;
  String? error;
  String? value;

  forceValue(){
    this.value = "";
  }
  forceCheck(){
    this.forceValue();

    this.check();
  }
  check(){
    if (this.value != null){
      this.error = this.validator(this.value!);
    }
  }

  Input({
    required this.form_key,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.label,
  }) : super(){

  }

  @override
  State<StatefulWidget> createState() {
    return InputState();
  }
}