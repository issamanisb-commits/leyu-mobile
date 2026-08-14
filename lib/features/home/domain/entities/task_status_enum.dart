enum TaskStatus {
  TEST_NOT_STARTED,
  TEST_UNDER_REVIEW,
  TEST_REJECTED,

  NOT_STARTED,
  REJECTED,
  UNDER_REVIEW,
}

TaskStatus? parseTaskStatus(String? status, bool isTestTask) {
  switch (status) {
    case 'TEST_UNDER_REVIEW':
      return TaskStatus.TEST_UNDER_REVIEW;
    case 'TEST_REJECTED':
      return TaskStatus.TEST_REJECTED;
    case 'REJECTED':
      return TaskStatus.REJECTED;
    case 'UNDER_REVIEW':
      return TaskStatus.UNDER_REVIEW;
    default:
      return isTestTask ? TaskStatus.TEST_NOT_STARTED : TaskStatus.NOT_STARTED;
  }
}
