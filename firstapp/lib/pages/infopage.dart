import 'package:firstapp/pages/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Data{
  List<Map<dynamic, dynamic>> data = [
    {

    },
    {
     
    }
  ];
}
// List<Map<String, dynamic>>recItems=[];
Data data = Data();

List<Map<String, dynamic>> cart = [];

class Product {
  final String name;
  final double price;
  final String imageUrl;

  Product({required this.name, required this.price, required this.imageUrl});
}



class info extends StatefulWidget {
  

   final int index;
   info({super.key, required this.index});

  @override
  State<info> createState() => _infoState();
}

class _infoState extends State<info> {


  // @override
  int id=0;
  String image='';
  String desc='';
  String name='';
  String price='';
  int datavalue=0;
  // String recName='';
  // int recPrice=0;
  // String recImg='';
  // String recname='';
  //  int recid=0;
  Future<void> fetchData() async {
    String apiUrl = 'http://localhost:8080/api/getSingleProduct/${widget.index}'; // Replace this with your API endpoint

    try {
      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        // Map<String, dynamic> jsonData = json.decode(response.body);
     final Map<dynamic, dynamic> jsonData= json.decode(response.body);
     print("*************************");
     print(jsonData);
        //  List<dynamic> recommendItems = jsonData['recommendItems'];
        // Assuming your API returns data in a similar format to your existing data
        //put this line of code inside other try cathc file not in this one

       
        print("&&&&&&&&&&&");
      //   print(data.data);
      if(jsonData['recommendItems'].length!=0)
      {
      data.data = List<Map<dynamic, dynamic>>.from(jsonData['recommendItems']);
      }
      else
      {
        setState(() {
          datavalue=1;
        });
      }

     
        // for(var items in recommendItems)
        // {
        //   setState(() {
        //     recName=items['name'];
        //     recImg=items['price'];
        //   });
        //   print('Recommended Items ${items['name']}, ${items['id']}');

        // }
        // print(data.data);

        // print(jsonData);
        //  print(data.data);
        setState(() {
          name =(jsonData['productById']['name']);
        id =(jsonData['productById']['id']);
        desc=(jsonData['productById']['description']);
        image=(jsonData['productById']['product_image']);
        price=(jsonData['productById']['price']);

        });
        
        //  return Future.value();

      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error loading data: $error');
    }
     
  }
  @override
  void initState() {
    super.initState();
    fetchData();
    // useData();
  }

  @override
  
  Widget build(BuildContext context) {
       
  
     return Scaffold(
       appBar: AppBar(
          title: Center(child: Text('Details')),
          backgroundColor:Colors.blue,
leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
        ),
       
      ),
      body:Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height:400,
                width:100,
                color:Colors.blue,
                child:Column(
                  children: [
                    Image.asset(image,
                    width: 200,
                    height: 200
                    ),
                    Text((price).toString(),
                    style: TextStyle(
                      fontSize:30,
                      color: Colors.yellow,
                    ),
                    ),
                    Text(name,
                    style: TextStyle(
                      fontSize:30,
                      color: Colors.yellow,
                    ),),
                    // Text((id).toString(),
                    // style: TextStyle(
                    //   fontSize:30,
                    //   color: Colors.yellow,
                    // ),),
                    Text(desc,
                    style: TextStyle(
                      fontSize:20,
                      color: Colors.yellow,
                    ),),
                  ],
                ),
          
              ),
            ),
          ],
        ),
    
    
        SizedBox(height: 10), // Adding some spacing between the Row and the ListView
        Text(
          "Recommended Products",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        
        Expanded(
          child:datavalue==0?ListView.builder(
            itemCount: data.data.length,
            itemBuilder: (context, index)
            {
              return   ListTile(
                leading: Image.asset(data.data[index]['product_image'],
                         width: 50,
                         height: 50,
                         fit: BoxFit.cover,

                         ), 
  title: Text('Item ${index + 1}: ${data.data[index]['name']}:'),
   subtitle: Text('Price: \NRs:${(data.data[index]['price']).toString()}'),
    trailing: Text(data.data[index]['description']),
    );
    //this line works only if the recommended value is not equal to 0 or null


                // title: Text(data.data[index]['name']),
                // subtitle: Text(data.data[index]['price']),
                // trailing: Text(data.data[index]['description']),
              
            },
            // children: <Widget>[
            //   ListTile(
            //     title: Text(recName),
            //     // subtitle: Text((recommendedItems[0]['id']).toString()),
            //     trailing: Text(recImg),
            //   ),
            //   ListTile(
            //     title: Text("Recommendationed Product"),
            //     subtitle: Text('Name'),
            //     trailing: Text("\$20"),
            //   ),
            //   // Add more ListTile widgets as needed
            // ],
          ): Center(
          child: Text(
            'No recommended products available for now',
            style: TextStyle(fontSize: 20,
            fontStyle:FontStyle.italic),
          ),
        ),
        )
      ],
    )
     );
  }
}
// class DividerPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: Container(
//                 height:350,
//                 width:100,
//                 color:Colors.blue,
//                 child:Column(
//                   children: [
//                     Image.asset('assets/1.png',
//                     width: 200,
//                     height: 200),
//                     Text("Index"),
//                     Text("PRice"),
//                     Text("Description")
//                   ],
//                 ),
          
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 20), // Adding some spacing between the Row and the ListView
//         Text(
//           "Recommended Products",
//           textAlign: TextAlign.center,
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         Expanded(
//           child: ListView(
//             children: <Widget>[
//               ListTile(
//                 title: Text("Product 1"),
//                 subtitle: Text("Description of Product 1"),
//                 trailing: Text("\$10"),
//               ),
//               ListTile(
//                 title: Text("Product 2"),
//                 subtitle: Text("Description of Product 2"),
//                 trailing: Text("\$20"),
//               ),
//               // Add more ListTile widgets as needed
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }


  