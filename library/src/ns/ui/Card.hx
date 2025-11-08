package ns.ui;

class Card extends VStack {
    public function new(children:Array<Component>) {
        super(children);
        this.padding(16)
            .background("#FFFFFF")
            .cornerRadius(12)
            .shadow(4, 0.2);
    }
}