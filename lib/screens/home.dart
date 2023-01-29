import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tamuhack2023/screens/roomsetup.dart';

import '../main.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

final list = ['Recent Room Captures', 'Bedroom', 'Living Room'];

class _HomeState extends State<Home> {
  String dropdownValue = list.first;
  bool _flag = false;
  bool _infoOpened = false;
  Map _infoString = {
    'id': null,
    'name': null,
    'desc': null,
    'rs': null,
  };
  final ImagePicker _picker = ImagePicker();

  final testData = [
  {'id': '1', 'img': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRY6fUgPSCtolNpj70dmnHsNMoaXXb44GyaI8rCjP4A&s', 'rs': 0.6, 'name': 'Help', 'desc': 'Lorem ipsum dolor sit amet what an idiot closing the gap from the inside this guy only knows how to start from the front', 'cat':'Bedroom'},
  {'id': '2', 'img': 'https://t3.ftcdn.net/jpg/03/09/15/38/360_F_309153899_e6oWpcNBV44DEx52vikvw9a5XNlw7pVb.jpg', 'rs': 0.4, 'name': 'Help', 'desc': 'I am trapped inside room', 'cat':'Living Room'},
  {'id': '3', 'img': 'https://media.istockphoto.com/id/1129813604/photo/empty-minimalist-room-with-gray-wall-on-background.jpg?s=612x612&w=0&k=20&c=56EjJTKfoXHWrbPZn9FXt4kWcJf2OwUj6pnh4zFSo6U=', 'rs': 0.6, 'name': 'Help', 'desc': 'lol', 'cat':'Bedroom'},
  {'id': '4', 'img': 'https://t3.ftcdn.net/jpg/03/09/15/38/360_F_309153899_e6oWpcNBV44DEx52vikvw9a5XNlw7pVb.jpg', 'rs': 0.2, 'name': 'Help', 'desc': 'lol', 'cat':'Bedroom'},
  {'id': '5', 'img': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRY6fUgPSCtolNpj70dmnHsNMoaXXb44GyaI8rCjP4A&s', 'rs': 0.4, 'name': 'Help', 'desc': 'lol', 'cat':'Living Room'},
  {'id': '6', 'img': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRY6fUgPSCtolNpj70dmnHsNMoaXXb44GyaI8rCjP4A&s', 'rs': 0.5, 'name': 'Help', 'desc': 'lol', 'cat':'Bedroom'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 38),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    boxShadow: const [BoxShadow(
                      blurRadius: 16,
                      color: Color.fromRGBO(205, 205, 205, 0.5),
                      spreadRadius: 5,
                    )],
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Welcome',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'Home',
                                style: TextStyle(
                                  fontSize: 44,
                                  fontWeight: FontWeight.w300
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 24),
                        child: Builder(
                          builder: (context) {
                            var avg = 0.0;
                            for(var room in testData) {
                              avg += room['rs'] as double;
                            }
                            avg /= testData.length;
                            return CircularPercentIndicator(
                              radius: 60.0,
                              lineWidth: 13.0,
                              animation: true,
                              percent: avg,
                              center: Text(
                                "${(avg*100).toInt()}%",
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                              ),
                              footer: const Text(
                                "Room Score",
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0),
                              ),
                              arcType: ArcType.FULL,
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: Color.fromRGBO(
                                (255 * (1 - avg)).round(),
                                (255 * avg).round(),
                                0,
                                1,
                              ),
                              arcBackgroundColor: Colors.black12,
                            );
                          }
                        ),
                      ),
                    ],
                  )
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      boxShadow: const [BoxShadow(
                        blurRadius: 16,
                        color: Color.fromRGBO(205, 205, 205, 0.5),
                        spreadRadius: 5,
                      )],
                    ),
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(12),
                        value: dropdownValue,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        elevation: 16,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        underline: Container(
                          color: Colors.transparent,
                        ),
                        onChanged: (value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items: list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text('$value  '),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const Spacer()
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Builder(
                    builder: (context) {
                      List<Widget> gridList = [];
                      for(var room in testData) {
                        if(dropdownValue==room['cat']||dropdownValue=='Recent Room Captures') {
                          gridList.add(roomBox(room['id'] as String, room['img'] as String,
                              room['rs'] as double, room['name'] as String,
                              room['desc'] as String));
                        }
                      }
                      return GridView.count(
                        padding: const EdgeInsets.all(0),
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children: gridList
                      );
                    }
                  ),
                ),
              ),
              AnimatedContainer(
                height: _infoOpened ? 200 : 0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: _infoOpened ? infoBox(_infoString['rs'], _infoString['name'], _infoString['desc']) : Container(),
              ),
              const SizedBox(
                height: 3,
              ),
              TextButton(
                onPressed: () async {
                  final XFile? image = await _picker.pickImage(source: ImageSource.camera);
                  Navigator.of(context).push(CupertinoPageRoute(builder: (context) => RoomSetup(img: Image.file(File(image!.path), fit: BoxFit.cover,))));
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.purpleAccent),
                  backgroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(
                        color: Colors.purpleAccent,
                        width: 3,
                      )
                    )
                  )
                ),
                child: Row(
                  children: const [
                    Spacer(),
                    Text(
                      'Add Room',
                      style: TextStyle(
                        color: Colors.purpleAccent
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              )
            ],
          ),
        ),
      )
    );
  }
  
  Widget roomBox(String id, String imgSource, double grade, String name, String desc) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if(_infoString['id']==id){
            _infoOpened = false;
            _infoString = {
              'id': null,
              'rs': null,
              'name': null,
              'desc': null
            };
          }
          else {
            _infoOpened = true;
            _infoString = {
              'id': id,
              'rs': grade,
              'name': name,
              'desc': desc
            };
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromRGBO(255, 255, 255, 1),
          boxShadow: const [BoxShadow(
            blurRadius: 16,
            color: Color.fromRGBO(205, 205, 205, 0.5),
            spreadRadius: 5,
          )],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            imgSource,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget infoBox(double rs, String name, String desc) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: CircularPercentIndicator(
            radius: 50.0,
            lineWidth: 10.0,
            animation: true,
            percent: rs,
            center: Text(
              "${(rs*100).toInt()}%",
              style:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            footer: const Text(
              "Room Score",
              style:
              TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0),
            ),
            arcType: ArcType.FULL,
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Color.fromRGBO(
              (255 * (1 - rs)).round(),
              (255 * rs).round(),
              0,
              1,
            ),
            arcBackgroundColor: Colors.black12,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, top: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width/2,
                child: Text(
                  desc,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

