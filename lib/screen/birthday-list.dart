import 'dart:convert';
import 'dart:math';

import 'package:birthday/lib/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

extension MyDateUtils on DateTime {
  DateTime copyWith(
      {int? year,
        int? month,
        int? day,
        int? hour,
        int? minute,
        int? second,
        int? millisecond,
        int? microsecond}) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }
}

class Person {
  final DateTime date_of_birth;
  DateTime incoming_birthday;
  final String lastname;
  final String firstname;
  final String email;
  final String avatar_url;
  final String id;

  Person({
    required this.date_of_birth,
    required this.incoming_birthday,
    required this.lastname,
    required this.firstname,
    required this.avatar_url,
    required this.email,
    required this.id,
  });

  age(){
    return this.incoming_birthday.year - this.date_of_birth.year;
  }
  name(){
    return this.firstname+" "+this.lastname;
  }

  String incoming() {
    print(DateTime.now().millisecondsSinceEpoch);
    final diff = ((this.incoming_birthday.millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch) / 1000).round();

    if (diff > 345600){
      if (diff < (345600 * 2)){
        return "un mois";
      }
      return (diff / 345600).floor().toString()+" mois";
    }

    if (diff > 1209600){
      if (diff < (86400 * 2)){
        return "un jour";
      }
      return (diff / 604800).floor().toString()+" semaines";
    }

    if (diff > 86400){
      if (diff < (86400 * 2)){
        return "un jour";
      }
      return (diff / 86400).floor().toString()+" jours";
    }

    if (diff > 3600){
      if (diff < 7200){
        return "une heure";
      }
      return (diff / 3600).floor().toString()+" heures";
    }

    return "";
  }
}

class BirthdayListStateScreen extends State<BirthdayListScreen>{
  final loading = Loading();
  final List<Person> friends = [];
  late Widget content;
  Widget? page;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Flex(
          direction: Axis.horizontal,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: min(MediaQuery.of(context).size.width, 420),
              child: AnimatedSwitcher(
                  duration: new Duration(milliseconds: 300),
                  child: this.page
              ),
            )
          ],
        )
    );
  }

  @override
  void initState() {
    this.page = this.loading;

    super.initState();

    this.update().then((response) {
      this.friends.clear();
      this.friends.addAll(response);

      this.content = Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          LayoutBuilder(
            builder: (context,_){
              return Container(
                width: min(MediaQuery.of(context).size.width, 400),
                child: ListView(
                  children: this.friends.map((friend){
                    return ListTile(
                      title: Text(friend.name()),
                      subtitle: Text("Fetes ses "+friend.age().toString()+" ans dans "+friend.incoming()),
                      leading: Image.network(friend.avatar_url+"?id="+friend.id,
                          headers: {
                            "Access-Control-Allow-Origin": "*"
                          },
                          width: 40,
                          height: 40
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          )
        ]
      );

      this.page = this.content;
      setState(() {});
    });
  }

  Future<List<Person>> update() async {
    final response = await http.get(Uri.parse('https://unforgettable-api.herokuapp.com/users/friends'));
    if (response.statusCode == 200) {
      final List<Person> friends = [];
      final now = DateTime.now();
      for(var friend in jsonDecode(response.body)["friends"]){
        try{
          final person = Person(
              date_of_birth: DateTime.parse(friend["dateOfBirth"]),
              incoming_birthday: DateTime.parse(friend["incomingBirthday"]),
              lastname: friend["lastName"],
              firstname: friend["firstName"],
              avatar_url: friend["profil"],
              id: friend["id"],
              email: friend["email"]
          );

          person.incoming_birthday = new DateTime(now.year, person.incoming_birthday.month, person.incoming_birthday.day, person.incoming_birthday.hour, person.incoming_birthday.minute, person.incoming_birthday.second, person.incoming_birthday.millisecond, person.incoming_birthday.microsecond);

          if (DateTime.now().isAfter(person.incoming_birthday)){
            person.incoming_birthday = new DateTime(now.year + 1, person.incoming_birthday.month, person.incoming_birthday.day, person.incoming_birthday.hour, person.incoming_birthday.minute, person.incoming_birthday.second, person.incoming_birthday.millisecond, person.incoming_birthday.microsecond);
          }

          friends.add(person);
        }catch(e){
          print(e);
        }
      }

      return friends;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

}

class BirthdayListScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return BirthdayListStateScreen();
  }
}