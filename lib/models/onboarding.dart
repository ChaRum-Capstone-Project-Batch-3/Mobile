// ignore_for_file: public_member_api_docs, sort_constructors_first
class OnBoarding {
  String image;
  String title;
  String description;
  OnBoarding({
    required this.image,
    required this.title,
    required this.description,
  });
}

List<OnBoarding> onBoards = [
    OnBoarding(
      image: "assets/onboarding_1.png",
      title: "Search Thread Whatever You Like",
      description:
          "Lorem ipsum dolor sit amet consectetur. Quisque ullamcorper vel ullamcorper nunc id diam sed. Quis quis ut ac mauris lobortis nibh. Sed nibh leo quis neque nunc.",
    ),
    OnBoarding(
      image: "assets/onboarding_2.png",
      title: "Discover Space Group",
      description:
          "Lorem ipsum dolor sit amet consectetur. Quisque ullamcorper vel ullamcorper nunc id diam sed. Quis quis ut ac mauris lobortis nibh. Sed nibh leo quis neque nunc.",
    ),
    OnBoarding(
      image: "assets/onboarding_3.png",
      title: "Invite Your Friend To Have Same Experience",
      description:
          "Lorem ipsum dolor sit amet consectetur. Quisque ullamcorper vel ullamcorper nunc id diam sed. Quis quis ut ac mauris lobortis nibh. Sed nibh leo quis neque nunc.",
    ),
  ];