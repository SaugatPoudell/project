import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firstapp/main.dart';

class PaymentPage extends StatefulWidget {
  final double paymentPrice;
  final int orderIds;

  PaymentPage({Key? key, required this.paymentPrice, required this.orderIds}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
   TextEditingController orderController = TextEditingController();


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
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Payment Price: ${widget.paymentPrice}'),
          ),
          ListTile(
            title: TextFormField(
              controller: otpController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid OTP';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'OTP',
              ),
            ),
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
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                // If form is valid, proceed with OTP validation
                await fetchOtpData();
              }
            },
            child: Text('Confirm Order'),
          ),
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
      print("Data from API: $dataa");
      // Handle API response here
    } else {
      print("API call failed");
      // Handle API failure here
    }
  }
}
