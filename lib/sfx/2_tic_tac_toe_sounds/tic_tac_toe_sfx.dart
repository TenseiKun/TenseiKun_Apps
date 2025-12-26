import 'package:audioplayers/audioplayers.dart';

class TTTSoundEffects {
  static final AudioPlayer player = AudioPlayer();

  static Future arenaTapSound(bool player1Turn) async {
    await player.stop();
    if (player1Turn) {
      await player.play(AssetSource('sounds/player1_tapSound.mp3'));
    } else {
      await player.play(AssetSource('sounds/player2_tapSound.mp3'));
    }
  }

  static Future arenaWinnerSound() async {
    await player.stop();
    await player.play(AssetSource('sounds/winnerAnnouncement.mp3'));
  }
}
