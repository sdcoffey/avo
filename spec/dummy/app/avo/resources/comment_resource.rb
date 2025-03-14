class CommentResource < Avo::BaseResource
  self.title = :tiny_name
  self.includes = [:user, :commentable]
  # self.search_query = ->(params:) do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end
  self.record_selector = false

  self.after_create_path = :index
  self.after_update_path = :index

  field :id, as: :id
  field :body, as: :textarea, format_using: ->(value) do
    if view == :show
      content_tag(:div, style: "white-space: pre-line") { value }
    else
      value
    end
  end
  field :tiny_name, as: :text, only_on: :index, as_description: true
  field :posted_at, as: :date_time,
    picker_format: "Y-m-d H:i:S",
    format: "cccc, d LLLL yyyy, HH:mm ZZZZ" # Wednesday, 10 February 1988, 16:00 GMT

  field :user, as: :belongs_to
  field :commentable, as: :belongs_to, polymorphic_as: :commentable, types: [::Post, ::Project]
end
