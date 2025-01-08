import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(ExamScheduleApp());
}

class ExamScheduleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exam Schedule',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExamSchedulePage(),
    );
  }
}

class ExamSchedulePage extends StatefulWidget {
  @override
  _ExamSchedulePageState createState() => _ExamSchedulePageState();
}

class _ExamSchedulePageState extends State<ExamSchedulePage> {
  late Map<DateTime, List<Map<String, dynamic>>> _events;
  List<Map<String, dynamic>> _selectedEvents = [];
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _events = {
      DateTime(2025, 1, 10): [
        {
          'exam': 'Роботика Exam',
          'room': 'АМФ МФ',
          'professor': 'Проф. Александра Јанева',
          'time': '10:00',
          'location': {'lat': 42.00484608045474, 'lng': 21.409797109881627} 
        }
      ],
      DateTime(2025, 1, 15): [
        {
          'exam': 'Физика Exam',
          'room': 'ФЕИТ 224',
          'professor': 'Проф. Елисавета Трифунова',
          'time': '15:00',
          'location': {'lat': 42.00512537513462, 'lng': 21.40829173850938} 
        }
      ],
      DateTime(2025, 1, 20): [
        {
          'exam': 'Математика 1 Exam',
          'room': 'АМФ ТМФ',
          'professor': 'Проф. Александар Јованов',
          'time': '13:00',
          'location': {'lat': 42.004657496552575, 'lng': 21.40992380709222} 
        }
      ],
    };
    _selectedEvents = _getEventsForDay(_focusedDay);
  }

  List<Map<String, dynamic>> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  Future<void> _openMap(double lat, double lng) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open map';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Schedule'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2020),
            lastDay: DateTime(2030),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            eventLoader: (day) => _getEventsForDay(day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _selectedEvents = _getEventsForDay(selectedDay);
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.yellowAccent,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Colors.pinkAccent,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ListView.builder(
              itemCount: _selectedEvents.length,
              itemBuilder: (context, index) {
                final event = _selectedEvents[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                  child: ListTile(
                    title: Text(event['exam']),
                    subtitle: Text(
                      'Room: ${event['room']}\nProfessor: ${event['professor']}\nTime: ${event['time']}',
                    ),
                    leading: Icon(Icons.event),
                    trailing: IconButton(
                      icon: Icon(Icons.location_on, color: Colors.blue),
                      onPressed: () {
                        final location = event['location'];
                        _openMap(location['lat'], location['lng']);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
