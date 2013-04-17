require 'json'
require 'forwardable'
module Rega
  
  module Charts
    #This class composes end json by comibining Visualization object, data object, axes, scales..
    class Chart
      
      extend Forwardable
      
      def_delegators :@marks, :fill_color, :fill_color=
      def_delegators :@marks, :fill_opacity, :fill_opacity=
      def_delegators :@marks, :hover_opacity, :hover_opacity=
      def_delegators :@marks, :hover_color, :hover_color=
      
      #Donut/Pie Chart specific
      def_delegators :@marks, :inner_radius, :inner_radius=
      def_delegators :@marks, :stroke_width, :stroke_width=
      
      attr_accessor :visualization, :axes, :scales, :data, :marks
      VALID_ATTRS = %w(visualization axes scales data marks)
      
      def initialize(**options)
        options.each { |name, value| instance_variable_set("@#{name}", value) if VALID_ATTRS.include?(name) }
      end
      
      #Need - visualization, marks and data
      #Optional - scales, axes(in some cases)
      def generate(&block)
        yield self if block_given?
        h = @visualization.attributes
        h[:data] = [@data.attributes]
        h[:scales] = @scales.map(&:attributes) if @scales
        h[:axes] = @axes.map(&:attributes) if @axes
        h[:marks] = [@marks.attributes] if @marks
        h
      end
      
    end
    
  end
  
end

