import 'dart:math';

Random random = Random();

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

int? searchEmptyTile(String humanPlayer, Map<int, String?> boxes) {
  for (var pattern in winPatterns) {
    int a = pattern[0];
    int b = pattern[1];
    int c = pattern[2];
    if (boxes[a] == humanPlayer &&
        boxes[b] == humanPlayer &&
        boxes[c] == null) {
      return c;
    }
    if (boxes[a] == humanPlayer &&
        boxes[b] == null &&
        boxes[c] == humanPlayer) {
      return b;
    }
    if (boxes[a] == null &&
        boxes[b] == humanPlayer &&
        boxes[c] == humanPlayer) {
      return a;
    }
  }
  return null;
}

int? tryingToWin(String aiPlayer, Map<int, String?> boxes) {
  double aiProbability = random.nextDouble();
  if (boxes[11] == null) {
    return 11;
  }
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

    if (aiProbability < 0.5) {
      if ((boxes[00] == null ||
              boxes[02] == null ||
              boxes[20] == null ||
              boxes[22] == null) &&
          boxes[11] != null) {
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

int? aiActing(String aiDifficulty, Map<int, String?> boxes, String humanPlayer,
    String aiPlayer) {
  List<int> emptyTiles =
      boxes.entries.where((e) => e.value == null).map((e) => e.key).toList();
  double aiProbability = random.nextDouble();

  if (aiDifficulty == "Beginner") {
    //random tile, dumb
    if (emptyTiles.isEmpty) return -1;
    return emptyTiles[random.nextInt(emptyTiles.length)];
  } else if (aiDifficulty == "Amateur") {
    //insanity diff prevents ai from losing and if possible, it will get that win
    if (aiProbability < 0.85) {
      //ai get win decision
      int? winMove = searchEmptyTile(aiPlayer, boxes);
      if (winMove != null) {
        return winMove;
      }
      //ai blocks win decision
      int? blockMove = searchEmptyTile(humanPlayer, boxes);
      if (blockMove != null) {
        return blockMove;
      }
      //ai random tile if it's not getting a win or lose
      if (emptyTiles.isEmpty) return -1;
      return emptyTiles[random.nextInt(emptyTiles.length)];
    } else {
      if (emptyTiles.isEmpty) return -1;
      return emptyTiles[random.nextInt(emptyTiles.length)];
    }
  } else if (aiDifficulty == "Master") {
    if (aiProbability < 0.98) {
      //ai get win decision
      int? winMove = searchEmptyTile(aiPlayer, boxes);
      if (winMove != null) {
        return winMove;
      }
      //ai blocks win decision
      int? blockMove = searchEmptyTile(humanPlayer, boxes);
      if (blockMove != null) {
        return blockMove;
      }
      int? tryingWinMove = tryingToWin(aiPlayer, boxes);
      if (tryingWinMove != null) {
        return tryingWinMove;
      }
      if (emptyTiles.isEmpty) return -1;
      return emptyTiles[random.nextInt(emptyTiles.length)];
    } else {
      if (emptyTiles.isEmpty) return -1;
      return emptyTiles[random.nextInt(emptyTiles.length)];
    }
  } else if (aiDifficulty == "Insanity") {
    if (aiProbability < 0.995) {
      int move = findBestMove(boxes, aiPlayer, humanPlayer);
      return move;
    }
    if (emptyTiles.isEmpty) return -1;
    return emptyTiles[random.nextInt(emptyTiles.length)];
  }
  return -1;
}

//for insanity diff
bool isMovesLeft(Map<int, String?> board) {
  return board.values.any((v) => v == null);
}

int evaluateBoard(
  Map<int, String?> board,
  String aiPlayer,
  String humanPlayer,
) {
  for (var pattern in winPatterns) {
    int a = pattern[0];
    int b = pattern[1];
    int c = pattern[2];

    if (board[a] == aiPlayer && board[b] == aiPlayer && board[c] == aiPlayer) {
      return 10;
    }

    if (board[a] == humanPlayer &&
        board[b] == humanPlayer &&
        board[c] == humanPlayer) {
      return -10;
    }
  }
  return 0;
}

int minimax(
  Map<int, String?> board,
  int depth,
  bool isMax,
  String aiPlayer,
  String humanPlayer,
) {
  int score = evaluateBoard(board, aiPlayer, humanPlayer);

  if (score == 10) return score - depth;
  if (score == -10) return score + depth;
  if (!isMovesLeft(board)) return 0;

  if (isMax) {
    int best = -1000;

    for (var key in board.keys) {
      if (board[key] == null) {
        board[key] = aiPlayer;
        best = max(
          best,
          minimax(board, depth + 1, false, aiPlayer, humanPlayer),
        );
        board[key] = null;
      }
    }
    return best;
  } else {
    int best = 1000;

    for (var key in board.keys) {
      if (board[key] == null) {
        board[key] = humanPlayer;
        best = min(
          best,
          minimax(board, depth + 1, true, aiPlayer, humanPlayer),
        );
        board[key] = null;
      }
    }
    return best;
  }
}

int findBestMove(
  Map<int, String?> board,
  String aiPlayer,
  String humanPlayer,
) {
  int bestVal = -1000;
  int bestMove = -1;

  for (var key in board.keys) {
    if (board[key] == null) {
      board[key] = aiPlayer;
      int moveVal = minimax(board, 0, false, aiPlayer, humanPlayer);
      board[key] = null;

      if (moveVal > bestVal) {
        bestVal = moveVal;
        bestMove = key;
      }
    }
  }
  return bestMove;
}
