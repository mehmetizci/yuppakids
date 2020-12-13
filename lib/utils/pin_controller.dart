import 'dart:math';

class PinController {
  static String toWord(int number) {
    return toNumberName(number);
  }

  static String generatePin() {
    Random random = new Random();
    int digit1 = random.nextInt(9) + 1;
    int digit2 = random.nextInt(9) + 1;
    int digit3 = random.nextInt(9) + 1;
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
