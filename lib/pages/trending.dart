import 'package:flutter/material.dart';

class Trending extends StatelessWidget {
  const Trending({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
        ),
        title: Center(child: Text("Trending products")),
        backgroundColor:Colors.orange,
      ),
      // body: ListView.builder(
      //   itemCount: items.length,
      //   itemBuilder: (context,index)
      //   {
      //     return ListTile(
      //       leading:Text("nname"),
      //       title: Text("product name"),
      //       onTap:()
      //       {

      //       }
      //     );
      //   }
      //   ),

  
    );
  }
}