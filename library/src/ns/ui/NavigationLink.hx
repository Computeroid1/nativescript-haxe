package ns.ui;

import ns.core.VNode;

class NavigationLink extends Component {
    private var label:Component;
    private var destination:Component;
    private var navigation:NavigationView;
    
    public function new(label:Component, destination:Component, navigation:NavigationView) {
        super({});
        this.label = label;
        this.destination = destination;
        this.navigation = navigation;
        
        props.onTap = function() {
            navigation.push(destination);
        };
    }
    
    public override function toVNode():VNode {
        return {
            type: VNodeType.NavigationLink,
            props: props,
            children: [label.toVNode()],
            key: null,
            nativeView: null
        };
    }
}