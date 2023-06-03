import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled4/ui/style/style.dart';
import 'package:untitled4/ui/widgets/custom_button.dart';

import '../route/route.dart';

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
  addToFav() async {
    FirebaseFirestore.instance
        .collection('user\'s_fav')
        .doc(uid)
        .collection('items')
        .doc()
        .set({
          'title': widget.data['title'],
          'info': widget.data['info'],
          'price': widget.data['price'],
          'img_url': widget.data['img_url'],
          'document_id': widget.data['document_id']
        })
        .then((value) => Get.showSnackbar(AppStyle().successSnack('Fav added')))
        .catchError((erorr) => Get.showSnackbar(AppStyle().failedSnack(erorr)));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> checkFav() async* {
    yield* FirebaseFirestore.instance
        .collection('user\'s_fav')
        .doc(uid)
        .collection('items')
        .where('document_id', isEqualTo: widget.data['document_id'])
        .snapshots();
  }

  addToCart() async {
    FirebaseFirestore.instance
        .collection('user\'s_cart')
        .doc(uid)
        .collection('items')
        .doc()
        .set({
          'title': widget.data['title'],
          'info': widget.data['info'],
          'price': widget.data['price'],
          'img_url': widget.data['img_url'],
          'document_id': widget.data['document_id']
        })
        .then((value) =>
            Get.showSnackbar(AppStyle().successSnack('Item\'s added')))
        .catchError((erorr) => Get.showSnackbar(AppStyle().failedSnack(erorr)));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> checkCart() async* {
    yield* FirebaseFirestore.instance
        .collection('user\'s_cart')
        .doc(uid)
        .collection('items')
        .where('document_id', isEqualTo: widget.data['document_id'])
        .snapshots();
  }

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
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: checkFav(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                      child: Icon(Icons.favorite_border_rounded),
                    );
                  }
                  return IconButton(
                      onPressed: () => snapshot.data!.docs.isEmpty
                          ? addToFav()
                          : Get.showSnackbar(
                              AppStyle().failedSnack('Already Added')),
                      icon: snapshot.data!.docs.isEmpty
                          ? Icon(Icons.favorite_border)
                          : Icon(Icons.favorite));
                }),
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
                          .map<Widget>(
                            (item) => CachedNetworkImage(
                              imageUrl: item,
                              key: UniqueKey(),
                              height: 200,
                              width: double.maxFinite,
                              fit: BoxFit.cover,
                            ),
                          )
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
                          .map<Widget>((item) {
                        return GestureDetector(
                          onTap: () =>
                              carouselController.animateToPage(item.key),
                          child: Container(
                            width: currentIndex == item.key ? 17 : 7,
                            height: 7.0,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 3.0,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: currentIndex == item.key
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
                    customButton('Add to Cart', () => addToCart()),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => Get.toNamed(cart),
            child: Icon(Icons.shopping_cart_outlined)));
  }
}
