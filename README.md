# Let's Talk
Membantu sepasangan kekasih memiliki komunikasi yang bermakna agar emotional intimacy mereka tumbuh. 

## Workflows
Berikut merupakan *guidelines* dalam pengerjaan project

### Git Branching
- Silahkan melakukan pull terlebih dahulu di branch main agar mendapatkan versi terbaru
> git pull
- Sebelum mengerjakan tiket(task di jira) **harus** membuat branch baru sesuai kode tiket
- Contoh mengerjakan *on-boarding* dengan kode tiket **BOED-12**
- Maka buat branch baru sesuai kode tiket dengan cara 
> git checkout -b **BOED-12/on-boarding**
- Untuk memastikan sudah pindah branch bisa dengan cara 
> git branch
- Pastikan asterisk(\*) berada di branch yg dituju sebelum mulai mengerjakan development

### Git Commit
Berikut adalah format pesan commit:
> type: description

- Sebelum melakukan commit tentukan dahulu jenis commitnya
- Jika melakukan perbaikan maka jenisnya adalah "fix"
- Sementara jika melakukan penambahan maka jenisnya adalah "feat"
- Lalu tinggal ditambahkan deskripsi apa yang telah dilakukan
- Sehingga jika melakukan penambahan fitur otentikasi bisa dilakukan dengan cara 
> git commit -m "feat: finish auth logic"
- Pastikan menggunakan kata kerja verb 1 untuk deskripsinya

### Git Push
- Setelah selesai commit bisa langsung melakukan push dengan cara
> git push
- Jika tiket sudah selesai dikerjakan bisa kembali ke branch main, sebelum branching lagi mengerjakan tiker lainnya

### Pull Request
- Setelah push code, agar bisa dimerge ke main branch, lakukan pull request
- Buka github repo project, lalu masuk ke tab pull request
- Buat pull request baru yang mencantumkan reviewer
- Silahkan tunggu pull request diterima atau ditolak
- Jika diterima maka branch akan dimerge ke main branch

## Code Convention

### Naming Convention
Ada beberapa convention untuk menamai, antara lain:

#### File Naming

- Use descriptive and meaningful names for your Swift files, following the same conventions as for variables and functions.
- Name files based on the primary purpose or content they represent.
- Consider using PascalCase for file names (e.g., UserProfileView.swift).

#### Variable Naming

- Use descriptive and meaningful names for variables, functions, and types to improve code readability and maintainability.
- Follow the Swift naming conventions, such as using camel case for variables and functions (e.g., myVariable, myFunction).
- Choose clear and concise names that accurately describe the purpose and role of each entity.

```swift
// Example
struct UserProfileView: View {
    ...
    var userFullName: String
    ...
    func updateProfile() {
        ...
    }
}
```

#### Enums and Constants

- Use uppercase camel case for enum types and constants.
- Enum cases should be lowercase, with each word separated by an underscore if needed.
- Constants should be named using descriptive words, providing clarity about their purpose.
- Consider using a namespace prefix for constants related to a specific module or feature.

```swift
// Example
enum UserStatus {
    case active
    case suspended
    case banned
}

let MaxRetryAttempts = 3
let APIEndpoint = "https://api.example.com"
```

#### Acronyms

- Treat acronyms as words in names, capitalizing only the first letter of the acronym.
- Avoid using all uppercase or lowercase acronyms in names, as they can reduce readability.

```swift
// Example
struct HTTPRequest {
    var method: String
    var url: String
}
```

#### Boolean Variables and Functions

- Name boolean variables and functions as a question or statement that can be answered with a true or false.
- Use clear and descriptive names to indicate the purpose of the boolean value or function.
- For conditional or ternary instead of doing it imperatively, please abstract it as a explicitly by extending or creating a constant. 


```swift
// Example
var isCompleted: Bool
var isProfileEmpty: Bool

func hasValidCredentials() -> Bool {
    ...
}

// Instead of this
if user === "student" {
    ...
}

// Do this
if user.isStudent {
    ...
}
```

#### Protocol Naming

- Use nouns or noun phrases to name protocols, representing the behavior or role they define.
- Prefer names that describe what the protocol does rather than how it is implemented.

```swift
// Example
protocol Authenticatable {
    func authenticate()
}
```

#### Avoid Abbreviations

- Minimize the use of abbreviations, as they can make code harder to understand and maintain.
- Use full words or descriptive names to improve clarity and readability.

```swift
// Example
struct UserProfile {
    var firstName: String
    var lastName: String
}
```

### Indentation and Spacing

- Use 4 spaces for indentation, as it is the recommended practice in Swift.
- Maintain consistent spacing and alignment to enhance code readability.
- Place a single space after colons and commas, but no space before them.
- Place opening and closing braces on their own lines.

```swift
// Example
struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .font(Font.title)
                .foregroundColor(Color.blue)
        }
    }
}
```

### Structure and Organization

- Group related code into separate extensions based on functionality or purpose to improve code organization and readability (e.g., Views, Helpers, Extensions).
- Use comments to separate different sections of code or to provide explanations when necessary.
- Arrange properties, functions, and initializers in a logical order to enhance code comprehension.

```swift
// Example
struct UserProfileView: View {
    // MARK: - Reactive Properties
    @State private var isProfileUpdated = false
    
    // MARK: - Non-reactive Properties
    var userFullName: String

    // MARK: - Body
    var body: some View {
        VStack {
            ...
        }
    }

    // MARK: - Methods
    func updateProfile() {
        ...
    }
}
```

### SwiftUI Specific Guidelines

- Use explicit parameter names for SwiftUI modifiers to improve readability and make code intentions clearer  (e.g., .foregroundColor(Color.red) instead of .foregroundColor(.red)).
- Avoid unnecessary force unwrapping of optionals. Instead, use null coalescing, optional binding, or optional chaining to handle optional values safely.
- Utilize SwiftUI's property wrappers like @State, @Binding, and @ObservableObject to manage state and data flow effectively.

```swift
// Example
struct ContentView: View {
    @State private var isShowingModal = false
    
    var placeholder: String?
    
    var body: some View {
        VStack {
            Button(placeholder ?? "Show Modal") {
                isShowingModal = true
            }
            .backgroundColor(Color.blue)
            .sheet(isPresented: $isShowingModal) {
                ModalView()
            }
        }
    }
}
```

### Error Handling

- Prefer the use of do-catch blocks for error handling instead of throwing functions, as it provides more control and flexibility in handling errors.
- When throwing an error, provide descriptive error messages to assist in debugging and troubleshooting.

```swift
// Example
func fetchData(completion: (Result<Data, Error>) -> Void) {
    do {
        let data = try fetchDataFromAPI()
        completion(.success(data))
    } catch {
        completion(.failure(error))
    }
}
```

### Code Documentation

- Use comments to document complex or non-obvious code sections, making it easier for others to understand your code.
- Document public functions, properties, and types using Swift's documentation comments (///) to generate documentation that can be easily accessed within Xcode.

```swift
// Example
/// Animation modifier will ignore later animation modifier
///
///     Circle("hallo world!")
///         .offset(x: animated: ? 0 : 70)
///         .animation(Animation.linear(duration: 0.5), value: animated)
///         .animation(Animation.linear(duration: 3), value: size)
///
/// In the example above the last animation configuration is ignored. The animation will be
/// linear in 0.5 sec duration instead of 3 sec
struct MultipleAnimationDepedency: View {
    ...
}
```
