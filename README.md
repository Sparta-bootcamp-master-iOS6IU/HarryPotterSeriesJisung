# 프로젝트 개요
프로젝트명: 로직에 UI를 더하다 (해리포터 책 시리즈 앱 프로젝트)  
개발 기간: 2025.03.26 ~ 2025.04.03  
사용 기술: Swift, UIKit, SnapKit  
주요 학습 목표: UIKit, SnapKit, MVC, MVVM, Clean Architecture  

# 프로젝트 구조
```bash
HarryPotterSeries
├── Application
│   ├── DIContainer
│   │   ├── AppDIContainer.swift
│   │   ├── DataSourceDIContainer.swift
│   │   ├── RepositoryDIContainer.swift
│   │   └── UseCaseDIContainer.swift
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
├── Data
│   ├── Helper
│   │   └── DateFormatterHelper.swift
│   ├── Mapper
│   │   └── BookMapper.swift
│   ├── Model
│   │   ├── Attributes.swift
│   │   ├── BookResponse.swift
│   │   ├── Chapter.swift
│   │   └── Datum.swift
│   ├── Repository
│   │   ├── DefaultBookRepository.swift
│   │   └── DefaultExpandedStatesRepository.swift
│   ├── Source
│   │   ├── Local
│   │   │   └── ExpandedStatesDataSource.swift
│   │   └── Remote
│   │       ├── BookDataSource.swift
│   │       └── BookDataSourceError.swift
│   ├── UseCase
│   │   ├── DefaultBookSummaryUseCase.swift
│   │   ├── DefaultFetchBooksUseCase.swift
│   │   └── DefaultManageExpandedStatesUseCase.swift
│   └── DataConstanat.swift
├── Domain
│   ├── Entity
│   │   └── Book.swift
│   ├── Repository
│   │   ├── BookRepository.swift
│   │   └── ExpandedStatesRepository.swift
│   └── UseCase
│       ├── BookSummaryUseCase.swift
│       ├── FetchBooksUseCase.swift
│       └── ManageExpandedStatesUseCase.swift
├── Presentation
│   ├── Main
│   │   ├── Component
│   │   │   ├── BookTitleLabel.swift
│   │   │   ├── SeriesOrderButton.swift
│   │   │   └── SummaryToggleButton.swift
│   │   ├── Extension
│   │   │   ├── UILabel+Extension.swift
│   │   │   ├── UIStackView+Extension.swift
│   │   ├── SubView
│   │   │   ├── BookDedicationView.swift
│   │   │   ├── BookDetailView.swift
│   │   │   ├── BookSummaryView.swift
│   │   │   └── ChapterView.swift
│   │   ├── MainViewController.swift
│   │   └── MainViewModel.swift
│   └── UIConstant.swift
├── Resource
│   ├── Assets.xcassets
│   ├── data.json
│   ├── Info.plist
│   └── LaunchScreen.storyboard
├── Util
    ├── AlertManager.swift
    ├── AppLogger.swift
    └── LoggingConstant.swift
```

---

프로젝트에 대한 더 자세한 내용은 [블로그](https://until.blog/@meowbutlerdev/-ios--%ED%95%B4%EB%A6%AC%ED%8F%AC%ED%84%B0-%EC%B1%85-%EC%8B%9C%EB%A6%AC%EC%A6%88-%EC%95%B1-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8)에서 확인할 수 있습니다!
