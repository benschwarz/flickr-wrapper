# Stolen from http://rubyforge.org/projects/concurrent
 
#
# concurrent/parallel - data-parallel programming for Ruby
#
# Copyright (C) 2007  MenTaLguY <mental@rydia.net>
#
# This file is made available under the same terms as Ruby.
#
 
module Concurrent #:nodoc:
module Parallel #:nodoc:
end
end
 
module Enumerable #:nodoc:
  def parallel_each( n, &block )
    parallel_subsets( n ).map do |slice|
      Thread.new { slice.each &block }
    end.each do |thread|
      thread.join
    end
    self
  end
 
  def parallel_map( n, &block )
    parallel_subsets( n ).map do |slice|
      Thread.new { slice.map &block }
    end.inject( [] ) do |a, thread|
      a.push *thread.value
    end
  end
 
  def parallel_select( n, &block )
    parallel_subsets( n ).map do |slice|
      Thread.new { slice.select &block }
    end.inject( [] ) do |a, results|
      a.push *thread.value
    end
  end
 
  def parallel_reject( n, &block )
    parallel_subsets( n ).map do |slice|
      Thread.new { slice.reject &block }
    end.inject( [] ) do |a, thread|
      a.push *thread.value
    end
  end
 
  def parallel_max( n )
    parallel_subsets( n ).map do |slice|
      Thread.new { slice.max }
    end.map { |t| t.value }.max
  end
 
  def parallel_min( n )
    parallel_subsets( n ).map do |slice|
      Thread.new { slice.min }
    end.map { |t| t.value }.min
  end
 
  def parallel_partition( n, &block )
    parallel_subsets( n ).map do |slice|
      Thread.new { slice.partition &block }
    end.inject( [ [], [] ] ) do |acc, thread|
      pair = thread.value
      acc[0].push *pair[0]
      acc[1].push *pair[1]
      acc
    end
  end
 
  def parallel_grep( re, n, &block )
    parallel_subsets( n ).map do |slice|
      Thread.new { slice.grep( re, &block ) }
    end.inject( [] ) do |acc, thread|
      acc.push *thread.value
    end
  end
 
  def parallel_all?( n, &block )
    parallel_subsets( n ).map do |slice|
      Thread.new { slice.all? &block }
    end.inject( true ) do |acc, thread|
      acc && thread.value
    end
  end
 
  def parallel_any?( n, &block )
    parallel_subsets( n ).map do |slice|
      Thread.new { slice.any? &block }
    end.inject( false ) do |acc, thread|
      acc || thread.value
    end
  end
 
  def parallel_include?( n, obj )
    parallel_subsets( n ).map do |slice|
      Thread.new { slice.include? obj }
    end.inject( false ) do |acc, thread|
      acc || thread.value
    end
  end
 
  def parallel_subsets( n )
    to_a.parallel_subsets( n )
  end
end
 
class Array #:nodoc:
  def parallel_subsets( n )
    if n > 1
      slice_size = (size.to_f / n.to_f).ceil
      (0...(size.to_f / slice_size)).map do |i|
        self[i*slice_size, slice_size.ceil]
      end
    else
      [ self ]
    end
  end
end