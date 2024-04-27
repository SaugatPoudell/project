import 'dart:convert';
import 'package:firstapp/pages/CartPage.dart';
import 'package:firstapp/pages/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firstapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CartPage.dart';

class PaymentPage extends StatefulWidget {
  final double paymentPrice;
  final int orderIds;
  final int Otp;
  PaymentPage({Key? key,required this.paymentPrice, required this.orderIds, required this.Otp}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isLoggedIn=false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
   TextEditingController orderController = TextEditingController();
 @override
  void initState() {
    super.initState();
    getLoginStatus();
  }
 Future<void> getLoginStatus() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    bool? loginStatus = sharedPref.getBool(MyAppState.KEYLOGIN);
    if (loginStatus != null) {
      setState(() {
        isLoggedIn = loginStatus;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Process order'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          },
        ),
      ),
      body:
      ListView(
        children: <Widget>[
          ListTile(
            title: Text('Payment Price: ${widget.paymentPrice}'),
          ),
          isLoggedIn ?
          ListTile(
title: TextFormField(
  controller: otpController,
  //  validator: (value) {
  //     if (value == null || value.isEmpty || value != widget.Otp.toString()) {
  //       return 'Please enter a valid OTP';
  //     }
  //     return null;
  //   },
    decoration: InputDecoration(
      hintText: 'OTP',
  ),
),
          ):
          ListTile(
            title:Center(child: Text("Please Login First to proceed your order"))
          ),
          //  ListTile(
          //   title: TextFormField(
          //     controller: orderController,
          //     validator: (value) {
          //       if (value == null || value.isEmpty) {
          //         return 'Please enter a valid OrderID';
          //       }
          //       return null;
          //     },
          //     decoration: InputDecoration(
          //       hintText: 'Order',
          //     ),
          //   ),
          // ),
          isLoggedIn
    ? ElevatedButton(
        onPressed: () {
          var otpV = otpController.text;
          print(otpV);
          print(widget.Otp);
          print("inside on pressed");
          fetchOtpData();
        },
        child: Text('Confirm Order'),
      )
    : Column(
        children: [
          ListTile(
            title: Center(child: Text("Payment Page can be accessed when Logged In")),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
            },
            child: Text('Go to Login Page'),
          ),
        ],
      ),
        
// if () {
//   if(otpController.text==null && otpController.text.isEmpty)
//   {
  // print(otpController.text);
  //after this
// if(otpV.isEmpty || otpV!=widget.Otp)
// {
// ScaffoldMessenger.of(context).showSnackBar(
// SnackBar(
// content: Text('Please Enter a Valid OTP S'),
// duration: Duration(seconds: 1),
// ),
// );
// }
// else
// {
//   ScaffoldMessenger.of(context).showSnackBar(
// SnackBar(
// content: Text('Order Completed OTP validated'),
// duration: Duration(seconds: 1),
// ),
//   );
// }
// }


        ],
      ),
    );
  }

  Future<void> fetchOtpData() async {
    var url = "http://localhost:8080/api/verifyOTP";
    var data = {
      "otp": otpController.text,
      // "orderId":orderController.text
      // "orderId": widget.orderIds.toString(),
    };
    var bodyy = json.encode(data);
    var urlParse = Uri.parse(url);
    var response = await http.post(
      urlParse,
      body: bodyy,
      headers: {"Content-type": "application/json"},
    );

    if (response.statusCode == 200) {
      var dataa = jsonDecode(response.body);
      print("responsepnse");
      print("Data from API: $dataa");
      if(dataa['otp']!=data['otp'])
      {
        ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text('Order has been placed'),
duration: Duration(seconds: 1),
),
  );
      }
      // Handle API response here
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text('OTP has been expired or user need to login again'),
duration: Duration(seconds: 1),
),
  );
      // Handle API failure here
    }
  }
}

