<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# Smooth Highlight

You can emphasize a specific widget by ***highlight animation*** when you want to emphasize something to your users. As you can see from the following samples, you can use `smooth_highlight` in any widget.

And also, you can use `ValueChangeHighlight` that is useful when you simply want to highlight only the text changes(refer to Sample2). It is inspired by the Firestore value change animation in the Firebase console.

| Sample1 | Sample2 | Sample3 |
| --- | --- | --- |
| ![](https://user-images.githubusercontent.com/12729025/185746812-58353f9b-1de7-458e-9319-64444cac48b9.gif) | ![](https://user-images.githubusercontent.com/12729025/185746818-ffe72f20-2acf-4f48-80f7-d039757aa71b.gif) | ![](https://user-images.githubusercontent.com/12729025/185746809-777d992d-d791-4d92-b555-594bdd51c106.gif) |


## Usage

`SmoothHighlight` is just wrap your widget.
```dart
SmoothHighlight(
  // set your custom color
  highlightColor: Colors.yellow,
  child: Text('Hightlight'),
);
```

`ValueChangeHighlight` requires highlight trigger value.

```dart
ValueChangeHighlight(
  // highlight if count changes
  value: count,
  highlightColor: Colors.yellow,
  child: Text('count: $count'),
);
```

and you can also define custom behavior.

```dart
SmoothHighlight(
  // highlight in initState phase.
  useInitialHighLight: true,

  // highlight if count is only even.
  enabled: count % 2 ==0,
);
```

if you don't want to highlight a specific values, `disableValues` property prevents it.
```dart
ValueChangeHighlight(
  value: count,

  // disable highlight if count changes from `null` or `2`.
  disableValues: const [null, 2],
);
```