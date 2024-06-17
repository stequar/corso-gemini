import 'package:corso_gemini/camera_screen.dart';
import 'package:corso_gemini/text_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TextScreen(),
                  ),
                );
              },
              child: Text('Text')),
          ElevatedButton(onPressed: () {
            Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(),
                  ),
                );
          }, child: Text('Camera')),
        ],
      ),
    );
  }
}
