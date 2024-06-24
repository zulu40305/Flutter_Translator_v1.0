
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';

import 'package:translator_testing/controller/app_state.dart';
import 'package:translator_testing/controller/show_alert.dart';
import 'package:translator_testing/src/drawer.dart';
import 'package:translator_testing/src/icon_button_widget.dart';
import 'package:translator_testing/src/language_selector.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:translator_testing/src/translator_selector.dart';
import 'package:translator_testing/view/image_crop.dart';

class TranslatorImage extends StatefulWidget {
  const TranslatorImage({required this.cameras, super.key});
  final List<CameraDescription> cameras;

  @override
  State<TranslatorImage> createState() => _TranslatorImageState();
}

class _TranslatorImageState extends State<TranslatorImage> {
  late CameraController _controller;
  late XFile image;

  Future<XFile> cropImage(XFile imageFile) async {
    final croppedFileTemp = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: '이미지 자르기/회전하기',
          toolbarColor: const Color.fromARGB(255, 65, 105, 225),
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: '이미지 자르기/회전하기',
        ),
      ],
    );
    
    return XFile(croppedFileTemp!.path);
  }

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.cameras[0], ResolutionPreset.max, enableAudio: false);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    })
    .catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            throw Exception("An error occured: CameraAccessDenied");
          default:
            throw Exception("An error occured: CameraController Error");
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<AppState>(
      builder: (context, appState, _) => Scaffold(
        drawer: const DrawerLayout(),
        body: _controller.value.isInitialized
          ? Stack(
            children: <Widget>[
              Positioned.fill(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.previewSize!.height,
                      height: _controller.value.previewSize!.width,
                      child: CameraPreview(_controller),
                    ),
                  ),
                )
              ),
              SafeArea(
                child: Stack(
                  children: [
                    const Align(
                      alignment: Alignment.topCenter,
                      child: LanguageSelector(),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 70.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButtonWidget(
                              borderColor: Colors.white,
                              backgroundColor: Colors.transparent,
                              iconColor: Colors.white,
                              buttonIcon: Icons.image_outlined,
                              padding: 7.0,
                              borderWidth: 1.5,
                              function: () async {
                                final XFile? pickedFile = 
                                  await ImagePicker().pickImage(source: ImageSource.gallery);
                                  if (pickedFile != null) {
                                    final croppedFile = await cropImage(pickedFile);
                                    final recognizedText = await appState.getRecognizedText(croppedFile);
                                    final translatedText = await appState.translateText(recognizedText);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ImageTranslation(
                                          image: croppedFile,
                                          originalText: recognizedText,
                                          translatedText: translatedText,
                                        )
                                      ),
                                    );
                                  }
                              }
                            ),
                            Container(
                              width: 80,
                              height: 80,
                              padding: const EdgeInsets.all(7.5),
                              decoration: BoxDecoration( 
                                color:const Color.fromARGB(255, 65, 105, 225),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: Container(
                                decoration: BoxDecoration( 
                                  border: Border.all(color: Colors.white, width: 2.5),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                child: TextButton(
                                  child: Container(),
                                  onPressed: () async {
                                    if (!_controller.value.isInitialized) {
                                      return;
                                    } else {
                                      if(appState.sourceLanguage.script_value != null) {
                                        image = await _controller.takePicture();

                                        final croppedFile = await cropImage(image);
                                        final recognizedText = await appState.getRecognizedText(croppedFile);
                                        final translatedText = await appState.translateText(recognizedText);
                                        
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ImageTranslation(
                                              image: croppedFile,
                                              originalText: recognizedText,
                                              translatedText: translatedText,
                                            )
                                          ),
                                        );
                                      } else {
                                        showAlertDialog(
                                          context,
                                          '해당 언어는 아직 이미지 번역을 지원하지 않습니다.',
                                        );
                                      }
                                    }
                                  },
                                )
                              )
                            ),
                            IconButtonWidget(
                              borderColor: Colors.white,
                              backgroundColor: Colors.transparent,
                              iconColor: Colors.white,
                              buttonIcon: Icons.file_open_outlined,
                              padding: 7.0,
                              borderWidth: 1.5,
                              function: () async {
                                FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ['png', 'jpg', 'jpeg'],
                                  allowMultiple: false
                                );
                                
                                if (pickedFile != null) {
                                  XFile file = XFile(pickedFile.files.single.path!);
                                  final croppedFile = await cropImage(file);
                                  final recognizedText = await appState.getRecognizedText(croppedFile);
                                  final translatedText = await appState.translateText(recognizedText);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ImageTranslation(
                                        image: croppedFile,
                                        originalText: recognizedText,
                                        translatedText: translatedText,
                                      )
                                    ),
                                  );
                                } 
                              }
                            ),
                          ],
                        )
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Builder(
                        builder: (context) {
                          return TranslatorSelector(
                            function: () { Scaffold.of(context).openDrawer(); }
                          );
                        },
                      )
                    )
                  ],
                )
              )
            ]
          )
          : const Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Color.fromARGB(255, 65, 105, 225)),
                SizedBox(height: 15),
                Text(
                  '카메라 준비중...',
                  style: TextStyle(
                    color: Color.fromARGB(255, 65, 105, 225),
                    fontSize: 14.0,
                  )
                )
              ],
            )
          ),
      )
    );
  }
}
