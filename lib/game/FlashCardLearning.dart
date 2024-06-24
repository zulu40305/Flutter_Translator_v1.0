import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flip_card/flip_card.dart';

import 'package:translator_testing/controller/app_state.dart';
import 'package:translator_testing/src/icon_button_widget.dart';

class FlashCardLearning extends StatefulWidget {
  const FlashCardLearning({required this.flashcard_name, required this.flashcards, super.key});

  final String flashcard_name;
  final List<dynamic> flashcards;

  @override
  State<FlashCardLearning> createState() => _FlashCardLearningState();
}

class _FlashCardLearningState extends State<FlashCardLearning> {
  late FlipCardController _controller_flip;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller_flip = FlipCardController();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, _) => Scaffold(
        appBar: AppBar(
          title: Text(
            widget.flashcard_name,
            style: const TextStyle(color: Color.fromARGB(255, 65, 105, 225)),
          ),
          iconTheme: const IconThemeData(color: Color.fromARGB(255, 65, 105, 225)),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlipCard(
                  controller: _controller_flip,
                  fill: Fill.fillBack,
                  direction: FlipDirection.HORIZONTAL,
                  side: CardSide.FRONT,
                  front: Card(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    '단어',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 65, 105, 225),
                                      fontSize: 12.0
                                    ),
                                  ),
                                  Text(
                                    widget.flashcards[currentPage]['word'],
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 26.0),
                                  )
                                ],
                              )
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 65, 105, 225),
                                borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0)),
                              ),
                              width: MediaQuery.of(context).size.width * 0.1,
                            ),
                          )
                        ],
                      )
                    )
                  ),
                  back: Card(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    '의미',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 65, 105, 225),
                                      fontSize: 12.0
                                    ),
                                  ),
                                  Text(
                                    widget.flashcards[currentPage]['meaning'],
                                    style: const TextStyle(fontSize: 18.0),
                                  ),
                                  const SizedBox(height: 10.0),
                                  const Text(
                                    '동의어',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 65, 105, 225),
                                      fontSize: 12.0
                                    ),
                                  ),
                                  Text(
                                    widget.flashcards[currentPage]['synonym'],
                                    style: const TextStyle(fontSize: 18.0),
                                  ),
                                  const SizedBox(height: 10.0),
                                  const Text(
                                    '반의어',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 65, 105, 225),
                                      fontSize: 12.0
                                    ),
                                  ),
                                  Text(
                                    widget.flashcards[currentPage]['antonym'],
                                    style: const TextStyle(fontSize: 18.0),
                                  ),
                                ],
                              )
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 65, 105, 225),
                                borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0)),
                              ),
                              width: MediaQuery.of(context).size.width * 0.1,
                            ),
                          )
                        ],
                      )
                    )
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButtonWidget(
                      borderColor: Colors.transparent, 
                      backgroundColor: const Color.fromARGB(255, 238, 241, 248), 
                      iconColor: const Color.fromARGB(255, 65, 105, 225), 
                      buttonIcon: Icons.arrow_back_ios_new_rounded,
                      iconSize: 30.0,
                      width: 70.0,
                      height: 70.0,
                      function: () {
                        setState(() {
                          if (currentPage != 0) {  currentPage -= 1; } 
                        });
                      },
                    ),
                    IconButtonWidget(
                      borderColor: Colors.transparent,
                      backgroundColor: const Color.fromARGB(255, 238, 241, 248), 
                      iconColor: const Color.fromARGB(255, 65, 105, 225), 
                      buttonIcon: Icons.arrow_forward_ios_rounded,
                      iconSize: 30.0,
                      width: 70.0,
                      height: 70.0,
                      function: () {
                        setState(() {
                          if (currentPage < widget.flashcards.length - 1) { currentPage += 1; }
                        });
                      },
                    ),
                  ],
                ),
                Text(
                  '${currentPage + 1} / ${widget.flashcards.length.toString()}',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 65, 105, 225),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600
                  ),
                )
              ],
            )
          )
        )
      )
    );
  }
}