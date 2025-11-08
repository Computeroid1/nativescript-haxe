package ns.core;

import ns.platform.PlatformAdapter;

class Reconciler {
    private var adapter:PlatformAdapter;
    private var rootNode:Null<VNode>;
    
    public function new(adapter:PlatformAdapter) {
        this.adapter = adapter;
    }
    
    public function render(newTree:VNode, container:Dynamic):Void {
        if (rootNode == null) {
            rootNode = newTree;
            rootNode.nativeView = createNativeView(newTree, container);
        } else {
            patch(rootNode, newTree, container);
            rootNode = newTree;
        }
    }
    
    private function createNativeView(vnode:VNode, parent:Dynamic):Dynamic {
        var nativeView = adapter.createElement(vnode.type, vnode.props);
        
        if (vnode.children != null) {
            for (child in vnode.children) {
                child.nativeView = createNativeView(child, nativeView);
            }
        }
        
        adapter.appendChild(parent, nativeView);
        adapter.applyModifiers(nativeView, vnode.props);
        
        return nativeView;
    }
    
    private function patch(oldVNode:VNode, newVNode:VNode, parent:Dynamic):Void {
        if (oldVNode.type != newVNode.type) {
            var newNative = createNativeView(newVNode, parent);
            adapter.replaceChild(parent, oldVNode.nativeView, newNative);
            newVNode.nativeView = newNative;
            return;
        }
        
        newVNode.nativeView = oldVNode.nativeView;
        adapter.updateElement(newVNode.nativeView, newVNode.type, newVNode.props);
        adapter.applyModifiers(newVNode.nativeView, newVNode.props);
        
        patchChildren(oldVNode, newVNode, newVNode.nativeView);
    }
    
    private function patchChildren(oldVNode:VNode, newVNode:VNode, parent:Dynamic):Void {
        var oldChildren = oldVNode.children != null ? oldVNode.children : [];
        var newChildren = newVNode.children != null ? newVNode.children : [];
        
        var maxLength = Std.int(Math.max(oldChildren.length, newChildren.length));
        
        for (i in 0...maxLength) {
            if (i >= newChildren.length) {
                adapter.removeChild(parent, oldChildren[i].nativeView);
            } else if (i >= oldChildren.length) {
                newChildren[i].nativeView = createNativeView(newChildren[i], parent);
            } else {
                patch(oldChildren[i], newChildren[i], parent);
            }
        }
    }
}
