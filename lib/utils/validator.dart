class FormValidator {
  String? isNotEmpty(String? data) {
    return (data?.isNotEmpty ?? false)
        ? null
        : ValidatorMessage().emptyInputText;
  }
}

class ValidatorMessage {
  final String emptyInputText = "Username can't be empty";
}
