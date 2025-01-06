using Base
import Pkg

struct dualno_število{T}
  realna_komponenta::T;
  dualna_komponenta::T;
end

dualno_število(x) = dualno_število(x, zero(x))

Base.:+(x::dualno_število, y::dualno_število) = dualno_število(x.realna_komponenta + y.realna_komponenta, x.dualna_komponenta + y.dualna_komponenta)
Base.:+(x, y::dualno_število) = dualno_število(x + y.realna_komponenta, y.dualna_komponenta)

Base.:-(x::dualno_število, y::dualno_število) = dualno_število(x.realna_komponenta - y.realna_komponenta, x.dualna_komponenta - y.dualna_komponenta)
Base.:-(x, y::dualno_število) = dualno_število(x - y.realna_komponenta, y.dualna_komponenta)

Base.:*(x::dualno_število, y::dualno_število) = dualno_število(x.realna_komponenta * y.realna_komponenta, (x.dualna_komponenta * y.realna_komponenta) + (y.dualna_komponenta * x.realna_komponenta))
Base.:*(x, y::dualno_število) = dualno_število(x * y.realna_komponenta, x * y.dualna_komponenta)

Base.:/(x::dualno_število, y::dualno_število) = dualno_število(x.realna_komponenta / y.realna_komponenta, (y.realna_komponenta * x.dualna_komponenta - x.realna_komponenta * y.dualna_komponenta)/(y.realna_komponenta * y.realna_komponenta))

Base.:^(x::dualno_število, y::Real) = dualno_število(x.realna_komponenta ^ y, y * x.realna_komponenta ^ (y - 1) * x.dualna_komponenta)
