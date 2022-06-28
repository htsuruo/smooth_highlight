import 'package:flutter/material.dart';

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
      ).copyWith(
        useMaterial3: true,
        dividerTheme: const DividerThemeData(space: 0),
      ),
      home: const _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage();

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SmoothHighlight'),
      ),
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, _) => const Divider(),
        itemBuilder: (context, index) {
          final target = index == 2;
          return ListTile(
            title: Text('index: ${index + 1}'),
            subtitle: Text(target ? 'highlight tile' : 'normal tile'),
            onTap: () {},
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
