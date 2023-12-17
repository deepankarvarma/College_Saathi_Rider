import 'dart:math';


import 'package:college_saathi_final/tapp_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class requests extends StatelessWidget {
  const requests({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('User Requests'),showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: List.generate(
              10,
              (index) => RideHistoryItem(
                rideId: Random().nextInt(90) + 10,
                isCompleted: index.isEven,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RideHistoryItem extends StatefulWidget {
  final int rideId;
  final bool isCompleted;

  RideHistoryItem({
    required this.rideId,
    required this.isCompleted,
  });

  @override
  _RideHistoryItemState createState() => _RideHistoryItemState();
}

class _RideHistoryItemState extends State<RideHistoryItem> {

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        children: [
          ListTile(
            title: Text('Request from Place A to Place B'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rickshaw ID: ${widget.rideId}'),
                Text('Fare: Rs 10'),
                
              ],
            ),
            onTap: () {
              // Handle tap event for each ride item
            },
          ),
          Positioned(
            bottom: 16,
            right: 8,
            child: ElevatedButton(
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(6),
                shape: CircleBorder(),
              ),
              child: Container(
                width: 24,
                height: 24,
                child: Icon(Icons.check, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
