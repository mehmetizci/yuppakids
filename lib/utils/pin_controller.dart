import 'dart:math';

class PinController {
  static String toWord(int number) {
    return toNumberName(number);
  }

  static String generatePin() {
    Set<int> setOfInts = Set();
    while (setOfInts.length < 4) {
      setOfInts.add(Random().nextInt(9) + 1);
    }

    int digit1 = setOfInts.elementAt(0);
    int digit2 = setOfInts.elementAt(1);
    int digit3 = setOfInts.elementAt(2);
    return toWord(digit1) + " " + toWord(digit2) + " " + toWord(digit3);
  }

  static bool pinDecoder(String pinDigits, int digit, int index) {
    if (toNumberName(digit) == pinDigits.split(" ").toList()[index]) {
      return true;
    }
    return false;
  }

  static String toNumberName(int number) {
    List<String> numberNames = [
      "",
      "Bir",
      "İki",
      "Üç",
      "Dört",
      "Beş",
      "Altı",
      "Yedi",
      "Sekiz",
      "Dokuz"
    ];

    return numberNames[number];
  }
}
