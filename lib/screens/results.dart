import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tamuhack2023/models/api_response.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
