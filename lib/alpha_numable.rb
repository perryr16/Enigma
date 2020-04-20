module AlphaNumable

  def a_one
    alpha = ("a".."z").to_a << " "
    numeric = (0..26).to_a
    Hash[alpha.zip(numeric)]
  end

  def one_a
    numeric = (0..26).to_a
    alpha = ("a".."z").to_a << " "
    Hash[numeric.zip(alpha)]
  end

end
