import 'dart:convert';
import 'package:firstapp/pages/AdminLogin.dart';
import 'package:firstapp/pages/helper.dart';
import 'package:firstapp/pages/RegistrationPage.dart';
import 'package:firstapp/main.dart';
import 'package:firstapp/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firstapp/pages/homepage.dart';

class Login extends StatelessWidget {
  const Login({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Center(child: Text('User Login Page')),
      ),
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Login Page')),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
                  Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyApp()));
            },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(hintText: 'Email'),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(hintText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                login();
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: Text('Login')),
              ),
            ),
          SizedBox(height: 40),
            GestureDetector(
              onTap: () {
               Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignUpScreen()), );
        },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: Text('Click here for New Registration of User')),
              ),
            ),
             SizedBox(height: 40),
            GestureDetector(
              onTap: () {
               Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminLogin()),);
        },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: Text('Admin Panel Login')),
              ),
            ),
          

          ],
        ),
      ),
    );
  }

  void login() async {
    var url = "http://localhost:8080/api/login";
    var data = {
      "email": emailController.text,
      "password": passwordController.text,
    };
    var bodyy = json.encode(data);
    var urlParse = Uri.parse(url);
    var response = await http.post(
      urlParse,
      body: bodyy,
      headers: {"Content-type": "application/json"},
    );
    var dataa = jsonDecode(response.body);
    print(dataa['message']);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(dataa['message']),
        duration: Duration(seconds: 1),
      ),
    );

    if (response.statusCode == 200 && dataa['status'] == 'success') {
      putValue();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    }
  }

  void putValue() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool(MyAppState.KEYLOGIN, true);
  }
}

