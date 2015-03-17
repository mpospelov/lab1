require 'matrix'
require 'byebug'

top_names = [4, 7, 8, 10, 11, 12, 16, 17, 18, 19, 20, 21, 22, 23, 24]

matrix = Matrix[
  # 4   7   8   10  11  12  16  17  18  19  20  21  22  23  24
  [ 2,  0, -1,  0,  0,  0,  0, -1,  0,  0,  0,  0,  0,  0,  0], # 4
  [ 0,  2, -1,  0, -1,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0], # 7
  [-1, -1,  3,  0,  0, -1,  0,  0,  0,  0,  0,  0,  0,  0,  0], # 8
  [ 0,  0,  0,  1, -1,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0], # 10 
  [ 0, -1,  0, -1,  3, -1,  0,  0,  0,  0,  0,  0,  0,  0,  0], # 11
  [ 0,  0, -1,  0, -1,  3, -1,  0,  0,  0,  0,  0,  0,  0,  0], # 12
  [ 0,  0,  0,  0,  0, -1,  1,  0,  0,  0,  0,  0,  0,  0,  0], # 16
  [-1,  0,  0,  0,  0,  0,  0,  3, -1,  0,  0, -1,  0,  0,  0], # 17
  [ 0,  0,  0,  0,  0,  0,  0, -1,  3, -1,  0,  0, -1,  0,  0], # 18
  [ 0,  0,  0,  0,  0,  0,  0,  0, -1,  3, -1,  0,  0, -1,  0], # 19
  [ 0,  0,  0,  0,  0,  0,  0,  0,  0, -1,  2,  0,  0,  0, -1], # 20 
  [ 0,  0,  0,  0,  0,  0,  0, -1,  0,  0,  0,  2, -1,  0,  0], # 21 
  [ 0,  0,  0,  0,  0,  0,  0,  0, -1,  0,  0, -1,  3, -1 , 0], # 22
  [ 0,  0,  0,  0,  0,  0,  0,  0,  0, -1,  0,  0, -1,  3, -1], # 23
  [ 0,  0,  0,  0,  0,  0,  0,  0,  0,  0, -1,  0,  0, -1,  2]  # 24
]

decomposition = Matrix::EigenvalueDecomposition.new(matrix)
lam_vector = decomposition.eigenvalues
u_vectors = decomposition.eigenvectors
result = {}

lam_vector.each_with_index do |el, i|
  result[el] = u_vectors[i]
end

result = Hash[result.sort]
result.each do |lam, u|
  puts "Lamda val: #{lam} \nU vector: #{u.to_a.join(", ")}\n\n"
end

u2 = result.to_a[1][1]

mean_val = u2.inject(:+)/u2.count
puts mean_val

first_part = []
second_part = []

u2.map do |el| 
  top_name = top_names[u2.to_a.index(el)]
  if el > mean_val
    first_part << top_name
  else
    second_part << top_name
  end
end

puts first_part.to_s
puts second_part.to_s