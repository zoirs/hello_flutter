import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/word.dart';
import 'pages/main_menu/main_menu_page.dart';
import 'word_learning_page.dart';
import 'settings_page.dart'; // если есть
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

// https://api.dictionaryapi.dev/
// https://www.at.alleng.org/mybook/6top2500/TOP2500.htm
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WordAdapter());
  await Hive.openBox<Word>('words');
  await loadWordsFromFile(); 
  runApp(const MyApp());
  final csvString = '''
Name,Age,Note
"Smith, John",30,"Works in ""IT"", loves pizza"
Doe,25,Student
''';

  final rows = const CsvToListConverter().convert(csvString);
  
  for (final row in rows) {
    print(row);
  }
}

Future<void> loadWordsFromFile() async {
  final box = Hive.box<Word>('words');
  // if (box.isNotEmpty) return;
  box.clear();

  final raw = await rootBundle.loadString('assets/words.csv');
  final rows = const CsvToListConverter(
    fieldDelimiter: ',',
    eol: '\n',
    shouldParseNumbers: false,
  ).convert(raw);

  for (final row in rows) {
    if (row.length < 6) continue;
    //word,pos,translation,example,rank,frequency
    final word = row[0].toString().trim();
    final partOfSpeech = row[1].toString().trim();
    final translation = row[2].toString().trim();
    final rank = int.tryParse(row[4].toString()) ?? 0;
    final frequency = double.tryParse(row[5].toString()) ?? 0.0;
    final example = row[3].toString().trim();

    // сохраняем в модель Word (если ты её расширишь)
    box.add(Word(
      word: word,
      translation: translation,
      partOfSpeech: partOfSpeech,
      rank: rank,
      frequency: frequency,
      example: example,
    ));
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Английские слова',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const MainMenuPage(),
        '/learn': (context) => WordLearningPage(),
        '/settings': (context) => SettingsPage(), // если есть
      },
    );
  }

  
}
