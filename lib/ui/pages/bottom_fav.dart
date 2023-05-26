import 'package:flutter/material.dart';

class Event {
  String title;
  DateTime startTime;
  DateTime finishTime;
  String status;

  Event(
      {required this.title,
      required this.startTime,
      required this.finishTime,
      required this.status});
}

class BottomFav extends StatelessWidget {
  final List<Event> events = [
    Event(
        title: 'Event One',
        startTime: DateTime(2023, 5, 24, 10),
        finishTime: DateTime(2023, 5, 24, 12),
        status: 'upcoming'),
    Event(
        title: 'Event Two',
        startTime: DateTime(2023, 5, 23, 14),
        finishTime: DateTime(2023, 5, 23, 16),
        status: 'finished'),
    Event(
        title: 'Event Three',
        startTime: DateTime(2023, 5, 22, 18),
        finishTime: DateTime(2023, 5, 22, 20),
        status: 'finished'),
    Event(
        title: 'Event Four',
        startTime: DateTime(2023, 5, 21, 9),
        finishTime: DateTime(2023, 5, 21, 11),
        status: 'finished'),
    Event(
        title: 'Event Five',
        startTime: DateTime(2023, 5, 20, 16),
        finishTime: DateTime(2023, 5, 20, 18),
        status: 'finished'),
    Event(
        title: 'Event Six',
        startTime: DateTime(2023, 5, 19, 8),
        finishTime: DateTime(2023, 5, 19, 10),
        status: 'finished'),
    Event(
        title: 'Event Seven',
        startTime: DateTime(2023, 5, 18, 19),
        finishTime: DateTime(2023, 5, 18, 21),
        status: 'finished'),
    Event(
        title: 'Event Eight',
        startTime: DateTime(2023, 5, 17, 13),
        finishTime: DateTime(2023, 5, 17, 15),
        status: 'finished'),
    Event(
        title: 'Event Nine',
        startTime: DateTime(2023, 5, 16, 11),
        finishTime: DateTime(2023, 5, 16, 13),
        status: 'finished'),
    Event(
        title: 'Event Ten',
        startTime: DateTime(2023, 5, 15, 9),
        finishTime: DateTime(2023, 5, 15, 11),
        status: 'finished'),
    Event(
        title: 'Event Eleven',
        startTime: DateTime(2023, 5, 25, 14),
        finishTime: DateTime(2023, 5, 25, 16),
        status: 'on going'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(events[index].title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Start Time: ${events[index].startTime.toString()}'),
                Text('Finish Time: ${events[index].finishTime.toString()}'),
                Text('Status: ${events[index].status}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
