import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:profile_app/ui/flChartGraph.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Timer(
        const Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const LineChartSample2())));
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          tileMode: TileMode.clamp,
          begin: Alignment.topCenter,
          colors: [Colors.white, Colors.white],
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.width * 0.1,
              ),
              Center(
                  child: Image.asset(
                'asset/image/splash.gif',
                height: 200,
              )),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'TDR Application',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: size.width * 0.08),
                )
                    .animate(
                      delay: 1000.ms,
                      onPlay: (controller) => controller.repeat(), // loop
                    )
                    .shimmer(delay: 500.ms),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(color: Colors.blueGrey)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 150,
                      padding: EdgeInsets.all(size.width * 0.05),
                      decoration: const BoxDecoration(color: Colors.white),
                      child: const Text(
                        "IIT BHU",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            fontStyle: FontStyle.italic),
                      ),
                    )..animate().slide().scale(),
                    Container(
                      width: 150,
                      padding: EdgeInsets.all(size.width * 0.05),
                      decoration: const BoxDecoration(color: Colors.white),
                      child: const Text(
                        "NCL",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic),
                      ),
                    ).animate().slide().scale()
                  ],
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.all(size.width * 0.03),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          border: Border.all(color: Colors.blueGrey)),
                      child: const Text('Project PI :- Prof. S.K Sharma',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic))),
                  SizedBox(height: size.width * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          padding: EdgeInsets.all(size.width * 0.03),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              border: Border.all(color: Colors.blueGrey)),
                          child: const Text('Research fellow :- Kadam Mishra',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.italic))),
                    ],
                  ),
                ],
              )
            ],
          )),
    );
  }
}
