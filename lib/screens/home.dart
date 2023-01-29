import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:tamuhack2023/screens/results.dart';
import 'package:localstorage/localstorage.dart';
import 'package:path_provider/path_provider.dart';
import '../models/api_response.dart';

final _backendUrl =
    Uri.parse('https://tamuhack2023-backend.elinicksic1.repl.co/analyze');

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

final list = ['All', 'Good', 'Acceptable', 'Bad'];

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
      'name': 'Help',
      'desc': 'I am trapped inside room'
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

  final LocalStorage storage = LocalStorage('app.json');

  @override
  Widget build(BuildContext context) {
    storage.setItem('rooms', testData);
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
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 16,
                        color: Color.fromRGBO(205, 205, 205, 0.5),
                        spreadRadius: 5,
                      )
                    ],
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
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'Home',
                                style: TextStyle(
                                    fontSize: 44, fontWeight: FontWeight.w300),
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
                            for (var room in testData) {
                              avg += room['rs'] as double;
                            }
                            avg /= testData.length;
                            print(avg);
                            return CircularPercentIndicator(
                              radius: 60.0,
                              lineWidth: 13.0,
                              animation: true,
                              percent: avg,
                              center: Text(
                                "${(avg * 100).toInt()}%",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              footer: const Text(
                                "Room Score",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.0),
                              ),
                              arcType: ArcType.FULL,
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor:
                                  HSLColor.fromAHSL(1.0, avg * 100, 1.0, 0.5)
                                      .toColor(),
                              arcBackgroundColor: Colors.black12,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
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
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 16,
                          color: Color.fromRGBO(205, 205, 205, 0.5),
                          spreadRadius: 5,
                        )
                      ],
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
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
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
              const SizedBox(height: 15),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FutureBuilder(
                    future: storage.ready,
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.data == true) {
                        List<dynamic> data = storage.getItem('rooms') ?? [];

                        List<Widget> gridList = [];

                        for (var room in testData) {
                          final rs = room['rs'] as double;
                          if ((dropdownValue == 'Good' && rs > 0.7) ||
                              (dropdownValue == 'Bad' && rs < 0.4) ||
                              (dropdownValue == 'Acceptable' &&
                                  0.4 < rs &&
                                  rs < 0.7) ||
                              dropdownValue == 'All') {
                            gridList.add(roomBox(
                                room['id'] as String,
                                room['img'] as String,
                                room['rs'] as double,
                                room['name'] as String,
                                room['desc'] as String));
                          }
                        }

                        return GridView.count(
                          padding: const EdgeInsets.all(0),
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          children: gridList,
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ),
              AnimatedContainer(
                height: _infoOpened ? 200 : 0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: _infoOpened
                    ? infoBox(_infoString['rs'], _infoString['name'],
                        _infoString['desc'])
                    : Container(),
              ),
              const SizedBox(
                height: 3,
              ),
              TextButton(
                onPressed: () async {
                  late XFile? image;
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Image Source'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Camera'),
                            onPressed: () async {
                              image = await _picker.pickImage(
                                  source: ImageSource.camera);
                              if (image != null) {
                                // Save temporary file to directory
                                Directory appDocDir =
                                    await getApplicationDocumentsDirectory();
                                image!.saveTo(appDocDir.path);

                                final response = await http.post(
                                  _backendUrl,
                                  body: json.encode({
                                    "room_type": "Bedroom",
                                    "image": base64Encode(
                                      await image!.readAsBytes(),
                                    ),
                                  }),
                                  headers: {
                                    'Content-type': 'application/json',
                                    'Accept': 'application/json',
                                  },
                                ).then((Response response) {
                                  final data = ApiResponse.fromJson(
                                    jsonDecode(response.body),
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResultsPage(
                                        data: data,
                                        img: image!,
                                      ),
                                    ),
                                  );
                                });
                              }
                            },
                          ),
                          TextButton(
                            child: const Text('Storage'),
                            onPressed: () async {
                              image = await _picker.pickImage(
                                source: ImageSource.gallery,
                              );
                              if (image != null) {
                                final response = await http.post(
                                  _backendUrl,
                                  body: json.encode({
                                    "room_type": "Bedroom",
                                    "image": base64Encode(
                                      await image!.readAsBytes(),
                                    ),
                                  }),
                                  headers: {
                                    'Content-type': 'application/json',
                                    'Accept': 'application/json',
                                  },
                                ).then((Response response) {
                                  final data = ApiResponse.fromJson(
                                    jsonDecode(response.body),
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResultsPage(
                                        data: data,
                                        img: image!,
                                      ),
                                    ),
                                  );
                                });
                              }
                            },
                          ),
                        ],
                      );
                    },
                  );

                  // ignore: use_build_context_synchronously
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.purpleAccent),
                  backgroundColor:
                      const MaterialStatePropertyAll<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(
                        color: Colors.purpleAccent,
                        width: 3,
                      ),
                    ),
                  ),
                ),
                child: Row(
                  children: const [
                    Spacer(),
                    Text(
                      'Add Room',
                      style: TextStyle(color: Colors.purpleAccent),
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
      ),
    );
  }

  Widget roomBox(
      String id, String imgSource, double grade, String name, String desc) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_infoString['id'] == id) {
            _infoOpened = false;
            _infoString = {'id': null, 'rs': null, 'name': null, 'desc': null};
          } else {
            _infoOpened = true;
            _infoString = {'id': id, 'rs': grade, 'name': name, 'desc': desc};
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromRGBO(255, 255, 255, 1),
          boxShadow: const [
            BoxShadow(
              blurRadius: 16,
              color: Color.fromRGBO(205, 205, 205, 0.5),
              spreadRadius: 5,
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: imgSource.startsWith("http")
              ? Image.network(
                  imgSource,
                  fit: BoxFit.cover,
                )
              : Image.file(File(imgSource)),
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
              "${(rs * 100).toInt()}%",
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            footer: const Text(
              "Room Score",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0),
            ),
            arcType: ArcType.FULL,
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: HSLColor.fromAHSL(1.0, rs * 100, 1.0, 0.5).toColor(),
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
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
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
