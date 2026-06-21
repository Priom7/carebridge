# Product Requirements Document

# CareBridge — Remote Family Health & Medicine Care App

## 1. Product Overview

### Product Name

**CareBridge**

### Tagline

**Remote family care, medicine reminders, and emergency support in one place.**

### Product Type

Cross-platform mobile application for **Android and iOS**, supported by a secure backend, caregiver dashboard, document vault, reminder engine, and notification/escalation system.

### Core Idea

CareBridge helps people living away from their family manage the health routines of loved ones, especially elderly parents. The app allows users to create profiles for family members, manage medicine schedules, upload prescriptions and reports, track doctor follow-ups, add emergency contacts, and receive alerts when a family member misses a medicine reminder or needs help.

The app should be highly scalable so that it is not limited to parents only. In the future, a user should be able to care for:

* Father
* Mother
* Wife/husband
* Brother
* Sister
* Children
* Grandparents
* In-laws
* Neighbours
* Domestic caregivers
* Any dependent person needing health support

---

## 2. Vision

To become a **remote family care operating system** for people who live far away from their loved ones but still want to stay connected to their health, medicine routine, checkups, prescriptions, reports, and emergency support network.

The first target use case is:

> A son living in the UK wants to remotely support his parents living in Bangladesh by tracking their medicines, doctor visits, reports, and emergency contacts.

The long-term product vision is:

> A secure, family-first health coordination platform for global families, elderly care, chronic condition support, and emergency response coordination.

---

## 3. Problem Statement

Many people live abroad while their parents or family members live in another country. They often depend on phone calls, WhatsApp messages, scattered prescriptions, and memory-based medicine routines. This creates several problems:

1. Parents may forget to take medicine on time.
2. The caregiver living abroad may not know whether medicine was taken.
3. Prescriptions, medical reports, and doctor notes are scattered across WhatsApp, paper files, and photo galleries.
4. Emergency contacts are not organised in one place.
5. In an emergency, the caregiver may not know who is closest to the parent.
6. Multiple family members may need to coordinate care, but there is no structured permission system.
7. Medicine stock, follow-up dates, test reports, and symptoms are difficult to track.
8. Timezone differences create confusion between caregiver and parent.

CareBridge solves these issues by creating a single family health management platform.

---

## 4. Target Users

### 4.1 Primary User: Remote Caregiver

Example: Sharif lives in the UK. His parents live in Bangladesh. He wants to:

* Add his father and mother as care profiles
* Track their medicines
* Receive missed medicine alerts
* Upload prescriptions and reports
* Add emergency contacts like relatives and neighbours
* Remotely ring/alarm the parent’s phone if medicine is missed
* See daily health updates
* Track doctor follow-ups

### 4.2 Secondary User: Parent / Dependent Person

The parent uses the app mainly to:

* Receive medicine reminders
* Tap “Taken”, “Snooze”, “Skip”, or “Need Help”
* View today’s medicines
* Call caregiver or emergency contact
* Upload documents if needed
* Complete simple health check-ins

### 4.3 Local Helper / Emergency Contact

This could be:

* Relative
* Neighbour
* Brother/sister
* Local cousin
* Family friend
* Building security guard
* Driver
* Domestic caregiver
* Nearby doctor assistant

They may receive emergency alerts or calls when the primary caregiver is far away.

### 4.4 Doctor / Medical Contact

Doctor profiles can be stored with:

* Name
* Speciality
* Hospital/chamber
* Phone number
* Follow-up date
* Consultation notes

Doctors may not need full app access in MVP, but the system should be designed so a doctor-facing access mode can be added later.

---

## 5. Product Goals

### 5.1 Business/Product Goals

1. Build a scalable family care app, not only a parent medicine reminder app.
2. Support multiple family members under one family account.
3. Provide reliable medicine reminders with caregiver visibility.
4. Provide a secure document vault for prescriptions and reports.
5. Provide an emergency contact system for local support.
6. Support remote caregiving across countries and timezones.
7. Create a foundation for future AI features such as prescription extraction, health summaries, and risk trend detection.
8. Design the app in a way that can later support subscription pricing, family plans, doctor integrations, pharmacy integrations, and elderly care services.

### 5.2 User Goals

The caregiver should be able to:

* Know whether parents took medicine on time
* Get alerts when medicine is missed
* Remotely trigger a ring/alarm reminder
* Store emergency contacts
* Store prescriptions and reports
* Track doctor follow-ups
* Add multiple family members
* See a health timeline
* Share care responsibility with siblings or relatives

The parent should be able to:

* Receive simple medicine reminders
* Confirm medicine easily
* Ask for help quickly
* Call caregiver or emergency contact
* Use the app without technical difficulty

---

## 6. Non-Goals

The first version of CareBridge should **not**:

1. Diagnose medical conditions.
2. Recommend medicine or dosage.
3. Replace doctors or emergency services.
4. Automatically change medicine schedules without human confirmation.
5. Claim to be a medical device.
6. Provide emergency ambulance dispatch as a guaranteed service.
7. Store unnecessary sensitive data.
8. Expose health information in push notification previews.

