import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '/controllers/login_controller.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final controller = LoginController();
  String username = '';
  String password = '';

  _loading() {
    return Center(child: CircularProgressIndicator());
  }

  _error() {
    return Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xff4c505b))),
            child: Text(
              'Error, try again',
            )));
  }

  _success(context) {
    Future(() {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    });
    return Center(child: Text('Sucesso'));
  }

  _showDialog(context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        insetPadding: EdgeInsets.symmetric(vertical: 280),
        // backgroundColor: Colors.blue,
        title: const Text('Login...'),
        content: AnimatedBuilder(
          animation: controller.state,
          builder: (context, child) {
            return stateManagement(controller.state.value, context);
          },
        ),
        actions: [],
      ),
    );
  }

  stateManagement(LoginState state, context) {
    switch (state) {
      case LoginState.initial:
        return Container();
      case LoginState.loading:
        return _loading();
      case LoginState.success:
        ;
        return _success(context);
      case LoginState.error:
        return _error();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //       // image: AssetImage('assets/login.png'), fit: BoxFit.cover),
      // ),
      width: MediaQuery.of(context).size.width * 0.5,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 96, 135, 142),
        body: Stack(
          children: [
            Container(),
            Container(
              padding: EdgeInsets.only(left: 35, top: 130),
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextField(
                            style: TextStyle(color: Colors.black),
                            onChanged: (value) {
                              username = value;
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Username",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            style: TextStyle(),
                            onChanged: (value) {
                              password = value;
                            },
                            onSubmitted: (value) {
                              controller.login(username, password);
                              _showDialog(context);
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sign in',
                                style: TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xff4c505b),
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      controller.login(username, password);
                                      _showDialog(context);
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  // Navigator.pushNamed(context, 'register');
                                },
                                child: Text(
                                  'Sign Up',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 18),
                                ),
                                style: ButtonStyle(),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
