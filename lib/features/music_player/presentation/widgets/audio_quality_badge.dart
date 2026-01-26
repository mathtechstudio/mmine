import 'package:flutter/material.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';

class AudioQualityBadge extends StatelessWidget {
  final AudioTrack track;

  const AudioQualityBadge({required this.track});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _getFormatColor(track.format).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _getFormatColor(track.format), width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            track.isHiRes ? Icons.hd : Icons.high_quality,
            size: 16,
            color: _getFormatColor(track.format),
          ),
          const SizedBox(width: 6),
          Text(
            _getQualityText(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: _getFormatColor(track.format),
            ),
          ),
          if (track.isHiRes) ...[
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Hi-Res',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getQualityText() {
    final format = track.format.name.toUpperCase();
    final bitDepth = track.bitDepth;
    final sampleRate = (track.sampleRate / 1000).toStringAsFixed(1);
    return '$format • $bitDepth-bit / ${sampleRate}kHz';
  }

  Color _getFormatColor(AudioFormat format) {
    return switch (format) {
      AudioFormat.flac => Colors.blue,
      AudioFormat.wav => Colors.green,
      AudioFormat.alac => Colors.purple,
    };
  }
}
