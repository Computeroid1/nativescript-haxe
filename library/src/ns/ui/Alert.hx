package ns.ui;

class Alert {
    public static function show(title:String, message:String, ?okButton:String = "OK"):Void {
        #if android
        var dialogs = js.Syntax.code("require('@nativescript/core').Dialogs");
        js.Syntax.code("{0}.alert({{title: {1}, message: {2}, okButtonText: {3}}})", 
            dialogs, title, message, okButton);
        #elseif windows
        var dialog = js.Syntax.code("new Windows.UI.Popups.MessageDialog({0}, {1})", message, title);
        js.Syntax.code("{0}.showAsync()", dialog);
        #end
    }
    
    public static function confirm(title:String, message:String, 
        okButton:String = "OK", 
        cancelButton:String = "Cancel",
        callback:Bool->Void):Void {
        #if android
        var dialogs = js.Syntax.code("require('@nativescript/core').Dialogs");
        js.Syntax.code("{0}.confirm({{title: {1}, message: {2}, okButtonText: {3}, cancelButtonText: {4}}}).then(function(result) {{ {5}(result); }})", 
            dialogs, title, message, okButton, cancelButton, callback);
        #elseif windows
        var dialog = js.Syntax.code("new Windows.UI.Popups.MessageDialog({0}, {1})", message, title);
        js.Syntax.code("{0}.showAsync().then(function(result) {{ {1}(result.label === {2}); }})", 
            dialog, callback, okButton);
        #end
    }
    
    public static function prompt(title:String, message:String, 
        defaultText:String = "",
        okButton:String = "OK",
        cancelButton:String = "Cancel",
        callback:Null<String>->Void):Void {
        #if android
        var dialogs = js.Syntax.code("require('@nativescript/core').Dialogs");
        js.Syntax.code("{0}.prompt({{title: {1}, message: {2}, defaultText: {3}, okButtonText: {4}, cancelButtonText: {5}}}).then(function(result) {{ {6}(result.result ? result.text : null); }})", 
            dialogs, title, message, defaultText, okButton, cancelButton, callback);
        #end
    }
}