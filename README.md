# nativescript-haxe

This is a complete **SwiftUI-style declarative UI framework** for **Haxe** that compiles to **NativeScript for Android** and **native Windows Runtime applications**.

Write once in Haxe, deploy to Android and Windows with native performance and native UI controls.

## ✨ Features

- 🎨 **SwiftUI-style Declarative API** - Intuitive, composable UI components
- 📱 **Native Android** - Full NativeScript integration with native Android controls
- 🪟 **Native Windows** - Native Windows Runtime (not Electron)
- ⚡ **Reactive State Management** - Built-in `State<T>` system with auto-updates
- 🔄 **Smart Reconciliation** - Virtual DOM diffing for optimal performance
- 🎯 **Type-Safe** - Full Haxe type safety across platforms
- 🧩 **Modular Architecture** - Clean separation of core, UI, and platform layers
- 🚀 **Zero JavaScript** - Write only Haxe, no JS required

## 📦 Installation

### Prerequisites

- [Haxe](https://haxe.org/download/) 4.3.0 or higher
- [Node.js](https://nodejs.org/) 18.0 or higher
- [NativeScript CLI](https://docs.nativescript.org/setup/) 8.5.0 or higher
- Android Studio (for Android development)
- Windows 10/11 SDK (for Windows development)

### Quick Start

```bash
# Clone the repository
git clone https://github.com/Computeroid/nativescript-haxe.git
cd nativescript-haxe

# Run setup script
chmod +x scripts/setup.sh
./scripts/setup.sh

# Or use Make
make setup
```

### Manual Installation

```bash
# Install Node.js dependencies
npm install

# Set up NativeScript template
cd template/app
npm install
cd ../..

# Generate Haxe externs
npm run gen-externs

# Install as Haxelib
haxelib dev nativescript-haxe .
```

## 🚀 Usage

### Basic Example

```haxe
import ns.ui.*;
import ns.core.*;

class Main {
    static function main() {
        var counter = new State<Int>(0);
        
        counter.subscribe(function(value) {
            App.update(buildUI(counter));
        });
        
        App.run(buildUI(counter));
    }
    
    static function buildUI(counter:State<Int>):VNode {
        return new VStack([
            new Text("Hello NativeScript!")
                .font(32, "bold")
                .foregroundColor("#2196F3")
                .padding(16),
            
            new Text('Count: ${counter.get()}')
                .font(24)
                .padding(8),
            
            new Button("Increment", function() {
                counter.set(counter.get() + 1);
            })
            .padding(12)
            .background("#4CAF50")
            .foregroundColor("#FFFFFF")
            .cornerRadius(8)
        ])
        .padding(16)
        .toVNode();
    }
}
```

### Build and Run

```bash
# Build for Android
haxe run_android.hxml
# or
make android

# Build for Windows
haxe run_windows.hxml
# or
make windows

# Just compile without running
haxe build.hxml
# or
make build
```

## 📚 API Reference

### UI Components

#### Basic Components

- `Text(content)` - Text label
- `Button(title, action)` - Tappable button
- `TextField(placeholder, state)` - Text input field
- `SecureField(placeholder, state)` - Password input field
- `Toggle(state)` - Boolean switch
- `Slider(state, min, max)` - Numeric slider
- `ActivityIndicator(busy)` - Loading spinner
- `Spacer()` - Flexible space
- `Divider()` - Horizontal line

#### Layout Components

- `VStack(children)` - Vertical stack layout
- `HStack(children)` - Horizontal stack layout
- `ZStack(children)` - Layered (absolute) layout
- `ScrollView(child)` - Scrollable container

### Modifiers

All components support chainable modifiers:

```haxe
component
    .padding(16)                          // Add padding
    .frame(width, height)                 // Set dimensions
    .background("#FF0000")                // Background color
    .foregroundColor("#FFFFFF")           // Text color
    .cornerRadius(8)                      // Rounded corners
    .shadow(4, 0.2)                       // Drop shadow
    .font(18, "bold")                     // Font styling
    .onTap(handler)                       // Tap gesture
    .accessibilityLabel("Description")    // Accessibility
```

### State Management

```haxe
// Create state
var counter = new State<Int>(0);
var username = new State<String>("");
var isEnabled = new State<Bool>(false);

// Get value
var value = counter.get();

// Set value (triggers re-render)
counter.set(42);

// Subscribe to changes
counter.subscribe(function(newValue) {
    trace('Counter changed to: $newValue');
    App.update(buildUI(counter));
});

// Unsubscribe
counter.unsubscribe(handler);
```

### Advanced Example

```haxe
class TodoApp {
    static function main() {
        var todos = new State<Array<Todo>>([]);
        var newTodoText = new State<String>("");
        
        todos.subscribe(function(_) {
            App.update(buildUI(todos, newTodoText));
        });
        
        newTodoText.subscribe(function(_) {
            App.update(buildUI(todos, newTodoText));
        });
        
        App.run(buildUI(todos, newTodoText));
    }
    
    static function buildUI(
        todos:State<Array<Todo>>,
        newTodoText:State<String>
    ):VNode {
        var todoItems = todos.get().map(function(todo) {
            return new HStack([
                new Text(todo.title)
                    .font(16)
                    .padding(8),
                new Spacer(),
                new Button("✓", function() {
                    removeTodo(todos, todo.id);
                })
                .background("#4CAF50")
                .foregroundColor("#FFFFFF")
                .cornerRadius(4)
            ])
            .padding(12)
            .background("#FFFFFF")
            .cornerRadius(8)
            .shadow(2, 0.1);
        });
        
        return new VStack([
            // Header
            new Text("Todo List")
                .font(32, "bold")
                .padding(16),
            
            // Add Todo Form
            new HStack([
                new TextField("New todo...", newTodoText)
                    .padding(12)
                    .background("#F0F0F0")
                    .cornerRadius(8)
                    .frame(250, null),
                
                new Button("Add", function() {
                    addTodo(todos, newTodoText);
                })
                .padding(12)
                .background("#2196F3")
                .foregroundColor("#FFFFFF")
                .cornerRadius(8)
            ])
            .padding(16),
            
            // Todo List
            new ScrollView(
                new VStack(todoItems)
                    .padding(8)
            )
        ])
        .toVNode();
    }
    
    static function addTodo(
        todos:State<Array<Todo>>,
        text:State<String>
    ):Void {
        var currentText = text.get();
        if (currentText.length > 0) {
            var currentTodos = todos.get();
            currentTodos.push({
                id: Date.now().getTime(),
                title: currentText,
                completed: false
            });
            todos.set(currentTodos);
            text.set("");
        }
    }
    
    static function removeTodo(
        todos:State<Array<Todo>>,
        id:Float
    ):Void {
        var currentTodos = todos.get();
        todos.set(currentTodos.filter(function(t) {
            return t.id != id;
        }));
    }
}

typedef Todo = {
    id:Float,
    title:String,
    completed:Bool
}
```

## 🏗️ Project Structure

```
nativescript-haxe/
├── library/
│   ├── src/
│   │   └── ns/
│   │       ├── core/           # Core framework
│   │       │   ├── App.hx      # Main application runner
│   │       │   ├── State.hx    # Reactive state management
│   │       │   ├── Reconciler.hx # Virtual DOM reconciler
│   │       │   ├── VNode.hx    # Virtual node definition
│   │       │   └── View.hx     # View interface
│   │       ├── ui/             # UI components
│   │       │   ├── Component.hx    # Base component
│   │       │   ├── Text.hx         # Text component
│   │       │   ├── Button.hx       # Button component
│   │       │   ├── VStack.hx       # Vertical stack
│   │       │   ├── HStack.hx       # Horizontal stack
│   │       │   ├── TextField.hx    # Text input
│   │       │   └── ...             # Other components
│   │       └── platform/       # Platform adapters
│   │           ├── PlatformAdapter.hx     # Adapter interface
│   │           ├── NativeScriptAdapter.hx # Android adapter
│   │           └── WindowsAdapter.hx      # Windows adapter
│   └── externs/                # Generated type definitions
│       └── NativeScript.hx
│
├── template/                   # Starter template
│   ├── app/                    # NativeScript project
│   │   ├── App_Resources/      # Android resources
│   │   ├── app.js              # Generated entry point
│   │   ├── package.json
│   │   ├── nsconfig.json
│   │   └── webpack.config.js
│   └── src/
│       ├── Main.hx             # Demo application
│       ├── ListViewExample.hx  # List example
│       └── NavigationExample.hx # Navigation example
│
├── scripts/
│   ├── gen-externs.sh          # Generate externs
│   ├── setup.sh                # Project setup
│   └── clean.sh                # Clean builds
│
├── build.hxml                  # Library build config
├── run_android.hxml            # Android build config
├── run_windows.hxml            # Windows build config
├── package.json
├── haxelib.json
├── Makefile
└── README.md
```

## 🔧 Architecture

### Three-Layer Architecture

1. **Core Layer** (`ns.core`)
   - Application lifecycle management
   - State management system
   - Virtual DOM reconciliation
   - Platform abstraction

2. **UI Layer** (`ns.ui`)
   - Declarative component API
   - Modifier system
   - Component composition
   - Layout primitives

3. **Platform Layer** (`ns.platform`)
   - NativeScript adapter (Android)
   - Windows Runtime adapter
   - Native view creation
   - Event handling

### Virtual DOM Flow

```
User Code (Haxe)
    ↓
Component Tree
    ↓
VNode Tree (Virtual DOM)
    ↓
Reconciler (Diffing)
    ↓
Platform Adapter
    ↓
Native UI (Android/Windows)
```

### State Management Flow

```
State.set(newValue)
    ↓
Notify Subscribers
    ↓
App.update(newTree)
    ↓
Reconciler.patch(oldTree, newTree)
    ↓
Update Native Views
```

## 🎯 Supported Components

| Component | Android | Windows | Description |
|-----------|---------|---------|-------------|
| Text      |   ✅   |      ✅ | Text labels |
| Button    | ✅     | ✅      | Tappable buttons |
| TextField | ✅ | ✅ | Text input |
| SecureField | ✅ | ✅ | Password input |
| Toggle | ✅ | ✅ | Boolean switch |
| Slider | ✅ | ✅ | Numeric slider |
| VStack | ✅ | ✅ | Vertical layout |
| HStack | ✅ | ✅ | Horizontal layout |
| ZStack | ✅ | ✅ | Layered layout |
| ScrollView | ✅ | ✅ | Scrolling container |
| ActivityIndicator | ✅ | ✅ | Loading spinner |
| Spacer | ✅ | ✅ | Flexible space |
| Divider | ✅ | ✅ | Separator line |

## 🛠️ Development

### Adding New Components

1. Create component class in `library/src/ns/ui/`
2. Extend `Component` base class
3. Implement `toVNode()` method
4. Add VNodeType enum value
5. Implement platform adapters

Example:

```haxe
// 1. Add to VNodeType enum
enum VNodeType {
    // ...
    CustomComponent;
}

// 2. Create component class
package ns.ui;

class CustomComponent extends Component {
    public function new() {
        super({});
    }
    
    public override function toVNode():VNode {
        return {
            type: VNodeType.CustomComponent,
            props: props,
            children: [],
            key: null,
            nativeView: null
        };
    }
}

// 3. Implement in platform adapters
public function createElement(type:VNodeType, props:Dynamic):Dynamic {
    return switch(type) {
        // ...
        case CustomComponent: createCustomNativeView();
        default: defaultView();
    };
}
```

### Running Tests

```bash
make test
```

### Generating Externs

```bash
make externs
# or
npm run gen-externs
```

## 📱 Platform-Specific Notes

### Android (NativeScript)

- Uses `@nativescript/core` for native UI
- Compiles to JavaScript (ES6)
- Supports all Android versions via NativeScript
- Hot reload available in development

### Windows

- Uses native Windows Runtime APIs
- Requires Windows 10/11 SDK
- Direct access to UWP controls
- No Electron overhead

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

MIT License - see LICENSE file for details

## 🙏 Acknowledgments

- Inspired by SwiftUI and Jetpack Compose
- Built on NativeScript foundation
- Haxe cross-platform capabilities

## 📞 Support

- 🐛 Issues: [GitHub Issues](https://github.com/Computeroid/nativescript-haxe/issues)
- 📖 Docs: In Progress

---

**Made with ❤️ using Haxe**