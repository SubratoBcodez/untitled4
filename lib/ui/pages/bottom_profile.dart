import 'package:flutter/material.dart';

enum EventStatus {
  ongoing,
  finished,
  upcoming,
}

class Event {
  final String title;
  final DateTime startTime;
  final DateTime endTime;

  const Event({
    required this.title,
    required this.startTime,
    required this.endTime,
  });
}

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final status = _getStatus(event, now);

    return Card(
      child: ListTile(
        title: Text(event.title),
        subtitle: Text(_getSubtitle(event)),
        trailing: Text(_getStatusText(status)),
      ),
    );
  }

  String _getSubtitle(Event event) {
    final start = event.startTime;
    final end = event.endTime;
    return '${start.day}/${start.month}/${start.year} - ${end.day}/${end.month}/${end.year}';
  }

  EventStatus _getStatus(Event event, DateTime now) {
    if (event.endTime.isBefore(now)) {
      return EventStatus.finished;
    } else if (event.startTime.isAfter(now)) {
      return EventStatus.upcoming;
    } else {
      return EventStatus.ongoing;
    }
  }

  String _getStatusText(EventStatus status) {
    switch (status) {
      case EventStatus.ongoing:
        return 'On Going';
      case EventStatus.finished:
        return 'Finished';
      case EventStatus.upcoming:
        return 'Upcoming';
    }
  }
}

class BottomProfile extends StatelessWidget {
  final events = [
    Event(
      title: 'Event A',
      startTime: DateTime(2023, 5, 20),
      endTime: DateTime(2023, 5, 23),
    ),
    Event(
      title: 'Event B',
      startTime: DateTime(2023, 5, 24),
      endTime: DateTime(2023, 5, 27),
    ),
    Event(
      title: 'Event C',
      startTime: DateTime(2023, 5, 21),
      endTime: DateTime(2023, 5, 22),
    ),
    Event(
      title: 'Event D',
      startTime: DateTime(2023, 5, 22),
      endTime: DateTime(2023, 5, 24),
    ),
    Event(
      title: 'Event E',
      startTime: DateTime(2023, 5, 23),
      endTime: DateTime(2023, 5, 24),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Events')),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return EventCard(event: events[index]);
        },
      ),
    );
  }
}
