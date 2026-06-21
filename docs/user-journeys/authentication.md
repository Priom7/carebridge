# Authentication and Account Journey

Status: Mock UI complete in UX-003  
Last updated: 2026-06-21

## Actors

- New caregiver creating an account
- Returning authenticated user
- User recovering access or managing account security

## Registration workflow

1. User opens the CareBridge welcome page.
2. User selects Get started.
3. User enters full name, email, phone, password, and password confirmation.
4. Client validates required fields, email shape, minimum password length, and confirmation.
5. Registration state becomes `verificationRequired`; guarded navigation redirects to verification.
6. User enters the six-digit email code. The deterministic UI demo accepts `123456`.
7. Invalid/expired code produces an inline error; resend produces a live-region confirmation.
8. Successful verification moves to required consent.
9. User must accept Terms/Privacy and explicit health-data storage consent. Notifications remain optional.
10. Successful consent changes state to authenticated and redirects to the caregiver dashboard.

## Sign-in workflow

1. Returning user selects Sign in from welcome.
2. User enters email and password.
3. Client validates input without disclosing whether an account exists.
4. Successful mock sign-in creates authenticated application state and redirects to Home.
5. BE-004 will replace the mock action with Firebase Authentication and server-side token verification.

## Password recovery

1. User selects Forgot password from sign-in.
2. User enters an email address.
3. The UI always returns the same response: “If an account exists, a reset link has been sent.”
4. The response is announced as a live region and does not reveal account membership.

## Account security

1. Authenticated user opens More → Account and security.
2. User can enable two-factor and biometric-unlock preferences.
3. User reviews current and other device sessions.
4. User revokes a device and receives confirmation.
5. Log out from all devices requires a destructive confirmation and returns to welcome.

## Privacy requests

1. User opens More → Privacy and data.
2. Request export queues a mock request and replaces the action with a status message.
3. Account deletion displays an irreversible-action warning and requires explicit confirmation.
4. Confirmed mock deletion signs the user out. BE-004/BE-013 will implement review periods, job states, identity reauthentication, audit, and secure deletion.

## States and guards

| State | Allowed destination | Other destinations |
|---|---|---|
| Unauthenticated | Welcome, sign-in, register, forgot | Redirect to welcome |
| Verification required | Verify | Redirect to verify |
| Consent required | Consent | Redirect to consent |
| Authenticated caregiver | Caregiver routes | Auth routes redirect home |
| Authenticated parent | Parent home | Caregiver routes redirect parent |

## Error, offline, and security rules

- Form errors are inline and do not destroy entered values.
- Verification expiration and resend are represented in the UI.
- Recovery wording prevents user enumeration.
- Password fields use obscured entry and platform autofill hints.
- Health details never appear on auth surfaces or notifications.
- Future network/offline failures use generic retry states and must not log tokens, passwords, codes, or health data.
- Sensitive account changes require recent authentication in BE-004.

## Acceptance evidence

- Registration test completes form → verification → required consent → dashboard.
- Recovery test verifies enumeration-safe success messaging.
- Account test enables 2FA, revokes a device, and queues export.
- Auth guards are exercised by the registration state transitions.
