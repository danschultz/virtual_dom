// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library virtual_dom.examples.counter;

import 'dart:async';
import 'dart:html';
import 'package:stream_transformers/stream_transformers.dart';
import 'package:virtual_dom/virtual_dom.dart' as vdom;

void main() {
  var count = new Stream.periodic(new Duration(seconds: 1), (i) => i)
      .transform(new Scan(0, (a, b) => b + 1))
      .asBroadcastStream();
  var trees = count.map((count) => buildTree(count));

  render(trees);
}

StreamSubscription render(Stream<vdom.VTree> view) {
  var trees = view.transform(new Scan([], (a, b) => a.isNotEmpty ? [a.last, b] : [b])).skip(1);
  var element = view.take(1).map((tree) => vdom.createElement(tree)).asBroadcastStream();
  Stream<RenderState> state = trees.transform(new Combine(element, (a, b) {
    return new RenderState(a.first, a.last, b);
  }));

  element.first.then((element) => document.body.append(element));
  return state.listen((state) => vdom.patch(state.rootElement, state.diff()));
}

vdom.VTree buildTree(int count) {
  return vdom.node("div", children: [vdom.text(count.toString())]);
}

class RenderState {
  final vdom.VTree previous;
  final vdom.VTree current;
  final Element rootElement;

  RenderState(this.previous, this.current, this.rootElement);

  factory RenderState.initial(vdom.VTree current) {
    return new RenderState(null, current, vdom.createElement(current));
  }

  vdom.PatchObject diff() => vdom.diff(previous, current);
}
