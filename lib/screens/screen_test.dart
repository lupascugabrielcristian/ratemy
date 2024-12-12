import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ratemy/screens/components/bottom_bar.dart';
import 'package:ratemy/screens/presentation/feed_presentation.dart';

import 'components/rate_button.dart';

class TestScreen extends StatefulWidget {
  final FeedPresentation presentation;

  const TestScreen({super.key, required this.presentation});

  static String id = 'test_screen';

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final GlobalKey _toolContainerKey = GlobalKey();
  double topPositionRateBtn = 0;


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox = _toolContainerKey.currentContext!.findRenderObject() as RenderBox;
      final Offset position = renderBox.localToGlobal(Offset.zero);

      log('Position obtained: ${position.dy}');

      setState(() {
        topPositionRateBtn = position.dy;
      });
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final sW = MediaQuery.sizeOf(context).width;
    final sH = MediaQuery.sizeOf(context).height;
    log('sH = $sH', name: 'TEST');
    // final searchBarH = sW * .1;
    final double searchBarH = sW * .2 > 50 ? 50 : sW * .2;
    // const double bottomBarH = 80;
    final double bottomBarH = sW * .3 > 60 ? 60 : sW * .3;
    log('bottomBarH = $bottomBarH', name: 'TEST');
    final double scalingFactor = sH > 700 ? 1 : sH / 700;
    log('scaling factor = $scalingFactor', name: 'TEST');
    // topPositionRateBtn = MediaQuery.sizeOf(context).height * .12;
    // log('rate button pos = $topPositionRateBtn', name: 'TEST');


    return Scaffold(
      backgroundColor: widget.presentation.background,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              widget.presentation.gapAboveScreenTitle,

              Container(
                color: Colors.green,
                height: searchBarH,
                child: Center(
                  child: Text('Search bar')
                ),
              ),

              SizedBox(height: 20 * scalingFactor,),
              Expanded(
                child: Column(
                  children: [

                    Flexible(
                      child: FractionallySizedBox(
                        // heightFactor: 0.7,
                        child: Container(
                          width: sW,
                          height: sW,
                          color: Colors.blue,
                          child: Center(
                              child: Text('Image')
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20 * scalingFactor,),

                    Container(
                      key: _toolContainerKey,
                      color: Colors.lightBlueAccent,
                      height: 50,
                      child: Center(
                          // child: Text('Tools')
                        child: _buildToolsRow(scalingFactor - 0.2),
                      ),
                    ),

                    Container(
                      color: Colors.red,
                      height: 100,
                      child: Center(
                          child: Text('Profile')
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                color: Colors.yellow,
                height: bottomBarH,
                // child: Center(
                //     child: Text('Bottom bar: 80')
                // ),
                child: BottomBar(scaling: scalingFactor,),
              ),
            ],
          ),


          // RATE BUTTON
          Positioned(
            top: topPositionRateBtn,
            right: 20,
            child: RateButton(
              saveGrade: (grade) {
              },
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildToolsRow(double scalingFactor) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, left: 10.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            iconSize: 40 * scalingFactor,
            icon: const Icon(Icons.insert_comment), color: widget.presentation.primary,),

          const SizedBox(width: 10,),

          IconButton(
            onPressed: () {},
            iconSize: 40 * scalingFactor,
            icon: const Icon(Icons.keyboard_return), color: widget.presentation.primary,),

          const SizedBox(width: 10,),

          IconButton(
            onPressed: () {},
            iconSize: 40 * scalingFactor,
            icon: const Icon(Icons.bookmark), color: widget.presentation.primary,),

          // const RateButton(),
        ],
      ),
    );
  }
}

