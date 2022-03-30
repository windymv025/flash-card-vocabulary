import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../../constants/enums.dart';

class SpeechWidget extends StatefulWidget {
  const SpeechWidget({Key? key, required this.text, this.engine, this.language})
      : super(key: key);
  final String text;
  final String? engine;
  final String? language;
  @override
  State<SpeechWidget> createState() => _SpeechWidgetState();
}

class _SpeechWidgetState extends State<SpeechWidget> {
  late FlutterTts flutterTts;

  double volume = 1;
  double pitch = 1;
  double rate = 0.5;
  bool isCurrentLanguageInstalled = false;

  TtsState ttsState = TtsState.stopped;
  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWeb => kIsWeb;

  @override
  initState() {
    super.initState();
    initTts();
  }

  initTts() {
    flutterTts = FlutterTts();

    _setAwaitOptions();

    if (isAndroid) {
      _getDefaultEngine();
    }

    flutterTts.setStartHandler(() {
      setState(() {
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.language != null) {
      flutterTts.setLanguage(widget.language!);
      if (isAndroid) {
        flutterTts
            .isLanguageInstalled(widget.language!)
            .then((value) => isCurrentLanguageInstalled = (value as bool));
      }
    }

    if (widget.engine != null) {
      flutterTts.setEngine(widget.engine!);
    }
    return InkWell(
      onTap: () => isStopped ? _speak() : _stop(),
      child: Icon(
        isStopped ? Icons.volume_up : Icons.volume_off,
        color: Colors.blue,
        size: 45,
      ),
    );
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {}
  }

  Future _speak() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (widget.text.isNotEmpty) {
      await flutterTts.speak(widget.text);
    }
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }
}
