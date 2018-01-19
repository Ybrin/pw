import Cryptor
#if os(Linux)
    import Glibc
#else
    import Darwin
#endif

func usage(programName: String? = nil) {
    let p = programName ?? "pw"
    print("Generates a new secure random password in hex format with")
    print("the given number of bytes.")
    print()
    print("Usage:")
    print("  \(p) <characters>")
    print()
    print("Examples:")
    print("  \(p) 16")
    print("  \(p) 64")
    print()
    print("Options:")
    print("  -h, --help  Show this screen.")
}

let logger = Logger(level: .warn)

for i in CommandLine.arguments {
    if i.lowercased() == "--help" || i.lowercased() == "-h" {
        usage(programName: CommandLine.arguments.first)
        exit(EXIT_SUCCESS)
    }
}
guard CommandLine.arguments.count == 2, let i = Int(CommandLine.arguments[1]) else {
    usage(programName: CommandLine.arguments.first)
    exit(EXIT_FAILURE)
}

guard let pass = try? Random.generate(byteCount: i) else {
    logger.fatal("Cryptor failed generating a secure random byte sequence.")
    exit(EXIT_FAILURE)
}

print(pass.reduce("", { $0 + String(format: "%02x", $1) }))
