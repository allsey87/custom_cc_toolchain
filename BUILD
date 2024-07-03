load(":custom.bzl", "custom_cc_toolchain_config_rule")

# declare a custom configuration to use with the toolchain
constraint_setting(name = "os")
constraint_setting(name = "cpu")
constraint_value(
  name = "custom_os",
  constraint_setting = ":os",
)
constraint_value(
  name = "custom_cpu",
  constraint_setting = ":cpu",
)
platform(
  name = "custom_platform",
  constraint_values = [
    ":custom_os",
    ":custom_cpu"
  ],
)

# this should be built in the target configuration
cc_binary(
  name = "test",
  srcs = ["empty.c"]
)

# this should be built in the exec configuration
py_binary(
  name = "clang_wrapper",
  srcs = ["clang_wrapper.py"],
)
filegroup(
    name = "compiler_files",
    srcs = [
      ":clang_wrapper",
    ],
)

custom_cc_toolchain_config_rule(
  name = "custom_toolchain_config",
  compiler = ":clang_wrapper"
)

filegroup(name = "empty")

cc_toolchain(
    name = "custom_cc_toolchain",
    all_files = ":empty",
    ar_files = ":empty",
    as_files = ":empty",
    compiler_files = ":compiler_files",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    toolchain_config = "custom_toolchain_config",
    toolchain_identifier = "custom_toolchain_identifier",
)

toolchain(
    name = "custom_toolchain",
    target_compatible_with = [
        ":custom_os",
        ":custom_cpu",
    ],
    toolchain = ":custom_cc_toolchain",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)
