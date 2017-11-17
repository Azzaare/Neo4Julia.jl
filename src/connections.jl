const BOLT = b"\x60\x60\xB0\x17"
const BOLT_VERSION = 1
# Versions are coded as UInt32, so 4*4 elements for 4 versions
const RAW_BOLT_VERSIONS = pack([0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0])[3:end]

const CLIENT = Dict(
    "INIT"          => 0x01,
    "ACK_FAILURE"   => 0x0e,
    "RESET"         => 0x0f,
    "RUN"           => 0x10,
    "DISCARD_ALL"   => 0x2f,
    "PULL_ALL"      => 0x3f,
)

const SERVER = Dict(
    "SUCESS"    => 0x70,
    "RECORD"    => 0x71,
    "IGNORED"   => 0x7e,
    "FAILURE"   => 0x7f,
)

const DEFAULT_USER_AGENT = "boltkit/0.0" # Unicode ?
const MAX_CHUNK_SIZE = 65535
const SOCKET_TIMEOUT = 5

# const DEFAULT = Dict(
#     "HOST"      => "localhost",
#     "PORT"      => 7474,
#     "URI"       => "/db/data/"
# )

struct ConnectionSettings
    user::AbstractString
    password::AbstractString
    user_agent::AbstractString

    ConnectionSettings(
        user::AbstractString,
        password::AbstractString,
        user_agent::AbstractString = DEFAULT_USER_AGENT
    ) = new(user, password, user_agent)
end

struct Request
    description::AbstractString
    data::Vector{UInt8}

    Request(
        description::AbstractString,
        message::Packable
    ) = new(description, pack(message))
end

const REQUESTS = Dict(
    [
        (str, Request(str, CLIENT[str]))
        for str in ["ACK_FAILURE", "RESET", "DISCARD_ALL", "PULL_ALL"]
    ]
)
