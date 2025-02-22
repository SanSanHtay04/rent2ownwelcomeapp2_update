import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import 'package:flutter/services.dart';
import 'package:workmanager/workmanager.dart';

// void callbackDispatcher() {
//   Workmanager().executeTask((dynamic task, dynamic inputData) async {
//     print('Background Services are Working!');
//     try {
//       final Iterable<CallLogEntry> cLog = await CallLog.get();
//       print('Queried call log entries');
//       for (CallLogEntry entry in cLog) {
//         print('-------------------------------------');
//         print('F. NUMBER  : ${entry.formattedNumber}');
//         print('C.M. NUMBER: ${entry.cachedMatchedNumber}');
//         print('NUMBER     : ${entry.number}');
//         print('NAME       : ${entry.name}');
//         print('TYPE       : ${entry.callType}');
//         print(
//             'DATE       : ${DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)}');
//         print('DURATION   : ${entry.duration}');
//         print('ACCOUNT ID : ${entry.phoneAccountId}');
//         print('ACCOUNT ID : ${entry.phoneAccountId}');
//         print('SIM NAME   : ${entry.simDisplayName}');
//         print('-------------------------------------');
//       }
//       return true;
//     } on PlatformException catch (e, s) {
//       print(e);
//       print(s);
//       return true;
//     }
//   });
// }

class CallLogsTestingScreen extends StatefulWidget {
  CallLogsTestingScreen({Key? key}) : super(key: key);

  @override
  State<CallLogsTestingScreen> createState() => _CallLogsTestingScreenState();
}

class _CallLogsTestingScreenState extends State<CallLogsTestingScreen> {
  Iterable<CallLogEntry> _callLogEntries = <CallLogEntry>[];

  Map<String, int> countAllOccurrences(List<String> values) {
    final counter = <String, int>{};
    for (final value in values) {
      counter.update(value, (count) => count + 1, ifAbsent: () => 1);
    }

    return counter;
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle mono = TextStyle(fontFamily: 'monospace');
    final List<Widget> children = <Widget>[];

    // var group = groupBy(_callLogEntries, (CallLogEntry e) => e.number).map(
    //     (key, value) => MapEntry(
    //         key,
    //         groupBy(value, (CallLogEntry e) => e.duration).map((key, value) =>
    //             MapEntry(key, value.map((e) => e.callType).whereNotNull()))));

    // print(group);

    List<String> phoneNumbers = [];
    for (CallLogEntry entry in _callLogEntries) {
      phoneNumbers.add(entry.number!);
    }

    Map<String, int> counter = countAllOccurrences(phoneNumbers);
    print(counter);

    phoneNumbers = phoneNumbers.toSet().toList();

    for (String phone in phoneNumbers) {
      print(_callLogEntries
          .where((e) => e.number == phone && e.callType == CallType.missed)
          .length); // 2

      children.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Divider(),
          Text("NUMBER : ${phone}"),
          Text(
              "Frequency : ${_callLogEntries.where((e) => e.number == phone).length}"),
          Text(
              "Incoming : ${_callLogEntries.where((e) => e.number == phone && e.callType == CallType.incoming).length}")
        ],
      ));
    }

    /*for (CallLogEntry entry in _callLogEntries) {
      children.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Divider(),
            Text('F. NUMBER  : ${entry.formattedNumber}', style: mono),
            Text('C.M. NUMBER: ${entry.cachedMatchedNumber}', style: mono),
            Text('NUMBER     : ${entry.number}', style: mono),
            Text('NAME       : ${entry.name}', style: mono),
            Text('TYPE       : ${entry.callType}', style: mono),
            Text(
                'DATE       : ${DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)}',
                style: mono),
            Text('DURATION   : ${entry.duration} sec', style: mono),
            Text('ACCOUNT ID : ${entry.phoneAccountId}', style: mono),
            Text('SIM NAME   : ${entry.simDisplayName}', style: mono),
          ],
        ),
      );
    }*/

    return Scaffold(
      appBar: AppBar(title: const Text('call_log example')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    final Iterable<CallLogEntry> result = await CallLog.query();
                    setState(() {
                      _callLogEntries = result;
                    });
                  },
                  child: const Text('Get all'),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Workmanager().registerOneOffTask(
                      DateTime.now().millisecondsSinceEpoch.toString(),
                      'simpleTask',
                      existingWorkPolicy: ExistingWorkPolicy.replace,
                    );
                  },
                  child: const Text('Get all in background'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: children),
            ),
          ],
        ),
      ),
    );
  }
}
