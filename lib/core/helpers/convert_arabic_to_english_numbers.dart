int? convertArabicToEnglishNumbers(String input) {
  const Map<String, String> arabicToEnglishMap = {
    '٠': '0',
    '١': '1',
    '٢': '2',
    '٣': '3',
    '٤': '4',
    '٥': '5',
    '٦': '6',
    '٧': '7',
    '٨': '8',
    '٩': '9',
  };

  String output = input;

  arabicToEnglishMap.forEach((arabic, english) {
    output = output.replaceAll(arabic, english);
  });

  return int.tryParse(output);
}
