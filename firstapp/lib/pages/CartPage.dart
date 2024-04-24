import 'package:flutter/material.dart';
import 'package:firstapp/pages/PaymentPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firstapp/pages/loginpage.dart';

List<dynamic> recoItems = [];
class CartPage extends StatefulWidget {
  final List<dynamic> cartData;

  const CartPage({required this.cartData});

 
  


  @override
  State<CartPage> createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  static const String KEYLOGIN="";
  static int ordersender=0;
  // 

  // }
  List<dynamic> productId=[];
double paymentPrice=0;
   double calculateTotalPrice() {
    double totalPrice=0;
    for (var item in widget.cartData) {
      double value =double.parse(item['price']);
      totalPrice=totalPrice+value;
    }
    return totalPrice;
  }
  void multiId(){
    for (var item in widget.cartData) {
      // double value =double.parse(item['price']);
      productId.add(item['id']);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use cartData to access the data
    return Scaffold(
     appBar: AppBar(
        title: Text('CartPage'),
        backgroundColor: Colors.yellowAccent,
      ),
      //my old code
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
               itemCount: widget.cartData.length,
              // itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {

                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      child: ListTile(
      
                         
                        // leading: Icon(Icons.done),
                        // title: Text('Item ${index + 1}: ${widget.cartData[index]}'),
                         leading: Image.asset('${widget.cartData[index]['product_image']}',
                         width: 50,
                         height: 50,
                         fit: BoxFit.cover,

                         ), 
  title: Text('Item ${index + 1}: ${widget.cartData[index]['name']}:'),
   subtitle: Text('Price: \NRs:${widget.cartData[index]['price']}'),

                        // title: Text(items[index]),
                        trailing: IconButton(
                          
                          icon: Icon(Icons.remove_circle_outline),
                          onPressed: () {
                          setState(() {
                            widget.cartData.removeAt(index);
                           
                          });
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(16.0),
            color: Colors.blue[200],
            child: ListTile(
                        leading: Icon(Icons.money),
                        title: Text('Total Price: \NRs:${calculateTotalPrice()}'),
                        trailing: ElevatedButton(
    onPressed: () {
      multiId();
       void orderNow() async {
        //  whereTogo();
    var url = "http://localhost:8080/api/createOrder";
    var data = {
      "productIds":productId,
      "total":calculateTotalPrice(),
    };
       print(data);
    var bodyy = json.encode(data);
    var urlParse = Uri.parse(url);
    var bearerToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOjIsImlhdCI6MTcxMjA3MTk3NSwiZXhwIjoxNzEyNTAzOTc1fQ.omhQeLN-lgxyEb9jIIp21OAUno-fkeMrd6bhuxhuaF8";
    var response = await http.post(
      urlParse,
      body: bodyy,
      headers: {"Content-type": "application/json","Authorization":"Bearer $bearerToken"},
    );
    var dataa = jsonDecode(response.body);
    print(dataa);
    ordersender=dataa['orderId'];
    
    // whereTogo();
    }
      orderNow();
      // fetchData();
      // if(true)
      // {
      //   print(productId);
      // }  

   
          ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('Your OTP has been sent to you Email'),
    duration: Duration(seconds:1), // Duration for which the snackbar should be displayed
  ),
);
 whereTogo();
     Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => PaymentPage(paymentPrice: calculateTotalPrice(),orderIds:ordersender),
  ),
);
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
    ),
    child: Text('Order Now'),
  ),
                      ),
            
          ),
        ],
      ),
    );
   
  }
  void whereTogo() async {
    var sharedpref =  await SharedPreferences.getInstance();
    var isLoggedIn = sharedpref.getBool(KEYLOGIN);
    if(isLoggedIn!=null)
    {
      if(isLoggedIn)
      {                           
                    widget.cartData.clear();        
      }
}
  }

      //new code starts from here//
//       body: ListView.builder(
//         itemCount: cartData.length,
//         itemBuilder: (context, index) {
//           // Use cartData[index] to access individual items
//           return ListTile(
//             title: Text('Item ${index + 1}: ${cartData[index]}'),
//           );
//         },
//       ),
//     );
//   }
// }

}