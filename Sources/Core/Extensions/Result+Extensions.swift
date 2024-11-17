extension Result where Success == Void {
    internal static var success: Result { .success(()) }
}
