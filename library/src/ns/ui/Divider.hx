package ns.ui;

import ns.core.VNode;

class Divider extends Component {
    public function new() {
        super({});
    }
    
    public override function toVNode():VNode {
        return {
            type: VNodeType.Divider,
            props: props,
            children: [],
            key: null,
            nativeView: null
        };
    }
}
