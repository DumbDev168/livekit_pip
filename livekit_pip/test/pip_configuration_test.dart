import 'package:flutter_test/flutter_test.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:livekit_pip/livekit_pip.dart';

void main() {
  group('IosPipConfiguration', () {
    test('self-view defaults to on and mirrored, with no avatars', () {
      const config = IosPipConfiguration();
      expect(config.includeLocalParticipantVideo, isTrue);
      expect(config.mirrorSelfView, isTrue);
      expect(config.avatarUrlResolver, isNull);
    });

    test('keeps the avatar resolver it is given', () {
      String? resolver(Participant participant) => 'https://example.com/a.png';
      final config = IosPipConfiguration(avatarUrlResolver: resolver);
      expect(config.avatarUrlResolver, same(resolver));
    });
  });
}
