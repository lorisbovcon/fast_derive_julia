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

Base.:sin(x::dualno_število) = dualno_število(sin(x.realna_komponenta), cos(x.realna_komponenta))
Base.:cos(x::dualno_število) = dualno_število(cos(x.realna_komponenta), -sin(x.realna_komponenta))
Base.:exp(x::dualno_število) = dualno_število(exp(x.realna_komponenta), exp(x.realna_komponenta) * x.dualna_komponenta)
Base.:log(x::dualno_število) = dualno_število(log(x.realna_komponenta), x.realna_komponenta / x.realna_komponenta)

function push_forward(f, primal::Real, tangent::Real)
  input = dualno_število(primal, tangent)
  output = f(input)
  primal_out = output.realna_komponenta
  tangent_out = output.dualna_komponenta
  return primal_out, tangent_out
end

x_point = 3.0

function f(x)
  return sin(x)
end

function deriviraj(f, x::Real)
  v = one(x)
  _, df_dx = push_forward(f, x, v)
  return df_dx
end

f(x_point)

print(deriviraj(f, x_point))
print("\n")
