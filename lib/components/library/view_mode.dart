import 'package:flutter/material.dart';

class ViewModeSection extends StatelessWidget {
  const ViewModeSection({Key? key, this.handleViewModeChange, this.showAsList})
      : super(key: key);

  final void Function()? handleViewModeChange;

  final bool? showAsList;

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
              child: Text('Recently played', style: TextStyle(fontSize: 13)),
            )
          ],
        ),
        GestureDetector(
          child: Icon(
            showAsList! ? Icons.dashboard_outlined : Icons.format_list_bulleted,
            size: 18,
          ),
          onTap: handleViewModeChange,
        )
      ],
    );
  }
}
