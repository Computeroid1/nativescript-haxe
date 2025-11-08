package ns.core;

class State<T> {
    private var value:T;
    private var listeners:Array<T->Void>;
    
    public function new(initialValue:T) {
        this.value = initialValue;
        this.listeners = [];
    }
    
    public function get():T {
        return value;
    }
    
    public function set(newValue:T):Void {
        if (value != newValue) {
            value = newValue;
            notifyListeners();
        }
    }
    
    public function subscribe(listener:T->Void):Void {
        listeners.push(listener);
    }
    
    public function unsubscribe(listener:T->Void):Void {
        listeners.remove(listener);
    }
    
    private function notifyListeners():Void {
        for (listener in listeners) {
            listener(value);
        }
    }
}
