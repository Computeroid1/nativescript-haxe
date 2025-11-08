package examples;

import ns.ui.*;
import ns.core.*;

class CalculatorApp {
    private static var display:State<String>;
    private static var operation:State<String>;
    private static var previousValue:State<Float>;
    private static var shouldResetDisplay:State<Bool>;
    
    public static function main() {
        display = new State<String>("0");
        operation = new State<String>("");
        previousValue = new State<Float>(0);
        shouldResetDisplay = new State<Bool>(false);
        
        display.subscribe(function(_) updateUI());
        
        App.run(buildUI());
    }
    
    private static function updateUI():Void {
        App.update(buildUI());
    }
    
    private static function buildUI():VNode {
        return new VStack([
            buildDisplay(),
            buildButtons()
        ])
        .background("#1E1E1E")
        .toVNode();
    }
    
    private static function buildDisplay():Component {
        return new Text(display.get())
            .font(48, "bold")
            .foregroundColor("#FFFFFF")
            .padding(24)
            .background("#2E2E2E")
            .frame(null, 120);
    }
    
    private static function buildButtons():Component {
        return new VStack([
            buildButtonRow(["C", "±", "%", "÷"]),
            buildButtonRow(["7", "8", "9", "×"]),
            buildButtonRow(["4", "5", "6", "-"]),
            buildButtonRow(["1", "2", "3", "+"]),
            buildButtonRow(["0", ".", "=", ""])
        ]);
    }
    
    private static function buildButtonRow(buttons:Array<String>):Component {
        var components = buttons.map(function(btn) {
            if (btn == "") return new Spacer();
            return createButton(btn);
        });
        return new HStack(components).padding(4);
    }
    
    private static function createButton(label:String):Component {
        var isOperator = ["÷", "×", "-", "+", "="].indexOf(label) >= 0;
        var isSpecial = ["C", "±", "%"].indexOf(label) >= 0;
        
        return new Button(label, function() {
            handleButtonPress(label);
        })
        .padding(16)
        .background(isOperator ? "#FF9500" : (isSpecial ? "#505050" : "#333333"))
        .foregroundColor("#FFFFFF")
        .cornerRadius(40)
        .font(24, "bold")
        .frame(label == "0" ? 160 : 70, 70);
    }
    
    private static function handleButtonPress(button:String):Void {
        switch(button) {
            case "C": clear();
            case "±": toggleSign();
            case "%": percentage();
            case "=": calculate();
            case "+", "-", "×", "÷": setOperation(button);
            default: appendDigit(button);
        }
    }
    
    private static function clear():Void {
        display.set("0");
        operation.set("");
        previousValue.set(0);
        shouldResetDisplay.set(false);
    }
    
    private static function toggleSign():Void {
        var current = Std.parseFloat(display.get());
        display.set(Std.string(-current));
    }
    
    private static function percentage():Void {
        var current = Std.parseFloat(display.get());
        display.set(Std.string(current / 100));
    }
    
    private static function appendDigit(digit:String):Void {
        if (shouldResetDisplay.get()) {
            display.set(digit == "." ? "0." : digit);
            shouldResetDisplay.set(false);
        } else {
            var current = display.get();
            if (current == "0" && digit != ".") {
                display.set(digit);
            } else {
                display.set(current + digit);
            }
        }
    }
    
    private static function setOperation(op:String):Void {
        var current = Std.parseFloat(display.get());
        previousValue.set(current);
        operation.set(op);
        shouldResetDisplay.set(true);
    }
    
    private static function calculate():Void {
        var current = Std.parseFloat(display.get());
        var previous = previousValue.get();
        var op = operation.get();
        
        var result = switch(op) {
            case "+": previous + current;
            case "-": previous - current;
            case "×": previous * current;
            case "÷": current != 0 ? previous / current : 0;
            default: current;
        };
        
        display.set(Std.string(result));
        operation.set("");
        shouldResetDisplay.set(true);
    }
}