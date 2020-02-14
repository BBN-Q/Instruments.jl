#VISA error codes
include("codes.jl")
#Atributes and other definitions
include("constants.jl")


macro check_status(viCall)
	return quote
		status = $(esc(viCall))
		if status[2] < VI_SUCCESS
			errMsg = codes[status[2]]
			error("VISA C call failed with status $(errMsg[1]): $(errMsg[2])")
		end
		status[1]
	end
end

function check_status(status)
	if status < VI_SUCCESS
		errMsg = codes[status]
		error("VISA C call failed with status $(errMsg[1]): $(errMsg[2])")
	end
	status
end
