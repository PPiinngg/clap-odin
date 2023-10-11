package clap

CLAP_VERSION :: Version{
	major    = 1,
	minor    = 1,
	revision = 8,
}

clap_version_is_compatible :: proc "c" (version: Version) -> bool {
	return version.major >= 1
}

Version :: struct {
	major:    u32,
	minor:    u32,
	revision: u32,
}
