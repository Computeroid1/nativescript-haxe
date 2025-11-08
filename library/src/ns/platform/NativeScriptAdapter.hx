package ns.platform;

#if android
@:native("require")
extern function require(module:String):Dynamic;

class NativeScriptAdapter implements PlatformAdapter {
    private var Application:Dynamic;
    private var Frame:Dynamic;
    private var Label:Dynamic;
    private var Button:Dynamic;
    private var StackLayout:Dynamic;
    private var ScrollView:Dynamic;
    private var TextField:Dynamic;
    private var Switch:Dynamic;
    private var Slider:Dynamic;
    private var ActivityIndicator:Dynamic;
    private var AbsoluteLayout:Dynamic;
    private var Image:Dynamic;
    private var ListView:Dynamic;
    private var ListPicker:Dynamic;
    private var WebView:Dynamic;
    private var Progress:Dynamic;
    
    public function new() {
        var core = require("@nativescript/core");
        Application = core.Application;
        Frame = core.Frame;
        Label = core.Label;
        Button = core.Button;
        StackLayout = core.StackLayout;
        ScrollView = core.ScrollView;
        TextField = core.TextField;
        Switch = core.Switch;
        Slider = core.Slider;
        ActivityIndicator = core.ActivityIndicator;
        AbsoluteLayout = core.AbsoluteLayout;
        Image = core.Image;
        ListView = core.ListView;
        ListPicker = core.ListPicker;
        WebView = core.WebView;
        Progress = core.Progress;
    }
    
    public function createRootContainer():Dynamic {
        return js.Syntax.code("new {0}()", StackLayout);
    }
    
    public function createElement(type:VNodeType, props:Dynamic):Dynamic {
        return switch(type) {
            case Text: js.Syntax.code("new {0}()", Label);
            case Button: js.Syntax.code("new {0}()", Button);
            case VStack | HStack: createStack(props);
            case ZStack: js.Syntax.code("new {0}()", AbsoluteLayout);
            case ScrollView: js.Syntax.code("new {0}()", ScrollView);
            case TextField | SecureField: js.Syntax.code("new {0}()", TextField);
            case Toggle: js.Syntax.code("new {0}()", Switch);
            case Slider: js.Syntax.code("new {0}()", Slider);
            case ActivityIndicator: js.Syntax.code("new {0}()", ActivityIndicator);
            case ImageView: js.Syntax.code("new {0}()", Image);
            case ListView: js.Syntax.code("new {0}()", StackLayout);
            case Picker: js.Syntax.code("new {0}()", ListPicker);
            case NavigationView: js.Syntax.code("new {0}()", StackLayout);
            case NavigationLink: js.Syntax.code("new {0}()", Button);
            case TabView: js.Syntax.code("new {0}()", StackLayout);
            case WebView: js.Syntax.code("new {0}()", WebView);
            case Progress: js.Syntax.code("new {0}()", Progress);
            case Spacer: createSpacer();
            case Divider: createDivider();
            case Container: js.Syntax.code("new {0}()", StackLayout);
        };
    }
    
    private function createStack(props:Dynamic):Dynamic {
        var stack = js.Syntax.code("new {0}()", StackLayout);
        var orientation = Reflect.field(props, "orientation");
        if (orientation == "horizontal") {
            js.Syntax.code("{0}.orientation = 'horizontal'", stack);
        } else {
            js.Syntax.code("{0}.orientation = 'vertical'", stack);
        }
        return stack;
    }
    
    private function createSpacer():Dynamic {
        var view = js.Syntax.code("new {0}()", Label);
        js.Syntax.code("{0}.height = '*'", view);
        return view;
    }
    
    private function createDivider():Dynamic {
        var view = js.Syntax.code("new {0}()", Label);
        js.Syntax.code("{0}.height = 1", view);
        js.Syntax.code("{0}.backgroundColor = '#CCCCCC'", view);
        return view;
    }
    