The product should be positioned as:

> A family health organisation, reminder, and coordination tool.

Not as:

> A medical diagnosis, treatment, or emergency healthcare service.

---

## 7. Key Product Principles

### 7.1 Family-First

The system should support parents, spouse, siblings, children, in-laws, and other dependents.

### 7.2 Elderly-Friendly

Parent mode must use large buttons, simple language, Bangla/English support, clear icons, and minimal navigation.

### 7.3 Remote-Care Ready

The app must handle timezone differences, cross-border care, and caregiver alerts.

### 7.4 Privacy by Design

Health data, emergency contacts, documents, and family information must be protected from day one.

### 7.5 Scalable Architecture

The system should support thousands or millions of users, multiple family groups, multiple dependents, and multi-role permissions.

### 7.6 Human Confirmation

Any AI or OCR-generated medicine extraction must require user confirmation.

---

# 8. Core Modules

## 8.1 Authentication & Account Management

### Features

* User registration
* Login
* Password reset
* Email/phone verification
* Optional two-factor authentication
* Device management
* Logout from all devices
* Account deletion
* Data export request

### User Types

* Caregiver
* Parent/dependent
* Emergency contact
* Local helper
* Admin
* Future: doctor/pharmacy/care organisation

### Requirements

* A user can belong to multiple family groups.
* A user can care for multiple people.
* A dependent person may or may not have their own login.
* Emergency contacts may be saved without requiring full app account access.
* Emergency contacts can later be invited to install the app.

---

## 8.2 Family Group Management

### Purpose

To allow the user to create a family care circle and add multiple people.

### Example

Family Group: **Sharif Family Care**

Members:

* Father — dependent profile
* Mother — dependent profile
* Sharif — primary caregiver
* Brother — secondary caregiver
* Neighbour — emergency contact
* Local cousin — emergency contact
* Family doctor — medical contact

### Functional Requirements

The caregiver can:

* Create a family group
* Rename family group
* Add family members
* Assign roles
* Set permissions
* Invite users by phone/email
* Remove users
* Archive inactive profiles
* Transfer ownership
* View family activity

### Relationship Types

* Father
* Mother
* Wife
* Husband
* Brother
* Sister
* Son
* Daughter
* Grandfather
* Grandmother
* Father-in-law
* Mother-in-law
* Uncle
* Aunt
* Cousin
* Neighbour
* Friend
* Doctor
* Nurse
* Caregiver
* Driver
* Other

---

## 8.3 Dependent / Care Profile Management

### Purpose

A care profile represents the person receiving support. This could be a parent, spouse, sibling, or any dependent person.

### Profile Fields

* Full name
* Preferred name
* Relationship
* Profile photo
* Date of birth / age
* Gender
* Blood group
* Phone number
* Address
* City
* Country
* Timezone
* Language preference
* Medical conditions
* Allergies
* Mobility notes
* Doctor notes
* Emergency instructions
* Primary caregiver
* Secondary caregiver
* Active/inactive status

### Example Profile

Name: Abdul Karim
Relationship: Father
Age: 59
Country: Bangladesh
Blood Group: B+
Conditions: High blood pressure, diabetes
Notes: Walks slowly, needs reminders after meals
Primary caregiver: Sharif
Emergency contact: Local neighbour

### Requirements

* One caregiver can manage multiple care profiles.
* One care profile can have multiple caregivers.
* Each care profile must have its own medicine list, documents, appointments, history, and emergency contacts.
* Caregiver must be able to switch between profiles quickly.
* Care profiles should support future modules like insurance, pharmacy, home nurse, wearable devices, and care plans.

---

# 9. Medicine Management Module

## 9.1 Purpose

To create, schedule, remind, track, and review medicines for each care profile.

## 9.2 Medicine Fields

* Medicine name
* Generic name
* Brand name
* Strength
* Form: tablet, capsule, syrup, injection, drops, inhaler, cream, other
* Dosage
* Quantity per dose
* Frequency
* Timing
* Food instruction: before food, after food, with food, empty stomach
* Start date
* End date
* Is long-term medicine?
* Prescribed by
* Linked doctor
* Linked prescription
* Medicine image
* Stock count
* Low stock threshold
* Notes
* Side effect notes
* Status: active, paused, completed, stopped

## 9.3 Scheduling Options

The system must support:

* Once daily
* Twice daily
* Three times daily
* Four times daily
* Every X hours
* Specific days of week
* Specific dates
* Weekly
* Monthly
* Before breakfast
* After breakfast
* Before lunch
* After lunch
* Before dinner
* After dinner
* Bedtime
* Custom time
* As needed
* Temporary course
* Long-term medicine

## 9.4 Medicine Reminder Actions

When a reminder appears, the parent can choose:

* Taken
* Snooze
* Skip
* Need help

When the caregiver views a reminder, they can:

* See status
* Send reminder
* Ring phone
* Send alarm
* Call parent
* Call emergency contact
* Mark as resolved
* Add note

