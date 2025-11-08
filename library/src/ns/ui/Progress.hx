package ns.ui;

import ns.core.VNode;
import ns.core.State;

class Progress extends Component {
    private var value:State<Float>;
    private var maxValue:Float;
    
    public function new(value:State<Float>, maxValue:Float = 100) {
        super({});
        this.value = value;
        this.maxValue = maxValue;
        props.value = value.get();
        props.maxValue = maxValue;
    }
    
    public override function toVNode():VNode {
        return {
            type: VNodeType.Slider, // Reuse Slider type for now
            props: props,
            children: [],
            key: null,
            nativeView: null
        };
    }
}