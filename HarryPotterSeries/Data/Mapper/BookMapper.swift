struct BookMapper {
    /// `Attributes` 배열을 `Book` 도메인 모델 배열로 변환하는 메서드
    /// - Parameter attributes: `Attributes` 배열
    /// - Returns: `Book` 배열
    func mapToDomainModel(_ attributes: [Attributes]) -> [Book] {
        attributes.enumerated().map { index, book in
            let seriesOrder = "\(index + 1)"

            return Book(
                title: book.title,
                author: book.author,
                pages: "\(book.pages)",
                releaseDate: DateFormatterHelper.formatDateString(book.releaseDate),
                dedication: book.dedication,
                summary: book.summary,
                wiki: book.wiki,
                chapters: book.chapters.map { $0.title },
                seriesOrder: seriesOrder,
                image: DataConstant.imageFileNmaePrefix + seriesOrder
            )
        }
    }
}
