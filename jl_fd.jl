import Pkg
import Base


struct dualno_število{T}
  realna_komponenta::T;
  dualna_komponenta::T;
end

#Base.:*(x::dualno_število, y::dualno_število) = dualno_število(x.realna_komponenta * y.realna_komponenta, x.realna_komponenta * y.dualna_komponenta + x.dualna_komponenta * y.realna_komponenta)
#Base.:*(x, y::dualno_število) = dualno_število(x * y.realna_komponenta, x * y.dualna_komponenta)
#Base.:+(x::dualno_število, y::dualno_število) = dualno_število(x.realna_komponenta + y.realna_komponenta, x.dualna_komponenta + y.dualna_komponenta)
#Base.:+(x, y::dualno_število) = dualno_število(x + y.realna_komponenta, y.dualna_komponenta)
#Base.:+(x::dualno_število, y) = dualno_število(x.realna_komponenta + y, x.dualna_komponenta)
#Base.:-(x::dualno_število, y::dualno_število) = dualno_število(x.realna_komponenta - y.realna_komponenta, x.dualna_komponenta - y.dualna_komponenta)
#Base.:-(x, y::dualno_število) = dualno_število(x - y.realna_komponenta, y.dualna_komponenta)
#Base.:-(x::dualno_število, y) = dualno_število(x.realna_komponenta - y, x.dualna_komponenta)




Base.:+(x::dualno_število, y::dualno_število) = dualno_število(x.realna_komponenta + y.realna_komponenta, x.dualna_komponenta + y.dualna_komponenta)

Base.:+(x, y::dualno_število) = dualno_število(x + y.realna_komponenta, y.dualna_komponenta)

Base.:-(x::dualno_število, y::dualno_število) = dualno_število(x.realna_komponenta - y.realna_komponenta, x.dualna_komponenta - y.dualna_komponenta)
Base.:-(x, y::dualno_število) = dualno_število(x - y.realna_komponenta, y.dualna_komponenta)
Base.:-(x::dualno_število, y) = dualno_število(x.realna_komponenta - y, x.dualna_komponenta)

Base.:*(x::dualno_število, y::dualno_število) = dualno_število(x.realna_komponenta * y.realna_komponenta, (x.dualna_komponenta * y.realna_komponenta) + (y.dualna_komponenta * x.realna_komponenta))
Base.:*(x, y::dualno_število) = dualno_število(x * y.realna_komponenta, x * y.dualna_komponenta)

Base.:/(x::dualno_število, y::dualno_število) = dualno_število(x.realna_komponenta / y.realna_komponenta, (y.realna_komponenta * x.dualna_komponenta - x.realna_komponenta * y.dualna_komponenta)/(y.realna_komponenta * y.realna_komponenta))

Base.:^(x::dualno_število, y::Real) = dualno_število(x.realna_komponenta ^ y, y * x.realna_komponenta ^ (y - 1) * x.dualna_komponenta)

function push_forward(f, primal::Real, tangent::Real)
  input = dualno_število(primal, tangent)
  output = f(input)
  primal_out = output.realna_komponenta
  tangent_out = output.dualna_komponenta
  return primal_out, tangent_out
end

function deriviraj(f, x::Real)
  v = one(x)
  _, df_dx = push_forward(f, x, v)
  return df_dx
end

function f(x)
  return 3 * x ^ 2 + 10 * x - 10
end

x_point = 3.0

f(x_point)

print(deriviraj(f, x_point))
print("\n")
