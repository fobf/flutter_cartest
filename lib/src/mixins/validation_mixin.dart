class ValidationMixin {
  String? validateEmail(value) {
    if (value == null || value.isEmpty) {
      return 'Your email is empty';
    } else if (!value.contains('@') || !value.contains('.')) {
      return "Your email is not valid";
    } else if (value.length <= 6) {
      return "Your email is too short ";
    }
    return null;
  }

  String? validatePassword(value) {
    if (value == null || value.isEmpty) {
      return 'Your password is empty';
    } else if (value.length <= 6) {
      return "Your password is too short ";
    }

    return null;
  }

  String? validateUsername(value) {
    if (value == null || value.isEmpty) {
      return 'Your username is empty';
    } else if (value.length <= 6) {
      return "Your username is too short ";
    }

    return null;
  }
}
