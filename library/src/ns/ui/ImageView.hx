package ns.ui;

import ns.core.VNode;

class ImageView extends Component {
    private var src:String;
    
    public function new(src:String) {
        super({});
        this.src = src;
        props.src = src;
    }
    
    public function aspectFit():ImageView {
        props.stretch = "aspectFit";
        return this;
    }
    
    public function aspectFill():ImageView {
        props.stretch = "aspectFill";
        return this;
    }
    
    public override function toVNode():VNode {
        return {
            type: VNodeType.ImageView,
            props: props,
            children: [],
            key: null,
            nativeView: null
        };
    }
}