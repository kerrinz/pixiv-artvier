class OriginalLoadStatus {
  final bool isLoading;
  final double? progress; // 0~1, null = indeterminate
  final bool isLoaded;

  const OriginalLoadStatus({
    required this.isLoading,
    required this.progress,
    required this.isLoaded,
  });

  const OriginalLoadStatus.idle() : this(isLoading: false, progress: null, isLoaded: false);

  OriginalLoadStatus copyWith({
    bool? isLoading,
    double? progress,
    bool? isLoaded,
  }) {
    return OriginalLoadStatus(
      isLoading: isLoading ?? this.isLoading,
      progress: progress ?? this.progress,
      isLoaded: isLoaded ?? this.isLoaded,
    );
  }
}

