import 'package:flutter/material.dart';

import '../models/portfolio_models.dart';

/// Edit this file to customize the whole portfolio.
abstract final class PortfolioData {
  static const String name = 'Bansi D.';
  static const String fullName = 'Bansi Dholakiya';
  static const String shortName = 'BD';
  static const String greeting = 'HELLO, THERE!';
  static const String location = 'Toronto, Canada';
  static const String email = 'bansidholakia@gmail.com';
  static const String github = 'https://github.com/bansidholakia';
  static const String linkedin = 'https://www.linkedin.com/in/bansi-dholakia/';
  static const String resumeUrl = 'https://example.com/resume.pdf';

  static const List<String> roles = <String>[
    'Software Developer',
    'Android Developer',
    'Flutter Developer',
    'Mobile Engineer',
  ];

  static const String heroLine =
      'I build polished, scalable mobile experiences with Kotlin, Flutter and React Native.';

  static const String about =
      'Mobile application developer passionate about building reliable, modern, and user-focused digital experiences. I enjoy turning complex requirements into intuitive products through clean architecture, reusable UI, and maintainable code, with a strong focus on performance, scalability, and cross-platform development.';

  static const List<String> hashtags = <String>[
    '#Kotlin',
    '#Java',
    '#Flutter',
    '#Dart',
    '#Android',
    '#JetpackCompose',
    '#KMP',
    '#ReactNative',
    '#Typescript',
    '#Swift',
    '#SwiftUI',
    '#MobileDevelopment',
  ];

  // Kept as three groups to match the visual structure of the reference site.
  static const List<SkillGroup> skillGroups = <SkillGroup>[
    SkillGroup(
      title: 'Languages & Databases',
      skills: <String>[
        'Kotlin',
        'Java',
        'Dart',
        'TypeScript',
        'JavaScript',
        'Node.js',
        'Swift',
        'Room',
        'SQLite',
        'Firebase',
        'MongoDB',
      ],
    ),
    SkillGroup(
      title: 'Platform & Frameworks & Libraries',
      skills: <String>[
        'Android SDK',
        'Flutter',
        'Jetpack Compose',
        'XML',
        'React Native',
        'iOS',
        'MVVM',
        'MVI',
        'Clean Architecture',
        'Coroutines',
        'Flow / StateFlow',
        'Retrofit',
        'Dio',
        'GraphQL',
        'OData',
        'OAuth 2.0',
        'Gson',
        'Dagger / Hilt',
        'Bloc',
        'Provider',
        'Riverpod',
        'GetX',
        'Get_it'
      ],
    ),
    SkillGroup(
      title: 'Tools',
      skills: <String>[
        'Android Studio',
        'VS Code',
        'Xcode',
        'Git',
        'GitHub',
        'GitHub Actions',
        'Postman',
        'Jira',
        'Bitbucket',
        'Confluence',
        'CI/CD',
        'Sourcetree',
        'AWS',
        'Figma',
        'Slack',
        'Github Copilot'
      ],
    ),
  ];

