import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class OnBoarding {
  String image;
  String bgImage;
  String title;
  String description;
  OnBoarding({
    required this.image,
    required this.bgImage,
    required this.title,
    required this.description,
  });

  OnBoarding copyWith({
    String? image,
    String? bgImage,
    String? title,
    String? description,
  }) {
    return OnBoarding(
      image: image ?? this.image,
      bgImage: bgImage ?? this.bgImage,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'bgImage': bgImage,
      'title': title,
      'description': description,
    };
  }

  factory OnBoarding.fromMap(Map<String, dynamic> map) {
    return OnBoarding(
      image: map['image'] as String,
      bgImage: map['bgImage'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OnBoarding.fromJson(String source) => OnBoarding.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OnBoarding(image: $image, bgImage: $bgImage, title: $title, description: $description)';
  }

  @override
  bool operator ==(covariant OnBoarding other) {
    if (identical(this, other)) return true;
  
    return 
      other.image == image &&
      other.bgImage == bgImage &&
      other.title == title &&
      other.description == description;
  }

  @override
  int get hashCode {
    return image.hashCode ^
      bgImage.hashCode ^
      title.hashCode ^
      description.hashCode;
  }
}

List<OnBoarding> onBoards = [
  OnBoarding(
    image: "assets/onboarding_1.png",
    bgImage: "assets/bg_onboarding_1.png",
    title: "Search Thread Whatever You Like",
    description:
        "Confused and want to talk about something but don't know where to go? You can talk to other people on Charum from anywhere and at any time.",
  ),
  OnBoarding(
    image: "assets/onboarding_2.png",
    bgImage: "assets/bg_onboarding_2.png",
    title: "Discover Space Group",
    description:
        "You no longer need to be confused looking for threads on a particular topic, with Space Group you can search for threads on the topic you want.",
  ),
  OnBoarding(
    image: "assets/onboarding_3.png",
    bgImage: "assets/bg_onboarding_3.png",
    title: "Share Your Experience",
    description:
        "You can gain a lot of insight from existing discussions using the Charum. What are you waiting for? Come on over and join us! ",
  ),
];
