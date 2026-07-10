import 'package:flutter/material.dart';
import 'package:islami/provider/radio_manager_provider.dart';
import 'package:provider/provider.dart';

class RadioReciterWidget extends StatelessWidget {
  const RadioReciterWidget({
    super.key,
    required this.sheikhName,
    required this.audioUrl,
  });

  final String sheikhName;
  final String audioUrl;

  @override
  Widget build(BuildContext context) {
    return Consumer<RadioManagerProvider>(
      builder: (context, radioProvider, child) {
        final bool isCurrentTrack = radioProvider.currentPlayingUrl == audioUrl;
        final bool isCurrentlyPlaying =
            isCurrentTrack && (radioProvider.isPlaying == true);
        final bool isMuted = isCurrentTrack && (radioProvider.volume == 0.0);

        return Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFD9B982),
            borderRadius: BorderRadius.circular(
              20,
            ),
            image: DecorationImage(
              image: AssetImage(
                isCurrentlyPlaying
                    ? 'assets/images/soundwave.png'
                    : 'assets/images/mosque_bg.png',
              ),
              alignment: Alignment.bottomCenter,
              fit: BoxFit.fitWidth,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                sheikhName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(
                    0xFF1E1E1E,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Play / Pause Toggle Button
                  IconButton(
                    onPressed: () {
                      radioProvider.play(audioUrl);
                    },
                    icon: Icon(
                      isCurrentlyPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      color: const Color(0xFF1E1E1E),
                      size:
                          45,
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Stop Button
                  IconButton(
                    onPressed: () {
                      if (isCurrentTrack) {
                        radioProvider.stop(audioUrl);
                      }
                    },

                    icon: const Icon(Icons.stop,color:  Color(0xFF1E1E1E), size: 35),

                  ),

                  const SizedBox(width: 10),

                  // Mute / Unmute Button
                  IconButton(
                    onPressed: () {
                      double targetVolume = isMuted ? 1.0 : 0.0;
                      radioProvider.muteAudio(targetVolume, audioUrl);
                    },
                    icon: Icon(
                      isMuted
                          ? Icons.volume_off_rounded
                          : Icons.volume_up_rounded,
                      color: const Color(0xFF1E1E1E),
                      size: 35,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
