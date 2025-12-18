import 'package:flutter/material.dart';

class TopHeaderBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      color: const Color(0xff1E4E79),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          const Text(
            "MUDPRO+",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              letterSpacing: 1,
            ),
          ),
          const Spacer(),
          _buildToolbarIcons(),
        ],
      ),
    );
  }

  Widget _buildToolbarIcons() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.save, color: Colors.white70, size: 20),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.print, color: Colors.white70, size: 20),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.refresh, color: Colors.white70, size: 20),
          onPressed: () {},
        ),
      ],
    );
  }
}