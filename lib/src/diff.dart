part of virtual_dom;

PatchObject diff(VTree previous, VTree current) {
  return new PatchObject(_context.callMethod("diff", [previous.asJsObject(), current.asJsObject()]));
}

class PatchObject extends _JsProxyObject {
  PatchObject(JsObject proxy) : super(proxy);
}