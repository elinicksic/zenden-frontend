import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

final list = ['Recent Room Captures', 'Bedroom', 'Living Room'];

class _HomeState extends State<Home> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 64),
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
                              'Welcome Home',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'James May',
                                  style: TextStyle(
                                    fontSize: 44,
                                    fontWeight: FontWeight.w300
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 24),
                        child: CircularPercentIndicator(
                          radius: 60.0,
                          lineWidth: 13.0,
                          animation: true,
                          percent: 0.7,
                          center: const Text(
                            "70.0%",
                            style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                          footer: const Text(
                            "Average Room Score",
                            style:
                            TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0),
                          ),
                          arcType: ArcType.FULL,
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: Colors.purple,
                          arcBackgroundColor: Colors.black12,
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
                height: 25,
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                  child: GridView.count(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: [
                      roomBox('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRY6fUgPSCtolNpj70dmnHsNMoaXXb44GyaI8rCjP4A&s', 0.6, 'Help'),
                      roomBox('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRY6fUgPSCtolNpj70dmnHsNMoaXXb44GyaI8rCjP4A&s', 0.6, 'Help'),
                      roomBox('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRY6fUgPSCtolNpj70dmnHsNMoaXXb44GyaI8rCjP4A&s', 0.6, 'Help'),
                      roomBox('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRY6fUgPSCtolNpj70dmnHsNMoaXXb44GyaI8rCjP4A&s', 0.6, 'Help'),
                      roomBox('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRY6fUgPSCtolNpj70dmnHsNMoaXXb44GyaI8rCjP4A&s', 0.6, 'Help'),
                      roomBox('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRY6fUgPSCtolNpj70dmnHsNMoaXXb44GyaI8rCjP4A&s', 0.6, 'Help'),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
  
  Widget roomBox(String imgSource, double grade, String name) {
    return Container(
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
    );
  }
}

