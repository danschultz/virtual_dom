# virtual_dom

A Dart wrapper for Matt Esch's [virtual-dom] JavaScript library. It provides methods for declaratively creating and applying diffs to the DOM.

My intention is to build upon this and apply diffs in reactively using FRP. Take a look at the [counter example] to get an idea of the direction this might go.

## Usage

A example usage example:

```dart
import 'dart:async';
import 'dart:html';
import 'package:virtual_dom/virtual_dom.dart' as vdom;

main() {
  var tree = buildTree(0);
  var element = vdom.createElement(tree);
  document.body.append(element);

  var tick = new Stream.periodic(new Duration(seconds: 1), (i) => i + 1);
  tick.listen((count) {
    var newTree = buildTree(count);
    var patch = vdom.diff(tree, newTree);
    vdom.patch(element, newTree);

    tree = newTree;
  });
}

vdom.VTree buildTree(int count) {
  return vdom.node("div", children: [vdom.text(count.toString())]);
}
```

This library requires that you import the JavaScript binding in your HTML.

```html
<!DOCTYPE html>
<html>
<head lang="en">
  <meta charset="UTF-8">
  <title></title>

  <script async src="packages/virtual_dom/virtual_dom.js"></script>
  <script async src="packages/browser/dart.js"></script>
  <script async type="application/dart" src="index.dart"></script>
</head>
<body>

</body>
</html>
```

## API

### Element creation

```dart
Element createElement(VTree tree)
```

Creates a DOM element for the given virtual DOM tree.

### Diffing

```dart
PatchObject diff(VTree previous, VTree next)
```

Creates a set of DOM patches that represent the differences between two `VTree`s.

### Patching

```dart
Element patch(Element node, PatchObject patches)
```

Applies a set of patches to the given DOM node.

### Virtual DOM trees

#### Elements

```dart
VTree node(String nodeName, {Map<String, String> properties, List<VTree> children})
```

Creates a new virtual DOM tree for the given `nodeName`.

Example:

```dart
var tree = node("div", properties: {"class": "my-div"}, children: [text("Hello")]);
```

#### Text

```dart
VTree text(String text)
```

Creates a new virtual DOM text node that contains `text`.

## Building

* Make sure you have Node, NPM and Browserify installed.
* Run `npm install`
* Run: `browserify lib/wrapper.js -o lib/virtual_dom.js`

[virtual-dom]: https://github.com/Matt-Esch/virtual-dom
[counter example]: https://github.com/danschultz/virtual_dom/tree/master/example/counter
