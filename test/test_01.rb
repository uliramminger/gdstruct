require_relative '../lib/gdstruct'

require 'minitest/autorun'

class TestGdstruct < Minitest::Test
  
  require_relative 'language_testcases.rb'
  
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
    
      assert_equal errorHappened, false
      assert_equal res, expectedResult  
    end    
  end
  
  def test_gds_file
    puts "Positive Testcases, test gds file"
    puts "================================="
    
    require_relative "testcase01_res.rb" 

    sentence = File.read( File.join( File.dirname(__FILE__), 'testcase01.gdstruct' ) )
        
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
  
    assert_equal errorHappened, false
    assert_equal res, Testcase01_res  
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
    
      assert_equal errorHappened, true
    end    
  end
  
end
