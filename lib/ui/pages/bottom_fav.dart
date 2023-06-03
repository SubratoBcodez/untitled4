import 'package:flutter/material.dart';

class BottomFav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
      ),
      body: Container(
        child: Column(
          children: [
            Center(
              child: Text('Fav'),
            )
          ],
        ),
      ),
    );
  }
}
