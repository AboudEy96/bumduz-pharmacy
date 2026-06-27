# Bumduz Pharmacy Design Style Guide

This file defines the visual direction Codex should follow when building or improving UI in this Flutter app.

## Brand Feel

Bumduz Pharmacy should feel like a modern, reliable, friendly healthcare product.

Keywords:

- Clean
- Calm
- Trustworthy
- Medical
- Modern
- Simple
- Premium
- Student-project friendly but MVP-quality

## Visual Style

Use a modern healthcare style:

- Light backgrounds with teal/green accents.
- Optional soft blue accents for patient-related sections.
- White cards on light backgrounds.
- Rounded corners between 16 and 24.
- Soft shadows, not heavy black shadows.
- Clear icons.
- Comfortable spacing.
- Large readable headings.
- Avoid clutter.

## Recommended Color Direction

Primary direction:

- Teal / medical green for primary actions.
- White and very light gray backgrounds.
- Dark navy or charcoal text.
- Soft red/orange only for warnings or urgent reminders.

Avoid:

- Random bright colors.
- Too many colors on one screen.
- Low contrast text.
- Heavy gradients everywhere.

## Typography Direction

- Use clear section titles.
- Use medium or semi-bold weights for important labels.
- Keep body text readable.
- Avoid tiny text on mobile.
- Use hierarchy: title, subtitle, card title, body, caption.

## Layout Rules

- Use consistent page padding, usually 16 or 20.
- Use vertical spacing between sections.
- Cards should have clear internal padding.
- Important actions should be easy to reach.
- Empty states should tell the user what to do next.
- Forms should have clear labels, hints, and validation.

## Animation Personality

Animations should feel smooth and professional, similar to a premium mobile app.

Use:

- Fade-in on screen entry.
- Slight upward slide for main content.
- Staggered cards in dashboard/list screens.
- Subtle scale feedback on buttons/cards.
- Smooth transitions for changing states.

Avoid:

- Excessive bounce.
- Spinning elements without purpose.
- Long delays.
- Animations that hide the actual content.

## Screen-Specific Guidance

### Login Screen

- Clean centered layout.
- App name and short subtitle.
- Clear role selection if patient/pharmacist is needed.
- Strong primary login button.
- Friendly error messages.

### Patient Home

- Greeting card.
- Medicine summary.
- Reminder summary.
- Quick actions.
- Empty state if no medicines exist.

### Pharmacist Home

- Dashboard-style overview.
- Medicine management card.
- Patient/order related cards when available.
- Clear add/manage actions.

### Medicine Cards

Each medicine card should show:

- Medicine name.
- Dose/frequency.
- Time/reminder information if available.
- Status or next action.
- Clean icon and color accent.

## Component Examples Codex Should Prefer

When useful, create widgets like:

```dart
class AnimatedPageWrapper extends StatelessWidget {
  final Widget child;
  const AnimatedPageWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 24 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
```

Use this kind of animation carefully and reuse it across screens when appropriate.
