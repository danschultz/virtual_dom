part of virtual_dom;

Element createElement(VTree tree) {
  return _context.callMethod("createElement", [tree.asJsObject()]);
}