import 'package:flutter/widgets.dart';
import 'package:livekit_client/livekit_client.dart';

/// Configuration for the Android PiP window.
class AndroidPipConfiguration {
  /// Creates Android PiP configuration.
  const AndroidPipConfiguration({
    required this.pipWidgetBuilder,
    this.autoEnterOnBackground = true,
  });

  /// Widget rendered inside the PiP window on Android.
  final Widget Function(BuildContext context, Room room) pipWidgetBuilder;

  /// If true, PiP is entered automatically when the user presses home.
  final bool autoEnterOnBackground;
}

/// Returns the avatar image URL for [participant], or null to show their
/// initials. Used in the iOS PiP window while their camera is off.
typedef PipAvatarUrlResolver = String? Function(Participant participant);

/// Configuration for the iOS PiP window.
///
/// iOS draws the PiP window natively: Flutter cannot render while the app is
/// in the background, which is when PiP is on screen. So there is no widget
/// builder here, unlike [AndroidPipConfiguration].
class IosPipConfiguration {
  /// Creates iOS PiP configuration.
  const IosPipConfiguration({
    this.includeLocalParticipantVideo = true,
    this.autoEnterOnBackground = true,
    this.mirrorSelfView = true,
    this.avatarUrlResolver,
  });

  /// If true, the PiP window shows the user's own tile beside the other
  /// person, and the plugin asks iOS to keep the camera running while the
  /// app is in the background.
  ///
  /// iOS only allows that with multitasking camera access; otherwise the
  /// user's tile shows their avatar. Keeping the camera running also keeps
  /// the other side seeing the user while they are in another app.
  final bool includeLocalParticipantVideo;

  /// If true, PiP is entered automatically when the app is backgrounded.
  final bool autoEnterOnBackground;

  /// If true, the user's own video is mirrored like a front-camera preview.
  final bool mirrorSelfView;

  /// Avatar for each participant, shown while their camera is off. Called
  /// again when a participant's name, metadata, or attributes change.
  final PipAvatarUrlResolver? avatarUrlResolver;
}

/// Master configuration for livekit_pip.
class LiveKitPipConfiguration {
  /// Creates the master PiP configuration.
  const LiveKitPipConfiguration({
    required this.android,
    required this.ios,
    this.enabled = true,
    this.disableWhenScreenSharing = true,
  });

  /// Master switch. When false, all PiP functionality is a no-op.
  final bool enabled;

  /// Suppress auto-enter when the local participant is screen sharing.
  final bool disableWhenScreenSharing;

  /// Android-specific configuration.
  final AndroidPipConfiguration android;

  /// iOS-specific configuration.
  final IosPipConfiguration ios;
}
