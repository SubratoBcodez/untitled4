import 'package:flutter/material.dart';

class Menu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 2,
              mainAxisSpacing: 20,
              mainAxisExtent: 250,
            ),
            itemCount: 6,
            itemBuilder: (_, index) {
              return Expanded(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(blurRadius: 3.3, color: Colors.grey)
                              ]),
                          child: Column(
                            children: [
                              SizedBox(
                                  width: 180,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 110, left: 25),
                                    child: Text(
                                      "Title",
                                      style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.w600),
                                    ),

                                  )),
                              SizedBox(height: 10,),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: -10,
                        left: 34,
                        child: Container(
                          child: Icon(Icons.ac_unit),
                          height: 125,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.pink.shade100,
                            boxShadow: [
                              BoxShadow(blurRadius: 2, color: Colors.grey),
                            ],
                          ),
                        ),
                      )
                    ],
                  ));
            },
          ),
        ),
      ),
    );
  }
}
