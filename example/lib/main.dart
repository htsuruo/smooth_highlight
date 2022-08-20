import 'package:flutter/material.dart';
import 'package:smooth_highlight/smooth_highlight.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
      ).copyWith(
        dividerTheme: const DividerThemeData(space: 0),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = <String, Widget>{
      _ListViewExample.title: const _ListViewExample(),
      _ContainerExample.title: const _ContainerExample(),
      _ValueChangeExample.title: const _ValueChangeExample(),
      _ValueChangeCustomExample.title: const _ValueChangeCustomExample(),
    }.entries.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Smooth Highlight'),
      ),
      body: ListView.separated(
        itemCount: pages.length,
        separatorBuilder: (context, _) => const Divider(),
        itemBuilder: (context, index) {
          final page = pages[index];
          return ListTile(
            title: Text(page.key),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              Navigator.of(context).push<void>(
                MaterialPageRoute(
                  builder: (context) => page.value,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _ListViewExample extends StatefulWidget {
  const _ListViewExample();

  static const title = 'ListViewExample';

  @override
  State<_ListViewExample> createState() => _ListViewExampleState();
}

class _ListViewExampleState extends State<_ListViewExample> {
  int targetIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_ListViewExample.title),
      ),
      body: ListView.separated(
        itemCount: 30,
        separatorBuilder: (context, _) => const Divider(),
        itemBuilder: (context, index) {
          return SmoothHighlight(
            useInitialHighLight: true,
            enabled: index == targetIndex,
            highlightColor: Colors.yellow,
            child: ListTile(
              title: Text('index: $index'),
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

  static const title = 'ContainerExample';

  @override
  State<_ContainerExample> createState() => _ContainerExampleState();
}

class _ContainerExampleState extends State<_ContainerExample> {
  var count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_ContainerExample.title),
      ),
      body: Center(
        child: SmoothHighlight(
          highlightColor: Colors.orange,
          child: Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.all(10),
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

class _ValueChangeExample extends StatefulWidget {
  const _ValueChangeExample();

  static const title = 'ValueChangeExample';

  @override
  State<_ValueChangeExample> createState() => _ValueChangeExampleState();
}

class _ValueChangeExampleState extends State<_ValueChangeExample> {
  var count = 0;
  var canUpdate = true;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(_ValueChangeExample.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ValueChangeHighlight(
              value: count,
              padding: const EdgeInsets.all(4),
              highlightColor: Colors.yellow,
              child: Text(
                'count: $count',
                style: theme.textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'highlight: ${!canUpdate}',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // if canUpdate is false, this widget rebuilds but cannot show highlight.
            if (canUpdate) {
              count++;
            }
            canUpdate = !canUpdate;
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class _ValueChangeCustomExample extends StatefulWidget {
  const _ValueChangeCustomExample();

  static const title = 'ValueChangeCustomExample';

  @override
  State<_ValueChangeCustomExample> createState() =>
      _ValueChangeCustomExampleState();
}

class _ValueChangeCustomExampleState extends State<_ValueChangeCustomExample> {
  int? count;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(_ValueChangeCustomExample.title),
      ),
      body: Center(
        child: ValueChangeHighlight(
          value: count,
          // disable highlight if count changes from `null` or `2`.
          disableValues: const [null, 2],
          padding: const EdgeInsets.all(4),
          highlightColor: Colors.yellow,
          child: Text(
            'count: $count',
            style: theme.textTheme.titleLarge,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            count == null ? count = 0 : count = count! + 1;
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
