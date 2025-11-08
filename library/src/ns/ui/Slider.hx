package ns.ui;

import ns.core.VNode;
import ns.core.State;

class Slider extends Component {
    private var value:State<Float>;
    private var minValue:Float;
    private var maxValue:Float;
    
    public function new(value:State<Float>, min:Float, max:Float) {
        super({});
        this.value = value;
        this.minValue = min;
        this.maxValue = max;
        props.value = value.get();
        props.minValue = min;
        props.maxValue = max;
        props.onChange = function(newValue:Float) {
            value.set(newValue);
        };
    }
    
    public override function toVNode():VNode {
        return {
            type: VNodeType.Slider,
            props: props,
            children: [],
            key: null,
            nativeView: null
        };
    }
}