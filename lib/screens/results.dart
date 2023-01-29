import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tamuhack2023/models/api_response.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:tamuhack2023/widgets/bulletpoint.dart';

class ResultsPage extends StatelessWidget {
  final ApiResponse data;
  ResultsPage({required this.data, super.key});
  Health health = Health.acceptable;

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
              Text(
                'Results',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 13.0,
                percent: data.scoring['total'],
                center: new Text(
                  "${(data.scoring['total'] * 100).toStringAsFixed(0)}%",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                progressColor: health == Health.good
                    ? Colors.green
                    : health == Health.acceptable
                        ? Colors.yellow
                        : Colors.red,
              ),
              Text("Recommendations: ", style: TextStyle(fontSize: 25)),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BulletPoint(text: "amogus"),
                    BulletPoint(text: "sussy")
                  ],
                ),
              ),
              Text(
                health == Health.good
                    ? 'Good'
                    : health == Health.bad
                        ? 'Bad'
                        : 'Acceptable',
                style: TextStyle(
                    color: health == Health.good
                        ? Colors.green
                        : health == Health.acceptable
                            ? Colors.yellow
                            : Colors.red,
                    fontSize: 35),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum Health { good, bad, acceptable }
