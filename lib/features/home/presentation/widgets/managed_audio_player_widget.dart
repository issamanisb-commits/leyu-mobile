import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leyu_mobile/core/services/audio_manager_service.dart';
import 'package:leyu_mobile/features/home/presentation/widgets/audio_player_widget.dart';

/// Wrapper for AudioPlayerWidget that manages audio lifecycle based on page visibility
class ManagedAudioPlayerWidget extends StatefulWidget {
  final String audioUrl;
  final String microTaskId;

  const ManagedAudioPlayerWidget({
    super.key,
    required this.audioUrl,
    required this.microTaskId,
  });

  @override
  State<ManagedAudioPlayerWidget> createState() =>
      _ManagedAudioPlayerWidgetState();
}

class _ManagedAudioPlayerWidgetState extends State<ManagedAudioPlayerWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive =>
      false; // Don't keep the widget alive when scrolled away

  @override
  void deactivate() {
    // Stop all audio when this widget is deactivated (scrolled away)
    try {
      final audioManager = Get.find<AudioManagerService>();
      audioManager.stopAllAudio();
      print(
          'ManagedAudioPlayer: Stopped all audio on deactivate for ${widget.microTaskId}');
    } catch (e) {
      print('ManagedAudioPlayer: Error stopping audio on deactivate: $e');
    }
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin

    return AudioPlayerWidget(
      key: ValueKey('audio_${widget.microTaskId}'),
      audioUrl: widget.audioUrl,
    );
  }
}
