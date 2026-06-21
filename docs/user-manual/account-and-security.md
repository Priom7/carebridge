# Account and Security

## Create an account

1. Open CareBridge and select **Get started**.
2. Enter your name, email, phone number, and a password of at least eight characters.
3. Enter the verification code sent to your email. In the current demo, use `123456`.
4. Review and accept the Terms, Privacy Policy, and health-data consent.
5. Notification consent is optional and can be changed later.
6. Select **Finish setup**.

## Sign in or recover a password

Select **Sign in** on the welcome page and enter your email and password. If you cannot remember the password, select **Forgot password?**, enter your email, and follow the private reset link if one arrives.

CareBridge intentionally shows the same recovery message whether or not an account exists.

## Protect the app

Open **More → Account and security**:

- Turn on two-factor authentication for an extra sign-in step.
- Turn on biometric unlock to use the security supported by your device.
- Review devices that can access the account.
- Revoke a device you no longer recognize or use.
- Select **Log out from all devices** to end every session.

Two-factor, biometric, and device actions are interactive UI demonstrations until backend task BE-004 connects Firebase Authentication and real sessions.

## Export or delete data

Open **More → Privacy and data**:

- **Request export** prepares a secure copy of account data.
- **Delete my account** starts a permanent deletion request after confirmation and a safety review period.

The current UI demonstrates these request states. Production processing, identity reauthentication, download delivery, retention exceptions, and deletion audit arrive with the backend and release privacy work.

## Safety guidance

- Never share passwords or verification codes.
- Revoke unfamiliar devices and change the password.
- Use a device screen lock before enabling biometric app unlock.
- CareBridge support should never ask for your password or full verification code.
