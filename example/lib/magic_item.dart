import 'package:example/conts.dart';
import 'package:flutter/material.dart';

class MagicItem extends StatelessWidget {
  final MagicAnimateGroup group;
  final ValueChanged<String> onChange;
  const MagicItem({super.key, required this.group, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            group.title,
            style: const TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: group.animates
                .map(
                  (e) => TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      overlayColor: const Color(0xFFFD287F),
                      side: const BorderSide(color: Color(0xFFFD287F)),
                    ),
                    onPressed: () => onChange(e),
                    child: Text(
                      e,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
