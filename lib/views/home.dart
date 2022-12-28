import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '/repositories/system_repository.dart';
import '/repositories/user_repository.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var userRepository = UserRepository();
  var systemRepository = SystemRepository();
  var user = '';
  var button_status = false;
  var led_status = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userRepository.getUser().then((value) {
      setState(() {
        user = value.name;
      });
    });

    systemRepository.getLed().then((value) {
      setState(() {
        led_status = value;
      });
    });

    Timer.periodic(new Duration(seconds: 1), (timer) {
      systemRepository.getButton().then((value) {
        // check 'mounted' to avoid calling 'setState' after 'dispose'
        if (mounted) {
          setState(() {
            button_status = value;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Cloud Device',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Bem vindo ao Cloud Device\n$user',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (button_status == led_status) {
                    systemRepository.setLed(!button_status);
                  }
                  setState(() {
                    led_status = !led_status;
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(Size(200, 50)),
                ),
                child: Text('Led - ' + (led_status ? 'On' : 'Off'),
                    style: TextStyle(fontSize: 20)),
              ),
              SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Botão'),
                    Switch(value: button_status, onChanged: (value) {}),
                  ],
                ),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  userRepository.removeUser();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(Size(120, 50)),
                ),
                child: Text('Logout', style: TextStyle(fontSize: 20)),
              ),
            ]),
      ),
    );
  }
}
