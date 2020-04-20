module AlphaNumable

  def alpha_to_num
    alpha = ("a".."z").to_a << " "
    numeric = (0..26).to_a
    Hash[alpha.zip(numeric)]
  end

  def num_to_alpha
    numeric = (0..26).to_a
    alpha = ("a".."z").to_a << " "
    Hash[numeric.zip(alpha)]
  end

end
