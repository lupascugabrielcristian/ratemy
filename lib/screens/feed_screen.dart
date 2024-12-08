import 'package:flutter/material.dart';
import 'package:ratemy/screens/presentation/feed_presentation.dart';

import 'components/bottom_bar.dart';
import 'components/title_row.dart';

class FeedScreen extends StatefulWidget {
  final FeedPresentation presentation;

  const FeedScreen({super.key, required this.presentation});

  static String id = 'feed_screen';

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.presentation.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          widget.presentation.gapAboveScreenTitle,



          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: TitleRow(
                    backAction: () {
                      Navigator.pop(context, false);
                    },
                    title: 'Feed',
                  ),
                ),

                const Text('RATE MY', style: TextStyle(color: Colors.white))
              ],
            ),
          ),

          _buildLineSeparator(),

          const BottomBar(),

          const SizedBox(height: 10,),
        ],
      ),
    );
  }

  Widget _buildLineSeparator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: 1,
        decoration: const BoxDecoration(
            color: Colors.white,
        ),
      ),
    );
  }
}
