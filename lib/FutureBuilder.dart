import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('FutureBuilder Error Tracking')),
        body: Center(
          child: FutureBuilder<String>(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                print('Error path executed');
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                print('Data path executed');
                return Text('Data: ${snapshot.data}');
              } else {
                return Text('No data available');
              }
            },
          ),
        ),
      ),
    );
  }

  Future<String> fetchData() async {
    await Future.delayed(Duration(seconds: 2));

    if (Random().nextBool()) {
      throw Exception('Simulated error occurred');
    }

    return 'Hello, Flutter!';
  }
}



// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('FutureBuilder Example')),
//         body: Center(
//           child: FutureBuilder<String>(
//             future: fetchData(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return CircularProgressIndicator();
//               } else if (snapshot.hasError) {
//                 return Text('Error: ${snapshot.error}');
//               } else if (snapshot.hasData) {
//                 return Text('Data: ${snapshot.data}');
//               } else {
//                 return Text('No data available');
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Future<String> fetchData() async {
//     await Future.delayed(Duration(seconds: 2));
//     return 'Hello, Flutter!';
//   }
// }
