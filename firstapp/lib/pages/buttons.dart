// buttons.dart

import 'package:firstapp/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class adminnew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: ButtonsPage(),
    );
  }
}

class ButtonsPage extends StatefulWidget {
  @override
  _ButtonsPageState createState() => _ButtonsPageState();
}

class _ButtonsPageState extends State<ButtonsPage> {
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name = '';
  String description = '';
  double price = 0;
  String image = '';
  int categoryId = 1;
  String id ="";
  String userId='';
  bool showContainer1 = false;
  bool showContainer2 = false;
  bool showContainer3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Admin Panel'),
          backgroundColor:Colors.blue,
leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => MyApp()),
      );
      
            },
        ),
       
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showContainer1 = true;
                  showContainer2 = false;
                  showContainer3 = false;
                });
              },
              child: Text('Add Item'),
            ),
            SizedBox(height:20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showContainer1 = false;
                  showContainer2 = true;
                  showContainer3 = false;
                });
              },
              child: Text('Remove Item'),
            ),
             SizedBox(height:20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showContainer1 = false;
                  showContainer2 = false;
                  showContainer3 = true;
                });
              },
              child: Text('Drop User'),
            ),
            SizedBox(height: 30),
            if (showContainer1) Container(
              width: 300,
              height: 400,
               padding: EdgeInsets.all(20),
              decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(20),
            color: Colors.green,
        ),
              child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Name',
              ),
              validator: (value) {
                if (value?.isEmpty ?? true)  {
                  return 'Please enter product name';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Description',
              ),
              onChanged: (value) {
                setState(() {
                  description = value;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Price',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  price = double.tryParse(value) ?? 0;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Image',
              ),
              onChanged: (value) {
                setState(() {
                  image = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
             onPressed: () {
  if (_formKey.currentState?.validate() ?? false) {
    postData();
    // Form is valid, you can perform actions here
    // void postData() async {
    //   var url= Uri.parse('http://localhost:8080/api/createProduct');
    //   var bodyData=
    //   {
    //     'category_id':categoryId,
    //     'name':name,
    //     'description':description,
    //     'price':price,
    //     'image':image
    //   };
      
    //     var response =await http.post(
    //       url,
    //       body:bodyData,
    //     );
    //     print(response);
 
    // }
    print('Form is valid');
    print('Name: $name');
    print('Description: $description');
    print('Price: $price');
    print('Image: $image');
    print('Category ID: $categoryId');
  }
},
              child: Text('Submit'),
            ),
          ],
        ),
      ),
            ),
              
            if (showContainer2) 
            Container(
      width: 300,
      height: 200,
    
      decoration:(
        BoxDecoration(
          borderRadius: BorderRadius.circular(20),
            color: Colors.red,
        )
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            onChanged: (value) {
              id = value;
            },
            decoration: InputDecoration(
              hintText: 'Enter ID',
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Perform actions with the ID value
              print('ID: $id');
            },
            child: Text('Submit'),
          ),
        ],
      ),
            ),
      
                SizedBox(height: 30),
            if(showContainer3) Container(
      width: 300,
      height: 200,
     
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
      borderRadius:BorderRadius.circular(20),
       color: Colors.blue,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            onChanged: (value) {
              id = value;
            },
            decoration: InputDecoration(
              hintText: 'Enter User ID To remove',
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Perform actions with the ID value
              // postData();
              // print('ID: $userId');
            },
            child: Text('Submit'),
          ),
        ],
      ),
            ),
          ],
        ),
      ),
    );
  }
  
    void postData() async {
      var url= Uri.parse('http://localhost:8080/api/createProduct');
      var bodyData=
      {
        'category_id':categoryId,
        'name':name,
        'description':description,
        'price':price,
        'image':image
      };
      var token='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOjIsImlhdCI6MTcxMjU5MDcwNSwiZXhwIjoxNzEzMDIyNzA1fQ.MWtxSf-9SEk3tvZyKZSxDL_V-dXmiTTxMQgCsx6bx2Y';
      var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
       var bodyDataen=jsonEncode(bodyData);
        var response =await http.post(
          url,
          headers:headers,
          body:bodyDataen,
        );
        print(response.body);


  }
}

//test

  // void registerUser() async {
  //   var url = "http://localhost:8080/api/register";
  //   var data = {
  //     "name": nameController.text,
  //     "email": emailController.text,
  //     "password": passwordController.text,
  //     "password_confirm": repasswordController.text,
  //     "address": addressController.text,
  //   };
  //   var bodyy = json.encode(data);
  //   var urlParse = Uri.parse(url);
  //   var response = await http.post(
  //     urlParse,
  //     body: bodyy,
  //     headers: {"Content-type": "application/json"},
  //   );
  //   var dataa = jsonDecode(response.body);
  //   print(dataa);
  // }
