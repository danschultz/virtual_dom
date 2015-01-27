var diff = require('vtree/diff');
var patch = require('vdom/patch');
var createElement = require('vdom/create-element');
var VNode = require('vtree/vnode');
var VText = require('vtree/vtext');

VirtualDom = {};
VirtualDom.diff = diff;
VirtualDom.patch = patch;
VirtualDom.createElement = createElement;
VirtualDom.node = function(name, properties, children) {
    return new VNode(name, properties, children);
};
VirtualDom.text = function(text) {
    return new VText(text);
};