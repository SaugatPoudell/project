import 'package:firstapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


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
      'https://example.com/user_photo.jpg'; 
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
    setState(()
    {
      loginValue=0;
      

    });
  },
  child: Text('Logout'),
)
            
            
    
           
          ],
        ),
      ),
    );
  }
}