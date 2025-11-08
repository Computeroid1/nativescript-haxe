package ns.core;

import ns.platform.PlatformAdapter;

class App {
    private static var reconciler:Reconciler;
    private static var adapter:PlatformAdapter;
    private static var rootView:Dynamic;
    
    public static function run(rootComponent:VNode):Void {
        #if android
        adapter = new ns.platform.NativeScriptAdapter();
        #elseif windows
        adapter = new ns.platform.WindowsAdapter();
        #else
        throw "Unsupported platform";
        #end
        
        reconciler = new Reconciler(adapter);
        rootView = adapter.createRootContainer();
        reconciler.render(rootComponent, rootView);
        adapter.startApp(rootView);
    }
    
    public static function update(rootComponent:VNode):Void {
        reconciler.render(rootComponent, rootView);
    }
}
