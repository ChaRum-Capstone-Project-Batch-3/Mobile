class Post {
  String? title;
  String? authorName;
  String? authorImageUrl;
  String? timeAgo;
  String? imageUrl;

  Post({
    this.title,
    this.authorName,
    this.authorImageUrl,
    this.timeAgo,
    this.imageUrl,
  });
}

final List<Post> posts = [
  Post(
    title:
        "What are the differences between the ancient Turks, the proto-Turks, and the modern Turks?",
    authorName: 'Ade Winda',
    authorImageUrl: 'assets/images/pp_1.png',
    timeAgo: '20m ago',
    imageUrl: 'assets/images/pp_1.jpg',
  ),
];
