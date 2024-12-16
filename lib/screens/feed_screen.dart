import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ratemy/application/entity/user.dart';
import 'package:ratemy/screens/components/rate_button.dart';
import 'package:ratemy/screens/presentation/feed_presentation.dart';

import 'components/bottom_bar.dart';
import 'components/grade_star.dart';

class FeedScreen extends StatefulWidget {
  final FeedPresentation presentation;
  final User user;

  const FeedScreen({super.key, required this.presentation, required this.user});

  static String id = 'feed_screen';

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final GlobalKey _toolContainerKey = GlobalKey();
  double rateButtonWidth = 0;
  double bottomPositionRateBtn = 100;
  final double profileImageSize = 70;
  final List<String> previousImages = ['https://picsum.photos/id/${Random().nextInt(1000)}/800/800'];
  String imageUrl = '';
  bool loading = false;
  double currentGrade = -1;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox = _toolContainerKey.currentContext!.findRenderObject() as RenderBox;
      final Offset position = renderBox.localToGlobal(Offset.zero);

      rateButtonWidth = MediaQuery.sizeOf(context).width * .13;

      setState(() {
        bottomPositionRateBtn = MediaQuery.sizeOf(context).height - position.dy - rateButtonWidth;
      });
    });
    super.initState();
  }


  @override
  void didChangeDependencies() {
    setState(() {
      imageUrl = previousImages.last;
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final sW = MediaQuery.sizeOf(context).width;
    final sH = MediaQuery.sizeOf(context).height;
    final double searchBarH = sW * .2 > 50 ? 50 : sW * .2;
    final double bottomBarH = sW * .3 > 60 ? 60 : sW * .3;
    final double scalingFactor = sH > 700 ? 1 : sH / 700;

    return Scaffold(
      backgroundColor: widget.presentation.background,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              widget.presentation.gapAboveScreenTitle,

              // TOP BAR
              SizedBox(
                height: searchBarH,
                child: _buildTopSearchBar(),
              ),

              _buildLineSeparator(),


              Expanded(
                child: Column(
                  children: [

                    SizedBox(height: 20 * scalingFactor,),

                    // IMAGE
                    Flexible(
                      child: FractionallySizedBox(
                        child: SizedBox(
                          width: sW,
                          height: sW,
                          child: _buildImage(imageUrl),
                        ),
                      ),
                    ),

                    SizedBox(height: 20 * scalingFactor,),

                    // TOOLS BUTTONS
                    SizedBox(
                      key: _toolContainerKey,
                      height: 50,
                      child: Center(
                        child: _buildToolsRow(scalingFactor - 0.2),
                      ),
                    ),

                    // PROFILE IMAGE
                    SizedBox(
                      height: 100,
                      child: _buildProfileRow(profileImageSize),
                    ),
                  ],
                ),
              ),

              _buildLineSeparator(),

              SizedBox(
                height: bottomBarH,
                child: BottomBar(scaling: scalingFactor,),
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
                setState(() {
                  currentGrade = grade * 1.0;
                });
              },
            ),
          ),


          // CURRENT GRADE
          Positioned(
              top: 130,
              left: 15,
              child: GradeStar(grade: currentGrade, width: 70)
          ),
        ],
      ),
    );
  }


  Widget _buildImage(String src) {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity != null) {
          if (details.primaryVelocity! < -50 && details.localPosition.dy < 200) {
            loading = true;
            _showNext();
          }

          if (details.primaryVelocity! > 50 && details.localPosition.dy > 200) {
            _showPrevious();
          }
        }
      },
      child: Image.network(
          src,
          gaplessPlayback: true,
          errorBuilder: onError,
          loadingBuilder: onLoading,
        ),
    );
  }

  Widget _buildLineSeparator([double margins = 0.0]) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: margins),
      child: Container(
        height: 1,
        decoration: const BoxDecoration(
            color: Colors.white,
        ),
      ),
    );
  }

  Widget onError(BuildContext context, Object error, StackTrace? stackTrace) {
    double w = MediaQuery.sizeOf(context).width;
    return Container(
      color: widget.presentation.secondary,
      height: w,
      width: w,
      child: Center(
        child: Icon(
          Icons.broken_image,
          color: widget.presentation.primary,
          size: 50,
        ),
      ),
    );
  }

  Widget onLoading(BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    double w = MediaQuery.sizeOf(context).width;

    if (loadingProgress == null) {
      return child;
    }

    loading = false;

    return Container(
      color: widget.presentation.secondary,
      height: w,
      width: w,
      child: Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
              : null,
        ),
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
              icon: const Icon(Icons.search), color: widget.presentation.primary,),

            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: const Icon(Icons.send), color: widget.presentation.secondary,)
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

  Widget _buildProfileRow(double profileImageSize) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, left: 20.0),
      child: Row(
        children: [
          Image.asset(
            alignment: Alignment.centerLeft,
            widget.user.profileImage,
            width: profileImageSize,
            height: profileImageSize,
          ),
          const SizedBox(width: 10),
          Text(widget.user.name, style: const TextStyle(color: Color.fromARGB(255, 225, 225, 225), fontSize: 18,))
        ],
      ),
    );
  }

  void _showNext() {
    previousImages.add('https://picsum.photos/id/${Random().nextInt(1000)}/800/800');
    setState(() {
      imageUrl = previousImages.last;
      currentGrade = -1;
    });
  }

  void _showPrevious() {
    previousImages.removeLast();
    setState(() {
      imageUrl = previousImages.last;
      currentGrade = -1;
    });
  }
}

