package ns.ui;

import ns.core.VNode;

class ScrollView extends Component {
    private var child:Component;
    
    public function new(child:Component) {
        super({});
        this.child = child;
    }
    
    public override function toVNode():VNode {
        return {
            type: VNodeType.ScrollView,
            props: props,
            children: [child.toVNode()],
            key: null,
            nativeView: null
        };
    }
}
