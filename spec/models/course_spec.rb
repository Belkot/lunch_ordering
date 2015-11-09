require 'rails_helper'

RSpec.describe Course, type: :model do

  it "is valid with a name, price and type" do
    expect(build(:course)).to be_valid
  end

  context "is invalid" do

    it "without a name" do
      course = build(:course, name: nil)
      course.valid?
      expect(course.errors[:name]).to include("can't be blank")
    end

    it "without a price" do
      course = build(:course, price: nil)
      course.valid?
      expect(course.errors[:price]).to include("can't be blank")
    end

    it "without a type" do
      course = build(:course, course_type: nil)
      course.valid?
      expect(course.errors[:course_type]).to include("can't be blank")
    end

    it "with a short name" do
      course = build(:course, name: 'Ab')
      course.valid?
      expect(course.errors[:name]).to include("is too short (minimum is 3 characters)")
    end

    it "with a long name" do
      long_name = 'a' * 31
      course = build(:course, name: long_name)
      course.valid?
      expect(course.errors[:name]).to include("is too long (maximum is 30 characters)")
    end

    it "with not a number price" do
      course = build(:course, price: 'txt')
      course.valid?
      expect(course.errors[:price]).to include("is not a number")
    end

  end

  it "destroy saver" do
    course = create(:course)
    expect { course.destroy_saver }.to_not change{ Course.count }
    expect(course.deleted_at).to be_within(1.second).of(Time.now)
  end

  it "update saver" do
    course = create(:course)
    expect { course.update_saver(name: "New name") }.to change{ Course.count }.by(1)
    expect(course.deleted_at).to be_within(1.second).of(Time.now)
  end

  it "today" do
    5.times { create(:course) }
    Course.last.destroy_saver
    expect(Course.today.count).to eq 4
  end

  it "for date" do
    5.times { create(:course, created_at: Time.now - 1.day) }
    create(:course, created_at: Time.now + 1.day)
    create(:course, created_at: Time.now + 2.day)
    expect(Course.count).to eq 7
    expect(Course.for_date(Date.today).count).to eq 5
  end

end
