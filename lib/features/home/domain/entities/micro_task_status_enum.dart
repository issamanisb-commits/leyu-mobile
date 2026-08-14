enum MicroTaskStatus {
  NOT_STARTED,
  UNDER_REVIEW,
  APPROVED,
  REJECTED,
}

MicroTaskStatus parseTaskStatus(String? status) {
  switch (status) {
    case 'NOT_STARTED':
      return MicroTaskStatus.NOT_STARTED;
    case 'PENDING':
      return MicroTaskStatus.UNDER_REVIEW;
    case 'APPROVED':
      return MicroTaskStatus.APPROVED;
    case 'REJECTED':
      return MicroTaskStatus.REJECTED;
    default:
      return MicroTaskStatus.NOT_STARTED;
  }
}