  static const List<Experience> experience = <Experience>[
    Experience(
      role: 'Mobile Application Developer',
      company: 'Freelance',
      period: '2024 — Present',
      location: 'Toronto, Canada',
      points: <String>[
        'Built reactive, responsive UI using Jetpack Compose and Material Design with reusable components, ViewModel, and lifecycle-aware state management.',
        'Architected an incremental Android-to-Kotlin Multiplatform migration, sharing domain, networking, state, and Compose Multiplatform UI across Android and iOS using Ktor, Room KMP, coroutines/Flow, and platform-specific integrations, while retaining native platform navigation and lifecycle boundaries.',
        'Built secure authentication and authorization flows using OAuth 2.0, OpenID Connect, biometrics, token-based access, Android Keystore, and encrypted local storage.',
        'Optimized application performance across startup, UI rendering, and network operations, reduced app startup by 50% via Android Studio Profiler and Firebase Performance Monitoring.',
        'Built offline-first architecture with Room database, enabled seamless backend synchronization.',
        'Used AI-assisted coding with OpenAI Codex and GitHub Copilot in daily development to accelerate delivery, generate tests, and improve code quality.',
        'Integrated Google Places and Android Location APIs for location-aware functionality, including geographic validation and restricting user login/access within configured location boundaries.',
      ],
    ),
    Experience(
      role: 'Senior Software Engineer',
      company: 'Tech Mahindra',
      period: '2022 — 2023',
      location: 'Mumbai, India',
      points: <String>[
        'Designed and developed scalable Android features using Kotlin, Jetpack Compose, and MVVM/Clean Architecture, applying clear separation of concerns across UI, domain, repository, and data layers.',
        'Implemented scalable dependency injection with Dagger and Hilt, reducing code complexity by 40%.',
        'Integrated backend services across REST, OData, and GraphQL with third-party APIs.',
        'Led a team of Android developers to build reusable native Android modules exposed to Flutter apps through method channels, enabling shared functionality across native and cross-platform codebases.',
        'Collaborated with product managers, designers, and backend developers, contributed to API documentation, mentored developers, and worked through pull requests and code reviews in Agile, Scrum, and Kanban.',
        'Wrote unit and integration tests (JUnit, Mockito, Espresso), troubleshot, debugged, and resolved production issues, and supported CI/CD pipelines releases with GitHub Actions.'
      ],
    ),
    Experience(
      role: 'Software Developer',
      company: 'Celusion Technologies',
      period: '2018 — 2022',
      location: 'Thane, India',
      points: <String>[
        'Developed and deployed secure banking/fintech apps with Java, Kotlin, XML that scaled to 500k+ users.',
        'Integrated Google Pay, Razorpay, PayPal, PayU payment gateways for transactions.',
        'Enhanced application security by implementing code obfuscation, encrypted data storage, and root detection to protect sensitive data and prevent unauthorized access.',
        'Reduced APK size by 30% through resource optimization, code shrinking, and dependency management.'
      ],
    ),
    Experience(
      role: 'Android Developer',
      company: 'Aegis Health Solution',
      period: '2018 — 2019',
      location: 'Mumbai, India',
      points: <String>[
        "Collaborated on developing and maintaining healthcare Android applications with 10k+ downloads, and built a pharmacy management app that streamlined pharmacists' daily operations.",
        "Implemented push notifications and in-app messaging, activity reminders, an in-app chatbot, Google Maps and Places API integration, and deep linking."
      ],
    ),
    Experience(
      role: 'Android Developer',
      company: 'Pragma Infotech',
      period: '2016 — 2017',
      location: 'Surat, India',
      points: <String>[
        'Developed a range of Android applications including Business Card Maker, Textagram, Kaka Parking for parking management, Sticky Notes, and Memory Game, catering to diverse user needs and preferences.'
      ],
    ),
  ];

  static const List<EducationItem> education = <EducationItem>[
    EducationItem(
      degree: 'Postgraduate Certificate',
      school: 'Centennial College, Toronto',
      period: '2023 — 2024',
      details: <String>[
        'Mobile Application Development',
        'GPA 4.4/4.5',
        'Courses: Android Development, iOS Development, Web Technologies, Cross-platform Application Development (Flutter & React Native), Enterprise Technologies, Mobile Application UI/UX Design, and Project Management Skills',
        'Learning Kotlin, Jetpeck Compose, SwiftUI, Obj-C, Dart(Flutter), React Native(Typescript & Javascript), API development, Room DB, MongoDB, Figma design, and Agile Methodology'
      ],
    ),
    EducationItem(
      degree: 'Bachelor of Engineering',
      school: 'Gujarat Technological University, India',
      period: '2012 — 2016',
      details: <String>[
        'Information Technology',
        'CGPA: 8.52/10',
      ],
    ),
  ];

