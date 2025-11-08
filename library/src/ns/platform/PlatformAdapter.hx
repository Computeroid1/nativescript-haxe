package ns.platform;

import ns.core.VNode;

interface PlatformAdapter {
    function createRootContainer():Dynamic;
    function createElement(type:VNodeType, props:Dynamic):Dynamic;
    function updateElement(element:Dynamic, type:VNodeType, props:Dynamic):Void;
    function appendChild(parent:Dynamic, child:Dynamic):Void;
    function removeChild(parent:Dynamic, child:Dynamic):Void;
    function replaceChild(parent:Dynamic, oldChild:Dynamic, newChild:Dynamic):Void;
    function applyModifiers(element:Dynamic, props:Dynamic):Void;
    function startApp(rootView:Dynamic):Void;
}