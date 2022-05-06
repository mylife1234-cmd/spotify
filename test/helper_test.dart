import 'package:flutter_test/flutter_test.dart';
import 'package:spotify/utils/helper.dart';

void main() {
  test('Get image from assets', () async {
    final image = getImageFromUrl('assets/images/placeholder');

    expect(image.runtimeType.toString(), 'AssetImage');
  });

  test('Get image from network', () async {
    final image = getImageFromUrl(
      'https://android-express-server.herokuapp.com/image/Cát%20Bà',
    );

    expect(image.runtimeType.toString(), 'NetworkImage');
  });
}
