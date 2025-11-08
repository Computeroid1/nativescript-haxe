package ns.platform;

import ns.core.VNode;

#if windows
class WindowsAdapter implements PlatformAdapter {
    public function new() {
        // Initialize Windows Runtime
    }
    
    public function createRootContainer():Dynamic {
        return js.Syntax.code("new Windows.UI.Xaml.Controls.StackPanel()");
    }
    
    public function createElement(type:VNodeType, props:Dynamic):Dynamic {
        return switch(type) {
            case Text: js.Syntax.code("new Windows.UI.Xaml.Controls.TextBlock()");
            case Button: js.Syntax.code("new Windows.UI.Xaml.Controls.Button()");
            case VStack | HStack: createStackPanel(props);
            case ZStack: js.Syntax.code("new Windows.UI.Xaml.Controls.Grid()");
            case ScrollView: js.Syntax.code("new Windows.UI.Xaml.Controls.ScrollViewer()");
            case TextField | SecureField: createTextBox(props);
            case Toggle: js.Syntax.code("new Windows.UI.Xaml.Controls.ToggleSwitch()");
            case Slider: js.Syntax.code("new Windows.UI.Xaml.Controls.Slider()");
            case ActivityIndicator: js.Syntax.code("new Windows.UI.Xaml.Controls.ProgressRing()");
            case ImageView: js.Syntax.code("new Windows.UI.Xaml.Controls.Image()");
            case ListView: js.Syntax.code("new Windows.UI.Xaml.Controls.ListView()");
            case Picker: js.Syntax.code("new Windows.UI.Xaml.Controls.ComboBox()");
            case NavigationView: js.Syntax.code("new Windows.UI.Xaml.Controls.Frame()");
            case NavigationLink: js.Syntax.code("new Windows.UI.Xaml.Controls.Button()");
            case TabView: js.Syntax.code("new Windows.UI.Xaml.Controls.Pivot()");
            case WebView: js.Syntax.code("new Windows.UI.Xaml.Controls.WebView()");
            case Progress: js.Syntax.code("new Windows.UI.Xaml.Controls.ProgressBar()");
            case Spacer: js.Syntax.code("new Windows.UI.Xaml.Controls.Border()");
            case Divider: createDivider();
            case Container: js.Syntax.code("new Windows.UI.Xaml.Controls.StackPanel()");
        };
    }
    
    private function createStackPanel(props:Dynamic):Dynamic {
        var panel = js.Syntax.code("new Windows.UI.Xaml.Controls.StackPanel()");
        var orientation = Reflect.field(props, "orientation");
        if (orientation == "horizontal") {
            js.Syntax.code("{0}.Orientation = Windows.UI.Xaml.Controls.Orientation.Horizontal", panel);
        } else {
            js.Syntax.code("{0}.Orientation = Windows.UI.Xaml.Controls.Orientation.Vertical", panel);
        }
        return panel;
    }
    
    private function createTextBox(props:Dynamic):Dynamic {
        var secure = Reflect.field(props, "secure");
        if (secure == true) {
            return js.Syntax.code("new Windows.UI.Xaml.Controls.PasswordBox()");
        }
        return js.Syntax.code("new Windows.UI.Xaml.Controls.TextBox()");
    }
    
    private function createDivider():Dynamic {
        var rect = js.Syntax.code("new Windows.UI.Xaml.Shapes.Rectangle()");
        js.Syntax.code("{0}.Height = 1", rect);
        js.Syntax.code("{0}.Fill = new Windows.UI.Xaml.Media.SolidColorBrush(Windows.UI.Colors.Gray)", rect);
        return rect;
    }
    
