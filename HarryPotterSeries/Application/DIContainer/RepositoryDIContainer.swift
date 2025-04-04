struct RepositoryDIContainer {
    private let dataSourceDIContainer: DataSourceDIContainer

    init(dataSourceDIContainer: DataSourceDIContainer) {
        self.dataSourceDIContainer = dataSourceDIContainer
    }

    func makeBookRepository() -> BookRepository {
        DefaultBookRepository(
            bookDataSource: dataSourceDIContainer.makeBookDataSource(),
            bookMapper: makeBookMapper()
        )
    }

    func makeExpandedStatesRepository() -> ExpandedStatesRepository {
        DefaultExpandedStatesRepository(
            expandedStatesDataSource: dataSourceDIContainer.makeExpandedStatesDataSource()
        )
    }

    func makeBookMapper() -> BookMapper {
        BookMapper()
    }
}
