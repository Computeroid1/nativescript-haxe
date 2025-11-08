package ns.ui;

import ns.core.VNode;
import ns.core.State;

class Picker extends Component {
    private var items:Array<String>;
    private var selectedIndex:State<Int>;
    
    public function new(items:Array<String>, selectedIndex:State<Int>) {
        super({});
        this.items = items;
        this.selectedIndex = selectedIndex;
        props.items = items;
        props.selectedIndex = selectedIndex.get();
        props.onChange = function(index:Int) {
            selectedIndex.set(index);
        };
    }
    
    public override function toVNode():VNode {
        return {
            type: VNodeType.Picker,
            props: props,
            children: [],
            key: null,
            nativeView: null
        };
    }
}