    public function updateElement(element:Dynamic, type:VNodeType, props:Dynamic):Void {
        switch(type) {
            case Text:
                var text = Reflect.field(props, "text");
                if (text != null) js.Syntax.code("{0}.Text = {1}", element, text);
                
            case Button:
                var text = Reflect.field(props, "text");
                if (text != null) js.Syntax.code("{0}.Content = {1}", element, text);
                var onTap = Reflect.field(props, "onTap");
                if (onTap != null) {
                    js.Syntax.code("{0}.Click += function(sender, e) {{ {1}(); }}", element, onTap);
                }
                
            case TextField | SecureField:
                var hint = Reflect.field(props, "hint");
                if (hint != null) js.Syntax.code("{0}.PlaceholderText = {1}", element, hint);
                var text = Reflect.field(props, "text");
                if (text != null) js.Syntax.code("{0}.Text = {1}", element, text);
                var onChange = Reflect.field(props, "onChange");
                if (onChange != null) {
                    js.Syntax.code("{0}.TextChanged += function(sender, e) {{ {1}(sender.Text); }}", element, onChange);
                }
                
            case Toggle:
                var checked = Reflect.field(props, "checked");
                if (checked != null) js.Syntax.code("{0}.IsOn = {1}", element, checked);
                var onChange = Reflect.field(props, "onChange");
                if (onChange != null) {
                    js.Syntax.code("{0}.Toggled += function(sender, e) {{ {1}(sender.IsOn); }}", element, onChange);
                }
                
            case Slider:
                var value = Reflect.field(props, "value");
                if (value != null) js.Syntax.code("{0}.Value = {1}", element, value);
                var minValue = Reflect.field(props, "minValue");
                if (minValue != null) js.Syntax.code("{0}.Minimum = {1}", element, minValue);
                var maxValue = Reflect.field(props, "maxValue");
                if (maxValue != null) js.Syntax.code("{0}.Maximum = {1}", element, maxValue);
                var onChange = Reflect.field(props, "onChange");
                if (onChange != null) {
                    js.Syntax.code("{0}.ValueChanged += function(sender, e) {{ {1}(sender.Value); }}", element, onChange);
                }
                
            case ActivityIndicator:
                var busy = Reflect.field(props, "busy");
                if (busy != null) js.Syntax.code("{0}.IsActive = {1}", element, busy);
                
            case ImageView:
                var src = Reflect.field(props, "src");
                if (src != null) {
                    js.Syntax.code("{0}.Source = new Windows.UI.Xaml.Media.Imaging.BitmapImage(new Windows.Foundation.Uri({1}))", element, src);
                }
                
            case WebView:
                var src = Reflect.field(props, "src");
                if (src != null) {
                    js.Syntax.code("{0}.Navigate(new Windows.Foundation.Uri({1}))", element, src);
                }
                
            case Progress:
                var value = Reflect.field(props, "value");
                if (value != null) js.Syntax.code("{0}.Value = {1}", element, value);
                var maxValue = Reflect.field(props, "maxValue");
                if (maxValue != null) js.Syntax.code("{0}.Maximum = {1}", element, maxValue);
                
            case Picker:
                var items = Reflect.field(props, "items");
                if (items != null) {
                    js.Syntax.code("{0}.Items.Clear()", element);
                    js.Syntax.code("for (var i = 0; i < {1}.length; i++) {{ {0}.Items.Add({1}[i]); }}", element, items);
                }
                var selectedIndex = Reflect.field(props, "selectedIndex");
                if (selectedIndex != null) js.Syntax.code("{0}.SelectedIndex = {1}", element, selectedIndex);
                
            default:
        }
    }
    
    public function appendChild(parent:Dynamic, child:Dynamic):Void {
        js.Syntax.code("if ({0}.Children) {0}.Children.Add({1})", parent, child);
        js.Syntax.code("else if ({0}.Content !== undefined) {0}.Content = {1}", parent, child);
    }
    
    public function removeChild(parent:Dynamic, child:Dynamic):Void {
        js.Syntax.code("if ({0}.Children) {0}.Children.Remove({1})", parent, child);
    }
    
    public function replaceChild(parent:Dynamic, oldChild:Dynamic, newChild:Dynamic):Void {
        removeChild(parent, oldChild);
        appendChild(parent, newChild);
    }
    
    public function applyModifiers(element:Dynamic, props:Dynamic):Void {
        var padding = Reflect.field(props, "padding");
        if (padding != null) {
            js.Syntax.code("{0}.Padding = new Windows.UI.Xaml.Thickness({1})", element, padding);
        }
        
        var width = Reflect.field(props, "width");
        if (width != null) js.Syntax.code("{0}.Width = {1}", element, width);
        
        var height = Reflect.field(props, "height");
        if (height != null) js.Syntax.code("{0}.Height = {1}", element, height);
        
        var backgroundColor = Reflect.field(props, "backgroundColor");
        if (backgroundColor != null) {
            js.Syntax.code("{0}.Background = new Windows.UI.Xaml.Media.SolidColorBrush(Windows.UI.ColorHelper.FromArgb(255, parseInt({1}.substr(1,2), 16), parseInt({1}.substr(3,2), 16), parseInt({1}.substr(5,2), 16)))", element, backgroundColor);
        }
        
        var color = Reflect.field(props, "color");
        if (color != null) {
            js.Syntax.code("{0}.Foreground = new Windows.UI.Xaml.Media.SolidColorBrush(Windows.UI.ColorHelper.FromArgb(255, parseInt({1}.substr(1,2), 16), parseInt({1}.substr(3,2), 16), parseInt({1}.substr(5,2), 16)))", element, color);
        }
        
        var cornerRadius = Reflect.field(props, "cornerRadius");
        if (cornerRadius != null) {
            js.Syntax.code("{0}.CornerRadius = new Windows.UI.Xaml.CornerRadius({1})", element, cornerRadius);
        }
        
        var fontSize = Reflect.field(props, "fontSize");
        if (fontSize != null) js.Syntax.code("{0}.FontSize = {1}", element, fontSize);
        
        var fontWeight = Reflect.field(props, "fontWeight");
        if (fontWeight != null) {
            if (fontWeight == "bold") {
                js.Syntax.code("{0}.FontWeight = Windows.UI.Text.FontWeights.Bold", element);
            } else {
                js.Syntax.code("{0}.FontWeight = Windows.UI.Text.FontWeights.Normal", element);
            }
        }
        
        var accessibilityLabel = Reflect.field(props, "accessibilityLabel");
        if (accessibilityLabel != null) {
            js.Syntax.code("Windows.UI.Xaml.Automation.AutomationProperties.SetName({0}, {1})", element, accessibilityLabel);
        }
    }
    
    public function startApp(rootView:Dynamic):Void {
        js.Syntax.code("Windows.UI.Xaml.Window.Current.Content = {0}", rootView);
        js.Syntax.code("Windows.UI.Xaml.Window.Current.Activate()");
    }
}
#end