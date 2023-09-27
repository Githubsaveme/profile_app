import 'dart:io';

import 'package:flutter/material.dart';
import 'package:profile_app/ui/graphScreen.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  String title = "My Profile";
  String buttonText = "Edit Profile";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Container(
        margin: Platform.isIOS
            ? const EdgeInsets.only(left: 20, right: 20, bottom: 30)
            : EdgeInsets.zero,
        width: size.width,
        height: size.width * 0.13,
        child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero)),
            child: Text(
              buttonText,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.04),
            )),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                    size: size.width * 0.05,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            leadingWidth: size.width * 0.35,
            expandedHeight: size.height / 3.3,
            collapsedHeight: 100,
            floating: true,
            pinned: true,
            snap: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Stack(
                children: [
                  ClipPath(
                    clipper: RoundedClipper(),
                    child: Container(
                      height: size.height / 3,
                      width: size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.orange,
                            Colors.orange, Colors.yellowAccent,
                            const Color(0xFFCD3B3B).withOpacity(1),
                            // Color(0xFFEE9260),
                            // Color(0xFFCD3B3B),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          padding: EdgeInsets.all(size.width * 0.02),
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: ClipOval(
                              child: Image.network(
                            'https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cGVyc29ufGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
                            height: size.width * 0.36,
                            width: size.width * 0.36,
                            fit: BoxFit.cover,
                          )))),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: EdgeInsets.all(size.width * 0.02),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(size.width * 0.04)),
                          color: Colors.red,
                          shape: BoxShape.rectangle),
                      child: CircleAvatar(
                          radius: size.width * 0.05,
                          backgroundColor: Colors.redAccent,
                          child: IconButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const GraphScreen();
                                }));
                              },
                              icon: const Icon(
                                Icons.auto_graph_outlined,
                                color: Colors.white,
                              ))),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                  hintText: 'First name',
                  prefixIcon: Icon(
                    Icons.account_box_outlined,
                    color: Colors.redAccent,
                  )),
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                  hintText: 'Email Address',
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Colors.redAccent,
                  )),
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: 'Mobile Number',
                  prefixIcon: Icon(
                    Icons.phone_android_sharp,
                    color: Colors.redAccent,
                  )),
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: 'City',
                  prefixIcon: Icon(
                    Icons.location_city,
                    color: Colors.redAccent,
                  )),
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: 'State',
                  prefixIcon: Icon(
                    Icons.location_city,
                    color: Colors.redAccent,
                  )),
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: 'Address',
                  prefixIcon: Icon(
                    Icons.location_city,
                    color: Colors.redAccent,
                  )),
            ),
            SizedBox(
              height: size.width * 0.15,
            ),
          ]))
        ],
      ),
    );
  }
}

class RoundedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 100);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
