import 'package:flutter/material.dart';

class SpaceModel {
  Image image;
  String title;
  String description;
  String sumThread;
  SpaceModel({
    required this.image,
    required this.title,
    required this.description,
    required this.sumThread,
  });
}

final List<SpaceModel> spaces = [
  SpaceModel(
    image: Image.asset('assets/space_business.png'),
    title: 'Bussiness',
    description:
        'Question, advice, and articles to do with running and growing business',
    sumThread: '2402 threads',
  ),
  SpaceModel(
      image: Image.asset('assets/space_technology.png'),
      title: 'Technology',
      description:
          'Discover and share information about advances in technology',
      sumThread: '2194 threads'),
  SpaceModel(
    image: Image.asset('assets/space_education.png'),
    title: 'Education',
    description:
        'A space to recommend and discuss new music all around the world',
    sumThread: '2162 threads',
  ),
  SpaceModel(
    image: Image.asset('assets/space_music.png'),
    title: 'Music',
    description:
        'A space to recommend and discuss new music all around the world',
    sumThread: '1934 threads',
  ),
  SpaceModel(
    image: Image.asset('assets/space_travel.png'),
    title: 'Travel',
    description:
        'A space to recommend and discuss new music all around the world',
    sumThread: '1857 threads',
  ),
  SpaceModel(
    image: Image.asset('assets/space_game.png'),
    title: 'Game',
    description:
        'A space to recommend and discuss new music all around the world',
    sumThread: '1821 threads',
  ),
];