## 9.5 Reminder Statuses

* Scheduled
* Due
* Taken
* Snoozed
* Skipped
* Missed
* Escalated
* Resolved
* Cancelled

## 9.6 Medicine History

Each medicine action must be recorded as an event.

Examples:

* Medicine created
* Reminder generated
* Reminder delivered
* Parent tapped Taken
* Parent snoozed
* Parent skipped
* Reminder missed
* Caregiver alerted
* Remote alarm sent
* Emergency contact notified
* Medicine completed
* Medicine paused
* Dosage updated

---

# 10. Reminder & Notification Module

## 10.1 Purpose

To remind the parent and notify caregivers when action is needed.

## 10.2 Reminder Types

* Medicine reminder
* Doctor appointment reminder
* Prescription renewal reminder
* Report upload reminder
* Lab test reminder
* Health check-in reminder
* Medicine refill reminder
* Emergency contact verification reminder
* Daily wellbeing reminder

## 10.3 Reminder Delivery Channels

MVP:

* In-app notification
* Push notification
* Local device notification

Future:

* SMS
* WhatsApp
* Automated phone call
* Email
* Smart speaker alert
* Wearable alert

## 10.4 Reminder Escalation Logic

Example:

1. Medicine due at 8:00 AM Bangladesh time.
2. Parent receives local notification.
3. If not confirmed in 10 minutes, parent receives a second reminder.
4. If not confirmed in 20 minutes, caregiver receives alert.
5. If not confirmed in 30 minutes, caregiver can tap “Ring Now”.
6. If still unresolved, emergency contact can be notified.
7. If parent taps “Need Help”, escalation starts immediately.

## 10.5 Remote Ring / Alarm

### Purpose

Allow caregiver to remotely trigger a louder reminder on the parent’s phone.

### Actions

Caregiver can tap:

* Ring Now
* Send Alarm
* Call Parent
* Notify Emergency Contact

### Parent Phone Behaviour

The parent app should show a full-screen alarm-style screen:

Message:

> Sharif is reminding you to take your medicine.

Buttons:

* Taken
* Snooze
* Call Sharif
* Need Help

### Requirements

* The app should use local notification + push notification strategy.
* The app should clearly ask parent permission for reminder/alarm settings.
* The system should track whether alarm was sent, delivered, opened, dismissed, or actioned.
* The system should not guarantee emergency delivery because mobile OS, internet, battery, silent mode, and permissions may affect delivery.
* The app should provide fallback actions such as call parent or call emergency contact.

---

# 11. Emergency Contacts Module

## 11.1 Purpose

Emergency Contacts is a first-class module that allows caregivers and family members to add trusted people who can be contacted during emergencies.

This is very important when the primary caregiver lives abroad and cannot physically reach the parent quickly.

## 11.2 Emergency Contact Types

The app should support different emergency contact categories:

* Relative
* Neighbour
* Brother
* Sister
* Son
* Daughter
* Cousin
* Uncle
* Aunt
* Friend
* Local caregiver
* Driver
* House helper
* Doctor
* Nurse
* Pharmacy
* Hospital
* Ambulance service
* Building security
* Other

## 11.3 Emergency Contact Fields

Each emergency contact profile should include:

* Full name
* Relationship to care profile
* Contact type
* Profile photo
* Primary phone number
* Secondary phone number
* WhatsApp number
* Email
* Address
* Distance from parent
* Availability
* Preferred contact method
* Can receive emergency alerts?
* Can receive medicine missed alerts?
* Can receive doctor visit alerts?
* Can access health records?
* Can view location?
* Notes
* Verification status
* Priority order

## 11.4 Contact Priority Levels

Emergency contacts should have priority levels:

### Priority 1 — Immediate Local Contact

Example: neighbour living next door.

### Priority 2 — Close Family Contact

Example: brother, sister, cousin.

### Priority 3 — Medical Contact

Example: doctor, nurse, pharmacy, clinic.

### Priority 4 — Backup Contact

Example: friend, distant relative, building security.

## 11.5 Emergency Contact Permissions

Each contact should have configurable permissions.

| Permission                    | Description                                  |
| ----------------------------- | -------------------------------------------- |
| Receive emergency alert       | Can receive urgent help alert                |
| Receive missed medicine alert | Can be notified if medicine is missed        |
| View basic profile            | Can see name, age, phone, address            |
| View medical summary          | Can see conditions, allergies, medicine list |
| View documents                | Can access prescriptions/reports             |
| Call parent                   | Can call parent from app                     |
| Call caregiver                | Can call primary caregiver                   |
| View location                 | Can see parent location if enabled           |
| Add notes                     | Can add emergency follow-up notes            |
| Resolve alert                 | Can mark emergency as handled                |

Default MVP should keep permissions simple:

* Emergency alert only
* Basic profile access
* Call parent/caregiver

Advanced medical document access should require explicit approval.

## 11.6 Emergency Contact Verification

The app should support contact verification.

