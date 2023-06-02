import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled4/ui/widgets/custom_button.dart';

class Details extends StatefulWidget {
  var data;
  Details({required this.data});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final box = GetStorage();
  String? uid;
  String? email;

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  @override
  void initState() {
    uid = box.read('uid');
    email = box.read('email');
    print(uid);
    print(email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _dataLength;
    var _index;
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
            Stack(
              children: [
                InkWell(
                  child: CarouselSlider(
                    carouselController: carouselController,
                    options: CarouselOptions(
                      scrollPhysics: const BouncingScrollPhysics(),
                      autoPlay: true,
                      aspectRatio: 2,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                    items: widget.data['img_url']
                        .map<Widget>((item) => Container(
                              child: Center(
                                  child: Image.network(item,
                                      fit: BoxFit.cover,
                                      width: double.maxFinite)),
                            ))
                        .toList(),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.data['img_url']
                        .asMap()
                        .entries
                        .map<Widget>((entry) {
                      return GestureDetector(
                        onTap: () =>
                            carouselController.animateToPage(entry.key),
                        child: Container(
                          width: currentIndex == entry.key ? 17 : 7,
                          height: 7.0,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 3.0,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: currentIndex == entry.key
                                  ? Colors.red
                                  : Colors.teal),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            // Image.network(
            //   widget.data['img_url'][0],
            //   height: 200,
            //   width: double.maxFinite,
            //   fit: BoxFit.cover,
            // ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data['title'],
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.data['info'],
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '\$ ${widget.data['price']}'.toString(),
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
            print(widget.data);
          },
          label: Text('Print')),
    );
  }
}
