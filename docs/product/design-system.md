# CareBridge Design System 1.0

Status: Active  
Implemented by: UX-001  
Last updated: 2026-06-21

## Purpose

CareBridge serves remote caregivers and older dependent users. The interface must feel calm during routine care and remain unambiguous during missed reminders or requests for help. The system follows the supplied UI references without coupling tokens to individual screens.

## Brand assets

Flutter-ready assets live in `apps/mobile/assets/brand/`:

- `carebridge_horizontal_logo.png` for headers and brand identification
- `carebridge_symbol.png` for compact brand moments
- `carebridge_app_icon.png` as the source application icon

Keep clear space around the logo. Do not recolor, distort, crop, or place it on a background that compromises contrast.

## Color roles

| Token | Value | Use |
|---|---:|---|
| Trust blue | `#075CD6` | Primary actions, navigation, current/due state |
| Connection teal | `#09A9A2` | Secondary brand accent and connected-care concepts |
| Taken green | `#16A66A` | Confirmed/taken/resolved success |
| Attention amber | `#F3A51C` | Low stock and non-critical attention |
| Emergency red | `#E33B45` | Need Help, missed, destructive and urgent actions |
| Ink | `#10233F` | Primary light-theme text |
| Slate | `#53657D` | Secondary light-theme text |
| Canvas | `#F5F9FD` | Light application background |

Color never carries status alone. Every status includes a text label and, where useful, an icon. Emergency red is reserved so it retains meaning.

## Typography

The initial implementation uses the platform-safe Arial family while final multilingual font evaluation is pending UX-002. The scale is:

- Display: 36/40, weight 800
- Screen heading: 28/34, weight 800
- Section/card title: 20/25, weight 700
- Control title: 16/20, weight 700
- Body: 16/24
- Supporting body: 14/20
- Button: 15, weight 700; 18 in parent mode

All layouts must remain functional at 200% text scaling. Bangla font and line-height testing belongs to UX-002.

## Space, shape, and motion

- Spacing scale: 4, 8, 12, 16, 24, 32, 48
- Radius scale: 10 for controls, 16 for cards, 24 for hero surfaces, pill for badges
- Normal controls are at least 48 logical pixels high
- Parent-mode critical controls are at least 64 logical pixels high
- Motion is 160ms for feedback and 240ms for standard transitions
- Motion must not delay an emergency or reminder action

## Components implemented

- `CareButton`: primary, secondary, success, danger, and quiet roles; expanded and parent-size variants
- `CareCard`: consistent bordered content surface
- `StatusBadge`: active, due, warning, missed, and neutral semantic states
- Responsive application shell: bottom navigation below 840px and navigation rail at/above 840px
- Foundation/color tiles, metrics, medicine card, family card, empty state, inputs, adaptive switches, and parent reminder preview

## Content rules

- Use direct human language: “I took it,” “Remind me in 15 minutes,” “I need help.”
- Do not use medical diagnosis or treatment language.
- Do not promise delivery of alarms or emergency response.
- Lock-screen notification examples must remain generic.
- Explain destructive or privacy-sensitive actions before confirmation.

## Review checklist

- Brand asset is readable and correctly proportioned.
- Touch targets meet 48/64px minimums.
- Status includes words, not color alone.
- Light and dark theme roles remain readable.
- Compact layouts wrap rather than overflow.
- Parent mode reduces choices and raises target size.
- Screen-reader semantics identify buttons, statuses, and images.
