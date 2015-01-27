# Counter Example

An example that takes a single stream of inputs, transforms them into a virtual DOM tree, and applies their diffs to a DOM node.

In a more interesting app, the stream of inputs would be a combination of mouse, keyboard, system and network events.

```dart
void main() {
  var count = new Stream.periodic(new Duration(seconds: 1), (i) => i)
      .transform(new Scan(0, (a, b) => b + 1))
      .asBroadcastStream();
  var trees = count.map((count) => buildTree(count));

  render(trees);
}
```

## Running

* Run: `pub serve`
* Open `http://localhost:8080` in your browser.
