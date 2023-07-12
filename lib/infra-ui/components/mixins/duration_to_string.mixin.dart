mixin DurationToString {
  String timeDiffToString(Duration duration) {
    final days = duration.inDays;
    final hours = duration.inHours - duration.inDays * 24;
    final minutes = duration.inMinutes - duration.inHours * 60;
    final seconds = duration.inSeconds - duration.inMinutes * 60;
    return [
      if (days > 0) "$days days",
      if (days > 0 && hours > 0) "and",
      if (hours > 0) "$hours hours",
      if (minutes > 0 && days == 0) "$minutes min",
      if (seconds > 0 && days == 0) "$seconds s",
    ].join(" ");
  }
}
