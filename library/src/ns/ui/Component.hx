package ns.ui;

import ns.core.VNode;

class Component {
    private var props:Dynamic;
    
    public function new(props:Dynamic) {
        this.props = props != null ? props : {};
    }
    
    public function padding(value:Float):Component {
        props.padding = value;
        return this;
    }
    
    public function frame(width:Null<Float>, height:Null<Float>):Component {
        props.width = width;
        props.height = height;
        return this;
    }
    
    public function background(color:String):Component {
        props.backgroundColor = color;
        return this;
    }
    
    public function foregroundColor(color:String):Component {
        props.color = color;
        return this;
    }
    
    public function cornerRadius(radius:Float):Component {
        props.cornerRadius = radius;
        return this;
    }
    
    public function shadow(radius:Float, opacity:Float):Component {
        props.shadowRadius = radius;
        props.shadowOpacity = opacity;
        return this;
    }
    
    public function font(size:Float, ?weight:String):Component {
        props.fontSize = size;
        if (weight != null) props.fontWeight = weight;
        return this;
    }
    
    public function onTap(handler:Void->Void):Component {
        props.onTap = handler;
        return this;
    }
    
    public function accessibilityLabel(label:String):Component {
        props.accessibilityLabel = label;
        return this;
    }
    
    public function toVNode():VNode {
        throw "Must override toVNode";
        return null;
    }
}