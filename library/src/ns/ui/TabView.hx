package ns.ui;

import ns.core.VNode;
import ns.core.State;

typedef Tab = {
    title:String,
    content:Component,
    icon:Null<String>
}

class TabView extends Component {
    private var tabs:Array<Tab>;
    private var selectedIndex:State<Int>;
    
    public function new(tabs:Array<Tab>) {
        super({});
        this.tabs = tabs;
        this.selectedIndex = new State<Int>(0);
        props.tabs = tabs;
        props.selectedIndex = selectedIndex.get();
        props.onChange = function(index:Int) {
            selectedIndex.set(index);
        };
    }
    
    public override function toVNode():VNode {
        var children = [];
        var currentIndex = selectedIndex.get();
        
        for (i in 0...tabs.length) {
            var tab = tabs[i];
            if (i == currentIndex) {
                children.push(tab.content.toVNode());
            }
        }
        
        return {
            type: VNodeType.TabView,
            props: props,
            children: children,
            key: null,
            nativeView: null
        };
    }
}