part of virtual_dom;

Element patch(Node rootNode, PatchObject patch) {
  return _context.callMethod("patch", [rootNode, patch.asJsObject()]);
}