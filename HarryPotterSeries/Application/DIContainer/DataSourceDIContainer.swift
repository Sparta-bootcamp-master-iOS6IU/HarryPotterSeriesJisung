struct DataSourceDIContainer {
    func makeBookDataSource() -> BookDataSource {
        BookDataSource()
    }

    func makeExpandedStatesDataSource() -> ExpandedStatesDataSource {
        ExpandedStatesDataSource()
    }
}
