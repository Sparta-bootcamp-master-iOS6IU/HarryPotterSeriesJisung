struct BookMapper {
    /// `Attributes` 배열을 `Book` 도메인 모델 배열로 변환하는 메서드
    ///
    /// - Parameter attributes: 변환할 `Attributes` 배열
    /// - Returns: 변환된 `Book` 배열
    func mapToDomainModel(_ attributes: [Attributes]) -> [Book] {
        attributes.enumerated().map { index, attribute in
            let seriesOrder = "\(index + 1)"

            return Book(
                title: attribute.title,
                author: attribute.author,
                pages: "\(attribute.pages)",
                releaseDate: DateFormatterHelper.formatDateString(attribute.releaseDate),
                dedication: attribute.dedication,
                summary: attribute.summary,
                wiki: attribute.wiki,
                chapters: attribute.chapters.map(\.title),
                seriesOrder: seriesOrder,
                image: DataConstant.imageFileNamePrefix + seriesOrder
            )
        }
    }
}