Verification methods:

* Phone OTP
* WhatsApp confirmation
* Caregiver manual verification
* Parent approval
* App invitation accepted

Statuses:

* Added
* Invited
* Verified
* Active
* Inactive
* Removed

## 11.7 Emergency Alert Flow

When parent taps “Need Help”:

1. Primary caregiver receives immediate alert.
2. Caregiver can call parent.
3. If caregiver does not respond within configured time, Priority 1 contacts are notified.
4. If still unresolved, Priority 2 contacts are notified.
5. The app shows who has seen the alert.
6. Any authorised contact can mark “I am going to help”.
7. The caregiver sees live status.

Example status:

> Neighbour Rahim has accepted the emergency alert and is going to check on Father.

## 11.8 Missed Medicine Emergency Flow

If a medicine reminder is missed:

1. Parent receives reminder.
2. Parent receives snooze reminder.
3. Caregiver receives missed alert.
4. Caregiver can ring parent.
5. Caregiver can notify local emergency contact.
6. Emergency contact receives message:

> Medicine reminder needs attention for Abdul Karim. Please call or check if possible.

## 11.9 Emergency Contact Card UI

Each emergency contact card should show:

* Photo
* Name
* Relationship
* Distance/area
* Priority badge
* Available now / unavailable
* Call button
* WhatsApp button
* Alert button
* Permission badge

Example:

Name: Rahim Uddin
Relationship: Neighbour
Priority: 1
Location: Same building
Availability: Morning/evening
Actions: Call / WhatsApp / Send Alert

## 11.10 Emergency Contact Use Cases

### Use Case 1: Parent misses medicine

Sharif gets an alert. He cannot reach his father. He taps “Notify Neighbour”. The neighbour receives a call/SMS/push and checks on the father.

### Use Case 2: Parent taps Need Help

Mother taps “Need Help”. Sharif receives alert in the UK. Brother and local cousin also receive alert. Brother marks “I am calling her now”.

### Use Case 3: Doctor follow-up emergency

Father feels unwell after medicine. Sharif opens emergency contacts and calls the listed cardiologist.

### Use Case 4: Caregiver unavailable

Sharif is asleep due to UK/Bangladesh timezone difference. The app escalates the alert to local Priority 1 and Priority 2 contacts.

---

# 12. Document Vault Module

## 12.1 Purpose

To store all health-related documents in one secure place.

## 12.2 Document Types

* Prescription
* Blood test report
* Urine test report
* ECG
* X-ray
* MRI
* CT scan
* Ultrasound
* Discharge summary
* Doctor note
* Medicine photo
* Hospital bill
* Insurance document
* Follow-up note
* Other

## 12.3 Document Fields

* Document title
* Care profile
* Document type
* Doctor name
* Hospital/clinic
* Date
* Tags
* File
* Notes
* Uploaded by
* Visibility permissions
* Linked medicine
* Linked appointment
* Linked condition

## 12.4 Features

* Upload PDF/image
* Take photo from camera
* Categorise documents
* Search documents
* Filter by type/date/doctor
* Link prescription to medicine
* Share document with family member
* Download document
* Delete document
* Archive document
* View document history

## 12.5 Future AI Feature

Prescription OCR:

* Upload prescription
* Extract medicine names
* Extract dosage
* Extract timing
* Show draft medicine list
* User confirms before saving
* Store OCR confidence score
* Keep original prescription linked

Important rule:

> OCR should never automatically create final medicine schedules without caregiver confirmation.

---

# 13. Doctor & Appointment Module

## 13.1 Purpose

To manage doctor follow-ups, appointments, and visit history.

## 13.2 Doctor Fields

* Doctor name
* Speciality
* Hospital/clinic
* Phone number
* Email
* Address
* Visiting hours
* Notes
* Linked care profiles

## 13.3 Appointment Fields

* Care profile
* Doctor
* Appointment date/time
* Timezone
* Location
* Reason for visit
* Questions to ask doctor
* Required reports
* Appointment status
* Follow-up required?
* Follow-up date
* Visit summary
* Attachments

## 13.4 Appointment Statuses

* Scheduled
* Reminder sent
* Completed
* Missed
* Cancelled
* Rescheduled
* Follow-up required

## 13.5 Doctor Visit Pack

Before an appointment, the app should generate a summary:

* Current medicines
* Recent missed medicine history
* Recent BP/sugar logs
* Symptoms
* Recent uploaded reports
* Notes from caregiver
* Questions for doctor

This can be exported as PDF in future versions.

---

# 14. Health Checkup & Tracking Module

## 14.1 Purpose

To track simple health metrics and daily wellbeing.

## 14.2 Trackable Items

* Blood pressure
* Blood sugar
* Weight
* Temperature
* Heart rate
* Oxygen saturation
* Sleep quality
* Pain level
* Mood
* Walking status
* Tremor observation
* Fall incident
* Appetite
* Water intake
* Custom health metric

## 14.3 Daily Check-In

Parent can answer simple questions:

