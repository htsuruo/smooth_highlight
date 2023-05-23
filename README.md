# Smooth Highlight

You can emphasize a specific widget by ***highlight animation*** when you want to emphasize something to your users. As you can see from the following samples, you can use `smooth_highlight` in any widget.

And also, you can use `ValueChangeHighlight` that is useful when you simply want to highlight only the text changes(refer to Sample2). It is inspired by the Cloud Firestore value change animation in the Firebase console.

| Sample1 | Sample2 | Sample3 |
| --- | --- | --- |
| ![](https://user-images.githubusercontent.com/12729025/185746812-58353f9b-1de7-458e-9319-64444cac48b9.gif) | ![](https://user-images.githubusercontent.com/12729025/185746818-ffe72f20-2acf-4f48-80f7-d039757aa71b.gif) | ![](https://user-images.githubusercontent.com/12729025/185746809-777d992d-d791-4d92-b555-594bdd51c106.gif) |

## Usage

You just wrap `SmoothHighlight` in your widget.

```dart
SmoothHighlight(
  // set your custom color
  color: Colors.yellow,
  child: Text('Hightlight'),
);
```

and you can also define custom behavior.

```dart
SmoothHighlight(
  // highlight in initState phase.
  useInitialHighLight: true,

  // highlight whenever count is even.
  enabled: count % 2 ==0,
);
```

### ValueChangeHighlight

If you want to highlight the widget only the value changed, `ValueChangeHighlight` is useful. It requires highlight trigger value.

```dart
ValueChangeHighlight(
  // highlight if count changes
  value: count,
  color: Colors.yellow,
  child: Text('count: $count'),
);
```

if you don't want to highlight a specific values, `disableFromValues` property prevents it.

```dart
ValueChangeHighlight(
  value: count,

  // disable highlight if count changes from `null` or `2` to some value.
  disableFromValues: const [null, 2],
);
```

## UseCase

Following gif is Firestore GUI in Firebase Console. Firestore realtime listener is powerful, but it is hard for your user to see ***what value changed***. You can make the user notice by highlighting the changed value. It's probably a user-friendly consideration, I think.

![](https://user-images.githubusercontent.com/12729025/185757958-a0aef8e1-855a-47b0-b99c-7dad5010e2d0.gif)
