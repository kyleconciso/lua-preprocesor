
local args = {...}

local ARG_IFN, ARG_OFN

for i, v in next, args do
	if v=="i" or v=="input" then ARG_IFN=args[i+1] end
	if v=="o" or v=="output" then ARG_OFN=args[i+1] end
end

local fi = io.open(ARG_IFN, "r")
local raw = fi:read("*a")
fi:close()

local output_raw = raw

for fn, _ in string.gmatch(raw:lower(),"@include \"([A-z.]*)\"") do
	tempf = io.open(fn, "r")
	print(fn)
	output_raw = string.gsub(output_raw:lower(), string.format('@include "%s"',fn), tempf:read("*a"))
	tempf:close()
end

local fo = io.open(ARG_OFN,"w")
fo:write(output_raw)

fo:close()

