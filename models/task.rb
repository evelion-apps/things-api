class Task < ActiveRecord::Base
  self.table_name = "TMTask"
  self.primary_key = "uuid"

  validates :uuid, presence: true

  # NOTE: output of `.schema TMTask` from `sqlite3` as of October, 2021:
  #
  # CREATE TABLE IF NOT EXISTS 'TMTask' (
  #   'uuid'                 TEXT PRIMARY KEY,
  #   'userModificationDate' REAL,
  #   'creationDate'         REAL,
  #   'trashed'              INTEGER,
  #   'type'                 INTEGER,
  #   'title'                TEXT,
  #   'notes'                TEXT,
  #   'dueDate'              REAL,
  #   'dueDateOffset'        INTEGER,
  #   'status'               INTEGER,
  #   'stopDate'             REAL,
  #   'start'                INTEGER,
  #   'startDate'            REAL,
  #   'index'                INTEGER,
  #   'todayIndex'           INTEGER,
  #   'area'                 TEXT,
  #   'project'              TEXT,
  #   'repeatingTemplate'    TEXT,
  #   'delegate'             TEXT,
  #   'recurrenceRule'               BLOB,
  #   'instanceCreationStartDate'    REAL,
  #   'instanceCreationPaused'       INTEGER,
  #   'instanceCreationCount'        INTEGER,
  #   'afterCompletionReferenceDate' REAL                    ,
  #   'actionGroup' TEXT,
  #   'untrashedLeafActionsCount' INTEGER,
  #   'openUntrashedLeafActionsCount' INTEGER,
  #   'checklistItemsCount' INTEGER,
  #   'openChecklistItemsCount' INTEGER,
  #   'startBucket' INTEGER,
  #   'alarmTimeOffset' REAL,
  #   'lastAlarmInteractionDate' REAL,
  #   'todayIndexReferenceDate' REAL,
  #   'nextInstanceStartDate' REAL,
  #   'dueDateSuppressionDate' REAL,
  #   'leavesTombstone' INTEGER,
  #   'repeater' BLOB,
  #   'repeaterMigrationDate' REAL,
  #   'repeaterRegularSlotDatesCache' BLOB,
  #   'notesSync' INTEGER,
  #   'cachedTags' BLOB
  # );
end
