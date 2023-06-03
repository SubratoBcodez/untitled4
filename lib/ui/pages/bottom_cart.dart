import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final box = GetStorage();
  String? uid;
  String? email;

  delCart(docid) async {
    return FirebaseFirestore.instance
        .collection('user\'s_cart')
        .doc(uid)
        .collection('items')
        .doc(docid)
        .delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> userCart() async* {
    yield* FirebaseFirestore.instance
        .collection('user\'s_cart')
        .doc(uid)
        .collection('items')
        .snapshots();
  }

  @override
  void initState() {
    uid = box.read('uid');
    email = box.read('email');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User\'s Cart'),
        centerTitle: true,
      ),
      body: Container(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: userCart(),
              builder: ((context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  final docs = snapshot.data!.docs;
                  if (docs.length == 0) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (_, index) {
                          return Card(
                            child: ListTile(
                              title: Text(
                                docs[index]['title'],
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                '\$ ${docs[index]['price']}'.toString(),
                              ),
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    NetworkImage(docs[index]['img_url'][0]),
                              ),
                              trailing: IconButton(
                                  onPressed: () => delCart(docs[index].id),
                                  icon: Icon(
                                    Icons.remove_circle_outline,
                                    color: Colors.red,
                                  )),
                            ),
                          );
                        });
                  }
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }))),
    );
  }
}
