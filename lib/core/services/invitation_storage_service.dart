class InvitationStorageService {
  static String? _pendingInvitationCode;

  static void storeInvitationCode(String code) {
    print('🔗 InvitationStorageService: Storing invitation code: $code');
    _pendingInvitationCode = code;
  }

  static String? getPendingInvitationCode() {
    print('🔗 InvitationStorageService: Getting pending invitation code: $_pendingInvitationCode');
    return _pendingInvitationCode;
  }

  static void clearPendingInvitationCode() {
    print('🔗 InvitationStorageService: Clearing pending invitation code');
    _pendingInvitationCode = null;
  }
}
