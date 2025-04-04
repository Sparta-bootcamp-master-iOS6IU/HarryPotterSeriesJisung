enum BookDataSourceError: Error {
    case invalidPath,
         jsonDecodingError,
         unknownError
}
