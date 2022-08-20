import 'package:flutter/material.dart';
import 'package:smooth_highlight/smooth_highlight.dart';

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
      home: const _ListViewExample(),
    );
  }
}

class _ListViewExample extends StatefulWidget {
  const _ListViewExample();

  @override
  State<_ListViewExample> createState() => _ListViewExampleState();
}

class _ListViewExampleState extends State<_ListViewExample> {
  int targetIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SmoothHighlight'),
      ),
      body: ListView.separated(
        itemCount: 30,
        separatorBuilder: (context, _) => const Divider(),
        itemBuilder: (context, index) {
          return SmoothHighlight(
            enabled: index == targetIndex,
            highlightColor: Colors.yellow,
            child: ListTile(
              title: Text('index: ${index + 1}'),
              onTap: () {},
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            targetIndex++;
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class _ContainerExample extends StatefulWidget {
  const _ContainerExample();

  @override
  State<_ContainerExample> createState() => _ContainerExampleState();
}

class _ContainerExampleState extends State<_ContainerExample> {
  var count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SmoothHighlight(
          enabled: count % 2 != 0,
          highlightColor: Colors.orange,
          child: Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.all(40),
            color: Colors.green,
            child: Center(
              child: Text('count: $count'),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            count++;
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class _TextChangeExample extends StatefulWidget {
  const _TextChangeExample();

  @override
  State<_TextChangeExample> createState() => _TextChangeExampleState();
}

class _TextChangeExampleState extends State<_TextChangeExample> {
  var count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SmoothHighlight(
          padding: const EdgeInsets.all(4),
          highlightColor: Colors.yellow,
          child: Text('count: $count'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            count++;
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
