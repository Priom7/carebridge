# Family Care Circle

## Create your care circle

After creating and verifying an account:

1. Enter a name for the family group.
2. Select the people you initially care for.
3. Optionally enter another caregiver’s email.
4. Review their starting permissions.
5. Review the family summary and select **Create family**.

Father and Mother are quick onboarding choices. Complete profile details and other relationships are added through the Care Profiles workflow.

## Invite a caregiver

An invitation does not grant immediate access. The recipient must accept it. Until then, its status is **Pending**. You can revoke a pending invitation if it was sent to the wrong address.

## Manage permissions

Open **More → Manage family**, open a secondary caregiver’s menu, and select **Edit permissions**. Medicine, document, appointment, and emergency-contact permissions are independent.

Document access is off by default. Enable it only when the person needs access to prescriptions or reports.

## Remove access

Select **Remove access** from a secondary caregiver’s menu and confirm. Production removal will sign that person out of the family group and revoke their server access. The current UI demonstrates the complete confirmation and status workflow with mock data.

## Transfer ownership

Select **Transfer ownership** for an accepted secondary caregiver. Read the warning carefully: the selected person becomes Owner, while the current Owner becomes a secondary caregiver.

Ownership transfer is a sensitive action. The backend version will require recent authentication and keep an immutable audit record.