* Did you take your medicines today?
* Are you feeling okay?
* Any dizziness?
* Any fall?
* Any pain?
* Do you need a call?

Caregiver can configure check-in questions per care profile.

## 14.4 Health Timeline

The timeline should show:

* Medicine taken
* Medicine missed
* Symptoms logged
* Reports uploaded
* BP/sugar added
* Appointment completed
* Emergency alert triggered
* Contact notified
* Notes added

---

# 15. Roles & Permission System

## 15.1 Roles

### Primary Caregiver

Full access to care profiles, medicines, documents, contacts, reminders, and permissions.

### Secondary Caregiver

Can help manage medicines, reminders, appointments, and emergency contacts depending on permission.

### Parent / Dependent

Can receive reminders, confirm medicine, request help, view simple profile, and upload documents.

### Emergency Contact

Can receive emergency alerts and view limited information.

### Medical Contact

Can be stored as a contact and may later receive shared reports.

### Admin

Platform administrator with restricted operational access.

## 15.2 Permission Levels

* Full access
* Manage medicine
* Manage documents
* Manage appointments
* Manage emergency contacts
* View-only access
* Emergency-only access
* No document access
* Temporary access

## 15.3 Permission Requirements

* Every sensitive action should be logged.
* Document access should be explicitly granted.
* Emergency contacts should not automatically see full medical history.
* Users should be able to revoke access.
* Parents should be able to approve or reject access where appropriate.

---

# 16. Notification & Escalation Rules

## 16.1 Notification Types

* Medicine due
* Medicine missed
* Medicine taken
* Medicine skipped
* Snooze reminder
* Caregiver alert
* Emergency alert
* Emergency contact accepted alert
* Doctor appointment reminder
* Report upload reminder
* Refill reminder
* Daily summary

## 16.2 Notification Priority

### Low

General updates.

### Medium

Medicine due, appointment reminder.

### High

Medicine missed, repeated missed reminders.

### Critical / Emergency

Parent tapped Need Help, fall reported, caregiver manually triggered emergency.

## 16.3 Notification Privacy

Push notifications should avoid sensitive details.

Good:

> A care reminder needs attention.

Avoid:

> Father missed Metformin 500mg for diabetes.

Sensitive details should only be visible after secure app unlock.

---

# 17. User Journeys

## 17.1 Onboarding Journey

1. User downloads app.
2. User creates account.
3. User creates family group.
4. User adds father profile.
5. User adds mother profile.
6. User adds medicines.
7. User adds emergency contacts.
8. User enables reminders.
9. User invites family members.
10. Dashboard becomes active.

## 17.2 Add Medicine Journey

1. Select care profile.
2. Tap Add Medicine.
3. Enter medicine details.
4. Set schedule.
5. Set reminder method.
6. Add prescription if available.
7. Confirm schedule.
8. System generates reminder instances.
9. Parent receives reminders.

## 17.3 Add Emergency Contact Journey

1. Select care profile.
2. Open Emergency Contacts.
3. Tap Add Contact.
4. Choose contact type.
5. Enter name, phone, relationship, location, availability.
6. Set priority level.
7. Set permissions.
8. Send invitation/verification.
9. Contact becomes active after verification.

## 17.4 Missed Medicine Journey

1. Reminder sent to parent.
2. Parent does not respond.
3. App sends second reminder.
4. Reminder becomes missed.
5. Caregiver receives alert.
6. Caregiver taps Ring Now.
7. Parent phone rings.
8. Parent taps Taken.
9. Caregiver receives resolved notification.
10. History is updated.

## 17.5 Emergency Help Journey

1. Parent taps Need Help.
2. Primary caregiver gets urgent alert.
3. Emergency contacts are prepared for escalation.
4. Caregiver calls parent.
5. If no response, caregiver alerts neighbour.
6. Neighbour accepts alert.
7. Neighbour checks on parent.
8. Caregiver marks emergency as resolved.
9. Full event timeline is saved.

---

# 18. MVP Scope

## MVP Version 1.0

### Must Have

* User registration/login
* Family group creation
* Add father/mother/dependent profile
* Add medicine
* Medicine reminder schedule
* Parent reminder screen
* Taken/snooze/skip/need help actions
* Missed reminder alert to caregiver
* Emergency contacts module
* Add relatives/neighbours/doctors as emergency contacts
* Contact priority level
* Contact permission level
* Call/WhatsApp emergency contact
* Prescription/report upload
* Doctor appointment tracking
* Health timeline
* Basic dashboard
* Bangla/English language support
* Timezone support
* Secure file storage
* Push notification
* Local notification

### Should Have

* Remote ring/alarm
* Medicine stock tracking
* Low stock alert
* Daily health check-in
* Multiple caregivers
* Emergency escalation
* Appointment reminder
* Document categories
* Parent-friendly UI mode

### Could Have

* OCR prescription extraction
* AI health summary
* PDF doctor visit pack
* SMS fallback
* WhatsApp alert integration
* Voice reminder from caregiver
* Wearable integration
* Pharmacy refill support

