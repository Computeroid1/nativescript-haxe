package ns.ui;

import ns.core.VNode;
import ns.core.State;

class SecureField extends Component {
    private var placeholder:String;
    private var text:State<String>;
    
    public function new(placeholder:String, text:State<String>) {
        super({});
        this.placeholder = placeholder;
        this.text = text;
        props.hint = placeholder;
        props.text = text.get();
        props.secure = true;
        props.onChange = function(newValue:String) {
            text.set(newValue);
        };
    }
    
    public override function toVNode():VNode {
        return {
            type: VNodeType.SecureField,
            props: props,
            children: [],
            key: null,
            nativeView: null
        };
    }
}