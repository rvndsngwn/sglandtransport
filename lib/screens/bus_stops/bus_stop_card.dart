import 'package:flutter/material.dart';

class BusCard extends StatelessWidget {
  const BusCard({
    this.openContainer,
    this.busStopCode,
    this.description,
    this.roadName,
  });

  final Function() openContainer;
  final String busStopCode;
  final String description;
  final String roadName;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(6),
      child: ListTile(
        leading: Icon(Icons.departure_board),
        onTap: openContainer,
        title: Text('$busStopCode ($description)'),
        subtitle: Text(roadName),
        trailing: Icon(Icons.assignment),
      ),
    );
  }
}