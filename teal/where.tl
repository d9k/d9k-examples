  local interface IA
     where self.t == "a"

     t: string
  end

  local interface IB
     where self.t == "b"

     t: string
  end

  local record R is IA
     where self.t == "r"

     rfield: string
  end

  local t: IA | IB

  if t and t is R and t.rfield then
    print("yay")
  else
    print("nay")
  end
