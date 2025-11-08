package ns.ui;

import ns.core.VNode;
import ns.core.State;

class Toggle extends Component {
    private var isOn:State<Bool>;
    
    public function new(isOn:State<Bool>) {
        super({});
        this.isOn = isOn;
        props.checked = isOn.get();
        props.onChange = function(newValue:Bool) {
            isOn.set(newValue);
        };
    }
    
    public override function toVNode():VNode {
        return {
            type: VNodeType.Toggle,
            props: props,
            children: [],
            key: null,
            nativeView: null
        };
    }
}
