package ns.ui;

import ns.core.VNode;
import ns.core.State;

typedef ListViewItem<T> = {
    data:T,
    index:Int
}

class ListView<T> extends Component {
    private var items:State<Array<T>>;
    private var itemBuilder:ListViewItem<T>->Component;
    
    public function new(items:State<Array<T>>, itemBuilder:ListViewItem<T>->Component) {
        super({});
        this.items = items;
        this.itemBuilder = itemBuilder;
        props.items = items.get();
        props.itemBuilder = itemBuilder;
    }
    
    public override function toVNode():VNode {
        var children = [];
        var itemsArray = items.get();
        
        for (i in 0...itemsArray.length) {
            var item = itemBuilder({
                data: itemsArray[i],
                index: i
            });
            var node = item.toVNode();
            node.key = 'item_$i';
            children.push(node);
        }
        
        return {
            type: VNodeType.ListView,
            props: props,
            children: children,
            key: null,
            nativeView: null
        };
    }
}