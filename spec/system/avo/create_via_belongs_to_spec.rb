# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Create Via Belongs to", type: :system do
  describe "edit" do
    let(:course_link) { create(:course_link) }

    it "successfully creates a new course and assigns it to the course link", :aggregate_failures do
      visit "/admin/resources/course_links/#{course_link.id}/edit"

      click_on "Create New"

      expect {
        fill_in "course_name", with: "Test course"
        click_on "Save"
        sleep 0.2
      }.to change(Course, :count).by(1)

      expect(page).to have_text course_link.link

      expect(find_field(id: "course_link_course_id", disabled: true).value).to eq "Test course"

      click_on "Save"
      sleep 0.2

      expect(course_link.reload.course).to eq Course.last
    end
  end

  describe "new" do
    it 'successfully creates a new course and assigns the value to the field in the form' do
      visit "/admin/resources/course_links/new"

      click_on "Create New"

      expect {
        fill_in "course_name", with: "Test course"
        click_on "Save"
        sleep 0.2
      }.to change(Course, :count).by(1)

      expect(page).to have_text "Create new course link"

      expect(find_field(id: "course_link_course_id", disabled: true).value).to eq "Test course"

      expect {
        fill_in("course_link_link", with: "https://www.example.com")
        click_on "Save"
        sleep 0.2
      }.to change(Course::Link, :count).by(1)

      expect(Course::Link.last.course).to eq Course.last
    end
  end
end
