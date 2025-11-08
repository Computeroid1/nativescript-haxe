package ns.ui;

import ns.core.VNode;

class Text extends Component {
    private var content:String;
    
    public function new(content:String) {
        super({});
        this.content = content;
        props.text = content;
    }
    
    public override function toVNode():VNode {
        return {
            type: VNodeType.Text,
            props: props,
            children: [],
            key: null,
            nativeView: null
        };
    }
}