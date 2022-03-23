import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MusicSlider extends StatefulWidget {
  const MusicSlider({Key? key}) : super(key: key);

  @override
  State<MusicSlider> createState() => _MusicSliderState();
}

class _MusicSliderState extends State<MusicSlider> {
  double _currentDuration = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SliderTheme(
        data: SliderThemeData(
            thumbShape:
            const RoundSliderThumbShape(enabledThumbRadius: 6),
            trackShape: const RectangularSliderTrackShape(),
            overlayShape: SliderComponentShape.noOverlay,
            overlayColor: Colors.white),
        child: Slider(
          value: _currentDuration,
          onChanged: (value) {
            setState(() {
              _currentDuration = value;
            });
          },
          activeColor: Colors.white,
          inactiveColor: Colors.white30,
        ),
      ),
    );
  }
}
