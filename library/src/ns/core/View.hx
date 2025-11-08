package ns.core;

interface View {
    function render():VNode;
    function setState(newState:Dynamic):Void;
}