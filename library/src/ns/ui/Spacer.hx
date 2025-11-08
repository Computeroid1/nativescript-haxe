package ns.ui;

import ns.core.VNode;

class Spacer extends Component {
    public function new() {
        super({});
    }
    
    public override function toVNode():VNode {
        return {
            type: VNodeType.Spacer,
            props: props,
            children: [],
            key: null,
            nativeView: null
        };
    }
}