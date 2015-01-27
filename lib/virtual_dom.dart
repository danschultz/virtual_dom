library virtual_dom;

import 'dart:html';
import 'dart:js';

part 'src/vtree.dart';
part 'src/diff.dart';
part 'src/patch.dart';
part 'src/create_element.dart';
part 'src/js_object.dart';

final JsObject _context = context["VirtualDom"];