### Not MVP

* Doctor portal
* Insurance integration
* AI diagnosis
* Payment/subscription
* Hospital integration
* Ambulance dispatch integration
* Full EHR integration

---

# 19. Future Scope

## Version 2.0

* AI prescription extraction
* Smart refill reminders
* Family care summary
* WhatsApp/SMS fallback
* Advanced emergency escalation
* Health trend graphs
* Doctor visit PDF
* Voice reminders
* Multi-language support
* Caregiver availability schedule

## Version 3.0

* Doctor portal
* Pharmacy integration
* Wearable device integration
* AI health assistant
* Family subscription plans
* Care organisation dashboard
* Country-specific emergency services
* Chronic condition care plans
* Predictive adherence analytics

---

# 20. Data Model

## 20.1 Main Entities

### users

* id
* name
* email
* phone
* password_hash
* preferred_language
* timezone
* status
* created_at
* updated_at

### family_groups

* id
* name
* owner_user_id
* country
* timezone
* status
* created_at
* updated_at

### family_group_members

* id
* family_group_id
* user_id
* role
* permissions
* status
* invited_at
* accepted_at
* created_at
* updated_at

### care_profiles

* id
* family_group_id
* full_name
* preferred_name
* relationship
* date_of_birth
* gender
* blood_group
* phone
* address
* country
* timezone
* language
* medical_conditions
* allergies
* notes
* primary_caregiver_id
* status
* created_at
* updated_at

### emergency_contacts

* id
* care_profile_id
* family_group_id
* full_name
* relationship
* contact_type
* profile_photo_url
* primary_phone
* secondary_phone
* whatsapp_number
* email
* address
* distance_note
* availability_note
* preferred_contact_method
* priority_level
* permissions
* verification_status
* can_receive_emergency_alerts
* can_receive_missed_medicine_alerts
* can_view_basic_profile
* can_view_medical_summary
* can_view_documents
* can_view_location
* notes
* status
* created_at
* updated_at

### medicines

* id
* care_profile_id
* name
* generic_name
* strength
* form
* dosage
* instructions
* prescribed_by
* prescription_document_id
* stock_count
* low_stock_threshold
* status
* created_at
* updated_at

### medicine_schedules

* id
* medicine_id
* care_profile_id
* frequency_type
* days_of_week
* times
* start_date
* end_date
* timezone
* before_or_after_food
* is_long_term
* status
* created_at
* updated_at

### reminder_instances

* id
* medicine_id
* schedule_id
* care_profile_id
* scheduled_at
* timezone
* status
* taken_at
* snoozed_until
* skipped_reason
* missed_at
* escalated_at
* resolved_at
* created_at
* updated_at

### notification_logs

* id
* family_group_id
* care_profile_id
* recipient_user_id
* recipient_contact_id
* notification_type
* channel
* title
* message_template
* status
* sent_at
* delivered_at
* opened_at
* failed_reason
* created_at
* updated_at

### alarm_requests

* id
* care_profile_id
* reminder_instance_id
* requested_by_user_id
* alarm_type
* status
* sent_at
* acknowledged_at
* resolved_at
* created_at
* updated_at

### documents

* id
* care_profile_id
* uploaded_by_user_id
* title
* document_type
* file_url
* file_size
* mime_type
* doctor_name
* hospital_name
* document_date
* tags
* notes
* visibility_permissions
* created_at
* updated_at

### doctors

* id
* family_group_id
* name
* speciality
* phone
* email
* hospital
* address
* notes
* created_at
* updated_at

### appointments

* id
* care_profile_id
* doctor_id
* appointment_datetime
* timezone
* location
* reason
* questions
* status
* followup_required
* followup_date
* visit_summary
* created_at
* updated_at

### health_logs

* id
* care_profile_id
* log_type
* value
* unit
* notes
* logged_by_user_id
* logged_at
* created_at
* updated_at

### audit_logs

* id
* actor_user_id
* family_group_id
* care_profile_id
* action
* entity_type
* entity_id
* metadata
* ip_address
* device_id
* created_at

---

# 21. API Requirements

## 21.1 Authentication

* POST /auth/register
* POST /auth/login
* POST /auth/logout
* POST /auth/forgot-password
* POST /auth/verify-phone
* POST /auth/refresh-token

## 21.2 Family Groups

* POST /family-groups
* GET /family-groups
* GET /family-groups/{id}
* PATCH /family-groups/{id}
* DELETE /family-groups/{id}

## 21.3 Care Profiles

* POST /care-profiles
* GET /care-profiles
* GET /care-profiles/{id}
* PATCH /care-profiles/{id}
* DELETE /care-profiles/{id}

## 21.4 Medicines

* POST /care-profiles/{id}/medicines
* GET /care-profiles/{id}/medicines
* GET /medicines/{id}
* PATCH /medicines/{id}
* DELETE /medicines/{id}

## 21.5 Reminders

