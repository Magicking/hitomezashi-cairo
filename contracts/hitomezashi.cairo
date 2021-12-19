# Declare this file as a StarkNet contract and set the required
# builtins.
%lang starknet
%builtins pedersen range_check

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.alloc import alloc
from starkware.starknet.common.messages import send_message_to_l1
from starkware.cairo.common.math import assert_le, assert_not_zero

# l1 gateway address
@storage_var
func l1_gateway() -> (res : felt):
end

# constructor
@external
func initialize{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        l1gateway : felt):
    let (is_initialized) = l1_gateway.read()
    assert is_initialized = 0

    l1_gateway.write(l1gateway)
    return ()
end

@view
func get_l1_gateway{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (_l1_gateway : felt):
    let (res) = l1_gateway.read()
    return (_l1_gateway=res)
end

# function write hitomezashi stich line (x, max, isOdd)
# alloc_locals
# tempvar _x
# tempvar max
# if x >= max return ()
#
# return concat(x & 0x1 ^ isOdd, hsl(x+1, max, isOdd))
#               ^^^^^^^^^^^^^^^ verify that

# function obtainInputAndWriteLine verticallyAndHorizontally
# Get hash1
# Get hash2
# For each byte


@external
func Stitch{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}():
    let (l1_gateway_address) = l1_gateway.read()
    assert_not_zero(l1_gateway_address)

    let (message_payload : felt*) = alloc()
    assert message_payload[0] = currentCounter

    send_message_to_l1(to_address=l1_gateway_address, payload_size=1, payload=message_payload)

    return ()
end
