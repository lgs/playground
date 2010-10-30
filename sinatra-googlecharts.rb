#!/usr/bin/env ruby 

require 'rubygems'
require 'sinatra'
require 'gchart'

# simple lines

get '/graph' do
line = Gchart.line(:size => '200x300',
            :title => "Graph",
            :bg => 'efefef',
            :legend => ['Blabla', 'Data'],
            :data => [[0, 40, 10, 70, 20],[41, 10, 80, 50]], :line_colors => "FF0000,00FF00")
  swap_var(line)
  haml :chart
end

# finance

get '/finance' do
data = [27,25,25,25,25,27,100,31,25,36,25,25,39,25,31,25,25,25,26,26,
25,25,28,25,25,100,28,27,31,25,27,27,29,25,27,26,26,25,26,26,35,33,
34,25,26,25,36,25,26,37,33,33,37,37,39,25,25,25,25]
@sparkline = Gchart.sparkline(:data => data,
                 :size => '300x200',
                 :line_colors => 'FF0000',
                 :title => "Finance stile chart"
                )
  swap_var(@sparkline)
  haml :chart
end

# Bars 

get '/bars' do
@chart = Gchart.bar(:data => [[300,100,30,200],[300,100,30,200]],
        :bar_colors => ['FF0000','00FF00'],
        :title => "Bar graph",
        :legend => ["wwwwww","zzzzzz"],
        :axis_with_labels => 'x',
        :axis_labels => ['Jan','Dec','Jan','Dec','Jan']
       )
  haml :chart
end

# background changing

get '/background' do
@chart = Gchart.bar(:title => "Background changing sample",
           :data => [15,30,10,20,100,20,40,100,90,100,80],
           :background => "6495ED"
          )
  haml :chart
end

get '/pizza' do
@chart = Gchart.pie(:data => [20,35,45],
           :title => "Pizza graph"
)
  haml :chart
end

get '/pizza3d' do
@chart = Gchart.pie_3d(:title => 'ruby_fu', :size => '400x200',
              :data => [10, 45, 45], :labels => ["Brasil", "Argentina", "Mexico"] )
  haml :chart
end

get '/' do
  haml :index
end

def swap_var(var)
  @chart = var
end

__END__

@@ layout
!!! 1.1
%html
  %head
    %title GitWatch
    %link{:rel => 'stylesheet', :href => 'http://www.blueprintcss.org/blueprint/screen.css', :type => 'text/css'}  
  %body
    .container
      %p
      = yield

@@ index
%h1 Many Charts:
%ul 
   %a{:href => "/graph"} /graph 
   %br
   %a{:href => "/finance"} /finance
   %br
   %a{:href => "/bars"} /bars
   %br
   %a{:href => "/background"} /background
   %br
   %a{:href => "/pizza"} /pizza
   %br
   %a{:href => "/pizza3d"} /pizza3d
   %br

@@ chart
%h1 Chart:
%img{:src => @chart}

