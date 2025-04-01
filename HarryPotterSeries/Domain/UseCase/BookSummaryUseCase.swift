protocol BookSummaryUseCase {
    func summary(for book: Book, isExpanded: Bool) -> (String, String)
}
