import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import 'package:translator_testing/model/flashcard.dart';
import 'package:translator_testing/model/translator_data.dart';
import 'package:translator_testing/model/language_data.dart';

class AppState with ChangeNotifier {
  AppState() {
    initilize();
  }

  Future<void> initilize() async {
    cameras = await availableCameras();
    await checkDownloadedModels();

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        getFlashcardDataFromDB();
      } else {
        _loggedIn = false;
        _flashcards = [];
        _flashcardSubscription.cancel();
      }
      notifyListeners();
    });
  }

  final String appTitle = "Translator";

  // ---------- 로그인 관련 함수 및 변수 ----------
  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  Future<void> createUserDocument(User user) async {
    CollectionReference colRef = FirebaseFirestore.instance.collection('user');
    DocumentReference docRef = colRef.doc(user.uid);

    final docSnapshot = await docRef.get();

    if(!docSnapshot.exists) {
      Map<String, dynamic> userData = {
        'name': user.displayName,
        'email': user.email,
        'uid': user.uid,
        'flashcard_list': <Map<String, FlashCardFrame>>[]
      };

      return await docRef.set(userData);
    }
  }

  Future<void> signFunc() async {
    final _googleSignIn = GoogleSignIn();

    if (!_loggedIn) {
      final GoogleSignInAccount? googleAccount = await _googleSignIn.signIn();

      if(googleAccount != null) {
        final GoogleSignInAuthentication? googleAuth = await googleAccount.authentication;
        if(googleAuth!.accessToken != null && googleAuth.idToken != null) {
          try {
            await FirebaseAuth.instance
              .signInWithCredential(GoogleAuthProvider.credential(
                idToken: googleAuth.idToken,
                accessToken: googleAuth.accessToken,
              ));
            createUserDocument(FirebaseAuth.instance.currentUser!);
            _loggedIn = true;
            notifyListeners();
          } on FirebaseAuthException catch (e) { 
            throw Exception('An error occured $e');
          } catch (e) {
            throw Exception('An error occured $e');
          }
        }
        else {
          throw Exception('An error occured');
        }
      } 
      else {
        throw Exception('An error occured');
      }
    } else {
      _loggedIn = false;
      notifyListeners();
    }
  }
  // ---------- 로그인 관련 함수 및 변수 ----------

  // ---------- 플래시카드 관련 함수 및 변수 ----------
  late StreamSubscription<DocumentSnapshot<Map<String, dynamic>>> _flashcardSubscription;
  List<dynamic> _flashcards = [];
  List<dynamic> get flashcards => _flashcards;

  void getFlashcardDataFromDB() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) { throw Exception('Must be logged in'); }

    String userId = user.uid;

    _flashcardSubscription = FirebaseFirestore.instance
    .collection('user')
    .doc(userId)
    .snapshots()
    .listen((snapshot) {
      if (snapshot.exists) {
        _flashcards = [];
        List<dynamic> flashcardList = snapshot.data()!['flashcard_list'];
        for (final flashcardFolder in flashcardList) {
          _flashcards.add(flashcardFolder);
        }
        notifyListeners();
      }
    });
  }

  Future<void> addFlashCardFolder(String name) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (!_loggedIn) { throw Exception('Must be logged in'); }

    String userId = user!.uid;    
    String id = Random.secure().nextDouble().toString();

    DocumentReference userDoc = FirebaseFirestore.instance.collection('user').doc(userId);

    return await userDoc.update({
      'flashcard_list': FieldValue.arrayUnion([{
        'id': id,
        'name': name,
        'cards': [],
      }])
    });
  }

  Future<void> deleteFlashCardList(String folderID) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (!_loggedIn) { throw Exception('Must be logged in'); }

    String userId = user!.uid;    

    DocumentReference userDoc = FirebaseFirestore.instance.collection('user').doc(userId);
    DocumentSnapshot userSnapshot = await userDoc.get();

    if (userSnapshot.exists) {
      List<dynamic> flashcardList = List<dynamic>.from(userSnapshot.get('flashcard_list') ?? []);

      flashcardList.removeWhere((flashcardFolder) => flashcardFolder['id'] == folderID);

      await userDoc.update({'flashcard_list': flashcardList});
      notifyListeners();
    } else {
      throw Exception('User document does not exist');
    }
  }

  Future<void> addFlashCard(String folderID, String word, String meaning, String synonym, String antonym) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (!_loggedIn) { throw Exception('Must be logged in'); }
    
    String userId = user!.uid; 
    String id = Random.secure().nextDouble().toString();

    DocumentReference userDoc = FirebaseFirestore.instance.collection('user').doc(userId);
    DocumentSnapshot userSnapshot = await userDoc.get();

    if (userSnapshot.exists) {
      List<dynamic> flashcardList = userSnapshot.get('flashcard_list');
      for (var flashcardFolder in flashcardList) {
        if (flashcardFolder['id'] == folderID) {
          List<dynamic> cards = flashcardFolder['cards'] ?? [];
          cards.add({
            'id': id,
            'word': word,
            'meaning': meaning,
            'synonym': synonym,
            'antonym': antonym,
        });
          flashcardFolder['cards'] = cards;
          break;
        }
      }
      await userDoc.update({'flashcard_list': flashcardList});
      notifyListeners();
    } else {
      throw Exception('User document does not exist');
    }
  }

  Future<void> editFlashCard(String cardID, String word, String meaning, String synonym, String antonym) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (!_loggedIn) { throw Exception('Must be logged in'); }
    
    String userId = user!.uid; 

    DocumentReference userDoc = FirebaseFirestore.instance.collection('user').doc(userId);
    DocumentSnapshot userSnapshot = await userDoc.get();

    if (userSnapshot.exists) {
      List<dynamic> flashcardList = userSnapshot.get('flashcard_list');
      for (var flashcardFolder in flashcardList) {
        List<dynamic> cards = flashcardFolder['cards'] ?? [];
        for (var flashcard in cards) {
          if (flashcard['id'] == cardID) {
            flashcard['word'] = word;
            flashcard['meaning'] = meaning;
            flashcard['synonym'] = synonym;
            flashcard['antonym'] = antonym;
            
            break;
          }
        }
        flashcardFolder['cards'] = cards;
      }
      await userDoc.update({'flashcard_list': flashcardList});
      notifyListeners();
    } else {
      throw Exception('User document does not exist');
    }
  }


  Future<void> deleteFlashCard(String folderID, String cardID) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (!_loggedIn) { throw Exception('Must be logged in'); }

    String userId = user!.uid;    

    DocumentReference userDoc = FirebaseFirestore.instance.collection('user').doc(userId);
    DocumentSnapshot userSnapshot = await userDoc.get();

    if (userSnapshot.exists) {
      List<dynamic> flashcardList = userSnapshot.get('flashcard_list');
      for (var flashcardFolder in flashcardList) {
        if (flashcardFolder['id'] == folderID) {
          List<dynamic> cards = flashcardFolder['cards'] ?? [];
          for (var flashcard in cards) {
            if (flashcard['id'] == cardID) {
              cards.remove(flashcard);
              flashcardFolder['cards'] = cards;
              break;
            }
          }
        }
      }
      await userDoc.update({'flashcard_list': flashcardList});
      notifyListeners();
    } else {
      throw Exception('User document does not exist');
    }
  }
  // ---------- 플래시카드 관련 함수 및 변수 ----------
  
  NavigatorValue _translator = translator_type[0];
  NavigatorValue get translator => _translator;

  void selectTranslator(NavigatorValue value) {
    _translator = value;
    notifyListeners();
  }

  late OnDeviceTranslator onDeviceTranslator;

  TranslatorValue _sourceLanguage = languages[51];
  TranslatorValue get sourceLanguage => _sourceLanguage;

  TranslatorValue _targetLanguage = languages[29];
  TranslatorValue get targetLanguage => _targetLanguage;

  void setLanguage() {
    onDeviceTranslator = OnDeviceTranslator(
      sourceLanguage: sourceLanguage.value,
      targetLanguage: targetLanguage.value,
    );
  }

  void switchLanguage() {
    TranslatorValue templateLanguage = _targetLanguage;
    _targetLanguage = _sourceLanguage;
    _sourceLanguage = templateLanguage;
    setLanguage();
    notifyListeners();
  }

  void selectSourceLanguage(TranslatorValue selectedLanguage) {
    if (selectedLanguage.value != _targetLanguage.value) {
      _sourceLanguage = selectedLanguage;
      setLanguage();
      notifyListeners();
    } else {
      switchLanguage();
    }
  }

  void selectTargetLanguage(TranslatorValue selectedLanguage) {
    if (selectedLanguage.value != _sourceLanguage.value) {
      _targetLanguage = selectedLanguage;
      setLanguage();
      notifyListeners();
    } else {
      switchLanguage();
    }
  }

  Future<void> checkDownloadedModels() async {
    for (TranslatorValue language in languages) {
      bool isDownloaded = await OnDeviceTranslatorModelManager().isModelDownloaded('${language.language_code}');
      language.isDownloaded = isDownloaded;
    }
    notifyListeners();
  }

  Future<void> downloadLanguageModel(TranslatorValue language) async {
    try {
      language.isDownloading = true;
      notifyListeners();
      await OnDeviceTranslatorModelManager().downloadModel('${language.language_code}');
      language.isDownloading = false;
      language.isDownloaded = true;
    } catch (e) {
      print('Error downloading model for ${language.language_code}: $e');
      language.isDownloading = false;
      language.isDownloaded = false;
    } finally {
      notifyListeners();
    }
  }

  Future<String> translateText(String sourceText) async {
    setLanguage();
    try {
      final String translation = await onDeviceTranslator.translateText(sourceText);
      return translation;
    } catch (e) {
      print('Error translating text: $e');
      rethrow;
    }
  }

  late List<CameraDescription> cameras;

  Future<String> getRecognizedText(XFile image) async {
    String scannedText = "";

    final InputImage inputImage = InputImage.fromFilePath(image.path);
    final textRecognizer = GoogleMlKit.vision.textRecognizer(script: sourceLanguage.script_value);
    RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    await textRecognizer.close();

    scannedText = "";
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = scannedText + line.text + "\n";
      }
    }

    return scannedText;
  }

  Future<void> useTTS(String text, TranslatorValue language) async {
    if (Platform.operatingSystem == 'ios') {
      await FlutterTts().setSharedInstance(true);

      await FlutterTts().setIosAudioCategory(
        IosTextToSpeechAudioCategory.ambient,
        [
          IosTextToSpeechAudioCategoryOptions.allowBluetooth,
          IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
          IosTextToSpeechAudioCategoryOptions.mixWithOthers
        ],
        IosTextToSpeechAudioMode.voicePrompt
      );
    }
    await FlutterTts().setLanguage(language.iso_language_code!);
    await FlutterTts().setPitch(1.0);
    await FlutterTts().setSpeechRate(0.5);
    await FlutterTts().speak(text);
  }

  late OnDeviceTranslator onDeviceTranslator_conversation;

  Future<String> useConversationTranslator(TranslatorValue source, TranslatorValue target, String sourceText) async {
    onDeviceTranslator_conversation = OnDeviceTranslator(
      sourceLanguage: source.value,
      targetLanguage: target.value,
    );
    try {
      final String translation = await onDeviceTranslator_conversation.translateText(sourceText);
      return translation;
    } catch (e) {
      print('Error translating text: $e');
      rethrow;
    }
  }
}