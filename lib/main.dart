import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hello_flutter/models/user_word_data.dart';
import 'package:hello_flutter/models/word_status.dart';
import 'package:hello_flutter/services/user_progress_service.dart';
import 'package:get_it/get_it.dart';
import 'package:hello_flutter/services/word_service.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'models/word.dart';
import 'pages/main_menu/main_menu_page.dart';
import 'word_learning_page.dart';
import 'settings_page.dart'; // если есть
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

// https://api.dictionaryapi.dev/
// https://www.at.alleng.org/mybook/6top2500/TOP2500.htm
void main() async {
  print("Run main !!!");
  // await Hive.deleteBoxFromDisk('words');

  WidgetsFlutterBinding.ensureInitialized();

  // GetIt.instance.registerSingleton<WordService>(WordService());

  final userWordBox = await Hive.openBox<UserWordData>('user_words');
  GetIt.instance.registerSingleton<UserProgressService>(UserProgressService(userWordBox));

  await Hive.initFlutter();
  Hive.registerAdapter(WordAdapter());
  Hive.registerAdapter(UserWordDataAdapter());
  Hive.registerAdapter(WordStatusAdapter());

  await Hive.openBox<Word>('words');
  await loadWordsFromFile(); 
  runApp(const MyApp());
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
    final id = int.tryParse(row[0].toString());
    final word = row[1].toString().trim();
    final partOfSpeech = row[2].toString().trim();
    final translation = row[3].toString().trim();
    final rank = int.tryParse(row[5].toString()) ?? 0;
    final frequency = double.tryParse(row[6].toString()) ?? 0.0;
    final example = row[4].toString().trim();

    // сохраняем в модель Word (если ты её расширишь)
    box.add(Word(
      id: id!,
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
