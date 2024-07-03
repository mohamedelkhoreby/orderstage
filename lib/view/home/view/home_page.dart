import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/color_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      body: SingleChildScrollView(
        child: Stack(children: [
          const Image(
              image: AssetImage(ImageAssets.homebackground),
              fit: BoxFit.scaleDown),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 2.w),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.w),
                    child: Row(children: [
                      SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: const Image(
                            image: AssetImage(ImageAssets.homebackground),
                            fit: BoxFit.fitWidth),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [])
                    ]),
                  ),
                ],
              )),
        ]),
      ),
    );
  }
}
