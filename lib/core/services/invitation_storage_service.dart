class InvitationStorageService {
  static String? _pendingInvitationCode;

  static void storeInvitationCode(String code) {
    _pendingInvitationCode = code;
  }

  static String? getPendingInvitationCode() {
    return _pendingInvitationCode;
  }

  static void clearPendingInvitationCode() {
    _pendingInvitationCode = null;
  }
}
