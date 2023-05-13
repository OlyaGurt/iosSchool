import Foundation

struct AuthViewData {
    let loginTextFieldPlaceholder: String
    let enterLoginTextFielsPlaceholder: String
    let enterPasswordTextFielsPlaceholder: String

    init() {
        loginTextFieldPlaceholder = "Авторизуйтесь"
        enterLoginTextFielsPlaceholder = "Логин"
        enterPasswordTextFielsPlaceholder = "Пароль"
    }
}
