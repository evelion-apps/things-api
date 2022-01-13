require "graphql"

require_relative "../field_types"

class TaskType < GraphQL::Schema::Object
  description "GraphQL Task Type"

  field :uuid, String, null: true
  field :userModificationDate, Float, null: true
  field :creationDate, Float, null: true
  field :trashed, Integer, null: true
  field :type, Integer, null: true
  field :typeString, String, null: true
  field :title, String, null: true
  field :notes, String, null: true
  field :dueDate, Float, null: true
  field :dueDateOffset, Integer, null: true
  field :status, Integer, null: true
  field :statusString, String, null: true
  field :stopDate, Float, null: true
  field :start, Integer, null: true
  field :startDate, Float, null: true
  field :index, Integer, null: true
  field :todayIndex, Integer, null: true
  field :area, String, null: true
  field :areaString, String, null: true
  field :project, String, null: true
  field :repeatingTemplate, String, null: true
  field :delegate, String, null: true
  field :recurrenceRule, FieldTypes::EncodedBlob, null: true
  field :instanceCreationStartDate, Float, null: true
  field :instanceCreationPaused, Integer, null: true
  field :instanceCreationCount, Integer, null: true
  field :afterCompletionReferenceDate, Float, null: true
  field :actionGroup, String, null: true
  field :untrashedLeafActionsCount, Integer, null: true
  field :openUntrashedLeafActionsCount, Integer, null: true
  field :checklistItemsCount, Integer, null: true
  field :openChecklistItemsCount, Integer, null: true
  field :startBucket, Integer, null: true
  field :alarmTimeOffset, Float, null: true
  field :lastAlarmInteractionDate, Float, null: true
  field :todayIndexReferenceDate, Float, null: true
  field :nextInstanceStartDate, Float, null: true
  field :dueDateSuppressionDate, Float, null: true
  field :leavesTombstone, Integer, null: true
  field :repeater, FieldTypes::EncodedBlob, null: true
  field :repeaterMigrationDate, Float, null: true
  field :repeaterRegularSlotDatesCache, FieldTypes::EncodedBlob, null: true
  field :notesSync, Integer, null: true
  field :cachedTags, FieldTypes::EncodedBlob, null: true
end
