import 'dart:async';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import 'package:tamuhack2023/screens/home.dart';

final testData = [
  {
    'id': '1',
    'img':
        'https://www.99images.com/photos/architecture/living-room/living-room-livingroomdesign-inspiration-interior2all-2534htlo.jpg?v=1607507822',
    'rs': 0.7,
    'name': 'Help',
    'desc': '',
  },
  {
    'id': '2',
    'img':
        'https://kentondejong.com/public/images/depressing_places/depress_operating_room.jpg',
    'rs': 0.1,
    'name': 'Dark room',
    'desc':
        'Adding a lamp to a dark room can significantly improve the overall ambiance and functionality of the space by providing additional lighting and reducing eye strain.'
  },
  {
    'id': '3',
    'img':
        'https://media.istockphoto.com/id/1129813604/photo/empty-minimalist-room-with-gray-wall-on-background.jpg?s=612x612&w=0&k=20&c=56EjJTKfoXHWrbPZn9FXt4kWcJf2OwUj6pnh4zFSo6U=',
    'rs': 0.6,
    'name': 'Help',
    'desc': 'lol'
  },
  {
    'id': '4',
    'img':
        'https://st.depositphotos.com/2501519/2970/v/450/depositphotos_29700139-Depression-man-in-empty-room.jpg',
    'rs': 0.2,
    'name': 'Help',
    'desc': 'lol'
  },
  {
    'id': '5',
    'img': 'https://img.sfist.com/attachments/SFist_Jay/apt-sad-mattress.jpg',
    'rs': 0.4,
    'name': 'Help',
    'desc': 'lol'
  },
  {
    'id': '6',
    'img':
        'https://trendesignbook.com/blog/wp-content/uploads/2020/10/nature-inspired-trends.jpg',
    'rs': 0.9,
    'name': 'Help',
    'desc': 'lol'
  },
];

void main() async {
  final LocalStorage storage = LocalStorage('app.json');
  storage.setItem('rooms', testData);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: const Home(),
    );
  }
}
