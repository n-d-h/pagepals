class ResponseResultCode {
  static String getMoMoResultCode(String resultCode) {
    switch (resultCode) {
      case '0':
        return 'You have successfully payment.';
      case '1002':
        return 'Transaction rejected by the issuers of the payment methods.';
      case '1004':
        return 'Transaction failed because the amount exceeds daily /monthly payment limit.';
      case '1006':
        return 'Transaction failed because user has denied to confirm the payment.';
      default:
        return 'Unknown error.';
    }
  }
}
