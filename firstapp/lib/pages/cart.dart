import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



class aCart extends StatelessWidget {
  aCart({super.key});

 
final List<String> items = ['Item 1', 'Item 2', 'Item 3'];

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
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
                        leading: Icon(Icons.done),
                        title: Text(items[index]),
                        trailing: IconButton(
                          icon: Icon(Icons.remove_circle_outline),
                          onPressed: () {
                          
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
                        title: Text('Total'),
                        trailing: Row(
                           mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              
                              icon: Icon(Icons.shopping_bag),
                              onPressed: () {
                                // Add your onTap functionality here
                              },
                             
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              'Order',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
            
          ),
        ],
      ),
    );
  }
}