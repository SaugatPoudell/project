import 'package:firstapp/main.dart';
import 'package:firstapp/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';


// class Profile extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'User Profile',
//       home: UserProfile(),
//       color:Colors.red,
//     );
//   }
// }

class UserProfile extends StatefulWidget {
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  int loginValue=1;

  final String userEmail = 'UserEmail'; 
 // Replace with user's email
  final String userName='UserName';

  final String userPhotoURL =
      'https://picsum.photos/id/237/5000/5000'; 
 // Replace with user's photo URL
      final String number="98123456789";

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(  
       appBar: AppBar(
          backgroundColor: Colors.orange,
          title:
           Center(child: const Text('User Profile')),
           
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(userPhotoURL),
            ),
             SizedBox(height: 20),
            Text(
              userName,
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 20),
            Text(
              userEmail,
              style: TextStyle(fontSize: 20),
            ),
               Text(
              number,
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
  onPressed: () {
    //  Navigator.push(
    // context,
    // MaterialPageRoute(builder: (context) => MyApp()),
    // );
    // setState(()
    // {
       void putValue() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool(MyAppState.KEYLOGIN, false);
      Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MyApp()),
    );
  }
  // runApp(MyApp());
      // loginValue=0;
   
    // // }
    // );
    putValue();
  },
  child: Text('Logout'),
)
            
            
    
           
          ],
        ),
      ),
    );
  }
}