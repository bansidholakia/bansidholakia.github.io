# Flutter Portfolio

Responsive one-page Flutter portfolio.

## Current UI

- Fixed navigation bar at the very top on web/desktop
- Right-side navigation drawer on mobile
- Responsive Home, About, Resume, Portfolio and Contact sections
- Key Skills split into three reference-style groups
- Desktop work-experience timeline rail while preserving the card layout
- Education timeline
- Large project images with hover overlays on web and tap-to-open links
- Mobile-friendly project overlays where hover is not available

## Customize your content

Most content lives in:

`lib/data/portfolio_data.dart`

Change your:

- Name / short name
- Email / location
- GitHub / LinkedIn / résumé URL
- Roles and About text
- Three skill groups
- Work experience
- Education
- Project descriptions, tags, image assets and URLs

Project artwork is stored in:

`assets/projects/`

Replace the sample PNG files with screenshots of your actual apps and keep the same asset paths, or update `imageAsset` for each project in `portfolio_data.dart`.

## Run

```bash
flutter pub get
flutter run -d chrome
```

For Android or iOS, select the desired Flutter device and run normally.

### Happy Coding!
# Bansi-Portfolio
