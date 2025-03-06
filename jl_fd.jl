import Pkg
import Base

print("Enter the point to evaluate at: ")
x_point = readline()
x_point = tryparse(Float64, x_point)

function f(x)
  return x ^ (1/2)
end

function enax(x)
  t = x + 1
  p = 1
  for i = 2:20;
    p = p * i;
    t = t + (x ^ i) / p
  end
  t
end

function sinus(x)
  t = x;
  p = 1;
  k = 1;
  for i = 2:20;
    p = p * i;
    if i % 2 != 0 
      k = k * (-1);
      t = t + k * (x ^ i) / p
    end
  end
  t
end

function sinus(x)
  t = 1;
  p = 1;
  k = 1;
  for i = 2:20;
    p = p * i;
    if i % 2 == 0 
      k = k * (-1);
      t = t + k * (x ^ i) / p
    end
  end
  t
end

struct D_Š{T}
  vf::T;
  vo::T;
end

#Base.:*(x::D_Š, y::D_Š) = D_Š(x.vf * y.vf, x.vf * y.vo + x.vo * y.vf)
#Base.:*(x, y::D_Š) = D_Š(x * y.vf, x * y.vo)
#Base.:+(x::D_Š, y::D_Š) = D_Š(x.vf + y.vf, x.vo + y.vo)
#Base.:+(x, y::D_Š) = D_Š(x + y.vf, y.vo)
#Base.:+(x::D_Š, y) = D_Š(x.vf + y, x.vo)
#Base.:-(x::D_Š, y::D_Š) = D_Š(x.vf - y.vf, x.vo - y.vo)
#Base.:-(x, y::D_Š) = D_Š(x - y.vf, y.vo)
#Base.:-(x::D_Š, y) = D_Š(x.vf - y, x.vo)

Base.:+(x::D_Š, y::D_Š) = D_Š(x.vf + y.vf, x.vo + y.vo)

Base.:+(x, y::D_Š) = D_Š(x + y.vf, y.vo)

Base.:-(x::D_Š, y::D_Š) = D_Š(x.vf - y.vf, x.vo - y.vo)
Base.:-(x, y::D_Š) = D_Š(x - y.vf, y.vo)
Base.:-(x::D_Š, y) = D_Š(x.vf - y, x.vo)

Base.:*(x::D_Š, y::D_Š) = D_Š(x.vf * y.vf, (x.vo * y.vf) + (y.vo * x.vf))
Base.:*(x, y::D_Š) = D_Š(x * y.vf, x * y.vo)

Base.:/(x::D_Š, y::D_Š) = D_Š(x.vf / y.vf, (y.vf * x.vo - x.vf * y.vo)/(y.vf * y.vf))

Base.:^(x::D_Š, y::Real) = D_Š(x.vf ^ y, y * x.vf ^ (y - 1) * x.vo)

Base.:sin(x::D_Š) = D_Š(sin(x.vf), cos(x.vf))
Base.:cos(x::D_Š) = D_Š(cos(x.vf), -sin(x.vf))
Base.:tan(x::D_Š) = D_Š(tan(x.vf), sec(x.vf) * sec(x.vf))
Base.:cot(x::D_Š) = D_Š(cot(x.vf), -csc(x.vf) * csc(x.vf))
Base.:exp(x::D_Š) = D_Š(exp(x.vf), exp(x.vf) * x.vo)
Base.:log(x::D_Š) = D_Š(log(x.vf), x.vf / x.vf)

convert(::Type{D_Š}, x::Real) = D_Š(x, 0.0)
promote_rule(::Type{D_Š}, ::Type{<:Real}) = D_Š
show(io::IO, x::D_Š) = print(io, x.vf, " + ", x.vo, "€")

function push_forward(f, primal::Real, tangent::Real)
  input = D_Š(primal, tangent)
  output = f(input)
  primal_out = output.vf
  tangent_out = output.vo
  return primal_out, tangent_out
end


function par(f, x::Real)
  v = D_Š(x, 1.0)
  return f(v).vf, f(v).vo
end

f(x_point)
out1, out2 = par(f, x_point)
print("Vrednost funkcije: ", out1, "\nVrednost odvoda v ", x_point, ": ", out2)
print("\n")
