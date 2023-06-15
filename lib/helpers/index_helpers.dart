extension IndexHelpers on int {
  bool get isPrime {
    bool isPrime = true;
    if (this == 0) {
      return false;
    }
    if (this == 1) {
      return false;
    }
    for (int i = 2; i <= this / 2; ++i) {
      if (this % i == 0) {
        isPrime = false;
        break;
      }
    }
    return isPrime;
  }
}
