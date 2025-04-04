struct UseCaseDIContainer {
    private let repositoryDIContainer: RepositoryDIContainer

    init(repositoryDIContainer: RepositoryDIContainer) {
        self.repositoryDIContainer = repositoryDIContainer
    }

    func makeFetchBooksUseCase() -> FetchBooksUseCase {
        DefaultFetchBooksUseCase(
            bookRepository: repositoryDIContainer.makeBookRepository()
        )
    }

    func makeManageExpandedStatesUseCase() -> ManageExpandedStatesUseCase {
        DefaultManageExpandedStatesUseCase(
            expandedStatesRepository: repositoryDIContainer.makeExpandedStatesRepository()
        )
    }

    func makeBookSummaryUseCase() -> BookSummaryUseCase {
        DefaultBookSummaryUseCase()
    }
}
