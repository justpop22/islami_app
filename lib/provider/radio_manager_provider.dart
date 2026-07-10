import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class RadioManagerProvider extends ChangeNotifier {
  late final AudioPlayer player;
  String? _currentPlayingUrl;
  bool? _isPlaying;
  double _volume = 1.0;

  String? get currentPlayingUrl => _currentPlayingUrl;
  bool get isPlaying => _isPlaying ?? false;
  double get volume => _volume;

  RadioManagerProvider() {
    player = AudioPlayer();
    player.playingStream.listen((isPlaying) {
      _isPlaying = isPlaying;
      notifyListeners();
    });
  }

  Future<void> play(String url) async {
    if (_currentPlayingUrl == url) {
      if (_isPlaying == true) {
        await player.pause();
      } else {
        await player.play();
      }
    } else {
      await player.stop();

      _currentPlayingUrl = url;
      _isPlaying = false;
      notifyListeners();

      try {
        await player.setUrl(url);
        await player.play();
      } catch (e) {
        debugPrint("Error loading audio URL: $e");
        _currentPlayingUrl = null;
        notifyListeners();
      }
    }
  }

  Future<void> pause() async {
    await player.pause();
  }

  Future<void> stop(String url) async {
    if (_currentPlayingUrl == url) {
      await player.stop();
      _currentPlayingUrl = null;
      _isPlaying = false;
      notifyListeners();
    }
  }

  Future<void> muteAudio(double volume, String url) async {
    if (_currentPlayingUrl == url) {
      _volume = volume;
      await player.setVolume(_volume);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}