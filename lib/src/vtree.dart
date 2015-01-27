part of virtual_dom;

VTree node(String name, {Map properties: const {}, List<VTree> children: const []}) {
  return new VTree(_context.callMethod("node", [
      name,
      new JsObject.jsify(properties),
      new JsObject.jsify(children.map((child) => child.asJsObject()))]));
}

VTree text(String text) => new VTree(_context.callMethod("text", [text]));

class VTree extends _JsProxyObject {
  VTree(JsObject proxy) : super(proxy);
}