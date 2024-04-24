import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart'; 

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>(); // Add a GlobalKey<FormState>

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form( // Wrap your form with a Form widget
          key: _formKey, // Set the GlobalKey<FormState>
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty || isNumeric(value)) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Name',
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // Basic email validation
                  if (!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                obscureText: true,
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                obscureText: true,
                controller: repasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  // Validate password match
                  if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: addressController,
                validator: (value) {
                  if (value == null || value.isEmpty || isNumeric(value)) {
                    return 'Please enter your address';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Address',
                ),
              ),
              SizedBox(height: 40,),
              GestureDetector(
                onTap: (){
                  if (_formKey.currentState!.validate()) { // Validate the form
                    registerUser();
                  }
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: Text('Register')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void registerUser() async {
    var url = "http://localhost:8080/api/register";
    var data = {
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "password_confirm": repasswordController.text,
      "address": addressController.text,
    };
    var bodyy = json.encode(data);
    var urlParse = Uri.parse(url);
    var response = await http.post(
      urlParse,
      body: bodyy,
      headers: {"Content-type": "application/json"},
    );
    var dataa = jsonDecode(response.body);
    print(dataa);
  }


  
  bool isNumeric(String value) {
     if (value == null) {
    return false;
  }
  return double.tryParse(value) != null;
}

  }

