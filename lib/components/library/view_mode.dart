import 'package:flutter/material.dart';

class ViewModeSection extends StatelessWidget {
  const ViewModeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              child: const Icon(Icons.arrow_downward, size: 18),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                  'Recently played',
                  style: TextStyle(fontSize: 13)
              ),
            )
          ],
        ),
        GestureDetector(
          child: const Icon(Icons.dashboard_outlined, size: 18),
        )
      ],
    );
  }
}
