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
      home: const _ValueChangeExample(),
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
        title: const Text('ListViewExample'),
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
      appBar: AppBar(
        title: const Text('ContainerExample'),
      ),
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

class _ValueChangeExample extends StatefulWidget {
  const _ValueChangeExample();

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
        title: const Text('ValueChangeExample'),
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
        title: const Text('ValueChangeCustomExample'),
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
