import 'dart:math';
import 'dart:ui';

import 'package:ratemy/application/entity/post.dart';
import 'package:ratemy/screens/presentation/presentation.dart';

import '../../application/entity/user.dart';

class FeedPresentation extends Presentation {

  @override
  get background => const Color.fromARGB(255, 27, 27, 1);

  List<Post> getTestPosts() {
    User u1 = const User(name: 'Alex', profileImage: 'assets/example_profile_image.jpeg');
    User u2 = const User(name: 'Alin', profileImage: 'assets/example_profile_image.jpeg');
    User u3 = const User(name: 'Marian', profileImage: 'assets/example_profile_image.jpeg');

    return [
      Post(u1, 5.9, 0, 'https://picsum.photos/id/${Random().nextInt(1000)}/800/400'),
      Post(u2, 8.2, 0, 'https://picsum.photos/id/${Random().nextInt(1000)}/800/400'),
      Post(u3, 7.5, 0, 'https://picsum.photos/id/${Random().nextInt(1000)}/800/400'),
      Post(u1, 3.5, 0, 'https://picsum.photos/id/${Random().nextInt(1000)}/800/400'),
      Post(u2, 6.8, 0, 'https://picsum.photos/id/${Random().nextInt(1000)}/800/400'),
      Post(u3, 4.8, 0, 'https://picsum.photos/id/${Random().nextInt(1000)}/800/400'),
    ];
  }

  Future<List<Post>> getRandomPosts(int count) {
    List<Post> res = [];
    for (int i = 0; i < count; i++) {
      res.add(_getRandomPost('User $i'));
    }

    return Future.delayed(const Duration(seconds: 1), () {
      return res;
    });
  }


  Post _getRandomPost(String name) {
    final user = User(name: name, profileImage: 'assets/example_profile_image.jpeg');
    final pictureRating = (100 * Random().nextDouble()).round() / 10;
    final userRating = Random().nextInt(5);

    return Post(user, pictureRating, userRating, 'https://picsum.photos/id/${Random().nextInt(1000)}/800/400');
  }
}

class PostsEffectiveList {
  final FeedPresentation presentation;
  List<Post> posts = [];
  List<Post> last = [];

  PostsEffectiveList(this.presentation);
  
  int get updatePoint => posts.length - 2;
  
  Future<void> updateBeginning() {
    return presentation.getRandomPosts(posts.length).then((posts) {
      last = posts;

      for (int i = 0; i < posts.length - 2; i++) {
        this.posts[i] = posts[i];
      }
    });
  }
  
  updateEnd() {
    
  }
}