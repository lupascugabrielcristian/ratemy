import 'package:ratemy/application/entity/user.dart';

class Post {
  final User user;
  final double currentRating;
  final int userRating;
  final String imageUrl;

  const Post(this.user, this.currentRating, this.userRating, this.imageUrl);
}