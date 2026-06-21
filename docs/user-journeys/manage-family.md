# Manage Family, Roles, and Permissions Journey

Status: Mock UI complete in UX-004  
Last updated: 2026-06-21

## Preconditions

- User is authenticated and onboarding is complete.
- User has Owner permission for the active family group.

## Member and invitation workflow

1. Owner opens More → Manage family.
2. Members are grouped by role: Owner, Secondary caregiver, and Dependent.
3. Invitations show Pending, Accepted, Revoked, or Expired with text and color.
4. The deterministic UI can simulate acceptance so the complete role workflow is demonstrable before backend delivery.
5. Accepted secondary caregiver appears in the member list.

## Edit permissions

1. Owner opens the secondary caregiver menu.
2. Owner selects Edit permissions.
3. Owner independently configures medicine, document, appointment, and emergency-contact management.
4. Save updates the member and appends an auditable activity event.
5. Document access remains denied unless explicitly enabled.

## Revoke invitation or access

- A pending invitation can be revoked after confirmation; the link stops working immediately.
- An accepted secondary caregiver can have access removed after destructive confirmation.
- The current Owner cannot be removed.
- Backend implementation will revoke server sessions/tokens and active realtime subscriptions in addition to membership.

## Transfer ownership

1. Owner selects Transfer ownership for a secondary caregiver.
2. UI explains that the recipient gains group control and the current owner becomes a secondary caregiver.
3. Explicit confirmation changes both roles atomically and writes an activity event.
4. BE-005 will require recent authentication, accepted membership, conflict protection, and immutable audit logging.

## Security rules

- Emergency-only contacts are not family caregivers and never inherit document access.
- Permission summaries must use plain language.
- Revoked/removed people cannot continue reading cached sensitive content after backend integration.
- All ownership and permission mutations are sensitive audit events.

## Acceptance evidence

- Widget workflow accepts an invitation, enables document permission, and transfers ownership.
- Widget workflow revokes a pending invitation with confirmation.
- English/Bangla role, state, permission, warning, and activity labels are generated from ARB files.