    public function updateElement(element:Dynamic, type:VNodeType, props:Dynamic):Void {
        switch(type) {
            case Text:
                var text = Reflect.field(props, "text");
                if (text != null) js.Syntax.code("{0}.text = {1}", element, text);
                
            case Button:
                var text = Reflect.field(props, "text");
                if (text != null) js.Syntax.code("{0}.text = {1}", element, text);
                var onTap = Reflect.field(props, "onTap");
                if (onTap != null) {
                    js.Syntax.code("{0}.off('tap')", element);
                    js.Syntax.code("{0}.on('tap', {1})", element, onTap);
                }
                
            case TextField | SecureField:
                var hint = Reflect.field(props, "hint");
                if (hint != null) js.Syntax.code("{0}.hint = {1}", element, hint);
                var text = Reflect.field(props, "text");
                if (text != null) js.Syntax.code("{0}.text = {1}", element, text);
                var secure = Reflect.field(props, "secure");
                if (secure != null) js.Syntax.code("{0}.secure = {1}", element, secure);
                var onChange = Reflect.field(props, "onChange");
                if (onChange != null) {
                    js.Syntax.code("{0}.off('textChange')", element);
                    js.Syntax.code("{0}.on('textChange', function(args) { {1}(args.value); })", element, onChange);
                }
                
            case Toggle:
                var checked = Reflect.field(props, "checked");
                if (checked != null) js.Syntax.code("{0}.checked = {1}", element, checked);
                var onChange = Reflect.field(props, "onChange");
                if (onChange != null) {
                    js.Syntax.code("{0}.off('checkedChange')", element);
                    js.Syntax.code("{0}.on('checkedChange', function(args) { {1}(args.value); })", element, onChange);
                }
                
            case Slider:
                var value = Reflect.field(props, "value");
                if (value != null) js.Syntax.code("{0}.value = {1}", element, value);
                var minValue = Reflect.field(props, "minValue");
                if (minValue != null) js.Syntax.code("{0}.minValue = {1}", element, minValue);
                var maxValue = Reflect.field(props, "maxValue");
                if (maxValue != null) js.Syntax.code("{0}.maxValue = {1}", element, maxValue);
                var onChange = Reflect.field(props, "onChange");
                if (onChange != null) {
                    js.Syntax.code("{0}.off('valueChange')", element);
                    js.Syntax.code("{0}.on('valueChange', function(args) { {1}(args.value); })", element, onChange);
                }
                
            case ActivityIndicator:
                var busy = Reflect.field(props, "busy");
                if (busy != null) js.Syntax.code("{0}.busy = {1}", element, busy);
                
            case ImageView:
                var src = Reflect.field(props, "src");
                if (src != null) js.Syntax.code("{0}.src = {1}", element, src);
                var stretch = Reflect.field(props, "stretch");
                if (stretch != null) js.Syntax.code("{0}.stretch = {1}", element, stretch);
                
            case WebView:
                var src = Reflect.field(props, "src");
                if (src != null) js.Syntax.code("{0}.src = {1}", element, src);
                
            case Progress:
                var value = Reflect.field(props, "value");
                if (value != null) js.Syntax.code("{0}.value = {1}", element, value);
                var maxValue = Reflect.field(props, "maxValue");
                if (maxValue != null) js.Syntax.code("{0}.maxValue = {1}", element, maxValue);
                
            case Picker:
                var items = Reflect.field(props, "items");
                if (items != null) js.Syntax.code("{0}.items = {1}", element, items);
                var selectedIndex = Reflect.field(props, "selectedIndex");
                if (selectedIndex != null) js.Syntax.code("{0}.selectedIndex = {1}", element, selectedIndex);
                var onChange = Reflect.field(props, "onChange");
                if (onChange != null) {
                    js.Syntax.code("{0}.off('selectedIndexChange')", element);
                    js.Syntax.code("{0}.on('selectedIndexChange', function(args) { {1}(args.value); })", element, onChange);
                }
                
            default:
        }
    }
    
    public function appendChild(parent:Dynamic, child:Dynamic):Void {
        js.Syntax.code("if ({0}.addChild) {0}.addChild({1})", parent, child);
        js.Syntax.code("else if ({0}.content === undefined) {0}.content = {1}", parent, child);
    }
    
    public function removeChild(parent:Dynamic, child:Dynamic):Void {
        js.Syntax.code("if ({0}.removeChild) {0}.removeChild({1})", parent, child);
    }
    
    public function replaceChild(parent:Dynamic, oldChild:Dynamic, newChild:Dynamic):Void {
        removeChild(parent, oldChild);
        appendChild(parent, newChild);
    }
    
    public function applyModifiers(element:Dynamic, props:Dynamic):Void {
        var padding = Reflect.field(props, "padding");
        if (padding != null) js.Syntax.code("{0}.padding = {1}", element, padding);
        
        var width = Reflect.field(props, "width");
        if (width != null) js.Syntax.code("{0}.width = {1}", element, width);
        
        var height = Reflect.field(props, "height");
        if (height != null) js.Syntax.code("{0}.height = {1}", element, height);
        
        var backgroundColor = Reflect.field(props, "backgroundColor");
        if (backgroundColor != null) js.Syntax.code("{0}.backgroundColor = {1}", element, backgroundColor);
        
        var color = Reflect.field(props, "color");
        if (color != null) js.Syntax.code("{0}.color = {1}", element, color);
        
        var cornerRadius = Reflect.field(props, "cornerRadius");
        if (cornerRadius != null) js.Syntax.code("{0}.borderRadius = {1}", element, cornerRadius);
        
        var fontSize = Reflect.field(props, "fontSize");
        if (fontSize != null) js.Syntax.code("{0}.fontSize = {1}", element, fontSize);
        
        var fontWeight = Reflect.field(props, "fontWeight");
        if (fontWeight != null) js.Syntax.code("{0}.fontWeight = {1}", element, fontWeight);
        
        var shadowRadius = Reflect.field(props, "shadowRadius");
        var shadowOpacity = Reflect.field(props, "shadowOpacity");
        if (shadowRadius != null && shadowOpacity != null) {
            js.Syntax.code("{0}.androidElevation = {1}", element, shadowRadius);
            js.Syntax.code("{0}.iosShadowRadius = {1}", element, shadowRadius);
            js.Syntax.code("{0}.iosShadowOpacity = {1}", element, shadowOpacity);
        }
        
        var onTap = Reflect.field(props, "onTap");
        if (onTap != null) {
            js.Syntax.code("{0}.on('tap', {1})", element, onTap);
        }
        
        var accessibilityLabel = Reflect.field(props, "accessibilityLabel");
        if (accessibilityLabel != null) {
            js.Syntax.code("{0}.accessibilityLabel = {1}", element, accessibilityLabel);
        }
    }
    
    public function startApp(rootView:Dynamic):Void {
        js.Syntax.code("{0}.run({{ create: function() {{ return {1}; }} }})", Application, rootView);
    }
}
#end

