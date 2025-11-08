package ns.ui;

import ns.core.VNode;

class ActivityIndicator extends Component {
    private var busy:Bool;
    
    public function new(busy:Bool = true) {
        super({});
        this.busy = busy;
        props.busy = busy;
    }
    
    public override function toVNode():VNode {
        return {
            type: VNodeType.ActivityIndicator,
            props: props,
            children: [],
            key: null,
            nativeView: null
        };
    }
}