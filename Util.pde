long getDaysBetween(LocalDate dateBefore, LocalDate dateAfter) {
  return ChronoUnit.DAYS.between(dateBefore, dateAfter);
}
