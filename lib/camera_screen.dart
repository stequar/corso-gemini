import 'package:camera/camera.dart';
import 'package:corso_gemini/gemini.dart';
import 'package:corso_gemini/recipe.dart';
import 'package:corso_gemini/recipe_screen.dart';
import 'package:flutter/material.dart';

// A screen that allows users to take a picture using a given camera.
// ignore: must_be_immutable
class TakePictureScreen extends StatefulWidget {
  TakePictureScreen({
    super.key,
    // required this.camera,
  });

  late CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    getCamera();

    // final cameras = await availableCameras();
    // widget.camera = cameras.first;
    // To display the current output from the Camera,
    // create a CameraController.
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  void getCamera() async {
    final cameras = await availableCameras();
    widget.camera = cameras.first;

    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
    setState(() {});
    return;
  }

  @override
  Widget build(BuildContext context) {
    // Fill this out in the next steps.
    return Scaffold(
      body: _initializeControllerFuture == null
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If the Future is complete, display the preview.
                  return CameraPreview(_controller);
                } else {
                  // Otherwise, display a loading indicator.
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and then get the location
            // where the image file is saved.
            final image = await _controller.takePicture();
            print(image.path);
            // GeminiRepo().sendImageToGemini('Che cosa c\'è nella foto?', image);
            Recipe? recipe = await GeminiRepo().sendImageWithInstructionToGemini(
                'Che ricetta posso costruire con questi ingredienti?',
                image,
                'Se nella foto sono presenti degli ingredienti, creami una ricetta utilizzando gli ingredienti visualizzati, contando anche olio sale pepe e pasta come altri eventuali ingredienti disponibili. restituiscimi un map con un urlImage del piatto, ricerca su google images, una Stringa con la lista di ingredienti e una stringa con il procedimento. Esempio: {"title" : " ", "ingredienti" : " ", "procedimento": " "}. Non inviare i 3 apici + json. manda solo il map. Non inviare altri testi, ho solo bisogno di quel map. Se non sono presenti degli ingredienti rispondi con "error": "Mostrami degli ingredienti per comporre la tua ricetta"}.');
            if (recipe != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeScreen(
                    recipe: recipe,
                  ),
                ),
              );
            }
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
