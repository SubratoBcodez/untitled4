import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled4/ui/route/route.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BottomHome extends StatefulWidget {
  BottomHome({super.key});

  @override
  State<BottomHome> createState() => _BottomHomeState();
}

class _BottomHomeState extends State<BottomHome> {
  List data = [];

  bool value = false;

  fetchData() {
    FirebaseFirestore.instance
        .collection('foods')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        data.add({
          'title': element['title'],
          'info': element['info'],
          'price': element['price'],
          'img_url': element['img_url'],
          'document_id': element.id,
        });
      });
      setState(() {
        value = true;
      });
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Container(
        child: Visibility(
          visible: value,
          replacement: Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Stack(
                    children: [
                      InkWell(
                          onTap: () {
                            Get.toNamed(details, arguments: data[index]);
                          },
                          splashColor: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: data[index]['img_url'][0],
                              key: UniqueKey(),
                              height: 200,
                              width: double.maxFinite,
                              fit: BoxFit.cover,
                            ),
                          )),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        right: 0,
                        child: Text(
                          data[index]['title'],
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
