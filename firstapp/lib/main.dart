import 'package:firstapp/pages/favourite.dart';
import 'package:firstapp/pages/profile.dart';
import 'package:firstapp/pages/homepage.dart';
import 'package:flutter/material.dart';
// import  'package:firstapp/pages/infopage.dart';
import  'package:firstapp/pages/cart.dart';
import  'package:firstapp/pages/loginpage.dart';
import  'package:firstapp/pages/RegistrationPage.dart';
import 'package:provider/provider.dart';
import 'package:firstapp/pages/adminpanel.dart';
import 'package:firstapp/pages/CartPage.dart';
import 'package:firstapp/pages/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firstapp/pages/buttons.dart';



void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int loginValue = 0;
  static const String KEYLOGIN = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies(); // Call super.initState() first
    // Call your function her;le
     Future.delayed(Duration(seconds: 3), () {
      setState(() {
          HomePage();
      });
    });

    Nav();
  }

  void Nav() async {
    var sharedpref = await SharedPreferences.getInstance();
    bool? isLoggedIn = sharedpref.getBool(MyAppState.KEYLOGIN);
    if (isLoggedIn != null && isLoggedIn==true) { // Check if isLoggedIn is not null
      setState(() {
        loginValue = 1; // Update loginValue based on isLoggedIn
      });
    }
    
  }


  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    
  final List<Widget> _pages = [
    HomePage(),
    // AdminPanel(),]
    CartPage(cartData: cart),
    // ButtonsPage(),
    // LoginForm(),
     loginValue == 1 ? UserProfile() : LoginForm() ,
  ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: 'Cart', icon: Icon(Icons.shopping_basket)),
            BottomNavigationBarItem(
              label: loginValue == 1 ? 'User Profile' : 'Log In',
              icon: loginValue == 1 ? Icon(Icons.person) : Icon(Icons.login_outlined),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
  void callHome()
  {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomePage()),
  );
  }
}
