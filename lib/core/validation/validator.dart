class Validator {
  // Email Validation
  static String? validateEmail(String value) {
    const emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regex = RegExp(emailPattern);

    if (value.isEmpty) {
      return 'Email is required';
    } else if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // Password Validation
  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password should be at least 6 characters long';
    }
    return null;
  }

  static String? validatePhone(String value) {
    // Regular expression to match phone numbers starting with 6, 7, 8, or 9, and exactly 10 digits
    const phonePattern = r'^[6-9]\d{9}$';
    final regex = RegExp(phonePattern);

    if (value.isEmpty) {
      return 'Phone number is required';
    } else if (!regex.hasMatch(value)) {
      return 'Enter a valid 10-digit phone number';
    }
    return null;
  }

  // General required field check
  static String? validateRequired(String value, String fieldName) {
    if (value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }
}
