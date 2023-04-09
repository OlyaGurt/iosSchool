import Foundation

struct RegistrationViewData {
    let registrationTextFieldPlaceholder: String
    let enterLoginTextFielsPlaceholder: String
    let enterPasswordTextFielsPlaceholder: String
    let repeatPasswordTextFielsPlaceholder: String

    init() {
        registrationTextFieldPlaceholder = "Регистрация"
        enterLoginTextFielsPlaceholder = "Введите логин"
        enterPasswordTextFielsPlaceholder = "Введите пароль"
        repeatPasswordTextFielsPlaceholder = "Повторите пароль"
    }
}
