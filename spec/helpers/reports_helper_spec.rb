# frozen_string_literal: true

require "rails_helper"

RSpec.describe ReportsHelper, type: :helper do
  describe "sizer" do
    it "allows a max size of 72" do
      expect(helper.sizer(100)).to eq(72)
    end

    it "allows a min size of 16" do
      expect(helper.sizer(3)).to eq(16)
    end

    it "returns the input + 10 for all other cases" do
      expect(helper.sizer(20)).to eq(30)
    end
  end

  describe "opacitizer" do
    it "returns 1.0 for high frequency words (20+)" do
      expect(helper.opacitizer(25)).to eq(1.0)
    end

    it "returns 0.9 for frequency 15-19" do
      expect(helper.opacitizer(17)).to eq(0.9)
    end

    it "returns 0.8 for frequency 10-14" do
      expect(helper.opacitizer(12)).to eq(0.8)
    end

    it "returns 0.7 for frequency 5-9" do
      expect(helper.opacitizer(7)).to eq(0.7)
    end

    it "returns 0.6 for frequency below 5" do
      expect(helper.opacitizer(3)).to eq(0.6)
    end
  end

  describe "color_hex" do
    it "returns purple/pink/fuchsia colors for frequency 30+" do
      colors = [helper.color_hex(30), helper.color_hex(35), helper.color_hex(100)]
      expected_colors = %w[#9333ea #db2777 #c026d3]

      colors.each do |color|
        expect(expected_colors).to include(color)
      end
    end

    it "returns blue/indigo/violet colors for frequency 20-29" do
      colors = [helper.color_hex(20), helper.color_hex(25)]
      expected_colors = %w[#2563eb #4f46e5 #7c3aed]

      colors.each do |color|
        expect(expected_colors).to include(color)
      end
    end

    it "returns green/teal/cyan colors for frequency 10-19" do
      colors = [helper.color_hex(10), helper.color_hex(15)]
      expected_colors = %w[#059669 #0d9488 #0891b2]

      colors.each do |color|
        expect(expected_colors).to include(color)
      end
    end

    it "returns orange/amber/yellow colors for frequency 5-9" do
      colors = [helper.color_hex(5), helper.color_hex(7)]
      expected_colors = %w[#f59e0b #f59e0b #ca8a04]

      colors.each do |color|
        expect(expected_colors).to include(color)
      end
    end

    it "returns gray/slate colors for frequency below 5" do
      colors = [helper.color_hex(3), helper.color_hex(1)]
      expected_colors = %w[#4b5563 #64748b]

      colors.each do |color|
        expect(expected_colors).to include(color)
      end
    end
  end

  describe "rotation_style" do
    it "returns a rotation transform or empty string" do
      rotations = (1..20).map { helper.rotation_style }
      valid_rotations = [
        "",
        "transform: rotate(2deg)",
        "transform: rotate(-2deg)",
        "transform: rotate(3deg)",
        "transform: rotate(-3deg)",
        "transform: rotate(1deg)",
        "transform: rotate(-1deg)"
      ]

      rotations.each do |rotation|
        expect(valid_rotations).to include(rotation)
      end
    end

    it "sometimes returns empty string (no rotation)" do
      rotations = (1..50).map { helper.rotation_style }

      expect(rotations).to include("")
    end

    it "sometimes returns a rotation" do
      rotations = (1..50).map { helper.rotation_style }

      expect(rotations.any? { |r| r.include?("rotate") }).to be true
    end
  end

  describe "weight" do
    it "returns 700 (bold) for frequency 15+" do
      expect(helper.weight(15)).to eq("700")
      expect(helper.weight(20)).to eq("700")
    end

    it "returns 500 (medium) for frequency below 15" do
      expect(helper.weight(14)).to eq("500")
      expect(helper.weight(5)).to eq("500")
    end
  end

  describe "word_classes" do
    it "returns the word-cloud-item class" do
      expect(helper.word_classes).to eq("word-cloud-item")
    end
  end

  describe "styler" do
    it "includes font-size from sizer" do
      result = helper.styler(10)

      expect(result).to include("font-size: 20px")
    end

    it "includes opacity from opacitizer" do
      result = helper.styler(10)

      expect(result).to include("opacity: 0.8")
    end

    it "includes color from color_hex" do
      result = helper.styler(10)

      expect(result).to match(/color: #[0-9a-f]{6}/)
    end

    it "includes font-weight from weight" do
      result = helper.styler(20)

      expect(result).to include("font-weight: 700")
    end

    it "includes line-height" do
      result = helper.styler(10)

      expect(result).to include("line-height: 1.2")
    end
  end
end
