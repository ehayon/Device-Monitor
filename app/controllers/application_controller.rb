class ApplicationController < ActionController::Base
  protect_from_forgery
  def get_distance(s1 ,s2)
      m = Hash.new
      (s1.length + 1).times do |i|
        m.store([i,0], i)
      end
      (s2.length + 1).times do |i|
        m.store([0,i], i)
      end
      s2.length.times do |j|
        s1.length.times do |k|
          if (s1[k] == s2[j]) 
            m.store([k+1,j+1], m[[k,j]])
          else
            s = []
            s << m[[k, j]] << m[[k+1, j]] << m[[k, j+1]]
            m.store([k+1,j+1], s.min+1)
          end
        end
      end
      return m[[s1.length, s2.length]]
    end
end
