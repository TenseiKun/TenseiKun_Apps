import 'dart:math';

Random random = Random();

bool aiChange(bool isAI) {
  if (isAI) {
    return true;
  } else {
    return false;
  }
}

final List<List<int>> winPatterns = [
  //rows
  [00, 01, 02],
  [10, 11, 12],
  [20, 21, 22],
  //columns
  [00, 10, 20],
  [01, 11, 21],
  [02, 12, 22],
  //diagonals
  [00, 11, 22],
  [20, 11, 02],
];

final List<int> corners = [00, 02, 20, 22];

int? searchEmptyTile(String player, Map<int, String?> boxes) {
  for (var pattern in winPatterns) {
    int a = pattern[0];
    int b = pattern[1];
    int c = pattern[2];
    if (boxes[a] == player && boxes[b] == player && boxes[c] == null) return c;
    if (boxes[a] == player && boxes[b] == null && boxes[c] == player) return b;
    if (boxes[a] == null && boxes[b] == player && boxes[c] == player) return a;
  }
  return null;
}

int? tryingToWin(String aiPlayer, Map<int, String?> boxes) {
  int aiProbability = random.nextInt(100) + 1;
  for (var pattern in winPatterns) {
    int a = pattern[0];
    int b = pattern[1];
    int c = pattern[2];

    int aiTiles = 0;
    if (boxes[a] == aiPlayer) aiTiles++;
    if (boxes[b] == aiPlayer) aiTiles++;
    if (boxes[c] == aiPlayer) aiTiles++;

    List<int> emptyTiles = [];
    if (boxes[a] == null) emptyTiles.add(a);
    if (boxes[b] == null) emptyTiles.add(b);
    if (boxes[c] == null) emptyTiles.add(c);

    if (boxes[11] == null) {
      print("center first!");
      return 11;
    }
    if (aiProbability <= 60 && aiProbability >= 1) {
      if (boxes[00] == null ||
          boxes[02] == null ||
          boxes[20] == null ||
          boxes[22] == null && boxes[11] != null) {
        print("corners first!");
        List<int> emptyCorners =
            corners.where((corner) => boxes[corner] == null).toList();
        return emptyCorners[random.nextInt(emptyCorners.length)];
      }
    } else {
      if (aiTiles == 1 && emptyTiles.length == 2) {
        return emptyTiles[random.nextInt(emptyTiles.length)];
      }
    }
  }
  return null;
}

int? aiActing(String aiDifficulty, Map<int, String?> boxes, String player,
    String aiPlayer) {
  List<int> emptyTiles =
      boxes.entries.where((e) => e.value == null).map((e) => e.key).toList();
  int aiProbability = random.nextInt(100) + 1;

  if (aiDifficulty == "Beginner") {
    //random tile, dumb
    if (emptyTiles.isEmpty) return -1;
    return emptyTiles[random.nextInt(emptyTiles.length)];
  } else if (aiDifficulty == "Amateur") {
    //insanity diff prevents ai from losing and if possible, it will get that win
    if (aiProbability <= 85 && aiProbability >= 1) {
      //ai get win decision
      int? winMove = searchEmptyTile(aiPlayer, boxes);
      if (winMove != null) {
        print('im gonna win!');
        return winMove;
      }
      //ai blocks win decision
      int? blockMove = searchEmptyTile(player, boxes);
      if (blockMove != null) {
        print('i block your win');
        return blockMove;
      }
      //ai random tile if it's not getting a win or lose
      if (emptyTiles.isEmpty) return -1;
      return emptyTiles[random.nextInt(emptyTiles.length)];
    } else {
      print("i decided to be a dumb");
      print({aiProbability});
      if (emptyTiles.isEmpty) return -1;
      return emptyTiles[random.nextInt(emptyTiles.length)];
    }
  } else if (aiDifficulty == "Insanity") {
    if (aiProbability <= 98 && aiProbability >= 1) {
      //ai get win decision
      int? winMove = searchEmptyTile(aiPlayer, boxes);
      if (winMove != null) {
        print('im gonna win!');
        return winMove;
      }
      //ai blocks win decision
      int? blockMove = searchEmptyTile(player, boxes);
      if (blockMove != null) {
        print('i block your win');
        return blockMove;
      }
      int? tryingWinMove = tryingToWin(player, boxes);
      if (tryingWinMove != null) {
        print('im strategizing');
        return tryingWinMove;
      }
      if (emptyTiles.isEmpty) return -1;
    } else {
      print("i decided to be a dumb");
      print({aiProbability});
      if (emptyTiles.isEmpty) return -1;
      return emptyTiles[random.nextInt(emptyTiles.length)];
    }
  }
  return -1;
}

void aiTurn() {}
