import 'package:flutter/material.dart';
import 'package:ratemy/screens/presentation/feed_presentation.dart';

import 'components/title_row.dart';

class TestScreen extends StatefulWidget {
  final FeedPresentation presentation;

  const TestScreen({super.key, required this.presentation});

  static String id = 'test_screen';

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    final sW = MediaQuery.sizeOf(context).width;
    // final searchBarH = sW * .1;
    final double searchBarH = sW * .2 > 50 ? 50 : sW * .2;
    const double bottomBarH = 80;
    // final double bottomBarH = sW * .2 > 50 ? 50 : sW * .2;

    return Scaffold(
      backgroundColor: widget.presentation.background,
      body: Column(
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


                Container(
                  color: Colors.lightBlueAccent,
                  height: 50,
                  child: Center(
                      child: Text('Tools')
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
            child: Center(
                child: Text('Bottom bar: 80')
            ),
          ),
        ],
      ),
    );
  }
}
