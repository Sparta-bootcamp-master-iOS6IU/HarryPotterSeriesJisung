final class AppDIContainer {
    let dataSourceDIContainer = DataSourceDIContainer()
    lazy var repositoryDIContainer = RepositoryDIContainer(dataSourceDIContainer: dataSourceDIContainer)
    lazy var useCaseDIContainer = UseCaseDIContainer(repositoryDIContainer: repositoryDIContainer)

    func makeMainViewModel() -> MainViewModel {
        MainViewModel(
            fetchBooksUseCase: useCaseDIContainer.makeFetchBooksUseCase(),
            manageExpandedStatesUseCase: useCaseDIContainer.makeManageExpandedStatesUseCase(),
            bookSummaryUseCase: useCaseDIContainer.makeBookSummaryUseCase()
        )
    }

    func makeMainViewController() -> MainViewController {
        MainViewController(mainViewModel: makeMainViewModel())
    }
}
