package examples;

import ns.ui.*;
import ns.core.*;

typedef Todo = {
    id:Int,
    title:String,
    completed:Bool,
    createdAt:Float
}

class TodoApp {
    private static var todos:State<Array<Todo>>;
    private static var newTodoText:State<String>;
    private static var filter:State<String>; // "all", "active", "completed"
    
    public static function main() {
        todos = new State<Array<Todo>>([]);
        newTodoText = new State<String>("");
        filter = new State<String>("all");
        
        // Subscribe to all state changes
        todos.subscribe(function(_) updateUI());
        newTodoText.subscribe(function(_) updateUI());
        filter.subscribe(function(_) updateUI());
        
        // Load initial data
        loadTodos();
        
        App.run(buildUI());
    }
    
    private static function updateUI():Void {
        App.update(buildUI());
    }
    
    private static function buildUI():VNode {
        return new VStack([
            buildHeader(),
            buildAddTodoSection(),
            buildFilterSection(),
            buildTodoList(),
            buildFooter()
        ])
        .background("#F5F5F5")
        .toVNode();
    }
    
    private static function buildHeader():Component {
        return new VStack([
            new Text("📝 Todo App")
                .font(32, "bold")
                .foregroundColor("#2196F3")
                .padding(16),
            
            new Text("Manage your tasks efficiently")
                .font(14)
                .foregroundColor("#666666")
                .padding(4)
        ])
        .background("#FFFFFF")
        .shadow(2, 0.1);
    }
    
    private static function buildAddTodoSection():Component {
        return new HStack([
            new TextField("What needs to be done?", newTodoText)
                .padding(12)
                .background("#F8F8F8")
                .cornerRadius(8)
                .frame(null, 48),
            
            new Button("Add", function() {
                addTodo();
            })
            .padding(12)
            .background("#4CAF50")
            .foregroundColor("#FFFFFF")
            .cornerRadius(8)
            .frame(80, 48)
        ])
        .padding(16);
    }
    
    private static function buildFilterSection():Component {
        var currentFilter = filter.get();
        
        return new HStack([
            createFilterButton("All", "all", currentFilter),
            createFilterButton("Active", "active", currentFilter),
            createFilterButton("Completed", "completed", currentFilter)
        ])
        .padding(8);
    }
    
    private static function createFilterButton(label:String, filterValue:String, currentFilter:String):Component {
        var isActive = currentFilter == filterValue;
        
        return new Button(label, function() {
            filter.set(filterValue);
        })
        .padding(8)
        .background(isActive ? "#2196F3" : "#E0E0E0")
        .foregroundColor(isActive ? "#FFFFFF" : "#666666")
        .cornerRadius(6);
    }
    
    private static function buildTodoList():Component {
        var filteredTodos = getFilteredTodos();
        
        if (filteredTodos.length == 0) {
            return new VStack([
                new Text(getEmptyMessage())
                    .font(16)
                    .foregroundColor("#999999")
                    .padding(32)
            ]);
        }
        
        var todoItems = filteredTodos.map(function(todo) {
            return buildTodoItem(todo);
        });
        
        return new ScrollView(
            new VStack(todoItems)
                .padding(8)
        );
    }
    
    private static function buildTodoItem(todo:Todo):Component {
        return new HStack([
            new Button(todo.completed ? "✓" : "○", function() {
                toggleTodo(todo.id);
            })
            .padding(8)
            .background(todo.completed ? "#4CAF50" : "#E0E0E0")
            .foregroundColor(todo.completed ? "#FFFFFF" : "#666666")
            .cornerRadius(20)
            .frame(40, 40),
            
            new VStack([
                new Text(todo.title)
                    .font(16, todo.completed ? "normal" : "bold")
                    .foregroundColor(todo.completed ? "#999999" : "#333333")
                    .padding(4),
                
                new Text(formatDate(todo.createdAt))
                    .font(12)
                    .foregroundColor("#AAAAAA")
                    .padding(2)
            ]),
            
            new Spacer(),
            
            new Button("🗑", function() {
                deleteTodo(todo.id);
            })
            .padding(8)
            .background("#F44336")
            .foregroundColor("#FFFFFF")
            .cornerRadius(6)
            .frame(40, 40)
        ])
        .padding(12)
        .background("#FFFFFF")
        .cornerRadius(8)
        .shadow(2, 0.1);
    }
    
    private static function buildFooter():Component {
        var activeTodos = todos.get().filter(function(t) return !t.completed);
        var completedTodos = todos.get().filter(function(t) return t.completed);
        
        return new VStack([
            new HStack([
                new Text('${activeTodos.length} active')
                    .font(12)
                    .foregroundColor("#666666"),
                
                new Spacer(),
                
                new Text('${completedTodos.length} completed')
                    .font(12)
                    .foregroundColor("#666666")
            ])
            .padding(12),
            
            if (completedTodos.length > 0) {
                new Button("Clear Completed", function() {
                    clearCompleted();
                })
                .padding(8)
                .background("#F44336")
                .foregroundColor("#FFFFFF")
                .cornerRadius(6);
            } else {
                new Spacer();
            }
        ])
        .padding(8)
        .background("#FFFFFF")
        .shadow(2, 0.1);
    }
    
    private static function addTodo():Void {
        var text = newTodoText.get().trim();
        if (text.length == 0) return;
        
        var currentTodos = todos.get();
        var newId = currentTodos.length > 0 
            ? currentTodos[currentTodos.length - 1].id + 1 
            : 1;
        
        currentTodos.push({
            id: newId,
            title: text,
            completed: false,
            createdAt: Date.now().getTime()
        });
        
        todos.set(currentTodos);
        newTodoText.set("");
        saveTodos();
    }
    
    private static function toggleTodo(id:Int):Void {
        var currentTodos = todos.get();
        for (todo in currentTodos) {
            if (todo.id == id) {
                todo.completed = !todo.completed;
                break;
            }
        }
        todos.set(currentTodos);
        saveTodos();
    }
    
    private static function deleteTodo(id:Int):Void {
        var currentTodos = todos.get().filter(function(t) return t.id != id);
        todos.set(currentTodos);
        saveTodos();
    }
    
    private static function clearCompleted():Void {
        var currentTodos = todos.get().filter(function(t) return !t.completed);
        todos.set(currentTodos);
        saveTodos();
    }
    
    private static function getFilteredTodos():Array<Todo> {
        var allTodos = todos.get();
        var currentFilter = filter.get();
        
        return switch(currentFilter) {
            case "active": allTodos.filter(function(t) return !t.completed);
            case "completed": allTodos.filter(function(t) return t.completed);
            default: allTodos;
        };
    }
    
    private static function getEmptyMessage():String {
        return switch(filter.get()) {
            case "active": "No active todos. Great job!";
            case "completed": "No completed todos yet.";
            default: "No todos yet. Add one above!";
        };
    }
    
    private static function formatDate(timestamp:Float):String {
        var date = Date.fromTime(timestamp);
        return '${date.getMonth() + 1}/${date.getDate()} ${date.getHours()}:${padZero(date.getMinutes())}';
    }
    
    private static function padZero(num:Int):String {
        return num < 10 ? '0$num' : '$num';
    }
    
    private static function saveTodos():Void {
        // Persist to storage (implementation depends on platform)
        trace('Saved ${todos.get().length} todos');
    }
    
    private static function loadTodos():Void {
        // Load from storage (implementation depends on platform)
        trace('Loaded todos');
    }
}
