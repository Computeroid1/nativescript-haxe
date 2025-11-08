package ns.ui;

import ns.core.VNode;

class ZStack extends Component {
    private var children:Array<Component>;
    
    public function new(children:Array<Component>) {
        super({});
        this.children = children;
    }
    
    public override function toVNode():VNode {
        var childNodes = [];
        for (child in children) {
            childNodes.push(child.toVNode());
        }
        
        return {
            type: VNodeType.ZStack,
            props: props,
            children: childNodes,
            key: null,
            nativeView: null
        };
    }
}