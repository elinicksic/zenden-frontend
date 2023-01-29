import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localstorage/localstorage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tamuhack2023/models/api_response.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:tamuhack2023/screens/home.dart';
import 'package:tamuhack2023/widgets/bulletpoint.dart';

class ResultsPage extends StatefulWidget {
  final ApiResponse data;
  final XFile img;
  ResultsPage({required this.data, required this.img, super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  Health health = Health.acceptable;

  TextEditingController _nameController = TextEditingController();

  final LocalStorage storage = LocalStorage('app.json');

  @override
  Widget build(BuildContext context) {
    if (widget.data.scoring['total'] > 0.7) {
      health = Health.good;
    } else if (widget.data.scoring['total'] < 0.4) {
      health = Health.bad;
    } else if (widget.data.scoring['total'] < 0.7) {
      health = Health.acceptable;
    }
    print('EEEEEEEEEEEEEEE'+_nameController.text+'EEEEEEEEEEEEEEEEEEE');
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                      child: const Icon(Icons.arrow_back_ios_new_rounded,
                          size: 30),
                      onTap: () => Navigator.pop(context)),
                  const Spacer(),
                ],
              ),
              const Spacer(
                flex: 1,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipOval(
                    child: Container(
                      width: 174,
                      height: 174,
                      child: Image.file(
                        File(widget.img.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  CircularPercentIndicator(
                    radius: 100.0,
                    lineWidth: 13.0,
                    percent: widget.data.scoring['total'],
                    progressColor: health == Health.good
                        ? const Color.fromRGBO(30, 195, 55, 1)
                        : health == Health.acceptable
                            ? const Color.fromRGBO(245, 194, 0, 1)
                            : const Color.fromRGBO(255, 49, 38, 1),
                    backgroundColor: Colors.transparent,
                  ),
                ],
              ),
              const Spacer(
                flex: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    label: const Text('Room Name'),
                  ),
                  validator: (String? value) {
                    return (value != null && RegExp("[\w.-]+").hasMatch(value))
                        ? 'Empty string'
                        : 'yeel';
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Score: ${(widget.data.scoring['total'] * 100).toStringAsFixed(0)}% - ${health == Health.good ? 'Good' : health == Health.bad ? 'Bad' : 'Acceptable'}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                        "The primary color in the room is ${widget.data.colors["name"]}. ${widget.data.colors["comments"]}"),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Recommendations: ",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500)),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: widget.data.recommendations.isNotEmpty
                            ? widget.data.recommendations
                                .map((e) => BulletPoint(text: e))
                                .toList()
                            : [
                                const Text(
                                    "We couldn't make a recommendation for this room :(")
                              ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(
                flex: 11,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: TextButton(
                  onPressed: () async {
                    if(_nameController.text==null||_nameController.text=='') {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Please Re-enter the Name'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Ok'),
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                    else {
                      // Save temporary file to directory
                      Directory appDocDir =
                      await getApplicationDocumentsDirectory();

                    List<Map<String, Object>> roomsData =
                        await storage.getItem('rooms');
                    roomsData.add({
                      'id': '${roomsData.length + 1}',
                      'img': appDocDir.path + "/" + widget.img.name,
                      'rs': widget.data.scoring['total'] * 100,
                      'name': _nameController.text,
                      'desc': widget.data.recommendations.length != 0
                          ? widget.data.recommendations[0]
                          : "No recommendations :)"
                    });
                    setState(() {
                      storage.setItem('rooms', roomsData);
                    });

                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Home()),ModalRoute.withName('/screens'));
                    }
                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                      health == Health.good
                          ? Colors.green
                          : health == Health.acceptable
                              ? Colors.orange
                              : Colors.red,
                    ),
                    backgroundColor: const MaterialStatePropertyAll<Color>(
                        Colors.transparent),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: health == Health.good
                              ? Colors.green
                              : health == Health.acceptable
                                  ? Colors.orange
                                  : Colors.red,
                          width: 3,
                        ),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Spacer(),
                      Text(
                        'Add Room',
                        style: TextStyle(
                          color: health == Health.good
                              ? Colors.green
                              : health == Health.acceptable
                                  ? Colors.orange
                                  : Colors.red,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              const Spacer(
                flex: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum Health { good, bad, acceptable }
