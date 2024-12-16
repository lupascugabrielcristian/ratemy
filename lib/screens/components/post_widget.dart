import 'dart:math';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:ratemy/screens/components/rate_button.dart';

import '../presentation/feed_presentation.dart';
import 'grade_star.dart';

class PostWidget extends StatefulWidget {
  final FeedPresentation presentation;

  const PostWidget({super.key, required this.presentation});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  double rateButtonWidth = 0;
  double bottomPositionRateBtn = 10;
  final double profileImageSize = 70;
  final List<String> previousImages = ['https://picsum.photos/id/${Random().nextInt(1000)}/800/800'];
  String imageUrl = '';
  bool loading = false;
  double currentGrade = -1;
  final GlobalKey _toolContainerKey = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox = _toolContainerKey.currentContext!.findRenderObject() as RenderBox;
      final Offset position = renderBox.localToGlobal(Offset.zero);
      dev.log('Position obtained: ${position.dy}');

      rateButtonWidth = MediaQuery.sizeOf(context).width * .13;
      dev.log('widget width = $rateButtonWidth', name: 'RATE BTN');

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
    final double scalingFactor = sH > 700 ? 1 : sH / 700;

    return Stack(
      children: [
        Column(
          children: [

            SizedBox(height: 20 * scalingFactor,),

            // IMAGE
            Flexible(
              child: FractionallySizedBox(
                child: Container(
                  width: sW,
                  height: sW,
                  color: Colors.blue,
                  child: Center(child: Text('Image')),
                ),
              ),
            ),

            SizedBox(height: 20 * scalingFactor,),

            // TOOLS BUTTONS
            Container(
              key: _toolContainerKey,
              color: Colors.lightBlueAccent,
              height: 50,
              child: Center(
                child: _buildToolsRow(scalingFactor - 0.2),
              ),
            ),

            // PROFILE IMAGE
            Container(
              color: Colors.red,
              height: 100,
              child: Center(child: Text('Profile')),
            ),
          ],
        ),

        // RATE BUTTON
        Positioned(
          bottom: bottomPositionRateBtn,
          right: 20,
          child: RateButton(
              width: rateButtonWidth,
              saveGrade: (grade) {
            },
          ),
        ),


        // CURRENT GRADE
        const Positioned(
            top: 130,
            left: 15,
            child: GradeStar(grade: 2, width: 70)
        ),
      ],
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