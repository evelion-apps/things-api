class Area < ActiveRecord::Base
  self.table_name = "TMArea"
  self.primary_key = "uuid"
  self.inheritance_column = "none"

  validates :uuid, presence: true

  # NOTE: output of `.schema TMArea` from `sqlite3` as of October, 2021:
  #
  # CREATE TABLE IF NOT EXISTS 'TMArea' (
  #   'uuid'       TEXT PRIMARY KEY,
  #   'title'      TEXT,
  #   'visible'    INTEGER,
  #   'index'      INTEGER,
  #   'cachedTags' BLOB
  # );
end
