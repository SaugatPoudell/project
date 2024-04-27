import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Panel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AdminPanel(),
    );
  }
}

class AdminPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
        backgroundColor: Colors.orange,
        
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
               decoration: InputDecoration(
                  hintText: 'Enter the item name you want to remove '
              ),
                // controller: addressController,
                validator: (value) {
                  if (value == null || value.isEmpty) 
                  //  || isNumeric(value)
                  {
                    return 'Please enter your address';
                  }
                  return null;
                },
            ),
            ElevatedButton(
              onPressed: () {
                // Add functionality to manage users
              },
              child: Text('Remove Items'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality to manage content
              },
              child: Text('Remove Items'),
          
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality to view analytics
              },
              child: Text('Confirm Order'),
            ),
          ],
        ),
      ),
    );
  }
}
