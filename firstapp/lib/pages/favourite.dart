import 'package:flutter/material.dart';

class FavPage extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.orange,
          title:
           Center(child: const Text('Favourites')),
           
        ),
    );
  }
}