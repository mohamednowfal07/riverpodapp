// ignore_for_file: unused_local_variable, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/provider/counter_provider.dart';
import 'package:riverpod_app/provider/theme_provider.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: MyHomePage(
        title: '',
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required String title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final count = ref.watch(counterProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Riverpod"),
        backgroundColor: Colors.red,
        actions: [
          Switch(
            onChanged: (_) {
              ref.read(themeModeProvider.notifier).state =
                  themeMode == ThemeMode.light
                      ? ThemeMode.dark
                      : ThemeMode.light;
            },
            value: themeMode == ThemeMode.light ? false : true,
          )
        ],
      ),
      body: Center(
        child: Text(
          ': $count',
          style: const TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  ref.read(counterProvider.notifier).state++;
                },
                icon: Icon(Icons.add)),
            IconButton(
                onPressed: () {
                  ref.read(counterProvider.notifier).state--;
                },
                icon: Icon(Icons.remove)),
            IconButton(
                onPressed: () {
                  ref.read(counterProvider.notifier).state = 0;
                },
                icon: Icon(Icons.refresh)),
          ],
        ),
      ),
    );
  }
}