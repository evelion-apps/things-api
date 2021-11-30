require "graphql"
require_relative "types/task"

class QueryType < GraphQL::Schema::Object
  description "The query root of this schema"

  # Fields

  field :headings, [TaskType], null: false do
    description "List headings"
  end

  field :projects, [TaskType], null: false do
    description "List projects"
  end

  field :todos, [TaskType], null: false do
    description "List to dos"
  end

  field :today, [TaskType], null: false do
    description "List today"
  end

  # Data Resolvers

  def todos
    Task
      .where(type: 0)
      .where(status: 0)
      .map do |todo|
        # Convert model instance to hash, allowing additional fields and data transforms
        as_hash = todo.attributes
        as_hash["statusString"] = get_status_string(as_hash)
        as_hash["typeString"] = "todo"
        as_hash
      end
  end

  def headings
    Task
      .where(type: 2)
      .where(status: 0)
      .map do |todo|
        # Convert model instance to hash, allowing additional fields and data transforms
        as_hash = todo.attributes
        as_hash["statusString"] = get_status_string(as_hash)
        as_hash["typeString"] = "heading"
        as_hash
      end
  end

  def projects
    Task
      .where(type: 1)
      .where(status: 0)
      .map do |todo|
        # Convert model instance to hash, allowing additional fields and data transforms
        as_hash = todo.attributes
        as_hash["statusString"] = get_status_string(as_hash)
        as_hash["typeString"] = "project"
        as_hash
      end
  end

  def today
    # Get todo task data
    todayStart = DateTime.now.beginning_of_day.in_time_zone("GMT").strftime('%s').to_f
    todayEnd = DateTime.now.end_of_day.in_time_zone("GMT").strftime('%s').to_f

    uncompleted = Task.where(type: 0).where(status: 0).where.not(startDate: nil).where("startDate <= ?", todayStart)
    completed = Task.where(type: 0).where(status: 3).where.not(stopDate: nil).where("stopDate > ?", todayStart).where("stopDate <= ?", todayEnd)
    todos = (uncompleted + completed).sort_by {|todo| todo.todayIndex}

    # Get associated data used for ordering
    headings = Task.where(type: 2).where(status: 0)
    projects = Task.where(type: 1).where(status: 0)
    areas = Area.order(:index)

    # Sort projects by the Area index. Projects without an associated area go first
    areas_index_lookup = areas.reduce({}) do |acc, area|
      acc[area.uuid] = area.index
      acc
    end

    areas_title_lookup = areas.reduce({}) do |acc, area|
      acc[area.uuid] = area.title
      acc
    end

    projects = projects.sort_by do |project|
      area_index = areas_index_lookup[project.area] || -Float::INFINITY

      [area_index, project.index]
    end

    # Add an empty project task to capture todos that aren't affiliated with a project
    no_project_placeholder = Task.new(type: 1)
    projects = [no_project_placeholder] + projects

    headings_lookup = headings.reduce({}) do |acc, heading|
      acc[heading.uuid] = heading.project
      acc
    end

    # Convert model instance to hash, allowing additional fields and data transforms
    projects = projects.map do |project|
      as_hash = project.attributes
      as_hash["areaString"] = areas_title_lookup[project.area]
      as_hash["statusString"] = get_status_string(as_hash)
      as_hash["typeString"] = "project"
      as_hash
    end

    # Group todos by project
    todos_by_project = todos.group_by do |todo|
      headings_lookup[todo.actionGroup] || todo.project
    end

    # Walk through projects in sorted order, returning a list of projects and
    # related todos
    projects.reduce([]) do |acc, project|
      todos_for_project = todos_by_project[project["uuid"]]

      if todos_for_project.present?

        # Convert model instance to hash, allowing additional fields and data transforms
        todos_for_project = todos_for_project.map do |todo|
          as_hash = todo.attributes
          as_hash["areaString"] = project["areaString"]
          as_hash["statusString"] = get_status_string(as_hash)
          as_hash["typeString"] = "todo"
          as_hash
        end

        acc = acc + [project] + todos_for_project
      end

      acc
    end
  end

  # Helpers

  def get_status_string(hash)
    hash["status"] == 3 ? "complete" : "open"
  end
end
