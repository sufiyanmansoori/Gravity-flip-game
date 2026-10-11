from .otp_service import OTPService


class TwoFactorService:
    @staticmethod
    def issue(user):
        return OTPService.issue(user, 'two_factor')

    @staticmethod
    def verify(user, code):
        return OTPService.verify(user, 'two_factor', code)