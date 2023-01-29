import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tamuhack2023/models/api_response.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:tamuhack2023/widgets/bulletpoint.dart';

import 'dart:io';

class ResultsPage extends StatelessWidget {
  final ApiResponse data;
  final File img;
  ResultsPage({required this.data, required this.img, super.key});
  Health health = Health.acceptable;
  TextEditingController _nameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    if (data.scoring['total'] > 0.7) {
      health = Health.good;
    } else if (data.scoring['total'] < 0.4) {
      health = Health.bad;
    } else if (data.scoring['total'] < 0.7) {
      health = Health.acceptable;
    }

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
                      child: const Icon(Icons.arrow_back_ios_new_rounded, size: 30),
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
                        img, fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  CircularPercentIndicator(
                    radius: 100.0,
                    lineWidth: 13.0,
                    percent: data.scoring['total'],
                    progressColor:
                      health == Health.good
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
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.black
                        ),
                      ),
                      label: const Text('Room Name')
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Score: ${(data.scoring['total'] * 100).toStringAsFixed(0)}% - ${health == Health.good
                          ? 'Good'
                          : health == Health.bad
                          ? 'Bad'
                          : 'Acceptable'}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                        "The primary color in the room is ${data.colors["name"]}. ${data.colors["comments"]}"),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Recommendations: ", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: data.recommendations
                            .map((e) => BulletPoint(text: e))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(
                flex: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextButton(
                  onPressed: () {

                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                      health == Health.good
                        ? Colors.green
                        : health == Health.acceptable
                        ? Colors.yellow
                        : Colors.red,),
                    backgroundColor:
                    const MaterialStatePropertyAll<Color>(Colors.transparent),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: health == Health.good
                              ? Colors.green
                              : health == Health.acceptable
                              ? Colors.yellow
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
                        style: TextStyle(color:
                          health == Health.good
                            ? Colors.green
                            : health == Health.acceptable
                            ? Colors.yellow
                            : Colors.red,),
                      ),
                      Spacer(),
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
