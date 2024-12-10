import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ratemy/application/entity/user.dart';
import 'package:ratemy/screens/components/rate_button.dart';
import 'package:ratemy/screens/presentation/feed_presentation.dart';

import 'components/bottom_bar.dart';

class FeedScreen extends StatefulWidget {
  final FeedPresentation presentation;
  final User user;

  const FeedScreen({super.key, required this.presentation, required this.user});

  static String id = 'feed_screen';

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final double profileImageSize = 70;
  final List<String> previousImages = ['https://picsum.photos/id/${Random().nextInt(1000)}/800/800'];
  String imageUrl = '';
  bool loading = false;
  int currentGrade = -1;

  @override
  void didChangeDependencies() {
    setState(() {
      imageUrl = previousImages.last;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.presentation.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          widget.presentation.gapAboveScreenTitle,

          Expanded(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    _buildTopSearchBar(),

                    _buildLineSeparator(),

                    const SizedBox(height: 40,),

                    _buildImage(imageUrl),

                    const SizedBox(height: 40,),

                    _buildToolsRow(),

                    const SizedBox(height: 20,),

                    _buildProfileRow(),
                  ],
                ),

                Positioned(
                  bottom: 100,
                  right: 20,
                  child: RateButton(
                    saveGrade: (grade) {
                      setState(() {
                        currentGrade = grade;
                      });
                    },
                  ),
                ),

                Positioned(
                  top: 130,
                  left: 20,
                  child: CurrentGrade(grade: currentGrade)
                ),
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

  Widget _buildLineSeparator([double margins = 10.0]) {
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
              iconSize: 30,
              icon: const Icon(Icons.search), color: widget.presentation.primary,),

            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              iconSize: 30,
              icon: const Icon(Icons.send), color: widget.presentation.secondary,)
          ],
        ),
      );
  }

  Widget _buildToolsRow() {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, left: 10.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            iconSize: 40,
            icon: const Icon(Icons.insert_comment), color: widget.presentation.primary,),

          const SizedBox(width: 10,),

          IconButton(
            onPressed: () {},
            iconSize: 40,
            icon: const Icon(Icons.keyboard_return), color: widget.presentation.primary,),

          const SizedBox(width: 10,),

          IconButton(
            onPressed: () {},
            iconSize: 40,
            icon: const Icon(Icons.bookmark), color: widget.presentation.primary,),

          const Spacer(),

          // const RateButton(),
        ],
      ),
    );
  }

  Widget _buildProfileRow() {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, left: 20.0),
      child: Row(
        children: [
          Image.asset(
            widget.user.profileImage,
            width: profileImageSize,
            height: profileImageSize,
          ),
        ],
      ),
    );
  }

  void _showNext() {
    dev.log('show next', name: 'FEED');

    previousImages.add('https://picsum.photos/id/${Random().nextInt(1000)}/800/800');
    setState(() {
      imageUrl = previousImages.last;
    });
  }

  void _showPrevious() {
    dev.log('show previous', name: 'FEED');

    previousImages.removeLast();
    setState(() {
      imageUrl = previousImages.last;
    });
  }
}

class CurrentGrade extends StatelessWidget {
  final int grade;

  const CurrentGrade({super.key, required this.grade});

  @override
  Widget build(BuildContext context) {
    if (grade > 0) {
      return Container(
        color: Colors.lightGreen,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(grade.toString(), style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

}
