require_relative '../test_helper'

class ChartTest <  MiniTest::Unit::TestCase

  def setup
    @chart = Rega::Charts::Chart.new
    @chart.visualization = Rega::Visualization.new(height: 200, padding: { left: 10, right: 10, top: 10 })
    @chart.data = Rega::Data.new(name: "table", values: [ { x: 10, y: 20}, { x: 23, y: 12} ])
    @chart.scales = [Rega::Scales::Ordinal.new(name: 'x', range: 'width', domain: {data: 'table', field: 'data.x'})]
    @chart.marks = [Rega::Marks::Rect.new]
  end
      
  def test_generate
    c = @chart.generate
    assert_kind_of Hash, c
    assert_kind_of Array, c[:data]
    assert_kind_of Array, c[:scales]
    assert_equal c[:axes], nil
    assert_instance_of Array, c[:marks]
  end
  
  def test_customization
    skip 'fix'
    assert_equal 'red', @chart.marks.fill_color
    c = @chart.generate do |config|
      config.fill_color = "purple"
    end
    assert_equal 'purple', @chart.marks.fill_color
  end
end
