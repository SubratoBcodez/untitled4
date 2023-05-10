import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _contactontroller = TextEditingController();
  final TextEditingController _updatetontroller = TextEditingController();

  Box? contactBox;
  @override
  void initState() {
    contactBox = Hive.box('contact-list');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
        child: Column(
          children: [
            TextField(
              controller: _contactontroller,
              decoration: InputDecoration(
                hintText: 'enter contact number',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                  onPressed: () async {
                    final userInput = _contactontroller.text;
                    print(userInput);
                    await contactBox!.add(userInput);
                    _contactontroller.clear();
                    Get.snackbar('Added', 'add successfull');
                  },
                  child: Text('Add Contact')),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: Hive.box('contact-list').listenable(),

                builder:
                    (BuildContext context, Box<dynamic> value, Widget? child) {
                  return ListView.builder(
                      itemCount: contactBox!.keys.toList().length,
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Card(
                              elevation: 2,
                              child: ListTile(
                                title: Text(contactBox!.getAt(index)),
                                trailing: SizedBox(
                                  width: 80,
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            showDialog(
                                                context: context,
                                                builder: (_) {
                                                  return Dialog(
                                                    child: Container(
                                                      height: 200,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(25),
                                                        child: Column(
                                                          children: [
                                                            TextField(
                                                              controller:
                                                                  _updatetontroller,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    'update contact number',
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            SizedBox(
                                                              width: 250,
                                                              child:
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () async {
                                                                        final input =
                                                                            _updatetontroller.text;
                                                                        contactBox!.putAt(
                                                                            index,
                                                                            input);
                                                                        _updatetontroller
                                                                            .clear();
                                                                        Get.back();
                                                                        Get.snackbar(
                                                                            'Updated',
                                                                            'update successfull');
                                                                      },
                                                                      child: Text(
                                                                          'Update Contact')),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.green,
                                          )),
                                      IconButton(
                                          onPressed: () async {
                                            await contactBox!.deleteAt(index);
                                          },
                                          icon: Icon(
                                            Icons.delete_forever,
                                            color: Colors.red,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                },
                // child: ListView.builder(
                //     itemCount: contactBox!.keys.toList().length,
                //     itemBuilder: (_,index){
                //   return Card(
                //     elevation: 2,
                //     child: ListTile(
                //       title: Text(contactBox!.getAt(index)),
                //     ),
                //   );
                // }),
              ),
            )
          ],
        ),
      ),
      // body: SafeArea(
      //   child: Center(
      //       child: Text(
      //         'Welcome to Home\n Chorui',
      //     style: TextStyle(fontFamily: 'Autodex', fontSize: 40),
      //   )),
      // ),
    );
  }
}
