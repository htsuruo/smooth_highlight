import 'package:flutter/material.dart';
import 'package:smooth_highlight/smooth_highlight.dart';
import 'package:touch_indicator/touch_indicator.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final routes = <String, WidgetBuilder>{
      _ListViewExample.title: (context) => const _ListViewExample(),
      _ContainerExample.title: (context) => const _ContainerExample(),
      _ValueChangeExample.title: (context) => const _ValueChangeExample(),
      _ValueChangeCustomExample.title: (context) =>
          const _ValueChangeCustomExample(),
    };
    final pages = routes.entries.toList();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
      ).copyWith(
        dividerTheme: const DividerThemeData(space: 0),
      ),
      routes: routes,
      builder: ((context, child) => TouchIndicator(
            child: child!,
          )),
      home: Scaffold(
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
                Navigator.of(context).pushNamed(page.key);
              },
            );
          },
        ),
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
            enabled: index == targetIndex,
            color: Colors.yellow,
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
  final _highlight = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text(_ContainerExample.title),
      ),
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SmoothHighlight(
              useInitialHighLight: true,
              color: Colors.yellow,
              child: Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.all(10),
                color: colorScheme.primary,
                child: Center(
                  child: Text(
                    'Highlight Object',
                    style: TextStyle(
                      color: colorScheme.onPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.all(10),
              color: colorScheme.primary,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _highlight == !_highlight;
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

/// Highlights whenever count changes if `highlight` property changes true.
class _ValueChangeExample extends StatefulWidget {
  const _ValueChangeExample();

  static const title = 'ValueChangeExample';

  @override
  State<_ValueChangeExample> createState() => _ValueChangeExampleState();
}

class _ValueChangeExampleState extends State<_ValueChangeExample> {
  var count = 0;
  var highlight = true;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(_ValueChangeExample.title),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'This example highlights whenever count changes if `highlight` property is true.',
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ValueChangeHighlight(
                    value: count,
                    padding: const EdgeInsets.all(4),
                    color: Colors.yellow,
                    child: Text(
                      'count: $count',
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'highlight: ${!highlight}',
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // if `highlight` is false, this widget rebuilds but cannot show highlight.
            if (highlight) {
              count++;
            }
            highlight = !highlight;
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

/// Highlights whenever count changes unless count `null` or `2`
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
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'This example highlights whenever count changes unless count `null` or `2`',
            ),
          ),
          Expanded(
            child: Center(
              child: ValueChangeHighlight(
                value: count,
                // disable highlight if count changes from `null` or `2`.
                disableFromValues: const [null, 2],
                padding: const EdgeInsets.all(4),
                color: Colors.yellow,
                child: Text(
                  'count: $count',
                  style: theme.textTheme.titleLarge,
                ),
              ),
            ),
          )
        ],
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
