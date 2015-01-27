part of virtual_dom;

class _JsProxyObject {
  final JsObject _jsObject;

  _JsProxyObject(this._jsObject);

  JsObject asJsObject() => _jsObject;
}