  static const List<ProjectItem> projects = <ProjectItem>[
    ProjectItem(
      title: 'PNB Customer Portal',
      description:
      'Customer Portal is PNB Housing Finance’s official cross platform mobile application for its customers.',
      url: 'https://play.google.com/store/apps/details?id=com.pnbhfl.pnbhfl2',
      tags: <String>['Flutter', 'Dart', 'Provider', 'REST API', 'OAuth2', 'Firebase', 'Bloc', 'GitHub Actions'],
      icon: Icons.note_alt_outlined,
      imageAsset: 'assets/projects/img_2.png',
      projectIcon: 'assets/icons/pnb_cust_icon.webp',
    ),
    ProjectItem(
      title: '51East',
      description:
      'Ecommerce application and Qatar’s signature retail brand.',
      url: 'https://play.google.com/store/apps/details?id=com.darwish.fiftyoneeastapp',
      tags: <String>['Kotlin', 'Jetpeck Compose', 'MVVM', 'GraphQL', 'Clean Architecture', 'Coroutines', 'Flow', 'Hilt'],
      icon: Icons.shopping_bag_outlined,
      imageAsset: 'assets/projects/img_4.png',
      projectIcon: 'assets/icons/51East_icon.webp',
    ),
    ProjectItem(
      title: 'SwiftTrend',
      description:
      'Fully functional e-commerce App - CAPSTONE PROJECT',
      url: 'https://bitbucket.org/bunny30/swifttrend/src/develop/',
      tags: <String>['Flutter', 'Bloc', 'Provider', 'Node.js', 'MongoDB', 'TypeScript'],
      icon: Icons.folder_copy_outlined,
      imageAsset: 'assets/projects/img_1.png',
      projectIcon: 'assets/icons/swift_trend_icon.png',
    ),
    ProjectItem(
      title: 'PNB ACE RO',
      description:
      'PNB ACE onboarding to provide instant personal loan. This automates the end-to-end loan onboarding process - loan information collection & verification, lead creation and video KYC.',
      url: 'https://play.google.com/store/apps/details?id=com.pnbhfl.ace',
      tags: <String>['Kotlin', 'XML', 'Livedata', 'RxJava', 'REST API', 'OAuth2', 'OData','Location API'],
      icon: Icons.location_on_outlined,
      imageAsset: 'assets/projects/img_3.png',
      projectIcon: 'assets/icons/ace_icon.webp',
    ),
    ProjectItem(
      title: 'Fnac Qatar',
      description:
      'Fnac Qatar is your one-stop destination for all things culture, leisure and technology.',
      url: 'https://play.google.com/store/apps/details?id=com.darwish.fnac',
      tags: <String>['Flutter','Bloc','GetX','Clean Architecture','Firebase', 'Deep Links'],
      icon: Icons.notifications_active_outlined,
      imageAsset: 'assets/projects/img_9.png',
      projectIcon: 'assets/icons/fnac_icon.webp',
    ),
    ProjectItem(
      title: 'Ask Aqua Armor',
      description:
      'This is a mobile application for Aquaculture, anyone can consult Experts who are ready to help you online anytime.',
      url: 'https://play.google.com/store/apps/details?id=com.adityabirla.askaquaarmor',
      tags: <String>['Android', 'Java', 'XML', 'REST API', 'OAuth2', 'Retrofit'],
      icon: Icons.account_tree_outlined,
      imageAsset: 'assets/projects/img_10.png',
      projectIcon: 'assets/icons/aqua_icon.webp',
    ),
    ProjectItem(
      title: 'Adani Lead App',
      description:
      'This is a offline first banking lead generating mobile app.',
      url: 'https://play.google.com/store/apps/details?id=com.adani.lint',
      tags: <String>['Flutter','RiverPod', 'GraphQL', 'Sqflite', 'Firebase', 'OAuth2'],
      icon: Icons.account_tree_outlined,
      imageAsset: 'assets/projects/img_5.png',
      projectIcon: 'assets/icons/adani_icon.webp',
    ),
    ProjectItem(
      title: 'Hedon',
      description:
      'This is a E-commerce App for trending clothing brands.',
      url: 'https://github.com/30Bunny/MAPD711_Online_Shopping/tree/main',
      tags: <String>['Kotlin', 'XML', 'Firestore', 'MVVM', 'Coroutines', 'Flow'],
      icon: Icons.account_tree_outlined,
      imageAsset: 'assets/projects/img_7.png',
      projectIcon: 'assets/icons/android.png',
    ),
    ProjectItem(
      title: 'Medicalwale',
      description:
      'This is a Health|Beauty|Fitness app which provides pocket-friendly deals on your daily needs & healthcare solutions.',
      url: 'https://play.google.com/store/apps/details?id=com.medicalwale.medicalwale',
      tags: <String>['Android', 'JAVA', 'XML', 'FCM', 'Retrofit', 'RxJava', 'MVVM', 'Work Manager'],
      icon: Icons.account_tree_outlined,
      imageAsset: 'assets/projects/img_8.png',
      projectIcon: 'assets/icons/medicalwale_icon.webp',
    ),
    ProjectItem(
      title: 'Hotel Booking',
      description:
      'A Hotel Booking Mobile App.',
      url: 'https://github.com/30Bunny/Group9_MAPD721/tree/develop',
      tags: <String>['Kotlin', 'Jetpack compose' , 'Firebase'],
      icon: Icons.account_tree_outlined,
      imageAsset: 'assets/projects/img_6.png',
      projectIcon: 'assets/icons/android.png',
    ),
  ];
}
