require 'rails_helper'

RSpec.describe LineItem, type: :model do

  before :each do
    @order = create(:order)
    @course_first = build(:course)
    @course_main = build(:course)
    @course_drink = build(:course)
  end

  it "valid when add to order corses for not one course types" do
    @order.courses << [@course_first, @course_main, @course_drink]
    expect(@order.courses).to include(@course_first, @course_main, @course_drink)
  end

  it "invalid when add to order corses one course types together" do
    course_drink2 = build(:course, course_type_id: @course_drink.course_type_id)
    expect{
      @order.courses << [@course_first, @course_drink, course_drink2]
    }.to raise_error(ActiveRecord::RecordNotSaved)
  end

end
