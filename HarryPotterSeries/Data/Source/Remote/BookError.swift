enum BookError: Error {
    case invalidPath,
         jsonDecodingError,
         unknownError
}
