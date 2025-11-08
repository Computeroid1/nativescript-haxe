package ns.ui;

import ns.core.VNode;
import ns.core.State;

class NavigationView extends Component {
    private var title:String;
    private var content:Component;
    private var stack:State<Array<Component>>;
    
    public function new(title:String, content:Component) {
        super({});
        this.title = title;
        this.content = content;
        this.stack = new State<Array<Component>>([content]);
        props.title = title;
    }
    
    public function push(view:Component):Void {
        var currentStack = stack.get();
        currentStack.push(view);
        stack.set(currentStack);
    }
    
    public function pop():Void {
        var currentStack = stack.get();
        if (currentStack.length > 1) {
            currentStack.pop();
            stack.set(currentStack);
        }
    }
    
    public override function toVNode():VNode {
        var currentStack = stack.get();
        var currentView = currentStack[currentStack.length - 1];
        
        return {
            type: VNodeType.NavigationView,
            props: props,
            children: [currentView.toVNode()],
            key: null,
            nativeView: null
        };
    }
}