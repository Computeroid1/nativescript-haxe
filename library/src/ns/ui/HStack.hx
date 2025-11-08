package ns.ui;

import ns.core.VNode;

class HStack extends Component {
    private var children:Array<Component>;
    
    public function new(children:Array<Component>) {
        super({});
        this.children = children;
        props.orientation = "horizontal";
    }
    
    public override function toVNode():VNode {
        var childNodes = [];
        for (child in children) {
            childNodes.push(child.toVNode());
        }
        
        return {
            type: VNodeType.HStack,
            props: props,
            children: childNodes,
            key: null,
            nativeView: null
        };
    }
}