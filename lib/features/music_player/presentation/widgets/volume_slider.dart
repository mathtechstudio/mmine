import 'package:flutter/material.dart';

class VolumeSlider extends StatelessWidget {
  final double volume;
  final ValueChanged<double> onChanged;

  const VolumeSlider({required this.volume, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        children: [
          Icon(
            volume == 0 ? Icons.volume_off : Icons.volume_up,
            color: Colors.grey[600],
          ),
          Expanded(
            child: Slider(
              value: volume,
              min: 0.0,
              max: 1.0,
              onChanged: onChanged,
              activeColor: Theme.of(context).colorScheme.primary,
            ),
          ),
          Text(
            '${(volume * 100).round()}%',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
