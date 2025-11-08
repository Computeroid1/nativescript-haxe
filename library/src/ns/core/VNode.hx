package ns.core;

enum VNodeType {
    Text;
    Button;
    VStack;
    HStack;
    ZStack;
    ScrollView;
    ListView;
    TextField;
    SecureField;
    ImageView;
    Toggle;
    Slider;
    Picker;
    NavigationView;
    NavigationLink;
    TabView;
    Container;
    Spacer;
    Divider;
    ActivityIndicator;
    WebView;
    Progress;
}

typedef VNode = {
    var type:VNodeType;
    var props:Dynamic;
    var children:Array<VNode>;
    var key:Null<String>;
    var nativeView:Null<Dynamic>;
}