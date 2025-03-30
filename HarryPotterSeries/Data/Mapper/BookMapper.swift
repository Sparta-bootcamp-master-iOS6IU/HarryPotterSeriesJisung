struct BookMapper {
    func mapToDomainModel(_ attributes: [Attributes]) -> [Book] {
        return attributes.enumerated().map { index, book in
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
