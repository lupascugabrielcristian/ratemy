import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ratemy/screens/components/bottom_bar.dart';
import 'package:ratemy/screens/components/post_widget.dart';
import 'package:ratemy/screens/presentation/feed_presentation.dart';


class TestScreen extends StatefulWidget {
  final FeedPresentation presentation;

  const TestScreen({super.key, required this.presentation});

  static String id = 'test_screen';

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final GlobalKey _toolContainerKey = GlobalKey();
  double rateButtonWidth = 0;
  double bottomPositionRateBtn = 100;



  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox = _toolContainerKey.currentContext!.findRenderObject() as RenderBox;
      final Offset position = renderBox.localToGlobal(Offset.zero);
      log('Position obtained: ${position.dy}');

      rateButtonWidth = MediaQuery.sizeOf(context).width * .13;
      log('widget width = $rateButtonWidth', name: 'RATE BTN');

      setState(() {
        bottomPositionRateBtn = MediaQuery.sizeOf(context).height - position.dy - rateButtonWidth;
      });
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final sW = MediaQuery.sizeOf(context).width;
    final sH = MediaQuery.sizeOf(context).height;
    log('sH = $sH', name: 'TEST');
    final double searchBarH = sW * .2 > 50 ? 50 : sW * .2;
    final double bottomBarH = sW * .3 > 60 ? 60 : sW * .3;
    log('bottomBarH = $bottomBarH', name: 'TEST');
    final double scalingFactor = sH > 700 ? 1 : sH / 700;
    log('scaling factor = $scalingFactor', name: 'TEST');


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
                  // child: Text('Search bar')
                  child: _buildTopSearchBar(),
                ),
              ),

              // Expanded(
              //   child: PostWidget(presentation: widget.presentation),
              // ),
              Expanded(
                child: PageView(
                  scrollDirection: Axis.vertical,
                  children: [
                    PostWidget(presentation: widget.presentation),
                    PostWidget(presentation: widget.presentation),
                    PostWidget(presentation: widget.presentation),
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

  _buildTopSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 20.0),
      child: Row(
        children: [
          const Expanded(child: Text('RATE MY', style: TextStyle(color: Colors.white))),

          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            // iconSize: 30,
            icon: const Icon(Icons.search), color: widget.presentation.primary,),

          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            // iconSize: 30,
            icon: const Icon(Icons.send), color: widget.presentation.secondary,)
        ],
      ),
    );
  }
}