* GET /care-profiles/{id}/reminders
* POST /reminders/{id}/taken
* POST /reminders/{id}/snooze
* POST /reminders/{id}/skip
* POST /reminders/{id}/need-help
* POST /reminders/{id}/ring
* POST /reminders/{id}/resolve

## 21.6 Emergency Contacts

* POST /care-profiles/{id}/emergency-contacts
* GET /care-profiles/{id}/emergency-contacts
* GET /emergency-contacts/{id}
* PATCH /emergency-contacts/{id}
* DELETE /emergency-contacts/{id}
* POST /emergency-contacts/{id}/verify
* POST /emergency-contacts/{id}/invite
* POST /emergency-contacts/{id}/notify

## 21.7 Emergency Alerts

* POST /care-profiles/{id}/emergency-alerts
* GET /care-profiles/{id}/emergency-alerts
* POST /emergency-alerts/{id}/accept
* POST /emergency-alerts/{id}/resolve
* POST /emergency-alerts/{id}/escalate

## 21.8 Documents

* POST /care-profiles/{id}/documents
* GET /care-profiles/{id}/documents
* GET /documents/{id}
* DELETE /documents/{id}
* POST /documents/{id}/share

## 21.9 Appointments

* POST /care-profiles/{id}/appointments
* GET /care-profiles/{id}/appointments
* PATCH /appointments/{id}
* DELETE /appointments/{id}

## 21.10 Health Logs

* POST /care-profiles/{id}/health-logs
* GET /care-profiles/{id}/health-logs

---

# 22. Recommended Tech Stack

## Mobile App

Recommended:

* React Native
* TypeScript
* Expo or bare React Native depending on notification/alarm complexity
* React Navigation
* Zustand or Redux Toolkit
* React Query
* Local notification library
* Secure storage
* Camera/document picker

Alternative:

* Flutter with Dart

## Backend

Recommended:

* Laravel API
* PostgreSQL
* Redis
* Laravel Queue
* Laravel Horizon
* Laravel Sanctum or Passport
* S3-compatible file storage
* WebSocket server for realtime alerts

## Notification

* Firebase Cloud Messaging
* Apple Push Notification Service through FCM/APNs
* Local notifications on device
* Future SMS/WhatsApp/call provider

## Admin Dashboard

* Laravel Filament
  or
* Next.js admin dashboard

## Infrastructure

* AWS, DigitalOcean, or GCP
* Docker
* CI/CD with GitHub Actions
* Object storage for documents
* CDN for static assets
* Database backups
* Monitoring/logging

---

# 23. Non-Functional Requirements

## 23.1 Scalability

The system should support:

* Multiple family groups per user
* Multiple care profiles per family group
* Multiple caregivers per profile
* Multiple emergency contacts per profile
* Multiple medicines and reminders per day
* Millions of reminder records
* Document storage growth
* High notification volume
* Future multi-country support

## 23.2 Reliability

* Reminder generation should be queue-based.
* Missed reminder checks should run frequently.
* Local notifications should work even when internet is weak.
* Cloud notifications should sync status back to server.
* Failed notifications should be retried.
* Critical events should be logged.

## 23.3 Performance

* Dashboard load under 2 seconds for normal users.
* Medicine list load under 1 second after cache.
* Reminder action should update instantly.
* Emergency alert should be sent as fast as possible.
* Document upload should support progress indicator.

## 23.4 Security

* Encrypted transport using HTTPS.
* Encrypted file storage.
* Signed document URLs.
* Role-based access control.
* Audit logs.
* Device token management.
* Optional 2FA.
* Biometric/PIN app lock.
* Minimal data in notifications.
* Secure deletion process.
* Access revocation.

## 23.5 Privacy

* Explicit consent for storing health data.
* Clear privacy policy.
* User can export data.
* User can delete account.
* Emergency contact permissions should be transparent.
* Parents should know who can access their information.
* Sensitive data should not be exposed on lock screen notifications.

## 23.6 Accessibility

* Large buttons
* High contrast
* Bangla/English support
* Voice reminder support in future
* Simple parent mode
* Minimal text on reminder screen
* Clear icons
* Support for older users

---

# 24. Analytics & Success Metrics

## 24.1 Product Metrics

* Number of registered caregivers
* Number of family groups created
* Number of care profiles created
* Number of medicines added
* Number of reminders generated
* Reminder completion rate
* Missed reminder rate
* Emergency contacts added per care profile
* Emergency alerts triggered
* Documents uploaded
* Appointments created
* Daily active users
* Weekly active users
* Retention rate

## 24.2 Care Metrics

* Medicine adherence percentage
* Average response time to reminders
* Average caregiver response time
* Number of escalations resolved
* Number of emergency contacts notified
* Number of low-stock alerts resolved
* Number of completed doctor follow-ups

## 24.3 Technical Metrics

* Push delivery success rate
* Reminder generation success rate
* Notification failure rate
* API response time
* Crash-free sessions
* Upload failure rate
* Queue failure count

---

# 25. Acceptance Criteria

## 25.1 Family Profile

