import 'package:flutter/material.dart';
import 'package:untitled4/ui/widgets/custom_button.dart';

class Details extends StatelessWidget {
  var data;
  Details({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Page'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Image.network(
              data['img_url'],
              height: 200,
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['title'],
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    data['info'],
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '\$ ${data['price']}'.toString(),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.red),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  customButton('Add to Cart', () {}),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            print(data);
          },
          label: Text('Print')),
    );
  }
}
