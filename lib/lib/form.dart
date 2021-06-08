import 'package:flutter/cupertino.dart';

import 'input.dart';

// ignore: top_level_function_literal_block
final transpile = (Widget item,void Function(Input input) action){
  if (item is Form){
    return;
  }
  if (item is Input){
    action(item);
    return;
  }

  if (item is MultiChildRenderObjectWidget){
    item.children.forEach((element) {
      transpile(element,action);
    });
    return;
  }
  if (item is SingleChildRenderObjectWidget){
    if (item.child == null){
      return;
    }
    transpile(item.child!,action);
    return;
  }
  return;
};

class LibForm extends Column{
  LibForm({children = const []}) : super(children: children){

  }

  forceCheck(){
    transpile(this,(Input input){
      input.forceCheck();
    });
  }

  getValues(){
    final map = new Map<String,String>();

    transpile(this,(Input input){
      if (input.value == null){
        return;
      }
      map[input.form_key] = input.value!;
    });

    return map;
  }

  getErrors(){
    final map = new Map<String,String>();

    transpile(this,(Input input){
      if (input.error == null){
        return;
      }
      map[input.form_key] = input.error!;
    });

    return map;
  }
}