* User can create a family group.
* User can add father, mother, wife, brother, sister, or other member.
* User can assign relationship and role.
* User can view all family members in one dashboard.

## 25.2 Medicine Reminder

* User can add medicine with schedule.
* Parent receives reminder at correct local time.
* Parent can mark medicine as taken.
* Caregiver can see medicine status.
* Missed reminders trigger caregiver alert.
* Reminder history is saved.

## 25.3 Emergency Contact

* User can add emergency contact.
* User can set contact type, relationship, priority, and permissions.
* User can call emergency contact from app.
* User can notify emergency contact during emergency.
* Emergency contact activity is logged.
* Emergency contact can be activated/deactivated.

## 25.4 Document Vault

* User can upload prescription/report.
* User can link document to care profile.
* User can filter documents by type.
* User can view document securely.
* User can delete document.

## 25.5 Doctor Follow-Up

* User can add doctor.
* User can create appointment.
* User receives appointment reminder.
* Appointment appears in health timeline.

## 25.6 Security

* Unauthorised users cannot access care profile.
* Emergency contacts cannot view documents unless permitted.
* All sensitive actions are logged.
* Health details are not shown in notification preview by default.

---

# 26. Risks & Mitigation

## Risk 1: Notifications may not always fire reliably

Mitigation:

* Use local notifications plus cloud push.
* Ask for correct device permissions.
* Show reminder health check in settings.
* Provide fallback call/WhatsApp action.

## Risk 2: Elderly parents may not use app properly

Mitigation:

* Parent mode with simple UI.
* Large buttons.
* Voice reminders.
* Minimal setup required.
* Caregiver can manage everything remotely.

## Risk 3: Privacy concerns around health data

Mitigation:

* Consent-first design.
* Role-based permissions.
* Encrypted storage.
* Minimal notification data.
* Data export/delete options.

## Risk 4: Emergency contacts may ignore alerts

Mitigation:

* Priority order.
* Multiple contacts.
* Escalation.
* Show who accepted alert.
* Fallback phone call.

## Risk 5: Medicine mistakes from OCR

Mitigation:

* OCR only creates draft.
* Human confirmation required.
* Show confidence score.
* Keep original prescription attached.

---

# 27. Monetisation Options

## Free Plan

* 1 family group
* 2 care profiles
* Basic medicine reminders
* Basic emergency contacts
* Limited document storage

## Family Plus

* Unlimited family members
* Multiple caregivers
* Advanced emergency escalation
* More document storage
* Medicine stock tracking
* Doctor visit summaries

## Premium Care

* AI prescription extraction
* AI daily health summary
* WhatsApp/SMS fallback
* PDF doctor visit pack
* Advanced analytics
* Priority support

## B2B Future

* Elderly care homes
* Clinics
* Pharmacies
* Remote care agencies
* Insurance partners

---

# 28. Suggested MVP Development Phases

## Phase 1: Foundation

* Auth
* Family group
* Care profiles
* Role structure
* Basic dashboard

## Phase 2: Medicine Reminder

* Medicine CRUD
* Schedule builder
* Reminder instances
* Parent reminder screen
* Taken/snooze/skip
* Missed alert

## Phase 3: Emergency Contacts

* Add contacts
* Priority levels
* Permissions
* Call/WhatsApp action
* Emergency alert flow
* Alert history

## Phase 4: Documents & Appointments

* Document upload
* Document categories
* Doctor profiles
* Appointment reminders
* Health timeline

## Phase 5: Advanced Caregiver Features

* Remote ring/alarm
* Daily check-in
* Low stock alert
* Multiple caregiver invitations
* Notification preferences

## Phase 6: AI & Automation

* Prescription OCR
* AI care summary
* Doctor visit pack
* Health trend alerts
* Voice reminders

---

# 29. Example Dashboard Content

## Caregiver Dashboard

Today:

* Father: 4 medicines due
* Mother: 3 medicines due
* Missed reminders: 1
* Upcoming appointment: Father, cardiologist, 25 June
* Reports uploaded this week: 2
* Emergency contacts active: 5

Quick actions:

* Add medicine
* Ring parent
* Upload report
* Add emergency contact
* Book follow-up
* View timeline

## Parent Dashboard

Today:

* Morning medicine
* Afternoon medicine
* Night medicine
* Call Sharif
* Need help
* Upload report

---

# 30. Final Product Positioning

CareBridge should be positioned as:

> A remote family care app for medicine reminders, health records, doctor follow-ups, and emergency contacts.

The key differentiator is:

> Designed for people living abroad who want to care for parents and family members back home.

The app should not be limited to one parent or one patient. It should be built around a flexible **Family Care Graph**, where any user can care for multiple family members with different roles, permissions, reminders, documents, and emergency contacts.

The emergency contact system should be treated as one of the most important modules because it solves a real-world problem: when the primary caregiver is far away, the app must help connect the parent with trusted people nearby.

CareBridge’s long-term potential is strong because it can grow from a simple medicine reminder app into a complete remote family health coordination platform.
