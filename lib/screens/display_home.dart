import 'package:flutter/material.dart';

class DisplayHome extends StatelessWidget {
  DisplayHome({super.key});

  final List<String> attendanceRules = [
    'A. Attendance',
    '  A.1 Tardiness',
    '    1st offense: Marked in the teacher\'s Class Record',
    '    2nd offense: Verbal Reprimand with marked in the teacher\'s Class Record',
    '    3rd offense: Marked absent in the teacher\'s Class record',
    '  A.2 Absence from Class',
    '    1st offense: Marked in the teacher\'s Class Record',
    '    2nd offense: Excuse letter noted by Parent or Guardian',
    '    3rd-6th offense: Excuse letter noted by Parent or Guardian and with verbal warning from the teacher',
    '    7th offense: Permit-for-Re-admission from the Discipline Coordinator, Guidance Counselor, and parent or guardian, to be certified by the Dean, concerned and to be approved by the Vice-President on Academic Affairs',
    '    8th offense: Dropping from the class (subject) when the number of hours of absence reaches 10% of total class hours',
  ];

  final List<String> cheatingRules = [
    'B. Cheating In Examinations And Quizzes',
    '  1st Offense: Suspension for 5 days',
    '  2nd Offense: Suspension for 10 days',
    '  3rd Offense: Suspension for 15 days',
    '  4th Offense: Automatic failing mark (5.0) in the subject',
  ];

  final List<String> postingRules = [
    'C. Posting, Removing, or destroying notices posted on bulletin boards or on any school property without authorization from school management representatives',
    '  1st Offense: Written Warning',
    '  2nd offense: Suspension for 1-2 days',
    '  3rd Offense: Suspension for 3-4 days',
    '  4th Offense: Suspension for 5 days',
    '  5th Offense: Suspension for 10 days',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('School Rules'),
      ),
      body: ListView(
        children: [
          _buildExpansionTile('Attendance Rules', attendanceRules),
          _buildExpansionTile('Cheating Rules', cheatingRules),
          _buildExpansionTile('Posting Rules', postingRules),
        ],
      ),
    );
  }

  Widget _buildExpansionTile(String title, List<String> rules) {
    return ExpansionTile(
      title: Text(title),
      children: rules.map((rule) => ListTile(title: Text(rule))).toList(),
    );
  }
}
