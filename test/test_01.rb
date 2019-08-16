require_relative '../lib/gdstruct'

require 'minitest/autorun'

class TestGdstruct < Minitest::Test

  require_relative 'defs/language_testcases.rb'

  def setup
  end

  def test_positive_cases
    puts "Positive Testcases"
    puts "=================="

    TestCases_positive.each_with_index do |testcase,idx|

      sentence, expectedResult = testcase

      puts "--- idx: #{idx}"
      puts sentence
      puts "--"

      errorHappened = false
      res = nil

      begin
        res = GDstruct.c( sentence )

      rescue Exception => e
        puts "Error:Exception: #{e.inspect}"
        errorHappened = true
      end

      assert_equal false, errorHappened
      assert_equal expectedResult, res
    end
  end

  def test_negative_cases
    puts "Negative Testcases"
    puts "=================="

    TestCases_negative.each_with_index do |sentence,idx|

      puts "--- idx: #{idx}"
      puts sentence
      puts "---"

      errorHappened = false
      res = nil

      begin
        res = GDstruct.c( sentence )

      rescue Exception => e
        puts "Error:Exception: #{e.inspect}"
        errorHappened = true
      end

      assert_equal true, errorHappened
    end
  end

  def test_gds_file
    puts "Positive Testcases, test gds file"
    puts "================================="

    require_relative "defs/testcase01_res.rb"

    sentence = File.read( File.join( File.dirname(__FILE__), 'defs', 'testcase01.gdstruct' ) )

    puts sentence
    puts "--"

    errorHappened = false
    res = nil

    begin
      res = GDstruct.c( sentence )

    rescue Exception => e
      puts "Error:Exception: #{e.inspect}"
      errorHappened = true
    end

    assert_equal false, errorHappened
    assert_equal Testcase01_res, res
  end

  def test_creator_01
    puts "Test, class Creator"
    puts "==================="

    require_relative "defs/testcase02_res.rb"

    errorHappened = false
    res = nil

    begin
      gdsCreator = GDstruct::Creator.new
      gdsCreator.include( File.read( File.join( File.dirname(__FILE__), 'defs/testcase02a.gdstruct' ) ) )
      gdsCreator.include( File.read( File.join( File.dirname(__FILE__), 'defs/testcase02b.gdstruct' ) ) )
      gdsCreator.include( File.read( File.join( File.dirname(__FILE__), 'defs/testcase02c.gdstruct' ) ) )
      res = gdsCreator.create

    rescue Exception => e
      puts "Error:Exception: #{e.inspect}"
      errorHappened = true
    end

    assert_equal false, errorHappened
    assert_equal Testcase02_res, res
  end

  def test_creator_02
    puts "Test, class Creator"
    puts "==================="

    require_relative "defs/testcase02_res.rb"

    errorHappened = false
    res = nil

    begin
      gdsCreator = GDstruct::Creator.new
      gdsCreator.include( File.read( File.join( File.dirname(__FILE__), 'defs/testcase02a.gdstruct' ) ) )
      gdsCreator.include_file( File.join( File.dirname(__FILE__), 'defs/testcase02b.gdstruct' ) )
      gdsCreator.include_file( File.join( File.dirname(__FILE__), 'defs/testcase02c.gdstruct' ) )
      res = gdsCreator.create

    rescue Exception => e
      puts "Error:Exception: #{e.inspect}"
      errorHappened = true
    end

    assert_equal false, errorHappened
    assert_equal Testcase02_res, res
  end

end
