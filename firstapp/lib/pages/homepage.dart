
// import 'dart:ffi';
import 'dart:convert';
import 'dart:io';

import 'package:firstapp/main.dart';
import 'package:firstapp/pages/CartPage.dart';
import 'package:firstapp/pages/infopage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:firstapp/pages/trending.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firstapp/pages/loginpage.dart';



class Data{
  List<Map<String, dynamic>> data = [];
 
}


Data data = Data();

List<Map<String, dynamic>> cart = [];



class HomePage extends StatefulWidget
{

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Icon cusIcon =Icon(Icons.search);
  Widget cusSearchBar = Text("Bikeszone");
  static const String KEYLOGIN="";
  
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData();
  }
    // Call fetchData() after a delay of 1 second
    
  
 Future<void> fetchData() async {
    String apiUrl = 'http://localhost:8080/api/getAllProducts'; // Replace this with your API endpoint
    try {
      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        // Assuming your API returns data in a similar format to your existing data
        data.data = List<Map<String, dynamic>>.from(jsonData);
        // print(jsonData);
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error loading data: $error');
    }
  }
  
  @override
  Widget build(BuildContext context)

  {
    return Scaffold(
backgroundColor: Colors.grey,
  appBar: AppBar(
    leading: IconButton(
      onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Trending()),
            );
      },
      icon:Icon(Icons.bolt),
    ),
    titleSpacing: 10.0,
          backgroundColor: Colors.orange,
        title:cusSearchBar,
         actions:<Widget>
         [
          IconButton(onPressed:(){
            setState(() {
              if(this.cusIcon.icon == Icons.search)
              {
                  this.cusIcon = Icon(Icons.cancel);
                this.cusSearchBar =TextField(
                  textInputAction: TextInputAction.go,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search gears here",
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                );
              }else
              {
 this.cusIcon =Icon(Icons.search);
 this.cusSearchBar = Text("Bikeszone");

              }
            });
          },
           icon:cusIcon,)
         ],
        //  bottom: PreferredSize(
        //   preferredSize:Size(50,50),
        //   child:Container(),
        //  ),
        ),
 body: Padding(
   padding: const EdgeInsets.all(5.0),
   child: GridView.builder(
    shrinkWrap: true,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,
    mainAxisSpacing: 2.0,crossAxisSpacing: 2.0),
     itemBuilder:(context,index)
     {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),),
        child: GridTile(
          header: Container(child: Text(data.data[index]["name"],
           style: TextStyle(color: Colors.white, fontSize:15.0),
          ),
          padding:EdgeInsets.all(5),
           decoration: BoxDecoration(color:Colors.orange),
           height: 30,//height added later
           ),
           child: GestureDetector(
            onTap: ()
            {
               Navigator.push(context,MaterialPageRoute(builder:(context)=>info(index:data.data[index]['id']??0)));
            },
             child: SingleChildScrollView(
               child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                        SizedBox(height: 20.0),
                        //  Image.asset('assets/${index + 1}.png'),
                         Image.asset(data.data[index]['product_image']),
                          // Image.network(data.data[index]["product_image"],
                          //need to manage it
                          Text(data.data[index]['description']),
                           SizedBox(height: 0.0),
                           Text(
                            "NRs " + (data.data[index]['price']),
                            style: TextStyle(color: const Color.fromARGB(255, 5, 4, 4),
                            fontSize:20.0),
                          ),
                          SizedBox(height: 0.0),
                         
                          Container(
                            width:double.infinity,
                            child: ElevatedButton(
                             onPressed: () { // Add the item to the cart
                 cart.add(data.data[index]);
                 // Navigate to the CartPage and pass the cart data
                 Navigator.push(
                   context,
                   MaterialPageRoute(
                     builder: (context) => CartPage(cartData: cart),
                   ), 
                 );
               },
                              style: ElevatedButton.styleFrom(backgroundColor:Colors.blue,
                              padding: EdgeInsets.all(5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              )
                              ),
                              child: Container(
                                child: Text('Add To Cart',
                                style: TextStyle(color: Colors.black,
                                fontSize:15.0),),
                              ),
                            ),
                          ),
                        ],
                     
                      ),
             ),
           ),
          // footer: Container(child: Text("NRs "+stockList[index].price.toString(),
          // style: TextStyle(color: Colors.white),),
          // padding:EdgeInsets.all(12),
          //  decoration: BoxDecoration(color:Colors.orange),
          //  ),
          // child:Image.network('https://miro.medium.com/v2/resize:fit:1358/1*LATm4vMh-oAKihKf0GNeaw.png',
          // scale:1.0,
          // fit:BoxFit.cover),
          ),
      );
     },
     itemCount: data.data.length,
     ),
  //  child: ListView.builder(itemCount:stockList.length,itemBuilder: (context, index){
  //   return Card(
  //     child: ListTile(
  //       onTap: (){},
  //       leading:CircleAvatar(
  //   radius: 60,
  //   backgroundImage:NetworkImage("${stockList[index].img}"),
  //  ),
  //       title: Text(" ${stockList[index].name}"),
  //       trailing:Text("\$ ${stockList[index].price}"),
  //     ),
  //   );
  //  },),
  
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
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage(),));
      }
      else
      {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login(),));
      }
  }else
  {
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login(),));
  }
}
}