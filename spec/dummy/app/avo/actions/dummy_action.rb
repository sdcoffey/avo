class DummyAction < Avo::BaseAction
  self.name = "Dummy action"
  self.standalone = true
  self.visible = ->(resource:, view:) { view == :index }

  def handle(**args)
    # Do something here

    puts "DummyAction triggered"

    succeed "Success response ✌️"
    warn "Warning response ✌️"
    inform "Info response ✌️"
    fail "Error response ✌️"
  end
end
