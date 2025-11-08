package ns.ui;

import ns.core.VNode;

class WebView extends Component {
    private var url:String;
    
    public function new(url:String) {
        super({});
        this.url = url;
        props.src = url;
    }
    
    public override function toVNode():VNode {
        return {
            type: VNodeType.ImageView, // Reuse ImageView type temporarily
            props: props,
            children: [],
            key: null,
            nativeView: null
        };
    }
}