package ns.ui;

import ns.core.VNode;

class Button extends Component {
    private var title:String;
    private var action:Void->Void;
    
    public function new(title:String, action:Void->Void) {
        super({});
        this.title = title;
        this.action = action;
        props.text = title;
        props.onTap = action;
    }
    
    public override function toVNode():VNode {
        return {
            type: VNodeType.Button,
            props: props,
            children: [],
            key: null,
            nativeView: null
        };
    }
}
