package;

import ns.ui.*;
import ns.core.*;

class Main {
    static function main() {
        var counter = new State<Int>(0);
        var username = new State<String>("");
        var password = new State<String>("");
        var isToggled = new State<Bool>(false);
        var sliderValue = new State<Float>(50.0);
        
        // Subscribe to state changes to trigger re-renders
        counter.subscribe(function(newValue) {
            App.update(buildUI(counter, username, password, isToggled, sliderValue));
        });
        
        username.subscribe(function(newValue) {
            App.update(buildUI(counter, username, password, isToggled, sliderValue));
        });
        
        password.subscribe(function(newValue) {
            App.update(buildUI(counter, username, password, isToggled, sliderValue));
        });
        
        isToggled.subscribe(function(newValue) {
            App.update(buildUI(counter, username, password, isToggled, sliderValue));
        });
        
        sliderValue.subscribe(function(newValue) {
            App.update(buildUI(counter, username, password, isToggled, sliderValue));
        });
        
        App.run(buildUI(counter, username, password, isToggled, sliderValue));
    }
    
    static function buildUI(
        counter:State<Int>,
        username:State<String>,
        password:State<String>,
        isToggled:State<Bool>,
        sliderValue:State<Float>
    ):VNode {
        return new ScrollView(
            new VStack([
                // Header Section
                new VStack([
                    new Text("NativeScript Haxe")
                        .font(32, "bold")
                        .foregroundColor("#2196F3")
                        .padding(16),
                    
                    new Text("SwiftUI-style Declarative UI")
                        .font(16)
                        .foregroundColor("#666666")
                        .padding(8),
                    
                    new Divider()
                ])
                .background("#F5F5F5")
                .padding(16),
                
                // Counter Section
                new VStack([
                    new Text("Counter Example")
                        .font(20, "bold")
                        .padding(8),
                    
                    new Text('Count: ${counter.get()}')
                        .font(24)
                        .foregroundColor("#4CAF50")
                        .padding(16),
                    
                    new HStack([
                        new Button("Increment", function() {
                            counter.set(counter.get() + 1);
                        })
                        .padding(8)
                        .background("#4CAF50")
                        .foregroundColor("#FFFFFF")
                        .cornerRadius(8),
                        
                        new Button("Decrement", function() {
                            counter.set(counter.get() - 1);
                        })
                        .padding(8)
                        .background("#F44336")
                        .foregroundColor("#FFFFFF")
                        .cornerRadius(8),
                        
                        new Button("Reset", function() {
                            counter.set(0);
                        })
                        .padding(8)
                        .background("#9E9E9E")
                        .foregroundColor("#FFFFFF")
                        .cornerRadius(8)
                    ])
                ])
                .padding(16)
                .background("#FFFFFF")
                .cornerRadius(12)
                .shadow(4, 0.2),
                
                new Spacer(),
                
                // Form Section
                new VStack([
                    new Text("Form Example")
                        .font(20, "bold")
                        .padding(8),
                    
                    new TextField("Username", username)
                        .padding(12)
                        .background("#F0F0F0")
                        .cornerRadius(8),
                    
                    new SecureField("Password", password)
                        .padding(12)
                        .background("#F0F0F0")
                        .cornerRadius(8),
                    
                    new HStack([
                        new Text("Remember me")
                            .font(14),
                        new Toggle(isToggled)
                    ]),
                    
                    new Text('Toggle is: ${isToggled.get() ? "ON" : "OFF"}')
                        .font(12)
                        .foregroundColor("#666666")
                        .padding(4),
                    
                    new Button("Login", function() {
                        trace('Login attempt: ${username.get()}');
                    })
                    .padding(12)
                    .background("#2196F3")
                    .foregroundColor("#FFFFFF")
                    .cornerRadius(8)
                    .frame(null, 48),
                    
                    new Text('Username: ${username.get()}')
                        .font(12)
                        .foregroundColor("#999999")
                        .padding(4)
                ])
                .padding(16)
                .background("#FFFFFF")
                .cornerRadius(12)
                .shadow(4, 0.2),
                
                new Spacer(),
                
                // Slider Section
                new VStack([
                    new Text("Slider Example")
                        .font(20, "bold")
                        .padding(8),
                    
                    new Text('Value: ${Math.round(sliderValue.get())}')
                        .font(18)
                        .foregroundColor("#FF9800")
                        .padding(8),
                    
                    new Slider(sliderValue, 0, 100)
                        .padding(16),
                    
                    new HStack([
                        new Text("0")
                            .font(12)
                            .foregroundColor("#999999"),
                        new Spacer(),
                        new Text("100")
                            .font(12)
                            .foregroundColor("#999999")
                    ])
                ])
                .padding(16)
                .background("#FFFFFF")
                .cornerRadius(12)
                .shadow(4, 0.2),
                
                new Spacer(),
                
                // Loading Indicator Section
                new VStack([
                    new Text("Loading Indicator")
                        .font(20, "bold")
                        .padding(8),
                    
                    new ActivityIndicator(true)
                        .padding(16),
                    
                    new Text("Processing...")
                        .font(14)
                        .foregroundColor("#666666")
                ])
                .padding(16)
                .background("#FFFFFF")
                .cornerRadius(12)
                .shadow(4, 0.2),
                
                new Spacer(),
                
                // Footer
                new Text("Built with Haxe + NativeScript")
                    .font(12)
                    .foregroundColor("#999999")
                    .padding(16)
            ])
        )
        .background("#E0E0E0")
        .toVNode();
    }
}
