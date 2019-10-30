//Built in Xcode 11.1.

var str = "Hello, playground"

@propertyWrapper
enum Lazy<Value> {
    case uninitialized(() -> Value)
    case initialized(Value)
    
    init(wrappedValue: @autoclosure @escaping () -> Value) {
        self = .uninitialized(wrappedValue)
    }
    
    var wrappedValue: Value {
        mutating get {
            switch self {
            case .uninitialized(let initializer):
                let value = initializer()
                self = .initialized(value)
                return value
            case .initialized(let value):
                return value
            }
        }
        set {
            self = .initialized(newValue)
        }
    }
}

class Foo {
    lazy var builtInLazy: String = { () in return "Old String Value"}()
    @Lazy var propertyLazy: String = { () in return "String Value" }()
    
    func runSomething() {
        print("Built-in: \(builtInLazy)")
        print("Property-Level: \(propertyLazy)")
    }
    
    func settableThough() {
        builtInLazy = "Something else"
        propertyLazy = "Hello"
    }
}

let foo = Foo()
foo.runSomething()
foo.settableThough()
foo.runSomething()


